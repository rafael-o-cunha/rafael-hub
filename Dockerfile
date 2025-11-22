FROM klakegg/hugo:ext-alpine

WORKDIR /src
EXPOSE 1313

CMD ["server", "--bind", "0.0.0.0", "--port", "1313", "-D"]
