.. include:: ../siteinclude.rst

OpenFOAM
========

OpenFOAM is the free, open source CFD software developed primarily by OpenCFD Ltd since 2004. It is available on the Lovelace cluster through two modes:

#. Locally built (Recent release only)
#. Container based (Multiple historical releases provided - more can be added on request)

Option 1 provides a recent release built by the HPC Admin Team and optimized to run on the Lovelace cluster. It should be generally used when maximising performance, using new functionality in OpenFOAM or for reliability and ease of user.

Option 2 is based on the OpenFOAM images published `here <https://hub.docker.com/r/opencfd/openfoam-default>`_ packaged as a :doc:`/containerisation/singularity` container with some 'wrapper' scripts provided. These scripts enable users to run the containerised version as if it were locally installed. This option should be used when desiring reproducibility.

Locally Built
-------------

.. warning::

   The current :plaintext:`openfoam/2312` has a bug where its utilities are unavailable. Users are recommended to switch to a beta set of Spack modules for now using the approach documented in :doc:`/user-guide/modules`. This will be fixed in the next release.

To use the locally built version, load OpenFOAM as follows.

.. code-block:: bash

   module --expert load openfoam

.. note::

   Here, :plaintext:`--expert` is recommended because OpenFOAM, through its chain of dependencies, depends on the LLVM Suite which provides the Clang compiler. On the Lovelace cluster, the GCC compiler is loaded by default. Normally, the module system will refuse to load multiple compiler modules however the :plaintext:`--expert` flag tells the module system to ignore this and proceed anyway. Curios users could try running the command above without :plaintext:`--expert` and see the result. Unloading GCC with :bash:`module rm gcc` would also be an option.


After this, users can use the OpenFOAM suite as normal. For example, try:

.. code-block:: bash

   icoFoam -help

Container Based
---------------

To use the contianer based approach, first see the available OpenFOAM versions:

.. code-block:: bash

   module avail openfoam

.. code-block:: console

   [apraveen@uop-hpc ~]$ module avail openfoam

   ----------------------------------------------------- /scratch/cicd/jenkins/workspace/UoP-Spack/main/192/spack/share/spack/lmod/openmpi/5.0.5-skres45/Core -----------------------------------------------------
      openfoam/2412-6y5xghw (L)

   ------------------------------------------------------------------------------------------ /scratch/software/modules -------------------------------------------------------------------------------------------
      openfoam/2206-container    openfoam/2212-container    openfoam/2306-container    openfoam/2312-container    openfoam/2506-container

As the name suggests, the versions suffixed with :plaintext:`container` are the container based versions. Let us pick :plaintext:`openfoam/2312-container` and load it.

.. code-block:: bash

   module load openfoam/2312-container

Users can then run OpenFOAM utilities as normal:

.. code-block:: console

   [apraveen@uop-hpc ~]$ module load openfoam/2312-container
   This is a Container based OpenFOAM module. Try running `openfoam-shell`.
   [apraveen@uop-hpc ~]$ icoFoam -help
   This is a Container based OpenFOAM module. Try running `openfoam-shell`.
   
   Usage: icoFoam [OPTIONS]
   Options:
     -case <dir>       Case directory (instead of current directory)
     -decomposeParDict <file>
                    Alternative decomposePar dictionary file
     -dry-run          Check case set-up only using a single time step
     -dry-run-write    Check case set-up and write only using a single time step
     -parallel         Run in parallel
     -postProcess      Execute functionObjects only
     -doc              Display documentation in browser
     -help             Display short help and exit
     -help-full        Display full help and exit
   
   Transient solver for incompressible, laminar flow of Newtonian fluids.
   
   Using: OpenFOAM-2312 (2312) - visit www.openfoam.com
   Build: _c39a0f64-20231220
   Arch:  LSB;label=32;scalar=64

Note particularly that the version is that which we picked earlier.

