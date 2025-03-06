.. include:: ../siteinclude.rst

NVIDIA® CUDA® Toolkit
=====================

The Nvidia CUDA Toolkit is available on the login node and on the GPU nodes of the Lovelace cluster.

Loading CUDA
------------

Many applications will autodetect CUDA will not require CUDA to be loaded manually. To load CUDA manually, simply run:

.. code-block:: bash

   module load cuda-toolkit

To see the the current CUDA version that is supported on the graphics nodes of the cluster, run the following:

.. code-block:: bash

   module --default avail cuda-toolkit

CUDA is subect to version compatibility guarantees. [1]_ However, it is reccomended by the HPC Admin Team that users build their applications against the same version of CUDA, as given above, where possible.

.. [1] `<https://docs.nvidia.com/deploy/cuda-compatibility/>`_


Using CUDA
----------

CUDA documentation [2]_ and Nvidia's CUDA examples repository [3]_ are good resources for writing CUDA applications in the C or C++ programming languages.

.. [2] `<https://docs.nvidia.com/cuda/>`_

.. [3] `<https://github.com/NVIDIA/cuda-samples>`_

Alternatively, users can use packages in higher level programming languages such as CUDA.jl [4]_ for Julia or CuPy [5]_ for Python.

.. [4] `<https://juliagpu.org/cuda/>`_

.. [5] `<https://cupy.dev/>`_

Please also familiarise yourself with the job submission parameters needed to request GPUs as in :ref:`L40S <gpu_l40s_job>` and :ref:`H100 <gpu_h100_job>`.
