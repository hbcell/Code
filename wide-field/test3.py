import cv2
import os
import numpy as np


class Plot():
    def __init__(self):
        super().__init__()

    def Figure8(self, Img):
        self.drawing = False  # 按下鼠标时变为True
        self.mode = False  # mode为True绘制矩形
        self.ix, self.iy = -1, -1

        def draw_circle(event, x, y, flags, param):  # 回调函数
            if event == cv2.EVENT_LBUTTONDOWN:
                self.drawing = True
                self.ix, self.iy = x, y
            elif event == cv2.EVENT_MOUSEMOVE and flags == cv2.EVENT_FLAG_LBUTTON:
                if self.drawing:
                    if self.mode:
                        cv2.rectangle(Img, (self.ix, self.iy), (x, y), 0, -1)
                    else:
                        cv2.circle(Img, (x, y), 3, 0, -1)
            elif event == cv2.EVENT_LBUTTONUP:
                self.drawing = False

        cv2.namedWindow('Draw Counters')
        cv2.setMouseCallback('Draw Counters', draw_circle)
        while True:
            cv2.imshow('Draw Counters', Img)
            k = cv2.waitKey(1)
            if k == ord('m'):
                self.mode = not self.mode
            elif k == 27:
                break
        cv2.destroyAllWindows()

        ImgGray = cv2.cvtColor(Img, cv2.COLOR_BGR2GRAY)
        cv2.imshow('ImgGray', ImgGray)
        cv2.waitKey(0)
        cv2.destroyAllWindows()

        ret, thresh = cv2.threshold(ImgGray, 0, 255, cv2.THRESH_BINARY_INV)  # 使用阈值检测边缘
        noise_contours, hierarchy = cv2.findContours(thresh, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        contours = []
        for i in noise_contours:
            if i.shape[0] > 10:
                contours.append(i)
        # mask = np.zeros(Img.shape, dtype=np.uint8)
        # cv2.drawContours(mask, contours, -1, 255, -1)  # 最后一个参数是0绘制边框，-1填充绘制

        for i, contour in enumerate(contours):
            M = cv2.moments(contour)
            cx = int(M['m10'] / M['m00'])
            cy = int(M['m01'] / M['m00'])
            area = round(cv2.contourArea(contour), 2)
            cv2.putText(Img, 'Area=' + str(area), (cx - 40, cy - 40), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 255), 1)
            # 旋转边界矩形：cv2.minAreaRect()
            minRect = cv2.minAreaRect(contour)  # [(x,y),(w,h),angle]
            box = cv2.boxPoints(minRect)  # 获取到最小矩阵的四个顶点box：[[x1, y1],[x2, y2],[x3, y3],[x4, y4]]
            box = np.int0(box)
            cv2.drawContours(Img, [box], -1, (255, 0, 0), 3)
            (x, y), (w, h), angle = minRect
            aspect_ratio = float(w) / h
            weight = str(round(w, 2))
            height = str(round(h, 2))
            ar = str(round(aspect_ratio, 2))
            cv2.putText(Img, 'Weight=' + weight, (cx - 40, cy - 20), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 255), 1)
            cv2.putText(Img, 'Height=' + height, (cx - 40, cy), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 255), 1)
            cv2.putText(Img, 'Aspect Ratio(w/h)=' + ar, (cx - 40, cy + 20), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 255), 1)
            print("Num:{}, Area:{}, Weight:{}, Height:{}, Aspect Ratio(w/h):{}".format(i, area, weight, height, ar))


        cv2.imshow('Img', Img)
        cv2.waitKey(0)
        cv2.destroyAllWindows()


if __name__ == '__main__':
    import warnings
    warnings.filterwarnings("ignore")

    TestImg = cv2.imread(r"\\10.10.29.36\brc5\Li Ruijie\data\wide-field\ALL ANALYSIS\ALL SLICE\0530\tone.png")
    print("Iamge shape:", TestImg.shape)
    Procedure = Plot()
    Procedure.Figure8(TestImg)