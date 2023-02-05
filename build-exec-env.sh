#!/bin/bash

# REF
# https://access.redhat.com/documentation/en-us/red_hat_ansible_automation_platform/2.0-ea/html-single/managing_containers_in_private_automation_hub/index
# https://infohub.delltechnologies.com/l/dell-powermax-ansible-modules-best-practices-1/creating-ansible-execution-environments-using-ansible-builder
# https://docs.oracle.com/en/learn/intro_podman/index.html#introduction


base_env(){
    # Confirm baselines are present
    echo ""
    echo "===Confirm baselines are present"
    echo ""
    pip3 install ansible-builder
    sudo yum -y install podman

}

redhat_io(){
    # Login into registry.redhat.io
    echo ""
    echo "===Login to registry.redhat.io"
    echo ""
    podman login registry.redhat.io -u=$REDHAT_USER -p=$REDHAT_PASSWORD --tls-verify=false
}

build_image(){
    
    # Run ansible builder
    echo ""
    echo "===Running ansible-builder"
    echo ""
    ansible-builder build --tag $IMAGE_NAME --container-runtime podman

}

test_image(){
    # testing image is usable
    echo ""
    echo "===TEST - Ansible version"
    echo ""
    podman run --rm localhost/$IMAGE_NAME ansible --version

    echo ""
    echo "===TEST - Installed modules"
    echo ""
    podman run --rm localhost/$IMAGE_NAME ansible-doc -l

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
#     podman tag localhost/$IMAGE_NAME:latest $PAH_URL/$IMAGE_NAME

#     # STEP 2 : Push your container image to your automation hub container registry
#     echo ""
#     echo "===PUSH - Podman push image to PAH"
#     echo ""
#     podman push $PAH_URL/$IMAGE_NAME --tls-verify=false
# }


upload_to_docker(){
    # Upload to docker.io for consumption in the lab environment.
    # https://computingforgeeks.com/how-to-publish-docker-image-to-docker-hub-with-podman/
    # Private docker hub repository is used to store and download.

    podman login docker.io -u $DOCKER_USER -p $DOCKER_PASSWORD --tls-verify=false
    podman tag localhost/$IMAGE_NAME:latest docker.io/$DOCKER_USER/$IMAGE_NAME
    podman push docker.io/$DOCKER_USER/$IMAGE_NAME --tls-verify=false

    ## Pulling into the lab environment ( controller-01 )
    podman pull docker.io/$DOCKER_USER/$IMAGE_NAME --tls-verify=false   # Public image don't need authentication

    ## Confirm
    podman images


}

base_env
redhat_io
build_image
test_image
#upload_to_pah