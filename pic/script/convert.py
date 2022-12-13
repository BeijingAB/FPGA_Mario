# coding=utf8
from PIL import Image

im = Image.open('mario_stay.png')
width = 16
height = 16

pixels = list(im.getdata())


print('Print Red')
for i in range(0, height, 1):
    for j in range(width - 1, 0 - 1, -1):
        pixel = pixels[16*i + j]
        r = 0
        if (pixel[0]==255):
            r = 1
        print(r, end='')
        print(r, end='')
    print('')
    for j in range(width - 1, 0 - 1, -1):
        pixel = pixels[16*i + j]
        r = 0
        if (pixel[0]==255):
            r = 1
        print(r, end='')
        print(r, end='')
    print('')

print('\n\nPrint Green')
for i in range(0, height, 1):
    for j in range(width - 1, 0 - 1, -1):
        pixel = pixels[16*i + j]
        r = 0
        if (pixel[1]==255):
            r = 1
        print(r, end='')
        print(r, end='')
    print('')
    for j in range(width - 1, 0 - 1, -1):
        pixel = pixels[16*i + j]
        r = 0
        if (pixel[1]==255):
            r = 1
        print(r, end='')
        print(r, end='')
    print('')

print('\n\nPrint Blue')
for i in range(0, height, 1):
    for j in range(width - 1, 0 - 1, -1):
        pixel = pixels[16*i + j]
        r = 0
        if (pixel[2]==255):
            r = 1
        print(r, end='')
        print(r, end='')
    print('')
    for j in range(width - 1, 0 - 1, -1):
        pixel = pixels[16*i + j]
        r = 0
        if (pixel[2]==255):
            r = 1
        print(r, end='')
        print(r, end='')
    print('')

# print('Print Red')
# for i in range(0, height, 1):
#     for j in range(width - 1, 0 - 1, -1):
#         pixel = pixels[16*i + j]
#         r = 0
#         if (pixel[0]==255):
#             r = 1
#         print(r, end='')
#     print('')

# print('\n\nPrint Green')
# for i in range(0, height, 1):
#     for j in range(width - 1, 0 - 1, -1):
#         pixel = pixels[16*i + j]
#         r = 0
#         if (pixel[1]==255):
#             r = 1
#         print(r, end='')
#     print('')

# print('\n\nPrint Blue')
# for i in range(0, height, 1):
#     for j in range(width - 1, 0 - 1, -1):
#         pixel = pixels[16*i + j]
#         r = 0
#         if (pixel[2]==255):
#             r = 1
#         print(r, end='')
#     print('')