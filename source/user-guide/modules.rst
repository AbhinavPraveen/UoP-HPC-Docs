.. include:: ../siteinclude.rst

Accessing Software with Modules
===================================

The software environment on the Lovelace cluster is primarily
controlled through *modules*. By loading and switching
modules you control the compilers, libraries and software available.

This means that for compiling software on Lovelace you typically set the compiler
you wish to use by loading the appropriate compiler module, and load all the
required library modules (e.g. numerical libraries such as OpenBLAS, driver related libraries such as CUDA, and IO format libraries).

Additionally, if you are compiling parallel applications using MPI 
(or SHMEM, etc.) then you will need to load the MPI environment
and use the appropriate compiler wrapper scripts.


The list of the modules loaded  can be obtained by typing:

.. code-block:: console

   [apraveen@uop-hpc ~]$ module list

   Currently Loaded Modules:
     1) gcc/13.2.1                   7) libxml2/2.13.4-lbtcocn     13) knem/1.1.4-zepjoi3       19) zstd/1.5.6-jz52fum            25) openssh/9.9p1-g77smjt   31) xpmem/2.6.5-36-37nyl32
     2) glibc/2.28-irs6j3j           8) cuda-toolkit/12.4.1        14) openssl/3.4.0-ayikrvj    20) tar/1.34-sh7q6fd              26) pmix/5.0.3-rpwutdw      32) ucx/1.17.0-mzdeqja
     3) gcc-runtime/13.2.1-lkklc4c   9) cuda/12.4.1-bcuhqd3        15) libevent/2.1.12-z4htgrn  21) gettext/0.22.5-3tvehct        27) check/0.15.2-ix4rojx    33) ucc/1.3.0-gl5spbf
     4) libiconv/1.17-bc3us7y       10) libpciaccess/0.17-txxvscv  16) numactl/2.0.18-bzdanek   22) krb5/1.21.3-bsozc3b           28) gdrcopy/2.4.1-mm5coch   34) openmpi/5.0.5-rcpsiyw
     5) xz/5.4.6-wxtrn6y            11) ncurses/6.5-wiqyrxp        17) bzip2/1.0.8-pyp2qtp      23) libedit/3.1-20240808-cl4k7o7  29) libnl/3.3.0-tmlq6yg
     6) zlib-ng/2.2.1-2ugru5y       12) hwloc/2.11.1-oomahxc       18) pigz/2.8-trznccw         24) libxcrypt/4.4.35-hydo43o      30) rdma-core/52.0-anqcllq

Basic usage of the :bash:`module` command is covered below. For
full documentation please see:

-  `User Guide for Lmod <https://lmod.readthedocs.io/en/latest/010_user.html>`_

Using the modules environment
-----------------------------

Information on the available modules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Finding out which modules (and hence which compilers, libraries and
software) are available on the system is performed using the
:bash:`module avail` command:

.. code-block:: console

   [apraveen@uop-hpc ~]$ module avail

   ------------------------------------------- /users/cicd/.jenkins/workspace/UoP-Spack/main/57/spack/share/spack/lmod/openmpi/5.0.5-rcpsiyw/Core --------------------------------------------
      hpl/2.3-cdf3jzd    openfoam/2312-3ez75zr    py-keras/3.6.0-25pmojg    py-netcdf4/1.7.1.post2-ueeh5rw    py-tensorflow/2.17.1-3yn3j3r    py-torch/2.5.1-uezq4xs

   ------------------------------------------------------ /users/cicd/.jenkins/workspace/UoP-Spack/main/57/spack/share/spack/lmod/Core -------------------------------------------------------
      gnuplot/6.0.0-axewn2o               py-matplotlib/3.9.2-zsu3nys     py-pip/23.1.2-o3vbbue                   py-virtualenv-py3.13/20.26.5-odglpfj    r/4.4.1-bxhk7cu
      openmpi/4.1.7-apv3r7k               py-numpy/1.26.4-mv6lajg         py-scipy/1.14.1-f23svxk                 py-virtualenv/20.26.5-ss4meiy           ucx/1.17.0-mzdeqja (L)
      openmpi/5.0.5-rcpsiyw      (L,D)    py-pandas/2.2.3-gfq43vl         py-sphinx-rtd-theme/1.2.2-bn4hnfg       python-py3.12/3.12.5-yhgncqw
      py-geopandas/1.0.1-iuzpkxu          py-pip-py3.12/23.1.2-s3hkt4u    py-sphinx/6.2.1-4lot3ku                 python-py3.13/3.13.0-a2js47p
      py-jupyter/1.1.1-hdsgzlk            py-pip-py3.13/23.1.2-za2klvv    py-virtualenv-py3.12/20.26.5-5d4ku23    python/3.11.9-spkc57n

   -------------------------------------------------------------------------------- /scratch/software/modules --------------------------------------------------------------------------------
      ansys/2025_R1         aocc/5.0.0          (D)    gcc/13.2.1                 intel-oneapi-toolkit-modules/2024.2          matlab/R2024b
      aocc/openmpi/4.1.5    cuda-toolkit/12.4.1 (L)    hpcx-modules/2.20          intel-oneapi-toolkit-modules/2025.0.1 (D)    matlab_parallel_server/R2024b
      aocc/4.2.0            fsl/6.0.7.16               hpcx-modules/2.22.1 (D)    julia/1.11.3                                 ohpc-modules/2

     Where:
      D:  Default Module
      L:  Module is loaded

   Module defaults are chosen based on Find First Rules due to Name/Version/Version modules found in the module tree.
   See https://lmod.readthedocs.io/en/latest/060_locating.html for details.

   If the avail list is too long consider trying:

   "module --default avail" or "ml -d av" to just list the default modules.
   "module overview" or "ml ov" to display the number of modules for each name.

   Use "module spider" to find all possible modules and extensions.
   Use "module keyword key1 key2 ..." to search for all possible modules matching any of the "keys".

