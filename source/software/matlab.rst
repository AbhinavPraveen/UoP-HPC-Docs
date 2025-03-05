.. include:: ../siteinclude.rst

MATLAB
======

MATLAB Individual Edition and MATLAB Parallel Server are available on all nodes of the cluster. 

Using MATLAB
--------------

MATLAB can be used through the following methods:

* Using a Graphical User Interface through X11 forwarding
* Using a command-line/nodisplay MATLAB session
* Executing MATLAB scripts as batch jobs
* Using MATLAB Parallel Server to distribute computations

Graphical User Interface Session
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To initiate a Graphical User Interface session, **connect to the login node or a node which is allocated to you with X11 Forwarding enabled** (please Login and access the internal site `<https://docs.lovelace.plymouth.ac.uk/private/>`_ for instructions on this). Assuming that you have set up an ssh host named :plaintext:`lovelace` referring to the login node and you are on a supported platform, simply run:

.. code-block:: bash

   ssh -XY lovelace
   module load matlab_parallel_server
   matlab

Command-Line Session
~~~~~~~~~~~~~~~~~~~~

To load MATLAB and initiate a command-line session on a compute node, run:

.. code-block:: bash

   module load matlab_parallel_server
   srun --pty matlab -nodisplay

MATLAB Script as Batch Job
~~~~~~~~~~~~~~~~~~~~~~~~~~

To run a MATLAB script as a batch job you may, for example, create a script called :plaintext:`hello.m` containing the following text (or any other script you might write):

.. code-block:: bash

   disp('Hello, World!')

You may then run this script on a compute node as follows:

.. code-block:: bash

   module load matlab_parallel_server
   srun matlab -nodisplay < hello.m
