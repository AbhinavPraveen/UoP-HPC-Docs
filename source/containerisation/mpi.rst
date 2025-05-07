.. include:: ../siteinclude.rst

Running Containerised MPI Workloads with Slurm
==============================================

Running Containerised MPI Workloads is not recommended for most users do to its complexity. It is possible however and provides some advantages in reproducibility and allows use of applications that do not support the environment on the Lovelace cluster (e.g. an application does not support the current version of the Red Hat Enterprise Linux distribution).

This will consist of building a container that is compatibile with the host environment (including Slurm, PMIx, and OFED) with Podman. We extend the container to include the MPI application using the example of `HiRep <https://github.com/claudiopica/HiRep>`_. We will then convert the container to a Singularity container - this makes it easier to allow the container to access MPI, Network and Device information from the host as this is allowed by default by Singularity but restricted by Podman. We will finally write a Job Submission script to run the container and the workload within the container.

Building the OpenMPI Container
------------------------------

We follow the process given in :doc:`/containerisation/podman`. We start by creating a folder called :plaintext:`openmpi` with a file called :plaintext:`Dockerfile` with the contents below:

.. literalinclude:: /_static/Dockerfile_openmpi5_manual
   :language: bash

Note that the container above is built against a Red Hat Universal Base Image. Users may choose to use rockylinux instead. We also expect installation files for `Nvidia OFED <https://network.nvidia.com/products/infiniband-drivers/linux/mlnx_ofed/>`_, `PMIx Reference Library (OpenPMIX) <https://github.com/openpmix/openpmix/releases>`_, `PMIx Reference RunTime Environment (PRRTE) <https://github.com/openpmix/prrte/releases>`_, and `OpenMPI <https://www.open-mpi.org/software/ompi/v5.0/>`_ to be in the :plaintext:`openmpi` folder. Each file can be download from the linked sources.

Additionally, a file called :plaintext:`.rpmmacros` with the following contents is expected in the folder:

.. literalinclude:: /_static/rpmmacros-openmpi

We then build the container with:

.. code-block:: bash

   podman build -t openmpi openmpi

Note that we expect the :plaintext:`openmpi` folder mentioned previously to be in the current working directory.


Extending the OpenMPI Container with the HiRep Application
----------------------------------------------------------

We then extend the container using the Dockerfile below. We create a folder called :plaintext:`hirep` with a file called :plaintext:`Dockerfile` with the contents below:

.. literalinclude:: /_static/Dockerfile_hirep
   :language: bash

We also expect the source files for HiRep at a specific commit to be in the :plaintext:`hirep` folder. This can be downloaded from `<https://github.com/claudiopica/HiRep/archive/57bac424dec078bbccb0d3eeb7e32a027d023685.zip>`_.

Next we build the container with:

.. code-block:: bash

   podman build -t hirep hirep

Note that we expect the :plaintext:`hirep` folder mentioned previously to be in the current working directory.

Convert the Container to a Singularity Container
------------------------------------------------

We now convert the container to a Singularity container. This can be done with the following command:

.. code-block:: bash

   podman save --format oci-archive hirep | singularity build hirep.sif oci-archive:///dev/stdin

This will create a file called :plaintext:`hirep.sif` which contains the container.

Submit the Job with Slurm
-------------------------

Finally, we will create a job submission file for the DiracOperator component of HiRep. First we create an input file called :plaintext:`hirep_input_file` with the following contents:

.. literalinclude:: /_static/hirep_input_file

We can the submit the job using the following Job Submission script:

.. literalinclude:: /_static/container_hirep.slurm

Note that we expect :plaintext:`hirep_input_file`, :plaintext:`hirep.sif` and the Job Submission script to be in the current working directory. Note that this example uses PMIx with OpenMPI but other MPI Implementations (such as Intel MPI) may work better with :plaintext:`--mpi=pmi2`.

We can submit the job above as normal and, upon completion, you should see the output of the DiracOperator test in a file called :plaintext:`hirep_output_file` in the current working directory.