One more method is provided for working with this OpenFOAM installation. That is the :plaintext:`openfoam-shell` command mentioned in the output above. To start a shell session with OpenFOAM utilites, simply run :plaintext:`openfoam-shell`.

.. code-block:: console

   [apraveen@uop-hpc ~]$ openfoam-shell
   This is a Container based OpenFOAM module. Try running `openfoam-shell`.
   ---------------------------------------------------------------------------
     =========                 |
     \\      /  F ield         | OpenFOAM in a container [from OpenCFD Ltd.]
      \\    /   O peration     |
       \\  /    A nd           | www.openfoam.com
        \\/     M anipulation  |
   ---------------------------------------------------------------------------
    Container Recipes:  https://develop.openfoam.com/packaging/containers
   ---------------------------------------------------------------------------
    Release notes:  https://www.openfoam.com/news/main-news/openfoam-v2312
    Documentation:  https://www.openfoam.com/documentation/
    Issue Tracker:  https://develop.openfoam.com/Development/openfoam/issues/
    Local Help:     more /openfoam/README
   ---------------------------------------------------------------------------
   System   :  Ubuntu 22.04.3 LTS  (admin user: sudofoam)
   OpenFOAM :  /usr/lib/openfoam/openfoam2312
   Build    :  _c39a0f64-20231220 OPENFOAM=2312 patch=0
   
   Note
       Different OpenFOAM components and modules may be present (or missing)
       on any particular container installation.
       Eg, source code, tutorials, in-situ visualization, paraview plugins,
           external linear-solver interfaces etc.
   ---------------------------------------------------------------------------
   Singularity> icoFoam -help
   
   Usage: icoFoam [OPTIONS]
   Options:
     -case <dir>       Case directory (instead of current directory)
     -decomposeParDict <file>
                    Alternative decomposePar dictionary file
     -dry-run          Check case set-up only using a single time step
     -dry-run-write    Check case set-up and write only using a single time step
     -parallel         Run in parallel
     -postProcess      Execute functionObjects only
     -doc              Display documentation in browser
     -help             Display short help and exit
     -help-full        Display full help and exit
   
   Transient solver for incompressible, laminar flow of Newtonian fluids.
   
   Using: OpenFOAM-2312 (2312) - visit www.openfoam.com
   Build: _c39a0f64-20231220
   Arch:  LSB;label=32;scalar=64

You can use :plaintext:`openfoam-shell` to run scripts. For example, if you a script called :plaintext:`makefoam.sh`:

.. code-block:: bash

   openfoam-shell makefoam.sh

Finally, you can also use :plaintext:`openfoam-shell` as a `shebang <https://en.wikipedia.org/wiki/Shebang_(Unix)>`_. For example, create a file as follows called, say, :plaintext:`icofoamtest.sh` :

.. code-block:: bash

   #!/usr/bin/env openfoam-shell
   icoFoam -help

Mark the file as executable

.. code-block:: bash

   chmod +x icofoamtest.sh

And execute it:

.. code-block:: console

   [apraveen@uop-hpc ~]$ ./icofoamtest.sh
   This is a Container based OpenFOAM module. Try running `openfoam-shell`.
   
   Usage: icoFoam [OPTIONS]
   Options:
     -case <dir>       Case directory (instead of current directory)
     -decomposeParDict <file>
                       Alternative decomposePar dictionary file
     -dry-run          Check case set-up only using a single time step
     -dry-run-write    Check case set-up and write only using a single time step
     -parallel         Run in parallel
     -postProcess      Execute functionObjects only
     -doc              Display documentation in browser
     -help             Display short help and exit
     -help-full        Display full help and exit
   
   Transient solver for incompressible, laminar flow of Newtonian fluids.
   
   Using: OpenFOAM-2312 (2312) - visit www.openfoam.com
   Build: _c39a0f64-20231220
   Arch:  LSB;label=32;scalar=64

The above output shows that :plaintext:`icoFoam` from the appropriate OpenFoam version was executed. Note that the OpenFOAM container based module must be loaded for this to work.
