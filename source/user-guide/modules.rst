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

   [user@uop-hpc ~]$ module list

   Currently Loaded Modules:
     1) prun/2.2   2) gnu12/12.3.0   3) hwloc/2.7.2   4) ucx/1.15.0   5) libfabric/1.19.0   6) openmpi4/4.1.6   7) singularity/3.7.1   8) ohpc

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

   [user@uop-hpc ~]$ module avail

   ----------------------------------------------------------------------------- /opt/ohpc/pub/moduledeps/gnu12 ------------------------------------------------------------------------------
      mpich/3.4.3-ucx    mvapich2/2.3.7    openmpi4/4.1.6 (L)

   -------------------------------------------------------------------------------- /opt/ohpc/pub/modulefiles --------------------------------------------------------------------------------
      EasyBuild/4.9.1    conda/24.9.2    gnu12/12.3.0 (L)    libfabric/1.19.0 (L)    os            prun/2.2          (L)    ucx/1.15.0 (L)
      cmake/3.24.2       gnu/12.3.0      hwloc/2.7.2  (L)    ohpc             (L)    pmix/4.2.9    singularity/3.7.1 (L)
   ...

This will list the names and versions of selected modules available on
the service. Not all of them may work in your account though due to,
for example, licencing restrictions. You will notice that for many
modules we have more than one version, each of which is identified by a
version number. One of these versions is the default. As the
service develops the default version will change.

To list the names of all modules available on the system, run the command below. These are normally hidden as these modules are typically not directly used by users. Instead, these modules are usually automatically loaded as dependancies of other modules. Using this command is not recommended for users due to the excessive number of modules.

.. code-block:: bash

   module --show_hidden avail

You can list all the modules of a particular type by providing an
argument to the :bash:`module avail` command. For example, to list all
available versions of the Intel libraries, compilers and tools:

.. code-block:: console

   [user@uop-hpc ~]$ module avail gnu

   -------------------------------------------------------------------------------- /opt/ohpc/pub/modulefiles --------------------------------------------------------------------------------
      gnu/12.3.0    gnu12/12.3.0 (L)
   ...

If you want more info on any of the modules, you can use the :bash:`module help` command:

.. code-block:: console

   [user@uop-hpc ~]$ module help openmpi4

   ------------------------------------------------------------------------ Module Specific Help for "openmpi4/4.1.6" ------------------------------------------------------------------------

   This module loads the openmpi4 library built with the gnu12 toolchain.

   Version 4.1.6


Loading, unloading and swapping modules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To load a module to use :bash:`module add` or :bash:`module load`. For example,
to load the default Intel compilers and their dependencies into the development environment:

.. code-block:: bash

    module load tbb compiler-rt compiler

If you need a specific version of each module, you can add more information:

.. code-block:: bash

    module load tbb/2021.13 compiler-rt/2024.2.1 compiler/2024.2.1

This will load the specified versions of the packages. If you
want to clean up, :bash:`module remove` will remove a loaded module:

.. code-block:: bash

    module remove tbb/2021.13 compiler-rt/2024.2.1 compiler/2024.2.1

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

The GCC 12.3.0 compiler suite is available by default. This is because the :plaintext:`gnu12/12.3.0` module is loaded by default.

The compilers are available as:

* :bash:`gfortran` - Fortran
* :bash:`gcc` - C
* :bash:`g++` - C++

AMD Optimizing C/C++ and Fortran Compilers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The AOCC compiler suite is also available. This can be loaded with:

.. code-block:: bash

   module load aocc/4.2.0

The compilers are then available as:

* :bash:`flang` - Fortran
* :bash:`clang` - C
* :bash:`clang++` - C++

Intel® oneAPI Compilers
~~~~~~~~~~~~~~~~~~~~~~~

The Intel oneAPI compiler suite is available as in the example above. This can be loaded with:

.. code-block:: bash

    module load tbb compiler-rt compiler

The compilers are then available as:

* :bash:`ifx` - Fortran
* :bash:`icx` - C
* :bash:`icpx` - C++

Compiling MPI codes
-------------------

Lovelace supports multiple MPI libraries including OpenMPI and Intel MPI. Both are available as modules.

Using GCC Compilers and openmpi
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To load :plaintext:`openmpi4`, type:

.. code-block:: bash


   module load openmpi4
  

The MPI compilers are then available as

* ``mpif90`` - Fortran with MPI
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
