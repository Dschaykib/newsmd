# Test setup

The test setup consists of three workflows for different scenarios. Next to these workflows there is one for lint checks and one for code coverage.

- **R CMD check fix**
  A workflow that checks the package on Windows, Linux and Mac for R versions 3.6, 4.0 and 4.2. It is run on PR to the master branch. This workflow is used for the master branch badge.
- **R CMD check relative**
  A workflow that checks the package on Windows, Linux and Mac for R versions oldrel, release and devel. It is run on PR to the master branch.

All OS are tested on the latest version. An overview of the specific version on GitHub can be found [here](https://docs.github.com/en/actions/reference/specifications-for-github-hosted-runners#supported-runners-and-hardware-resources).

