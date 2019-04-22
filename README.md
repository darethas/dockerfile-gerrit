# dockerfile-gerrit

Dockerfile that runs [Gerrit Code Review](https://www.gerritcodereview.com/).

Steps:

1. clone and build with `docker build -t gerrit .`
2. run with `docker run -p 8080:8080 -p 29418:29418 gerrit:latest`

## Why

There is an existing dockerfile under the Gerrit github mirror, but it uses some deprecated options (namely, Maintainer), and a pretty hefty base image, and they don't accept PR's on github.

## For development and testing out Gerrit

I have not ran this in production yet. The official dockerfile repo for Gerrit has some nice instructions on how to run in production. Please reference those.