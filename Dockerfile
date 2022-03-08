FROM primetoninc/jdk:1.8

LABEL AUTHOR="Abelit"
LABEL EMAIL="ychenid@live.com"

ADD build/aj-report /opt/aj-report

WORKDIR /opt/aj-report

EXPOSE 9095

CMD [ "/opt/aj-report/bin/start-frontend.sh" ]