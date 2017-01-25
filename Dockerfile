FROM debian:wheezy

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y git gcc make bison

WORKDIR /bash_src
RUN git clone http://git.savannah.gnu.org/r/bash.git
#COPY bash/ /bash_src/bash
WORKDIR /bash_src/bash
RUN git checkout bash-3.2-beta
RUN rm y.tab.* # clean checkouted version of y.tab so that bison rebuilds it. Otherwise:
               # /bash_src/bash/eval.c:215: undefined reference to `execute_variable_command'

RUN ./configure 
RUN make 
RUN make install
