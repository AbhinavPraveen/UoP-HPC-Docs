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
     1) gcc/13.3.1                   7) zlib/1.3.1-zkl5wjj         13) hwloc/2.11.1-mqg2qec     19) pigz/2.8-pipe537              25) libxcrypt/4.4.35-2leymva  31) rdma-core/52.0-vibka2e
     2) spack-modules/113            8) libxml2/2.13.4-vqoagpe     14) knem/1.1.4-prvvzic       20) zstd/1.5.6-pdk6d4j            26) openssh/9.9p1-agycqww     32) xpmem/2.6.5-36-rxnv6w6
     3) glibc/2.28-lmcpkml           9) cuda-toolkit/12.4.1        15) openssl/3.4.0-7ckv34u    21) tar/1.34-dzeehng              27) pmix/5.0.3-2gkjs47        33) ucx/1.17.0-mzix24r
     4) gcc-runtime/13.3.1-2kda5rk  10) cuda/12.4.1-b35sufh        16) libevent/2.1.12-tgsoax3  22) gettext/0.22.5-zjglimm        28) check/0.15.2-aflo7jk      34) ucc/1.3.0-h2s7mm6
     5) libiconv/1.17-6nlfqwe       11) libpciaccess/0.17-d5wcj52  17) numactl/2.0.18-xy2slzw   23) krb5/1.21.3-i3rz3pq           29) gdrcopy/2.4.1-xyc5lwi     35) openmpi/5.0.5-fp6i5jk
     6) xz/5.4.6-rb3mavc            12) ncurses/6.5-pnmzftp        18) bzip2/1.0.8-hwh4cnv      24) libedit/3.1-20240808-fxke3py  30) libnl/3.3.0-haaq6e3

Basic usage of the :bash:`module` command is covered below. For full documentation please see:

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

   ------------------------------------------- /users/cicd/.jenkins/workspace/UoP-Spack/main/113/spack/share/spack/lmod/openmpi/5.0.5-fp6i5jk/Core -------------------------------------------
      abyss/2.3.10-65lydhd         hpl/2.3-f7adg7v            py-keras/3.6.0-qm535qo            py-torch/2.5.1-h3qeknb    xbeach/6118-rfmbfsw
      adcirc/56.0.3-4oztlos        openfoam/2312-fyzw4ln      py-netcdf4/1.7.1.post2-lrnbi6s    swan/4145-filbquq
      bigdft-core/1.9.5-43un7wm    py-bigdft/1.9.5-4xrtwr7    py-tensorflow/2.17.1-mlz3f6e      swash/main-5s3s4uc

   ------------------------------------------------------ /users/cicd/.jenkins/workspace/UoP-Spack/main/113/spack/share/spack/lmod/Core ------------------------------------------------------
      bwa/0.7.17-v72ok5n             py-geopandas/1.0.1-vultwue      py-pip-py3.13/23.1.2-dauydjf            py-virtualenv-py3.13/20.26.5-sqb2hgl    trinity/2.15.1.FULL-myzlz5u
      gatk/4.5.0.0-yvwst4o           py-jupyter/1.1.1-32xgg6m        py-pip/23.1.2-qwz5sj5                   py-virtualenv/20.26.5-fmvfrje           ucx/1.17.0-mzix24r          (L)
      gnuplot/6.0.0-r5k27jt          py-matplotlib/3.9.2-hsad7f7     py-scipy/1.14.1-tisu5tg                 python-py3.12/3.12.5-uni66am
      openmpi/4.1.7-q3idazf          py-numpy/1.26.4-mde553l         py-sphinx-rtd-theme/1.2.2-45lz6nd       python-py3.13/3.13.0-irwel6m
      openmpi/5.0.5-fp6i5jk (L,D)    py-pandas/2.2.3-sgvtc6s         py-sphinx/6.2.1-fry74n4                 python/3.11.9-bgjodjg
      paml/4.10.7-pkdiklo            py-pip-py3.12/23.1.2-dor7udl    py-virtualenv-py3.12/20.26.5-qp5jrs3    r/4.4.1-flsgxmv

   -------------------------------------------------------------------------------- /scratch/software/modules --------------------------------------------------------------------------------
      ansys/2025_R1             conda/24.9.2               delft3d-fm/1          hpcx-modules/2.20                            julia/1.11.3                     spack-modules/113 (L)
      aocc/openmpi/4.1.5        cuda-toolkit/12.4.1 (L)    fsl/6.0.7.16          hpcx-modules/2.22.1                   (D)    matlab/R2024b
      aocc/4.2.0                delft3d-delft3d4/1         gcc/13.3.1   (L,D)    intel-oneapi-toolkit-modules/2024.2          matlab_parallel_server/R2024b
      aocc/5.0.0         (D)    delft3d-flow2d3d/1         gcc/14.2.1            intel-oneapi-toolkit-modules/2025.0.1 (D)    ohpc-modules/2

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

The GCC 13.3.1 compiler suite is available by default. This is because the :plaintext:`gcc/13.3.1` module is loaded by default.

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

+----------+----------+---------+
| Language | Intel    | GCC     |
+==========+==========+=========+
| Fortran  | mpiifort | mpifort |
+----------+----------+---------+
| C++      | mpiicpc  | mpicxx  |
+----------+----------+---------+
| C        | mpiicc   | mpicc   |
+----------+----------+---------+



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


Spack Modules
~~~~~~~~~~~~~

Most software modules provided on the Lovelace cluster are generated by the `Spack <https://spack.io>`_ package manager. These modules themselves are provided through the :plaintext:`spack-modules` metamodule. From time to time, the Spack modules on the Lovelace cluster may be regenerated (e.g. due to the release of a new compiler version). In the event that you would like to build and run your application against a fixed version of these modules, you can note down the version of the :plaintext:`spack-modules` metamodule that is in use (e.g. :plaintext:`spack-modules/113`). To use only modules (currently with the exception of the :plaintext:`gcc` module) provided in this version (and thus, a largely fixed set of binaries), you could use the command below:

.. code-block:: bash

   module purge
   module load spack-modules/113
   module load gcc openmpi

You should replace the version number above (113) with the number you noted down.

Additionally, if you would like to use the latest features we are developing on the Lovelace cluster, you can load the latest :plaintext:`spack-modules`. This is often newer than the default set. You can do this as follows.

.. code-block:: bash

   module purge
   module --latest load spack-modules
   module load gcc/13.3.1 openmpi

.. warn::

   Beta modules are used for testing and rapid iteration, and may have issues. Please be aware of this when using them.

Software Requests
~~~~~~~~~~~~~~~~~

Please contact the `HPC Admin Team <mailto:hpcsupport@plymouth.ac.uk>`_ if you would like to request or suggest for software to be installed onto the cluster.
