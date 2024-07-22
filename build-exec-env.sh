#!/bin/bash

base_env(){
    # Confirm baselines are present
    
    echo "" && echo "===> Ensure ansible-builder and podman are installed" && echo ""
    pip3 install ansible-builder
    sudo yum -y install podman

}

redhat_io(){
    # Login into registry.redhat.io
    echo "" && echo "===Login to registry.redhat.io" &&  echo ""
    podman login registry.redhat.io -u=$REDHAT_USN -p=$REDHAT_PWD --tls-verify=false
}

ansible_builder(){
    # Run ansible builder
    echo "" && echo "===Running ansible-builder" && echo ""
    ansible-builder build --tag $AAP_IMAGE_NAME --container-runtime podman
}

test_image(){
    # testing image is usable
    echo ""
    echo "===TEST - Ansible version"
    echo ""
    podman run --rm localhost/$AAP_IMAGE_NAME ansible --version

    echo ""
    echo "===TEST - Installed modules"
    echo ""
    podman run --rm localhost/$AAP_IMAGE_NAME ansible-doc -l

}

# upload_to_pah(){
#     # Upload image to PAH

#     # STEP 1 : Log in to Podman using your automation hub location and credentials
#     # tls verification needs to be turned off unless all issues of certs signing is alligned
#     echo ""
#     echo "===PUSH - Podman Login to PAH"
#     echo ""
#     podman login -u=$PAH_USER -p=$PAH_PASSWORD $PAH_URL --tls-verify=false


#     # STEP 2 : Tag the locally found image to reflect url for the AH.
#     echo ""
#     echo "===PUSH - Podman tag image before push"
#     echo ""
#     podman tag localhost/$AAP_IMAGE_NAME:latest $PAH_URL/$AAP_IMAGE_NAME

#     # STEP 2 : Push your container image to your automation hub container registry
#     echo ""
#     echo "===PUSH - Podman push image to PAH"
#     echo ""
#     podman push $PAH_URL/$AAP_IMAGE_NAME --tls-verify=false
# }


upload_to_docker(){
    # Upload to docker.io for consumption in the lab environment.
    # https://computingforgeeks.com/how-to-publish-docker-image-to-docker-hub-with-podman/
    # Private docker hub repository is used to store and download.

    podman login docker.io -u $DOCKER_USER -p $DOCKER_ACCESS_TOKEN --tls-verify=false
    podman tag localhost/$AAP_IMAGE_NAME:latest docker.io/$DOCKER_USER/$AAP_IMAGE_NAME # You have to re-name before push
    podman push docker.io/$DOCKER_USER/$AAP_IMAGE_NAME --tls-verify=false

    ## Pulling into the lab environment ( controller-01 )
    ## podman pull docker.io/$DOCKER_USER/$AAP_IMAGE_NAME --tls-verify=false   # Public image don't need authentication

    ## Confirm
    ## podman images


}

base_env
# redhat_io
ansible_builder
test_image
#upload_to_pah
upload_to_docker