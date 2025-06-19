.. include:: ../siteinclude.rst

Python
======

The Python programming language is provided on all nodes of the Lovelace. Multiple versions of the Python Interpreter are provided. In fact, for a specific version of Python (e.g. Python 3.11), multiple versions of the same Interpreter are provided. This document details how users should load or install packages on the cluster.

Setting up a Python Environment with Modules
--------------------------------------------

A selection of Python Packages are available through the modules framework described in `../user-guide/modules`. To see a selection of the available Python packages, run:

.. code-block:: bash

   module avail

Many Python packages are hidden as they are usually not directly loaded by users but rather as dependencies of other Python packages. It is possible show these packages but this view is not reccomended for users due to the length of the output. To see all available packages, run the command below.

.. code-block:: bash

   module --show_hidden avail

Modules for Python packages are named with the prefix :plaintext:`py-`. Such modules support a specific version of Python. You can tell which packages a module supports by looking at its suffix. If there is no suffix, the module supports the recommended version of Python selected by the HPC Admin team, currently Python 3.11. If there is a suffix, such as :plaintext:`-py3.13`, the module supports only the version indicated in the suffix. Some examples of the naming convention are given below:

* :plaintext:`py-numpy` provides the NumPy Python Package for the recommended version of Python (currently Python 3.11)
* :plaintext:`py-pip` provides the Pip Python Package for the recommended version of Python (currently Python 3.11)
* :plaintext:`py-pip-py3.13` provides the Pip Python Package for Python 3.13

To load only the recommended version of python itself, simply run:

.. code-block:: bash

   module load python

Using Packages Provided in Modules with The Recommended Python
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Note the modules you would like to use. For instance, say that we would like to use Numpy and Scipy. We see that :plaintext:`py-numpy` and :plaintext:`py-scipy` are available from the output of the command above. Also, we additionally assume that we would like to use the recommended version of Python, 3.11. In this case, it is sufficient to load these modules as follows:

.. code-block:: bash

   module load py-numpy py-scipy

Then we can use numpy within python. For example:

.. code-block:: console

   [apraveen@uop-hpc ~]$ module load py-numpy py-scipy
   [apraveen@uop-hpc ~]$ python3
   Python 3.11.9 (main, Feb  3 2025, 14:12:39) [GCC 13.2.1 20231205 (Red Hat 13.2.1-6)] on linux
   Type "help", "copyright", "credits" or "license" for more information.
   >>> import numpy
   >>> numpy.eye(3)
   array([[1., 0., 0.],
          [0., 1., 0.],
          [0., 0., 1.]])

.. raw:: html

   <div id="asciinemademo"></div>
   <script src="/_static/asciinema-player.min.js"></script>
   <script>
     AsciinemaPlayer.create('/_static/numpy.cast', document.getElementById('asciinemademo'), {
       theme: 'dracula',
     });
   </script>

Note that Python 3.11 and many other modules are implicitly loaded as dependencies. To see the loaded modules, you may use the command below:

.. code-block:: bash

   module list

Using Both Packages Provided in Modules and Those Available Externally with The Recommended Python
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

However, if we want to use Numpy, Scipy and a module not currently provided on Lovelace such as Pygame, additionally load the virtualenv and pip and install Pygame within a virtual environment.

.. code-block:: console

   [apraveen@uop-hpc ~]$ module load py-numpy py-scipy py-virtualenv
   [apraveen@uop-hpc ~]$ virtualenv pygame
   created virtual environment CPython3.11.9.final.0-64 in 297ms
     creator CPython3Posix(dest=/users/apraveen/pygame, clear=False, no_vcs_ignore=False, global=False)
     seeder FromAppData(download=False, pip=bundle, setuptools=bundle, wheel=bundle, via=copy, app_data_dir=/users/apraveen/.local/share/virtualenv)
       added seed packages: pip==24.3.1, setuptools==75.7.0, wheel==0.45.1
     activators BashActivator,CShellActivator,FishActivator,NushellActivator,PowerShellActivator,PythonActivator
   [apraveen@uop-hpc ~]$ . pygame/bin/activate
   (pygame) [apraveen@uop-hpc ~]$ pip install pygame
   Collecting pygame
     Downloading pygame-2.6.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (12 kB)
   Downloading pygame-2.6.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (14.0 MB)
      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 14.0/14.0 MB 126.8 MB/s eta 0:00:00
   Installing collected packages: pygame
   Successfully installed pygame-2.6.1

   [notice] A new release of pip is available: 24.3.1 -> 25.0
   [notice] To update, run: pip install --upgrade pip
   (pygame) [apraveen@uop-hpc ~]$ python3
   Python 3.11.9 (main, Feb  3 2025, 14:12:39) [GCC 13.2.1 20231205 (Red Hat 13.2.1-6)] on linux
   Type "help", "copyright", "credits" or "license" for more information.
   >>> import pygame
   >>> ...

