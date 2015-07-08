## Docker Workflow Demo
* Run the image with an error
  - cmd in demo_docker_run
* Show the logs
* Run the image in an interactive container
  - cmd in demo_docker_shell
  - show /env.sh mounted
  - show /src mounted
  - show /src/entrypoint.sh
  - duplicate the error by running /src/entrypoint.sh
* Correct the error
  - from the host, edit src/application.pl
* Run /src/entrypoint.sh to show the error is fixed
  - exit interactive container
* Run the image and show that it works
  - cmd in demo_docker_run
* Run the image with a different environment file
  - cmd in demo_docker_run2

