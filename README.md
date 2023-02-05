Overview
========

This is after frustrations of having to build endless execution environments to run different things in the different Ansible Automation Platform projects I have undertaken!

In this repo, I build one mother execution environment, that will keep being updated whenever I realize I need something else!

Design
=======
- Base Image is ansible-automation-platform/ee-minimal-rhel8:2.14.1-3.

  ** You need to $ podman login registry/redhat.io  to have access to this one. Use your usual redhat credentials.

- Ontop I have added these:

a) Ansible collections ( Ref: requirements.yml )

    - community.general : I rely on the email module aloooot for sending email notifications real-time as playbooks are running!!

    - awx.awx  : I hate clicking and clicking on the AAP GUI to build Organizations, Projects,Job Templates , Workflows etc.. A good Ansible script does that for me! You will need awx.awx

    - f5networks.f5_modules : Needed this in some project to update F5s. I thought, why not add them permanently.

    -  infoblox.nios_modules : Some modules I have had a hard time understanding!..But needed them along the way :(


- Used ansible-builder to build the podman image . All this done on an RHEL 8* environment.

- In this project am storing my end image in docker.io and that's where I pull it down whenever I want to use, or update it if I need to.



How to use
===========

Step 1: Configure your environmental variables for the following :

  a) REDHAT_USER

  b) REDHAT_PASSWORD

  c) IMAGE_NAME

  d) DOCKER_USER

  e) DOCKER_PASSWORD


      
      

