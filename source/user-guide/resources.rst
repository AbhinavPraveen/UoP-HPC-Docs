.. include:: ../siteinclude.rst

Accessing Compute Resources
===========================

The Lovelace Cluster uses Slurm to schedule jobs and allocate resources.

Writing a submission script is typically the most convenient way to
submit your job to the job submission system. Example submission scripts
(with explanations) for the most common job types are provided below.

Interactive jobs are also available and can be particularly useful for
developing and debugging applications. More details are available below.

If you have any questions on how to run jobs on Lovelace do not hesitate
to contact the HPC Support at `hpcsupport@plymouth.ac.uk <mailto:hpcsupport@plymouth.ac.uk>`_.

Using Slurm
------------

You typically interact with Slurm by (1) specifying Slurm directives in job
submission scripts (see examples below) and (2) issuing Slurm commands
from the login nodes.

There are three key commands used to interact with the Slurm on the
command line:

-  :bash:`sbatch`
-  :bash:`squeue`
-  :bash:`scancel`

Check the Slurm :bash:`man` page for more advanced commands:

.. code-block:: bash

    man slurm

The sbatch command
~~~~~~~~~~~~~~~~~~

The sbatch command submits a job to Slurm:

.. code-block:: bash

    sbatch job_script

This will submit your job script :plaintext:`job_script` to the job-queues.
See the sections below for details on how to write job scripts.

The qstat command
~~~~~~~~~~~~~~~~~

Use the command qstat to view the job queue. For example:

.. code-block:: bash

    squeue

will list all jobs on Lovelace.

You can view just your jobs by using:

.. code-block:: bash

    squeue -u <username>

The scancel command
~~~~~~~~~~~~~~~~~~~~

Use this command to delete a job from Lovelace's job queue. For example:

.. code-block:: bash

    scancel <jobid>

will remove the job with ID :plaintext:`<jobid>` from the queue.


Queues
------------

Please note that Slurm job scheduler uses the term 'partitions' to
refer to queues, and therefore you may see the word partition used
interchangeably both here and on other sites.

There are eight partitions available on the Lovelace cluster. These correspond to two sets of four partiitons. These are the standard queues (:plaintext:`cpu`, :plaintext:`cpu_highmem`, :plaintext:`gpu_h100`, :plaintext:`gpu_l40s`) and the billed queues (:plaintext:`cpu-billed`, :plaintext:`cpu_highmem-billed`, :plaintext:`gpu_h100-billed`, :plaintext:`gpu_l40s-billed`).

You may only schedule task on the billed queues if there is funding assosciated with your account. Jobs submitted to these queues will be prioritised over those submitted to the standard queue.

:plaintext:`cpu`
~~~~~~~~~~~~~~~~

To run on the :plaintext:`cpu` queue, add the following to the header of your
submission script :

.. code-block:: bash

   #SBATCH -p cpu

:plaintext:`cpu_highmem`
~~~~~~~~~~~~~~~~~~~~~~~~

To run on the :plaintext:`cpu_highmem` queue add the following to the header of your
submission script :

.. code-block:: bash

   #SBATCH -p cpu_highmem

.. _gpu_h100_job:

:plaintext:`gpu_h100`
~~~~~~~~~~~~~~~~~~~~~

To run on the :plaintext:`gpu_h100` queue add the following to the header of your
submission script :

.. code-block:: bash

   #SBATCH -p gpu_h100
   #SBATCH --gpus 1

Each job must request exactly one GPU if running on this partition.

.. _gpu_l40s_job:

:plaintext:`gpu_l40s`
~~~~~~~~~~~~~~~~~~~~~

To run on the :plaintext:`gpu_l40s` queue add the following to the header of your
submission script :

.. code-block:: bash

   #SBATCH -p l40s
   #SBATCH --gpus 1

Each job must request exactly one GPU if running on this partition.

Sometimes some nodes are "down" and less nodes are available.

If you have special request, contact `hpcsupport@plymouth.ac.uk
<mailto:hpcsupport@plymouth.ac.uk>`_.


Output from Slurm jobs
----------------------

Slurm produces the output of your job submission in a file with the format :plaintext:`slurm-<Job ID>.out`. This file will be created in the working directory from which you submitted the job with :bash:`sbatch`. You can view the job using the :bash:`less` utility as below:

.. code-block:: bash

   less -r slurm-<Job ID>.out
