.. include:: ../siteinclude.rst

Running Graphical Applications With X11 Forwarding
==================================================

Graphical applications such as Ansys Workbench or MATLAB can be ran on a compute node and viewed on your local machine using X11 forwarding. X11 is a display protocol capable of operating over the network

Tis is possible with two approaches:

* Connecting the the Login Node with X11 forwarding enabled and then using Slurm's (Slurm is the job scheduler) X11 forwarding functionality to run a job on a compute node
* Getting a Job Allocation on a compute node and connecting to it directly

The former approach is detailed below. Please log in and see `<https://docs.lovelace.plymouth.ac.uk/private/>`_ for instructions on the latter case.

Slurm X11 Forwarding
--------------------

First connect to the lovelace cluster with X11 forwarding enabled (please Login and access the internal site `<https://docs.lovelace.plymouth.ac.uk/private/>`_ for instructions on this). Assuming that you have set up an ssh host named :plaintext:`lovelace` referring to the login node and you are on a supported platform, simply run:

.. code-block:: bash

   ssh -XY username@lovelace

Next, run the application using :bash:`srun` with its :plaintext:`--x11` option. In the following example, we use the :plaintext:`xeyes` application

.. code-block:: bash

   srun --x11 xeyes

You should then see a pair of googly eyes on your desktop. If you see this, then X11 forwarding is working.

Examples of software that could be used with X11 forwarding include:

* :doc:`/software/matlab`
