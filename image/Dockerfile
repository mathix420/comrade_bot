FROM nvidia/cuda:11.4.2-base-ubuntu20.04

WORKDIR /usr/src/app

COPY . .

RUN apt-get update && apt-get install -y --no-install-recommends python3 python3-pip python3-dev llvm llvm-dev
RUN pip3 install --no-cache-dir -r requirements.txt && mkdir -p ~/.u2net && \
    gdown --id 1ao1ovG1Qtx4b7EoskHXmi2E9rp5CHLcZ -O ~/.u2net/u2net.pth && \
    python3 -c 'from rembg.bg import remove; remove(b"")' || echo "done"

ENTRYPOINT ["gunicorn"]
CMD [ "main:app" ]
