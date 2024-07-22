## Prerequisites
- Image has been built successfully.
- Image is stored in the container registry.


## Testing execution env
1. Login to the container registry and pull down the image. ** In my case it is docker.io

   $ podman login docker.io -u $DOCKER_USER -p $DOCKER_ACCESS_TOKEN --tls-verify=false

   $ podman pull docker.io/$DOCKER_USER/$AAP_IMAGE_NAME --tls-verify=false

2. Start a docker container iteractively:

   $ docker run -it docker.io/$DOCKER_USER/$AAP_IMAGE_NAME /bin/bash

   - -i flag keeps STDIN open even if not attached.
   - -t flag allocates a pseudo-TTY, making it possible to interact with the container's terminal.

3. In the container you can do some checks :
   
   bash-4.4# ansible --version && git --version

4. Clone the git repo you want to test.
   
   bash-4.4# git clone -b develop https://github.com/254In61/linux-env-check.git

5. Create a file in the container and add the following:
   
   bash-4.4# touch ../secret-vars.yml
   
   ---
   # Extra vars for testing

   ansible_user: <username>

   ansible_password: <user password>

   ansible_become_password: <root/admin password>


5. Run the ansible-playbook you want to test while calling the variables file.
   
   bash-4.4# cd linux-env-check && ansible-playbook site.yml -e '@../secret-vars.yml'

   ** AAP hands over credentials to the aee/container as a temp file and deleted after run is complete..That's what you will be simulating**


## Notes

- Projects in the aap are domiciled in /var/lib/awx/projects. You get into the directory to test if needed.

- If your playbooks run fine here, then your AAP should be able to work fine with the Image as the Ansible Execution Environment.
    