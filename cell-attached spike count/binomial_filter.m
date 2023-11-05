function data_filtered = binomial_filter(data,nt)
h = [1/2 1/2];
binomialCoeff = conv(h,h);
for n = 1:nt-1
    binomialCoeff = conv(binomialCoeff,h);
end

data_filtered = filtfilt(binomialCoeff, 1, data);
