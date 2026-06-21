import os, math, random
import numpy as np
from PIL import Image, ImageDraw, ImageFont, ImageFilter

random.seed(7)
OUT = os.path.expanduser('~/ea-repo/.github')
os.makedirs(OUT, exist_ok=True)
W, H = 1280, 384


def font(paths, size):
    for p in paths:
        if os.path.exists(p):
            return ImageFont.truetype(p, size)
    return ImageFont.load_default()

BOLD = ['C:/Windows/Fonts/segoeuib.ttf', 'C:/Windows/Fonts/arialbd.ttf']
SEMI = ['C:/Windows/Fonts/seguisb.ttf', 'C:/Windows/Fonts/segoeui.ttf', 'C:/Windows/Fonts/arial.ttf']


def bg():
    yy, xx = np.mgrid[0:H, 0:W]
    # diagonal gradient deep-blue -> abyss purple-black
    t = (xx / W * 0.55 + yy / H * 0.45)
    img = np.zeros((H, W, 3))
    top = np.array([24, 16, 48]); bot = np.array([6, 4, 14])
    for i in range(3):
        img[..., i] = top[i] * (1 - t) + bot[i] * t
    # radial glow on the right (the abyss)
    cx, cy = W * 0.80, H * 0.5
    r = np.sqrt((xx - cx) ** 2 + (yy - cy) ** 2)
    glow = np.clip(1 - r / (W * 0.42), 0, 1) ** 2.2
    for i, c in enumerate((120, 50, 200)):
        img[..., i] += glow * c * 0.55
    return Image.fromarray(np.clip(img, 0, 255).astype('uint8')).convert('RGBA')


def add_stars(img):
    d = ImageDraw.Draw(img)
    for _ in range(220):
        x, y = random.uniform(0, W), random.uniform(0, H)
        a = random.randint(20, 150)
        s = random.choice([1, 1, 1, 2])
        d.ellipse([x, y, x + s, y + s], fill=(220, 210, 255, a))
    return img


def glow_text(size, text, fnt, fill, blur):
    g = Image.new('RGBA', size, (0, 0, 0, 0))
    ImageDraw.Draw(g).text((size[0] // 2, size[1] // 2), text, font=fnt, fill=fill, anchor='mm')
    return g.filter(ImageFilter.GaussianBlur(blur))


img = add_stars(bg())

# abyss "eye" accent on the right
d = ImageDraw.Draw(img)
ex, ey = int(W * 0.82), int(H * 0.5)
for rad, col in [(150, (40, 14, 70, 70)), (96, (70, 26, 120, 90)), (54, (150, 70, 230, 130)), (26, (220, 160, 255, 200))]:
    d.ellipse([ex - rad, ey - rad, ex + rad, ey + rad], fill=col)
d.ellipse([ex - 9, ey - 12, ex + 9, ey + 12], fill=(12, 4, 20, 255))

# title
title = 'EXCITING ADVENTURES'
ft = font(BOLD, 92)
# auto-fit
while ft.getlength(title) > W * 0.72 and ft.size > 40:
    ft = font(BOLD, ft.size - 2)
tx, ty = int(W * 0.045), int(H * 0.40)
img.alpha_composite(glow_text((W, H), title, ft, (150, 70, 230, 255), 18))
d = ImageDraw.Draw(img)
# left-anchored manual draw with stroke
d.text((tx, ty), title, font=ft, fill=(240, 230, 255, 255), anchor='lm', stroke_width=2, stroke_fill=(30, 10, 50, 255))

# accent line
ly = ty + 44
d.line([(tx + 2, ly), (tx + int(W * 0.60), ly)], fill=(150, 90, 210, 170), width=3)

# subtitle
sub = 'A Fabric 1.20.1 Adventure Modpack  ·  460+ mods  ·  Chronicles of the Abyss'
fs = font(SEMI, 30)
while fs.getlength(sub) > W * 0.70 and fs.size > 16:
    fs = font(SEMI, fs.size - 1)
d.text((tx + 2, ly + 30), sub, font=fs, fill=(196, 178, 224, 235), anchor='lm')

# tagline top
fk = font(SEMI, 24)
d.text((tx + 2, int(H * 0.13)), 'SURVIVE · EXPLORE · CONQUER THE ABYSS', font=fk, fill=(150, 120, 190, 220), anchor='lm')

img.convert('RGB').save(os.path.join(OUT, 'banner.png'), quality=95)
print('banner ->', os.path.join(OUT, 'banner.png'), img.size)
