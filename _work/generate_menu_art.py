# -*- coding: utf-8 -*-
# Арт главного меню «Хроники Бездны» — единый стиль «Пролог · Часть I».
# Делает две картинки в config/fancymenu/assets:
#   abyss_vignette.png — полноэкранная виньетка (затемнение краёв, атмосфера)
#   abyss_title.png    — карточка-заголовок: надзаголовок «ПРОЛОГ · ЧАСТЬ I»,
#                        титул «ХРОНИКИ БЕЗДНЫ», разделитель, название главы и слоган.
# Подложка под текстом — мягкая, с растушёвкой, чтобы текст читался на любом фоне,
# но не превращался в жёсткую плашку, налезающую на логотип пака слева.
import os
import numpy as np
from PIL import Image, ImageDraw, ImageFont, ImageFilter

OUT = 'config/fancymenu/assets'
os.makedirs(OUT, exist_ok=True)

BOLD = ['C:/Windows/Fonts/segoeuib.ttf', 'C:/Windows/Fonts/seguisb.ttf',
        'C:/Windows/Fonts/georgiab.ttf', 'C:/Windows/Fonts/arialbd.ttf']
SEMI = ['C:/Windows/Fonts/seguisb.ttf', 'C:/Windows/Fonts/segoeuib.ttf',
        'C:/Windows/Fonts/arialbd.ttf']
ITALIC = ['C:/Windows/Fonts/segoeuii.ttf', 'C:/Windows/Fonts/georgiai.ttf',
          'C:/Windows/Fonts/ariali.ttf', 'C:/Windows/Fonts/segoeui.ttf']

# палитра «бездны»
C_TITLE = (233, 216, 255, 255)
C_TITLE_STROKE = (40, 8, 62, 255)
C_GLOW = (150, 55, 225, 255)
C_EYEBROW = (197, 160, 232, 255)
C_SUB = (214, 190, 240, 240)
C_TAG = (176, 156, 204, 235)
C_LINE = (150, 95, 200, 165)
C_DIAMOND = (205, 160, 240, 235)


def pick_font(candidates, size):
    for p in candidates:
        if os.path.exists(p):
            return ImageFont.truetype(p, size), os.path.basename(p)
    return ImageFont.load_default(), 'default'


def text_w(draw, text, font, stroke=0):
    b = draw.textbbox((0, 0), text, font=font, stroke_width=stroke)
    return b[2] - b[0]


def tracked_width(draw, text, font, tracking):
    w = 0
    for ch in text:
        w += text_w(draw, ch, font) + tracking
    return w - tracking if text else 0


def draw_tracked(draw, cx, cy, text, font, fill, tracking):
    total = tracked_width(draw, text, font, tracking)
    x = cx - total / 2
    for ch in text:
        cw = text_w(draw, ch, font)
        draw.text((x + cw / 2, cy), ch, font=font, fill=fill, anchor='mm')
        x += cw + tracking


def diamond(draw, cx, cy, r, fill):
    draw.polygon([(cx, cy - r), (cx + r, cy), (cx, cy + r), (cx - r, cy)], fill=fill)


def make_vignette():
    W, H = 1920, 1080
    yy, xx = np.mgrid[0:H, 0:W]
    cx, cy = W / 2.0, H / 2.0
    d = np.sqrt(((xx - cx) / (W / 2.0)) ** 2 + ((yy - cy) / (H / 2.0)) ** 2)
    d = np.clip(d, 0, 1.42) / 1.42
    a = np.clip((d - 0.36) / (1.0 - 0.36), 0, 1) ** 1.7
    alpha = (a * 188).astype('uint8')          # чуть мягче прежнего — сцена видна
    img = np.zeros((H, W, 4), 'uint8')
    img[..., 0] = 12
    img[..., 1] = 4
    img[..., 2] = 22
    img[..., 3] = alpha
    Image.fromarray(img).save(os.path.join(OUT, 'abyss_vignette.png'))
    print('vignette ok')


def make_title():
    W, H = 1280, 460
    eyebrow = 'ПРОЛОГ · ЧАСТЬ I'
    title = 'ХРОНИКИ БЕЗДНЫ'
    chapter = 'Пробуждение Бездны'
    tagline = '« Это лишь начало. Бездна только приоткрыла глаз. »'

    f_eye, _ = pick_font(SEMI, 30)
    f_title, fn = pick_font(BOLD, 88)
    f_sub, _ = pick_font(ITALIC, 38)
    f_tag, _ = pick_font(ITALIC, 27)

    # вертикальная раскладка
    y_eye = 96
    y_title = 188
    y_div = 262
    y_sub = 312
    y_tag = 372

    probe = ImageDraw.Draw(Image.new('RGBA', (8, 8)))
    tw = text_w(probe, title, f_title, 3)

    # --- мягкая тёмная подложка (растушёванная, без жёстких краёв) ---
    backdrop = Image.new('RGBA', (W, H), (0, 0, 0, 0))
    bd = ImageDraw.Draw(backdrop)
    bd.rounded_rectangle([280, 64, W - 280, 404], radius=72, fill=(8, 3, 16, 216))
    backdrop = backdrop.filter(ImageFilter.GaussianBlur(40))
    img = Image.new('RGBA', (W, H), (0, 0, 0, 0))
    img = Image.alpha_composite(img, backdrop)

    # --- свечение титула ---
    glow = Image.new('RGBA', (W, H), (0, 0, 0, 0))
    ImageDraw.Draw(glow).text((W // 2, y_title), title, font=f_title, fill=C_GLOW, anchor='mm')
    glow = glow.filter(ImageFilter.GaussianBlur(18))
    img = Image.alpha_composite(img, glow)
    img = Image.alpha_composite(img, glow)

    d = ImageDraw.Draw(img)

    # --- надзаголовок с трекингом и ромбами ---
    eye_w = tracked_width(d, eyebrow, f_eye, 7)
    draw_tracked(d, W // 2, y_eye, eyebrow, f_eye, C_EYEBROW, 7)
    diamond(d, W // 2 - eye_w / 2 - 26, y_eye, 6, C_DIAMOND)
    diamond(d, W // 2 + eye_w / 2 + 26, y_eye, 6, C_DIAMOND)

    # --- титул ---
    d.text((W // 2, y_title), title, font=f_title, fill=C_TITLE, anchor='mm',
           stroke_width=3, stroke_fill=C_TITLE_STROKE)

    # --- разделитель с ромбами ---
    lw = int(tw * 0.74)
    cx = W // 2
    d.line([(cx - lw // 2 + 12, y_div), (cx + lw // 2 - 12, y_div)], fill=C_LINE, width=2)
    for sx in (cx - lw // 2, cx + lw // 2):
        diamond(d, sx, y_div, 7, C_DIAMOND)
    diamond(d, cx, y_div, 5, C_DIAMOND)

    # --- название главы ---
    d.text((cx, y_sub), chapter, font=f_sub, fill=C_SUB, anchor='mm')

    # --- слоган ---
    d.text((cx, y_tag), tagline, font=f_tag, fill=C_TAG, anchor='mm')

    img.save(os.path.join(OUT, 'abyss_title.png'))
    print('title ok (font=%s) %dx%d' % (fn, W, H))


make_vignette()
make_title()
print('done ->', os.path.abspath(OUT))
