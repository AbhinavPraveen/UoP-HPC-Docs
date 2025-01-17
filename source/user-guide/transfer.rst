.. include:: ../siteinclude.rst

Data Transfer Guide
===================

This section covers the different ways that you can transfer data 
on to and off Lovelace.

scp command
-----------

The :bash:`scp` command creates a copy of a file, or if given the :plaintext:`-r`
flag a directory, on a remote machine. Below shows an example of the
command to transfer a single file to Lovelace:

.. code-block:: bash

    scp [options] source_file user@lovelace.plymouth.ac.uk:[destination]

In the above example, the :plaintext:`[destination]` is optional, as when left
out scp will simply copy the source into the users home directory.

rsync command
-------------

The :bash:`rsync` command creates a copy of a file, or if given the :plaintext:`-r`
flag a directory, at the given destination, similar to scp above.
However, given the -a option rsync can also make exact copies (including
permissions), this is referred to as 'mirroring'. In this case the
:bash:`rsync` command is executed with (tunneled over) ssh to transfer data.
To transfer files to Lovelace the command should have the form:

.. code-block:: bash

    rsync [options] source user@lovelace.plymouth.ac.uk:[destination]

In the above example, the :plaintext:`[destination]` is optional, as when left
out rsync will simply copy the source into the users home directory.
