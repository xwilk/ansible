### build docker container
docker build . -t nvim-computer 

### run docker container with mounted working dir
docker run -v $(pwd):/home/piwilk/ansible-wsl2 --rm -it nvim-computer bash

### test ubuntu roles
```
ansible-playbook setup_ssh.yml --ask-vault-pass
ansible-playbook setup_shell.yml [--ask-become-pass]
```

