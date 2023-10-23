FROM ubuntu:focal as base
# To avoid questions during apt install
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y software-properties-common curl git build-essential sudo && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt update && \
    apt install -y ansible && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

FROM base AS piwilk
RUN addgroup -gid 1000 piwilk
RUN adduser --gecos piwilk --uid 1000 --gid 1000 piwilk
RUN usermod -aG sudo piwilk
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER piwilk
RUN mkdir -p /home/piwilk/ansible-wsl2
WORKDIR /home/piwilk/ansible-wsl2

FROM piwilk
ARG TAGS="--tags=ohmyzsh"
ENV TAGS ${TAGS}
ENV USER=piwilk
CMD ["sh", "-c", "ANSIBLE_STDOUT_CALLBACK=yaml", "ansible-playbook ${TAGS} setup_shell_environment.yml"]

