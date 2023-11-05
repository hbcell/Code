DataImport = importdata('online analysis.txt');
CalciumTime=DataImport.data(:,2);
%CalciumData=ExportedImagesch1registerdff';
DataImport2 = importdata('Exported Images_ch1_registerdf_f.txt');
CalciumData=DataImport2.data';
DataImport3 = importdata('data_user input.txt');
StimulusData=DataImport3.data(:,2)';
%StimulusData=datauserinput(:,2);
CalciumTimeInSed=CalciumTime/1000;
position_center=ROI_coodinate_compute();
%
PosAbove=find(StimulusData'>2);
PosAboveDiff=diff(PosAbove);
PosAboveDoubleDiff=diff(PosAboveDiff);
FirstPointOfPos=find(PosAboveDoubleDiff>0)+2;
TriggerPositions=PosAbove([1 FirstPointOfPos'])-1;

%
Resampling=length(StimulusData)/length(CalciumTimeInSed);
StimulusTime=zeros(1,length(StimulusData));    
StimulusTime(Resampling:Resampling:end)=CalciumTimeInSed;
RecordedValueInd=find(StimulusTime>0);

%
for k=1:length(RecordedValueInd)
    StartValue=RecordedValueInd(k)-Resampling+1;
    EndValue=RecordedValueInd(k);        
    if k==1 
        StimulusTime(RecordedValueInd(k)-Resampling+1:RecordedValueInd(k))=linspace(StimulusTime(StartValue),StimulusTime(EndValue),Resampling);
    else
        StimulusTime(RecordedValueInd(k)-Resampling:RecordedValueInd(k))=linspace(StimulusTime(StartValue-1),StimulusTime(EndValue),Resampling+1);
    end
end
%

TimePositions=StimulusTime(TriggerPositions); 

%
DataCutPool=[];
TimePool=[];
for i=[1 2 3]
    StartTime=TimePositions(i)-0.5;
    EndTime=TimePositions(i)+1.5;
    [~,StartPoint]=min(abs(CalciumTimeInSed-StartTime));
    [~,EndPoint]=min(abs(CalciumTimeInSed-EndTime));
    CalciumTimeCut=CalciumTimeInSed(StartPoint:EndPoint);
    CalciumTimeCut=CalciumTimeCut-StartTime;
    %CalciumTimeCut=CalciumTimeCut-CalciumTimeCut(1);
    CalciumDataCut=CalciumData(:,StartPoint:EndPoint);    
    CalciumTimeCut=CalciumTimeCut';
    CalTime_shift=CalciumTimeCut-0.5;
    TimePool=cat(3,TimePool,CalTime_shift);
    DataCutPool=cat(3,DataCutPool, CalciumDataCut);
end


TimePool_mean=mean(TimePool,3);
DataCutPool_mean=mean(DataCutPool,3);

%
for i=1:size(DataCutPool_mean,1)
    CalciumDataPoolMean_3(1,i)=max(DataCutPool_mean(i,11:end));
end

save('pcolor_map.mat','CalciumDataPoolMean_3','position_center')
