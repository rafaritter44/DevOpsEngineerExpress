FROM golang

COPY calculator-microservice.go .

RUN go build calculator-microservice.go

ENTRYPOINT [ "/bin/bash", "-c", "./calculator-microservice" ]

EXPOSE 8080