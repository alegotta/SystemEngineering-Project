[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# System Engineering Project

Source code from [mealie](https://github.com/hay-kot/mealie)

## Description

**Goal**: automatize the integration and deployment of [grocy](https://github.com/alegotta/grocy)

**Pipeline workflow**:
1) the project is tested
2) the python docker image is build at every commit on `main`, or when a `tag` is added
3) the image is then pushed to Docker Hub (see [here](https://hub.docker.com/u/alegotta)
4) an Azure instance (web server + PHP image + database) is created or updated

**Implementation**:
1) PyTest
2) Github Actions
3) Docker
4) Terraform + azurerm module. The state is handled by either Terraform Cloud or Gitlab

See the pipeline report on [GitHub](https://github.com/alegotta/SystemEngineering-Project/actions) and [Gitlab](https://gitlab.inf.unibz.it/Alessandro.Gottardi/mealie/-/tree/gitlab_ci).

## References

- [Push to Docker Hub using GitHub Actions](https://itsmetommy.com/2021/07/05/push-to-docker-hub-using-github-actions/)
- [`docker/metadata-action` documentation](https://github.com/docker/metadata-action#tags-input)
- ["Terraform Is NOT the Cloud Agnostic Platform You Think It Is"](https://adinermie.com/terraform-is-not-the-cloud-agnostic-platform-you-think-it-is/)

