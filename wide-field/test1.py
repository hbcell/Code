from PIL import Image
import numpy as np
import matplotlib.pyplot as plt


desired_size = (1357, 1072)   ##  重新调整大小尺寸  可以自己设置

# 打开三张图像
image1 = Image.open('./0509/16k.png')
image2 = Image.open('./0509/32k.png')
image3 = Image.open('./0509/chord2.png')

# 调整图像大小
image1 = image1.resize(desired_size, Image.ANTIALIAS)
image2 = image2.resize(desired_size, Image.ANTIALIAS)
image3 = image3.resize(desired_size, Image.ANTIALIAS)

# 将三张图像转换为NumPy数组
image1_array = np.array(image1)
image2_array = np.array(image2)
image3_array = np.array(image3)

# 创建一个新的空白图像，用于叠加结果
result_array = np.zeros_like(image1_array)

# 定义白色背景像素值
white_pixel = np.array([255, 255, 255])

# 遍历每个像素点
overlap_area = 0
image3_color_area = 0
for x in range(result_array.shape[1]):
    for y in range(result_array.shape[0]):
        # 获取三张图像在该像素点的颜色
        color1 = image1_array[y, x]
        color2 = image2_array[y, x]
        color3 = image3_array[y, x]

        # 叠加颜色
        result_color = np.clip(color1 + color2 + color3, 0, 255)

        # 如果三张图像的对应像素都不是白色背景
        if (not np.array_equal(color3, [255, 255, 255])) and (
                (not np.array_equal(color1, [255, 255, 255])) or (not np.array_equal(color2, [255, 255, 255]))):
            result_color = np.array([50, 205, 50])
            overlap_area += 1

        # 计算image3图像彩色区域的面积
        if not np.array_equal(color3, white_pixel):
            image3_color_area += 1

        # 在结果图像中设置该像素点的颜色
        result_array[y, x] = result_color

# 计算重叠区域面积与image3彩色区域面积的占比
overlap_ratio = overlap_area / image3_color_area

# 显示叠加结果图像
plt.imshow(result_array.astype(np.uint8))
plt.axis('off')
plt.show()

print("重叠区域面积:", overlap_area)
print("chord区域面积:", image3_color_area)
print("占比:", overlap_ratio)