This will list the names and versions of selected modules available on
the service. Not all of them may work in your account though due to,
for example, licencing restrictions. You will notice that for many
modules we have more than one version, each of which is identified by a
version number. One of these versions is the default. As the
service develops the default version will change.

To list the names of all modules available on the system, run the command below. These are normally hidden as these modules are typically not directly used by users. Instead, these modules are usually automatically loaded as dependencies of other modules. Using this command is not recommended for users due to the excessive number of modules.

.. code-block:: bash

   module --show_hidden avail

You can list all the modules of a particular type by providing an
argument to the :bash:`module avail` command. For example, to list all
available versions of the Intel libraries, compilers and tools:

.. code-block:: console

   [apraveen@uop-hpc ~]$ module avail intel-oneapi-toolkit-modules

   -------------------------------------------------------------------------------- /scratch/software/modules --------------------------------------------------------------------------------
      intel-oneapi-toolkit-modules/2024.2    intel-oneapi-toolkit-modules/2025.0.1 (D)
   ...

If you want more info on any of the modules, you can use the :bash:`module help` command:

.. code-block:: console

   [apraveen@uop-hpc ~]$ module help python

   -------------------------------------------------------------------- Module Specific Help for "python/3.11.9-spkc57n" ---------------------------------------------------------------------
   Name   : python
   Version: 3.11.9
   Target : zen4

   The Python programming language.

Loading, unloading and swapping modules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To load a module to use :bash:`module add` or :bash:`module load`. For example,
to load the default Intel compilers and their dependencies into the development environment:

.. code-block:: bash

    module load intel-oneapi-toolkit-modules umf tbb compiler-rt compiler

If you need a specific version of each module, you can add more information:

.. code-block:: bash

    module load intel-oneapi-toolkit-modules/2025.0.1 umf/0.9.1 tbb/2022.0 compiler-rt/2025.0.4 compiler/2025.0.4

This will load the specified versions of the packages. If you
want to clean up, :bash:`module remove` will remove a loaded module:

.. code-block:: bash

    module remove intel-oneapi-toolkit-modules/2025.0.1 umf/0.9.1 tbb/2022.0 compiler-rt/2025.0.4 compiler/2025.0.4

(or :bash:`module rm tbb compiler-rt compiler` or
:bash:`module unload tbb compiler-rt compiler`) will unload what ever version of
intel (even if it is not the default) you might have
loaded. There are many situations in which you might want to change the
presently loaded version to a different one, such as trying the latest
version which is not yet the default or using a legacy version to keep
compatibility with old data. This can be achieved most easily by using 
:bash:`module swap oldmodule newmodule`. 

Available Compiler Suites
-------------------------

.. note::
   As lovelace uses dynamic linking by default you will generally also need
   to load any modules you used to compile your code in your job submission
   script when you run your code.


GCC Compiler Suite
~~~~~~~~~~~~~~~~~~

The GCC 13.2.1 compiler suite is available by default. This is because the :plaintext:`gcc/13.2.1` module is loaded by default.

The compilers are available as:

* :bash:`gfortran` - Fortran
* :bash:`gcc` - C
* :bash:`g++` - C++

AMD Optimizing C/C++ and Fortran Compilers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The AOCC compiler suite is also available. This can be loaded with:

.. code-block:: bash

   module load aocc

The compilers are then available as:

* :bash:`flang` - Fortran
* :bash:`clang` - C
* :bash:`clang++` - C++

Intel® oneAPI Compilers
~~~~~~~~~~~~~~~~~~~~~~~

The Intel oneAPI compiler suite is available as in the example above. This can be loaded with:

.. code-block:: bash

   module load intel-oneapi-toolkit-modules umf tbb compiler-rt compiler

The compilers are then available as:

* :bash:`ifx` - Fortran
* :bash:`icx` - C
* :bash:`icpx` - C++

Compiling MPI codes
-------------------

Lovelace supports multiple MPI libraries including OpenMPI and Intel MPI. Both are available as modules.

Using GCC Compilers and openmpi
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenMPI 5.0.5 is available by default. This is because the OpenMPI module is loaded by default.

  

The MPI compilers are then available as

* ``mpifort`` - Fortran with MPI
* ``mpicc`` - C with MPI
* ``mpicxx`` - C++ with MPI


Summary
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The name of the  wrapper
script depends on the compiler suite you are using. In summary:

+----------+----------+--------+
| Language | Intel    | GCC    |
+==========+==========+========+
| Fortran  | mpiifort | mpif90 |
+----------+----------+--------+
| C++      | mpiicpc  | mpicxx |
+----------+----------+--------+
| C        | mpiicc   | mpicc  |
+----------+----------+--------+



Compiler Information and Options
--------------------------------

Help is available for the different compiler suites

GCC
    Fortran :bash:`gfortran --help` or :bash:`man gfortran`,
    C/C++ :bash:`gcc --help` or :bash:`man gcc`
Intel
    Fortran ``man ifx`` ,
    C/C++ ``man icx``

Useful compiler options
~~~~~~~~~~~~~~~~~~~~~~~

Whilst difference codes will benefit from compiler optimisations in
different ways, for reasonable performance on Lovelace, at least
initially, we suggest the following compiler options:

Intel
    ``-O2``
GNU
    ``-O2 -funroll-loops -march=native``


Software Requests
~~~~~~~~~~~~~~~~~

Please contact the `HPC Admin Team <mailto:hpcsupport@plymouth.ac.uk>`_ if you would like to request or suggest for software to be installed onto the cluster.
