import os, math, random
import numpy as np
from PIL import Image, ImageDraw, ImageFilter

random.seed(73)
OUT = 'config/paxi/resourcepacks/abyss_chronicles_rp/assets/minecraft/textures/painting'
os.makedirs(OUT, exist_ok=True)


def vgrad(W, H, top, bot, power=1.0):
    t = (np.linspace(0, 1, H) ** power)[:, None]
    img = np.zeros((H, W, 3))
    for i in range(3):
        img[..., i] = top[i] * (1 - t) + bot[i] * t
    return img


def glow_layer(size, draw_fn):
    g = Image.new('RGBA', size, (0, 0, 0, 0))
    draw_fn(ImageDraw.Draw(g))
    return g.filter(ImageFilter.GaussianBlur(size[0] // 22 + 3))


def save(arr_or_img, name):
    if isinstance(arr_or_img, np.ndarray):
        im = Image.fromarray(np.clip(arr_or_img, 0, 255).astype('uint8'))
    else:
        im = arr_or_img
    im.convert('RGBA').save(os.path.join(OUT, name))
    print('saved', name, im.size)


# ---------- void.png : вертикальный рифт Бездны (1x2) ----------
def make_void():
    W, H = 128, 256
    base = vgrad(W, H, (26, 10, 40), (3, 1, 8), 1.4)
    img = Image.fromarray(base.astype('uint8')).convert('RGBA')
    cx = W / 2
    pts = []
    for y in range(16, H - 14, 4):
        x = cx + math.sin(y / 26.0) * 10 + math.sin(y / 7.0) * 4 + random.uniform(-3, 3)
        pts.append((x, y))
    def rift(d):
        d.line(pts, fill=(206, 132, 255, 255), width=4, joint='curve')
        for x, y in pts[::3]:
            d.ellipse([x - 3, y - 3, x + 3, y + 3], fill=(150, 70, 230, 120))
    img = Image.alpha_composite(img, glow_layer((W, H), rift))
    img = Image.alpha_composite(img, glow_layer((W, H), rift))
    d = ImageDraw.Draw(img)
    d.line(pts, fill=(238, 214, 255, 255), width=2, joint='curve')
    # редкие искры
    for _ in range(40):
        x, y = random.uniform(0, W), random.uniform(0, H)
        a = int(max(0, 120 - abs(x - cx) * 3))
        d.point((x, y), fill=(200, 160, 255, a))
    save(img, 'void.png')


# ---------- pointer.png : Око Бездны (4x4) ----------
def make_pointer():
    S = 256
    yy, xx = np.mgrid[0:S, 0:S]
    r = np.sqrt((xx - S / 2) ** 2 + (yy - S / 2) ** 2) / (S / 2)
    base = np.zeros((S, S, 3))
    base[..., 0] = 10 + 30 * np.clip(1 - r, 0, 1)
    base[..., 1] = 3 + 6 * np.clip(1 - r, 0, 1)
    base[..., 2] = 16 + 60 * np.clip(1 - r, 0, 1)
    img = Image.fromarray(np.clip(base, 0, 255).astype('uint8')).convert('RGBA')
    c = S / 2
    def maw(d):
        for rad, col in [(120, (40, 14, 70, 150)), (92, (60, 20, 100, 170)),
                         (64, (90, 36, 150, 190)), (40, (150, 70, 230, 220)),
                         (22, (220, 150, 255, 255))]:
            d.ellipse([c - rad, c - rad, c + rad, c + rad], fill=col)
        for k in range(24):
            a = k / 24 * 2 * math.pi
            x2 = c + math.cos(a) * 124
            y2 = c + math.sin(a) * 124
            d.line([c + math.cos(a) * 36, c + math.sin(a) * 36, x2, y2],
                   fill=(120, 50, 200, 120), width=2)
    img = Image.alpha_composite(img, glow_layer((S, S), maw))
    d = ImageDraw.Draw(img)
    d.ellipse([c - 20, c - 20, c + 20, c + 20], fill=(240, 220, 255, 255))
    d.ellipse([c - 7, c - 9, c + 7, c + 9], fill=(20, 4, 30, 255))  # зрачок
    save(img, 'pointer.png')


# ---------- wanderer.png : Холодный берег (1x2) ----------
def make_wanderer():
    W, H = 128, 256
    horizon = int(H * 0.62)
    sky = vgrad(W, horizon, (30, 14, 46), (60, 40, 80), 1.1)
    sea = vgrad(W, H - horizon, (16, 12, 30), (6, 4, 14), 0.8)
    img = Image.new('RGBA', (W, H))
    img.paste(Image.fromarray(sky.astype('uint8')), (0, 0))
    img.paste(Image.fromarray(sea.astype('uint8')), (0, horizon))
    mx, my = W * 0.32, horizon * 0.4
    def moon(d):
        d.ellipse([mx - 16, my - 16, mx + 16, my + 16], fill=(214, 198, 240, 230))
    img = Image.alpha_composite(img, glow_layer((W, H), moon))
    d = ImageDraw.Draw(img)
    d.ellipse([mx - 13, my - 13, mx + 13, my + 13], fill=(232, 224, 248, 255))
    # отражение луны на воде
    for i in range(horizon, H, 3):
        a = int(90 * (1 - (i - horizon) / (H - horizon)))
        d.line([mx - 6, i, mx + 6, i], fill=(200, 190, 230, a))
    # одинокая фигура на берегу справа
    fx, fy = W * 0.66, horizon + 4
    d.ellipse([fx - 4, fy - 18, fx + 4, fy - 10], fill=(6, 4, 12, 255))     # голова
    d.polygon([(fx - 6, fy), (fx + 6, fy), (fx + 4, fy - 12), (fx - 4, fy - 12)], fill=(8, 5, 16, 255))  # плащ
    # линия берега
    d.line([0, horizon, W, horizon], fill=(40, 30, 55, 160), width=2)
    save(img, 'wanderer.png')


make_void()
make_pointer()
make_wanderer()
print('done ->', os.path.abspath(OUT))
