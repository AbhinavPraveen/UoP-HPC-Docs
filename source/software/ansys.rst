.. include:: ../siteinclude.rst

Ansys
=====

Ansys Software is available on the Lovelace Cluster. Graphical Ansys software, such as Ansys workbench, can be used with X11 Forwarding. An example is given below.

Ansys Workbench with X11 Forwarding
-----------------------------------

To initiate a Graphical User Interface session, **connect to the login node with X11 Forwarding enabled** (please Login and access the internal site `<https://docs.lovelace.plymouth.ac.uk/private/>`_ for instructions on this). Assuming that you have set up an ssh host named :plaintext:`lovelace` referring to the login node and you are on a supported platform, simply run:

.. code-block:: bash

   ssh -XY lovelace
   module load ansys
   srun --x11 runwb2

Ansys Workbench will run on a compute node but its interface will be visible to you on your local device.
