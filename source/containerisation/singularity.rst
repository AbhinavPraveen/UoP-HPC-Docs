.. include:: ../siteinclude.rst

Singularity
===========

Singularity is a container platform designed with a focus on integration (interacting with host system) and ease-of-use particularity in a HPC environment with a shared filesystem. Singularity, by default, uses images in the 'Singularity Image Format' (SIF). Singularity also supports images in the Open Container Initiative (OCI) format among others.

To get more information about Singularity, the following manual pages are available:

.. code-block:: bash

   man singularity
   man singularity-run
   man singularity-exec
   man singularity-build

Building and Using Containers with Singularity
------------------------------------

With Singularity, containers can be be built either by building using a Singularity Definition File (which defines the steps to build the container) or, by importing from an existing container in an alternative format.

The general format to building a container from a definiton file with Singularity is:

.. code-block:: bash

   singularity build --fakeroot SIF_FILE_NAME DEFINTION_FILE_NAME

The general format to converting an image from a container registry (such as `DockerHub <https://hub.docker.com/r>`__) is:

.. code-block:: bash

   singularity build SIF_FILE_NAME docker://SIF_FILE_PATH

The general format to running a container interactively is:

.. code-block:: bash

   singularity run SIF_FILE_NAME

The general format to running a command in a container non-interactively is:

.. code-block:: bash

   singularity exec SIF_FILE_NAME COMMAND ARGS...

The general format to running a container interactively with a GPU is (note that this must be ran on a GPU node):

.. code-block:: bash

   singularity run --nv SIF_FILE_NAME

The general format to running a command in a container non-interactively with a GPU is (note that this must be ran on a GPU node):

.. code-block:: bash

   singularity exec --nv SIF_FILE_NAME COMMAND ARGS...

These commands can be included on job submission scripts. Some specific examples of building containers with Singularity are given below.


Build and Use a Container with Tensorflow and Various Python Packages
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This examples extends the SIF image provided by the HPC Admin Team (itself based on the `tensorflow/tensorflow image on DockerHub <https://hub.docker.com/r/tensorflow/tensorflow>`__) by installing various Python packages inside it.

.. code-block:: singularity

   Bootstrap: localimage
   From: /users/lico/container/tensorflow-2.17.0-gpu.image

   %post
        pip install pandas matplotlib scikit-learn pyyaml keras biopython numba viennarna keras_tuner

Assuming a file containing the above is saved as :plaintext:`tensorflow-plus.def`, the container can be built with:

.. code-block:: singularity

   singularity build --fakeroot tensorflow-plus.sif tensorflow-plus.def

The container can then be executed with:

.. code-block:: bash
        
   singularity run tensorflow-plus.sif

If you have a python script in your home folder called :plaintext:`myscript.py`, you could create (and submit -- see :doc:`/user-guide/resources`) a job file such as the following to run the python script in the container on a CPU node. The following example assumes that both the SIF image and script are saved in your home folder.

.. code-block:: sbatch

   #!/bin/bash
   #SBATCH -p cpu

   cd
   singularity exec tensorflow-plus.sif python3 myscript.py

To run the same python script on a GPU node with a GPU available, you could use the following

.. code-block:: sbatch

   #!/bin/bash
   #SBATCH -p gpu_l40s
   #SBATCH --gpus 1

   cd
   singularity exec --nv tensorflow-plus.sif python3 myscript.py

Note the use of the :plaintext:`--nv` option.


Build a Container from Rocky Linux 9 with Python and :plaintext:`requirements.txt`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To build a container from Rocky Linux 9 (functionally equivalent to Red Hat Enterprise Linux 9) and, install Python and arbitrary Python packages according to a :plaintext:`requirements.txt` file (in the same folder as the Singularity definition file below), use the definition file below.

.. code-block:: singularity

   Bootstrap: docker
   From: rockylinux:9

   %files
        requirements.txt /requirements.txt

   %post
        dnf install -y python3 python3-pip
        python3 -m pip install -r /requirements.txt

To import the :plaintext:`texlive/texlive` image from `DockerHub <https://hub.docker.com/r/texlive/texlive>`__:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   singularity build texlive.sif docker://texlive/texlive
