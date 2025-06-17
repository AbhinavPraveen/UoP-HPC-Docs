.. include:: ../siteinclude.rst

GROMACS
=======

The GROMACS free and open-source software suite for high-performance molecular dynamics and output analysis is available on all nodes of the cluster. 

Using GROMACS on the Lovelace Cluster
-------------------------------------

The GROMACS installation on the Lovelace cluster supports multi-node computation using the OpenMPI implementation of the MPI (Message Passing Interface) standard. This means that, during multi-node computation, data between nodes is transferred using our high-performance NDR200 interconnect using technologies like RDMA (Remote Direct Memory Access). We also support the use of Nvidia GPU Acceleration through the Nvidia CUDA.

To use GROMACS, it is sufficient to load the module (see also :doc:`/user-guide/modules`) using the command below:

.. code-block:: bash

   module load gromacs

GROMACS is then available as the :bash:`gmx_mpi` command. For example, the help text can be shown by running:

.. code-block:: bash

   gmx_mpi -h

Sample Multi-Node Job
---------------------

The following sample is adapted from the `jubench-gromacs <https://github.com/FZJ-JSC/jubench-gromacs/tree/main>`_ benchmark.

First we acquire the input file for the job. An archive containing the file is available at `<https://repository.prace-ri.eu/ueabs/GROMACS/2.2/GROMACS_TestCaseB.tar.xz>`_. You can download the archive on the Lovelace cluster using the command below:

.. code-block:: bash

   wget 'https://repository.prace-ri.eu/ueabs/GROMACS/2.2/GROMACS_TestCaseB.tar.xz'

We then extract the archive using the command below:

.. code-block:: bash

   tar xvf GROMACS_TestCaseB.tar.xz

Finally we create a job submission file called, say, :plaintext:`gromacs.slurm` containing:

.. code-block:: sbatch

   #!/bin/bash
   #SBATCH --nodes 4
   #SBATCH --ntasks-per-node=8
   
   module load gromacs
   srun --mpi=pmix gmx_mpi mdrun -s GROMACS_TestCaseB/lignocellulose.tpr -maxh 0.50 -resethway -noconfout -nsteps 10000 -g logfile -dlb auto

Here, note that:

* The :plaintext:`#!/bin/bash` header specifies that the BASH interpreter should be used for the script.
* The :plaintext:`#SBATCH --nodes 4` header specifies to distribute the computation should be distributed over 4 nodes. **This number can be increased or decreased independently.**
* The :plaintext:`#SBATCH --ntasks-per-node=8` header specifies that eight 'tasks' should be created on each node. This is a reasonable default and does not necessarily need to be changed.
* The :plaintext:`srun` command interacts with the Job Scheduler to spawn the GROMACS application (:plaintext:`gmx_mpi`) once for each task. 
* The :plaintext:`--mpi=pmix` requests Slurm to set up `PMIx <https://pmix.org/>`_ to allow OpenMPI to communicate and initialise itself.
* The :plaintext:`gmx_mpi mdrun` command starts the main computation chemistry engine within GROMACS with MPI support. Details of this command can be found at `<https://manual.gromacs.org/current/onlinehelp/gmx-mdrun.html>`_.
* The remainder of the final line specifies options to the computation chemistry engine within GROMACS. **This can be changed freely by the user as described in the documentation linked above.**

We can then submit the job file using the following command. Note that the archive extracted as above is expected to be in the same folder as the job submission file and the current working directory.

.. code-block:: bash

   sbatch gromacs.slurm

To generalise, users could use the following as a template:

.. code-block:: sbatch

   #!/bin/bash
   #SBATCH --nodes NUMBER_OF_NODES
   #SBATCH --ntasks-per-node=8
   
   module load gromacs
   srun --mpi=pmix gmx_mpi mdrun GROMACS_ARGUMENTS

Where :plaintext:`NUMBER_OF_NODES` and :plaintext:`GROMACS_ARGUMENTS` must be modified.
