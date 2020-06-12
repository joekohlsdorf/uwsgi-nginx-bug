This repo is a minimal example to reliably reproduce a bug where uwsgi closes connections prematurely.

## How To Run

You need Docker to run this demo.

* Checkout the code
* Run `make up`
* Wait a few seconds and you'll see error messages `upstream prematurely closed connection while reading response header from upstream` from then `nginx` container appearing
* You will also see the logstream of `uwsgi` which is clean.
* Hit CTRL-C and everything will stop within in a couple of seconds.

## What Does It Run

* The container `workload` is an empty Django project. Django is served by uwsgi in worker mode running 2 processes.
* The container `nginx` runs an nginx reverse proxy to uwsgi.
* The container `ab` runs apachebench against the `nginx` container.

## Frequently Asked Questions

* Change setting XYZ of uwsgi.
  * I sadly haven't found any setting which fixes this.

* You are overflowing the listen backlog.
  * uwsgi has a mechanism to alert when this happens, it isn't the cause of the problem.

* This is a benchmark problem.
  * Exactly the same happens with real traffic.

* The problem is caused by Nginx.
  * This does not happend with gunicorn.

* How can I change the uwsgi config?
  * Adjust `uwsgi.ini` and run again.

* How can I change what is installed in the Docker images?
  * Adjust the `Dockerfile` and run `make rebuild`.

## Further illustration of the problem

In the below graph you can see two days of these errors in a production environment.

First day is uwsgi, second day is gunicorn. Similar traffic, same amount of processes. gunicorn errors are due to timeout (gunicorns harakiri), unexpected errors on gunicorn are 0.

This environment is running with very low load, about 30% worker usage.

![errors](https://user-images.githubusercontent.com/32424163/84462897-28c26600-ac3e-11ea-99a8-83f8bdd706da.png)
