.. include:: ../siteinclude.rst

Data Storage on the Lovelace Cluster
====================================

The Lovelace cluster has an IBM Spectrum Scale (also known as GPFS) filesystem with approximately 2 PiB of data storage available. This storage is provided by two types of phyiscal disks; very fast SSD disks and HDD disks. THe data is stored using RAID 6 (dual parity) meaning that for any data loss to occur, at least 3 drives must fail -- in fact, theoretically, a higher number of failures can occur without data loss if the failing drivers are not part of the same internal array (for example, in the event that 2 SSDs and 2 HDDs fail simultaneously, data availability is still guaranteed).

On the Lovelace cluster, users have access to two filesystems, :plaintext:`/users` and :plaintext:`/scratch` over which the 2 PiB capacity is distributed. Home directories of users on the lovelace cluster are under :plaintext:`/users` (for example :plaintext:`/users/apraveen`). The :plaintext:`/scratch` directory is used for bulk storage and project data storage. Users can use the commands below to see files inside these directories.

.. code-block:: bash

   df -h /users /scratch
   ls -lah /users
   ls -lah /scratch
   find /users
   find /scratch


Users should notice their own home directory in the output of :bash:`ls -lah /users`. Users should also have been allocated one or multiple directories under :plaintext:`/scratch` corresponding to the projects they are part of. Please move data (for example, using the :bash:`mv` command) to the :plaintext:`/scratch` directory where possible; particularly when storing data for a long period of time, such as for the duration of a project.

.. note::

   User data on the Lovelace cluster is not backed up. Although it is stored using reliable parity-based schemes and the file system is monitored by the HPC Admin Team, it should not be the sole location where important data is stored. Users should back up important data to at least one other location such as Microsoft OneDrive.

Performance Notes
-----------------

As the cluster has both very fast SSD storage and HDD storage, the HPC Admin Team will migrate data so that 'hot' data is on the SSD disks and 'cold' data is on HDD disks. Because more storage is available on the :plaintext:`/scratch` filesystem, it may be more likely that your data remains on the hot storage if you store your data on the :plaintext:`/scratch` filesystem. The heuristic used to determine whether data is hot or cold is simply the time at which the data was most recently accessed and files are prioritised in order of this.

Users can use the command below to determine whether a file is on the SSD storage or on the HDD storage. If on the SSD storage, the output will show :plaintext:`storage pool name: system`. If on the HDD storage, the output will show :plaintext:`storage pool name: data`.

.. code-block:: bash

   /usr/lpp/mmfs/bin/mmlsattr -L FILENAME

If users would like to request or advise us to store data on a specific storage type, please send the `HPC Admin Team <mailto:hpcsupport@plymouth.ac.uk>`_ an email.
