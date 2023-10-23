### build docker container
docker build . -t nvim-computer 

### run docker container with mounted working dir
docker run -v $(pwd):/home/piwilk/ansible-wsl2 --rm -it nvim-computer bash
