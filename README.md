# Docker configuration

Here is an example of a custom Docker configuration for a (not that) simple PHP
project, for the dev environment. We use docker-compose to set up everything
together.

I keep many of the config files we have to give a more realistic example. But
you shouldn't simply copy them, because it won't fit your project.

The `Makefile` contains examples of shortcut commands that we have set for our
non-docker-friendly devs. It will show you how we do interact with our docker
env.

The `docker-compose.yml` file, the `Makefile` and the `.docker` folder are
located at the root of our project sources.
