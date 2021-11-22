[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# System Engineering Project

Source code from [mealie](https://github.com/hay-kot/mealie)

## Initials

**Goal**: automatize the integration and deployment of [grocy](https://github.com/alegotta/grocy)

**Workflow**:
1) the python docker image is build at every commit on `main`, or when a `tag` is added
2) the image is then pushed to Docker Hub (see [here](https://hub.docker.com/u/alegotta)
3) an Azure instance (web server + PHP image + database) is created or updated

**How**:
1) Github Actions
2) Docker
3) ?

## Possible strategies for point 3

### Using `docker-compose`

- Define the infrastructure using docker-compose
- Push the configuration to Azure using its command line interface through Github Actions

See [here](https://docs.microsoft.com/en-us/azure/container-instances/tutorial-docker-compose).

### Using `kubernetes`

- Define the infrastructure using kubernetes (practical example [here](https://github.com/kadnan/LearningK8s))
- Create a new [cluster](https://learn.hashicorp.com/tutorials/terraform/aks)
- Push the configuration to Azure using Terraform (see [here](https://learn.hashicorp.com/tutorials/terraform/kubernetes-provider))

## References

- [Push to Docker Hub using GitHub Actions](https://itsmetommy.com/2021/07/05/push-to-docker-hub-using-github-actions/)
- [`docker/metadata-action` documentation](https://github.com/docker/metadata-action#tags-input)
- ["Terraform Is NOT the Cloud Agnostic Platform You Think It Is"](https://adinermie.com/terraform-is-not-the-cloud-agnostic-platform-you-think-it-is/)

