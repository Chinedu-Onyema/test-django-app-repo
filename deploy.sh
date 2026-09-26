#!/bin/bash
git pull origin main

DOCKERHUB_USERNAME="edunaking"           # replace with your dockerhub username 
                                                       # for example edunaking


TAG=$(git rev-parse --short HEAD)                      # use the TAG environment variable to tag 
                                                       # your latest git commit  


docker build -t $DOCKERHUB_USERNAME/portfolio-website:$TAG .     # build and tag your django app image name
                                                                 # with the latest git commit id

docker push $DOCKERHUB_USERNAME/portfolio-website:$TAG           # push your django app image name to dockerhub


# after every new git commit, use the latest git commit id and tag is to the django_service_deployment.yml file 
sed -i "s|image: .*/portfolio-website:.*|image: $DOCKERHUB_USERNAME/portfolio-website:$TAG|" django_deployment.yml

git add django_deployment.yml              # add only the django_service_deployment.yml file
git commit -m "Deploy new tag to argocd"           # commit the changes made above 
git push                                           # push changes to GitHub