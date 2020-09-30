# y2_devops_test

Create a branch with your name and follow these tasks:

### Task 1 - Dockerize
Create a `Dockerfile` for this simple go web application.

### Task 2 - Kubernetes Integration
Create all of the neccessry objects in order to run the application in a working kubernetes cluster.

### Task 3 - Create a simple CI/CD script
Edit `.github/actions/pipeline/entrypoint.sh` with the following steps:
* build docker image
* tag the new image as `<branch_name>-<sha>`
* optional - test the image before pushing (only `/posts` on GET)
* push
* deploy

TIPs:
* the script will run after each commit
* build is running on a fresh ubuntu image so docker must be installed
* you can check it in `Actions` tab

# Solution
### Solution 1:
* Initialized go modules to deal with dependencies
* Built docker file by copying go.mod and downloading dependencies, then build the application and including it as the entrypoint.
* Edited entrypoint.sh to include following steps:
    1. Update repositories and install relevant tools (ie docker)
    2. build the docker image using docker username and password as secrets in repo (tagged with relevant branch and sha).
    3. logged into dockerhub
    4. push image to dockerhub
* to further deploy containers to k8s cluster would use relevant action in workflow.

( kubernetes deployment files make use of nodeport service for testing purposes. in a clound environment we would use a different service type )

### Solution 2:
* using docker official github actions in workflow to build and push image in pipeline file

```
on: push

name: pipeline

jobs:
  changedFiles:
    name: y2_devops_test
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: Build and push Docker images
      uses: docker/build-push-action@v1.1.1
      with:
        username: ${{ secrets.DOCKER_USER }}
        password: ${{ secrets.DOCKER_PASS }}
        tag_with_sha: true

```