Using Packages Available Externally with a Python other than the Recommended Version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Few modules are provided for Python versions other than the reccomnded one. As such, packages should generally be installed through Pip when using such a Python version. For instance, to use Numpy with Python 3.13:


.. code-block:: console

   [apraveen@uop-hpc ~]$ module load py-virtualenv-py3.13
   [apraveen@uop-hpc ~]$ virtualenv numpy
   created virtual environment CPython3.13.0.final.0-64 in 565ms
     creator CPython3Posix(dest=/users/apraveen/numpy, clear=False, no_vcs_ignore=False, global=False)
     seeder FromAppData(download=False, pip=bundle, via=copy, app_data_dir=/users/apraveen/.local/share/virtualenv)
       added seed packages: pip==24.2
     activators BashActivator,CShellActivator,FishActivator,NushellActivator,PowerShellActivator,PythonActivator
   [apraveen@uop-hpc ~]$ . numpy/bin/activate
   (numpy) [apraveen@uop-hpc ~]$ pip install numpy
   Collecting numpy
      Downloading numpy-2.2.2-cp313-cp313-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (62 kB)
   Downloading numpy-2.2.2-cp313-cp313-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (16.1 MB)
      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 16.1/16.1 MB 128.8 MB/s eta 0:00:00
   Installing collected packages: numpy
   Successfully installed numpy-2.2.2

   [notice] A new release of pip is available: 24.2 -> 25.0
   [notice] To update, run: pip install --upgrade pip
   (numpy) [apraveen@uop-hpc ~]$ python3
   Python 3.13.0 (main, Feb  3 2025, 14:13:03) [GCC 13.2.1 20231205 (Red Hat 13.2.1-6)] on linux
   Type "help", "copyright", "credits" or "license" for more information.
   >>> import numpy
   >>> numpy.eye(3)
   array([[1., 0., 0.],
          [0., 1., 0.],
          [0., 0., 1.]])

Setting up a Python Environment without Modules
-----------------------------------------------

It is also possible to set up a python environment without modules. The following versions of Python are provided outsite of modules:

* Python 3.12
* Python 3.11
* Python 3.9 (not reccomended)
* Python 3.6 (not recommended)

Users can also create Virtual Environments with these Python Versions. For example to set up SciPy in a Virtual Environment without using Modules with Python 3.12:

.. code-block:: console

   [apraveen@uop-hpc ~]$ python3.12 -m venv scipy
   [apraveen@uop-hpc ~]$ . scipy/bin/activate
   (scipy) [apraveen@uop-hpc ~]$ pip install scipy
   Collecting scipy
     Obtaining dependency information for scipy from https://files.pythonhosted.org/packages/b0/3c/0de11ca154e24a57b579fb648151d901326d3102115bc4f9a7a86526ce54/scipy-1.15.1-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata
     Downloading scipy-1.15.1-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (61 kB)
        ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 62.0/62.0 kB 3.8 MB/s eta 0:00:00
   Collecting numpy<2.5,>=1.23.5 (from scipy)
      Obtaining dependency information for numpy<2.5,>=1.23.5 from https://files.pythonhosted.org/packages/5b/73/65d2f0b698df1731e851e3295eb29a5ab8aa06f763f7e4188647a809578d/numpy-2.2.2-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata
     Downloading numpy-2.2.2-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (62 kB)
        ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 62.0/62.0 kB 11.3 MB/s eta 0:00:00
   Downloading scipy-1.15.1-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (40.2 MB)
      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 40.2/40.2 MB 121.8 MB/s eta 0:00:00
   Downloading numpy-2.2.2-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (16.1 MB)
      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 16.1/16.1 MB 157.2 MB/s eta 0:00:00
   Installing collected packages: numpy, scipy
   Successfully installed numpy-2.2.2 scipy-1.15.1

   [notice] A new release of pip is available: 23.2.1 -> 25.0
   [notice] To update, run: pip install --upgrade pip
   (scipy) [apraveen@uop-hpc ~]$ python3
   Python 3.12.1 (main, Feb 21 2024, 10:25:11) [GCC 8.5.0 20210514 (Red Hat 8.5.0-21)] on linux
   Type "help", "copyright", "credits" or "license" for more information.
   >>> import scipy.sparse
   >>> scipy.sparse.eye(3)
   <DIAgonal sparse matrix of dtype 'float64'
           with 3 stored elements (1 diagonals) and shape (3, 3)>

Conda
-----

A conda module is also provided. To use it, load the module and set a conda package directory within your home directory:

.. code-block:: bash

   module load conda
   mkdir -p ~/conda/pkgs && conda config --add pkgs_dirs ~/conda/pkgs

A conda environment can then be created an used as follows:

.. code-block:: bash

   conda create -p ~/test_condaenv
   conda activate ~/test_condaenv
   conda install numpy
   python -c 'import numpy; print(numpy.eye(3))'
