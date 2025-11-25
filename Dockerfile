FROM peaceiris/hugo:latest

ARG UID=1000
ARG GID=1000

RUN addgroup --gid $GID hugo && \
    adduser --disabled-password --gecos "" --uid $UID --gid $GID hugo

WORKDIR /src

USER hugo

EXPOSE 1313

CMD ["server", "--bind", "0.0.0.0", "--port", "1313", "-D"]
