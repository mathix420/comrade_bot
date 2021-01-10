#! /usr/bin/python3

from flask import Flask, send_file
from rembg.bg import remove
from requests import get
from io import BytesIO
from PIL import Image

app = Flask(__name__)


def center_bottom(bg_siz, im_siz):
    bw, bh = bg_siz
    iw, ih = im_siz
    return (int(bw / 2 - iw / 2), bh - ih + 40)


def left_middle(bg_siz, im_siz):
    # bw, bh = bg_siz
    # iw, ih = im_siz
    return (40, -10)


filters = [
    (Image.open('bg1.jpg'), center_bottom),
    (Image.open('bg2.jpg'), center_bottom),
    (Image.open('bg3.jpg'), left_middle),
]


@app.route('/image/<bg_id>/<username>/comrade.jpg')
def get_chart(bg_id, username):
    filter = filters[int(bg_id)]
    bg = filter[0].copy()

    r = get(f'https://cdn.intra.42.fr/users/medium_{username}.jpg')

    image = Image.open(BytesIO(remove(r.content)))

    bg.paste(image, filter[1](bg.size, image.size), image)

    img_bytes = BytesIO()
    bg.save(img_bytes, format='JPEG', quality=70)
    img_bytes.seek(0)

    return send_file(
        img_bytes,
        mimetype='image/jpeg',
        # as_attachment=True,
        # attachment_filename='comrade.jpg'
    )


if __name__ == "__main__":
    from os import getenv

    app.run(host=getenv('HOST', '0.0.0.0'), port=getenv('PORT', 4242))
