.. include:: ../siteinclude.rst

Singularity
===========

Podman is a container platform focused on security. It is very robust and is supported by `Red Hat <https://www.redhat.com/en/topics/containers/what-is-podman>`__. Podman supports images in the Open Container Initiative (OCI) format -- these are also supported by Docker, Kubernetes and Singularity among others.

To get more information about Singularity, the following manual pages are available:

.. code-block:: bash

   man podman
   man podman-run
   man podman-build

Using Containers with Podman
----------------------------

To use a container non-interactively with Podman, the basic syntax is:

.. code-block:: bash

   podman run --rm CONTAINER_NAME ARGS

To use a non-interactively with Podman, the basic syntax is:

.. code-block:: bash

   podman run -it --rm CONTAINER_NAME ARGS

To use a container non-interactivel with a GPU with Podman, the basic syntax is:

**TODO**

To make a folder on the host available within the container environment, you must additionally use a bind-mount. For example, to make your home folder available at the same place inside a non-interactive coontainer:

.. code-block:: bash

   podman run --volume "$HOME:$HOME" --rm CONTAINER_NAME ARGS

The containers will be pulled automatically if they available from `DockerHub <https://hub.docker.com/r>`__ and not available locally.

Building Containers with Podman
_______________________________

With Podman, containers can be built by using a :plaintext:`Dockerfile`. See `Dockerfile reference <https://docs.docker.com/reference/dockerfile/>`__ for the full syntax.

To build a container, create a folder for the :plaintext:`Dockerfile`, say :plaintext:`CONTAINER_FOLDER`. Then store or write a :plaintext:`Dockerfile` at :plaintext:`CONTAINER_FOLDER/Dockerfile`. Then, to build the container, use the basic syntax is:

.. code-block:: bash

   podman build -t CONTAINER_NAME CONTAINER_FOLDER

Examples
________

Some examples of building and using containers are given below:

Build and Use a Container with Tensorflow and Various Python Packages (Podman)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To extend the `tensorflow/tensorflow image on DockerHub <https://hub.docker.com/r/tensorflow/tensorflow>`__) by installing various Python packages inside it, you could use the dockerfile below:

.. code-block:: dockerfile

   From tensorflow/tensorflow:2.17.0-gpu
   RUN pip install pandas matplotlib scikit-learn pyyaml keras biopython numba viennarna keras_tuner

Assuming the above is stored as a file called :plaintext:`Dockerfile` in a folder called :plaintext:`tensorflow-build`, it can be built with:

.. code-block:: bash

   podman build -t tensorflow-plus tensorflow-build

The container can then be executed with:

.. code-block:: bash

   podman run -it --rm tensorflow-plus

If you have a python script in your home folder called :plaintext:`myscript.py`, you could create (and submit -- see :doc:`/user-guide/resources`) a job file such as the following to run the python script in the container on a CPU node.

.. code-block:: sbatch

   #!/bin/bash
   #SBATCH -p cpu

   cd
   podman run --volume "$HOME:$HOME" --rm tensorflow-plus "$HOME/myscript.py"

To run the same python script on a GPU node with a GPU available, you could use the following:

**TODO**

Build a Container from Rocky Linux 9 with Python and :plaintext:`requirements.txt` (Podman)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To build a container from Rocky Linux 9 (functionally equivalent to Red Hat Enterprise Linux 9) and, install Python and arbitrary Python packages according to a :plaintext:`requirements.txt` file (in the same folder as the :plaintext:`Dockerfile` below), you could use the :plaintext:`Dockerfile` below:

.. code-block:: dockerfile

   From rockylinux:9
   COPY requirements.txt /requirements.txt
   RUN dnf install -y python3 python3-pip
   RUN python3 -m pip install -r /requirements.txt
