## Overview

This is after frustrations of having to build endless execution environments to run different things in the different Ansible Automation Platform projects I have undertaken!

In this repo, I build one mother execution environment, that will keep being updated whenever I realize I need something else!

## Design

- Base Image is ansible-automation-platform-24/ee-supported-rhel8:latest.

  ** You need to $ podman login registry/redhat.io  to have access to this one. Use your usual redhat credentials.

- Ontop I have added these:

    - community.general : I rely on the email module aloooot for sending email notifications real-time as playbooks are running!!

    - awx.awx  : I hate clicking and clicking on the AAP GUI to build Organizations, Projects,Job Templates , Workflows etc.. A good Ansible script does that for me! You will need awx.awx

    - f5networks.f5_modules : Needed this in some project to update F5s. I thought, why not add them permanently.

    - infoblox.nios_modules : Some modules I have had a hard time understanding!..But needed them along the way :(
    
- Checkout the requirements.txt to see the python modules included to support the above modules.

- Used ansible-builder to build the podman image . All this done on an RHEL 8* environment.

- In this project am storing my end image in docker.io and that's where I pull it down whenever I want to use, or update it if I need to.

## ee-supported-rhel8:latest
- This is the base image.

- $ ansible-navigator images ... the pick image number.. and enter ansible collections number to see the collections included.

- See COLLECTIONS.md

## How to use

Step 1: Configure your environmental variables for the following :

  - IMAGE_NAME

Step 2: On your dev environment ensure you are successfully logged into:
  - docker.io          : $ podman login docker.io
  - registry.redhat.io : $ podman login registry.redhat.io

Step 2: $ ./build-exec-env.sh

- Script has the steps to do the image build within different functions.
      
      
## Author
254in61 
