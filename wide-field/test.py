import matplotlib.pyplot as plt
from matplotlib.patches import Polygon
from matplotlib.path import Path
from PIL import Image
import numpy as np

desired_size = (1356, 1072)   ##  重新调整大小尺寸  可以自己设置

# 打开三张图像
image1 = Image.open('./0530/16k.png')
image2 = Image.open('./0530/32k.png')
image3 = Image.open('./0530/tone.png')

# 调整图像大小
image1 = image1.resize(desired_size, Image.ANTIALIAS)
image2 = image2.resize(desired_size, Image.ANTIALIAS)
image3 = image3.resize(desired_size, Image.ANTIALIAS)

# 将图像转换为NumPy数组
image1_array = np.array(image1)
image2_array = np.array(image2)
image3_array = np.array(image3)

# # 创建一个新的空白图像，用于叠加结果
# result_array = np.zeros_like(image1_array)
# 创建一个新的空白图像，用于叠加结果
result_array = image3_array.copy()

# 创建绘图窗口
fig, ax = plt.subplots()

# 显示图像
ax.imshow(image3_array)

# 定义绘制多边形的回调函数
class PolygonData:
    def __init__(self):
        self.polygon_points = []
        self.polygon_patch = None

polygon_data = PolygonData()
def draw_polygon(event, polygon_data):
    if event.inaxes != ax:
        return
    if event.button == 1:
        x, y = event.xdata, event.ydata
        polygon_data.polygon_points.append([x, y])
        if polygon_data.polygon_patch:
            polygon_data.polygon_patch.remove()
        if len(polygon_data.polygon_points) > 1:
            polygon = Polygon(polygon_data.polygon_points, closed=False, fill=None, edgecolor='red')
            polygon_data.polygon_patch = ax.add_patch(polygon)
        fig.canvas.draw()
    elif event.button == 3:
        fig.canvas.mpl_disconnect(cid)
        plt.close(fig)

# 注册鼠标点击事件
cid = fig.canvas.mpl_connect('button_press_event', lambda event: draw_polygon(event, polygon_data))

# 显示绘图窗口
plt.show()

# 创建路径对象
polygon_path = Path(polygon_data.polygon_points)

# 遍历每个像素点
overlap_area = 0
polygon_area = 0
for x in range(result_array.shape[1]):
    for y in range(result_array.shape[0]):
        # 获取三张图像在该像素点的颜色
        color1 = image1_array[y, x]
        color2 = image2_array[y, x]
        color3 = image3_array[y, x]

        # 判断是否在多边形区域内
        if polygon_path.contains_point((x, y)):
            polygon_area += 1
            # 判断是否为重叠区域
            if (not np.array_equal(color3, [255, 255, 255])) and (
                    (not np.array_equal(color1, [255, 255, 255])) or (not np.array_equal(color2, [255, 255, 255]))):
                result_color = np.array([50, 205, 50])
                overlap_area += 1
                # 在结果图像中设置该像素点的颜色为叠加结果
                result_array[y, x] = result_color

# 计算重叠区域面积与多边形区域面积的占比
overlap_ratio = overlap_area / polygon_area

# 显示叠加结果图像
plt.imshow(result_array.astype(np.uint8))
plt.axis('off')
plt.show()

print("重叠区域面积:", overlap_area)
print("多边形区域面积:", polygon_area)
print("占比:", overlap_ratio)
