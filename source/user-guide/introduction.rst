.. include:: ../siteinclude.rst

Introduction
============

This guide is designed to be a reference for users of the
high-performance computing (HPC) facility: Lovelace and for external users who may benefit from our work.
It will provide the information needed to transfer data, manage your
resources (disk and compute time), submit jobs, compile programs,
manage your environment and make use for common applications.
It has been been adapted from the documentation of the tesseract service:

https://tesseract-dirac.readthedocs.io/en/latest/user-guide/introduction.html


Acknowledging foseres
-----------------------

You should use the following phrase to acknowledge Lovelace in all
research outputs that have used the facility:

*This work was carried out using the computational facilities of the High Performance Computing Centre, University of Plymouth-* https://www.plymouth.ac.uk/about-us/university-structure/faculties/science-engineering/hpc. 


Getting help
---------------

If you need any assistance in using foseres, please send a support requests to HPC Support at `hpcsupport@plymouth.ac.uk <mailto:hpcsupport@plymouth.ac.uk>`_, and our team will try to help you as soon as possible. In your Email, please share as much detail as possible about your query.

.. note::
   Drop-in HPC Support sessions are periodically held. See :doc:`/user-guide/dropin` for details.

Training
-------------

Some resources are available here: 

https://www.archer2.ac.uk/training/#upcoming-training

Hardware
--------

The current Lovelace HPC Cluster consists of 69 nodes of which 64 nodes are designated for compute.

There is a login node that shares a common software environment and file system with the compute nodes.

Standard Compute Nodes
^^^^^^^^^^^^^^^^^^^^^^

Lovelace' standard compute nodes each contain two 3.8 GHz, 32-core AMD EPYC™ 9354 processors.

There are 60 standard compute nodes on Lovelace giving a total of 3840 cores in these nodes.

The Standard Compute Nodes in Lovelace have 384 GB of memory shared between the two processors. The memory is arranged in a non-uniform access (NUMA)
form: each 32-core processor is a single NUMA region with local memory of 192 GB. Access to the local memory by cores within a NUMA region has
a lower latency than accessing memory on the other NUMA region.

There are three levels of cache, configured as follows:

* L1 Cache 2 MB
* L2 Cache 32 MB
* L3 Cache 256 MB

Highmem Compute Nodes
^^^^^^^^^^^^^^^^^^^^^

Lovelace' two Highmem compute nodes have the same specifications as the standard compute nodes except that they have 1.5 TB (1536GiB) of memory similarly distributed over two NUMA regions.

H100 GPU Nodes
^^^^^^^^^^^^^^

Lovelace' H100 GPU node has the similar specifications to the Highmem compute node but additionally four Nvidia H100 Graphics Processing Units.

L40S GPU Nodes
^^^^^^^^^^^^^^

Lovelace' L40S GPU node has the similar specifications to the Highmem compute node but additionally eight Nvidia L40S Graphics Processing Units.


Nvidia NDR200 Interconnect
^^^^^^^^^^^^^^^^^^^^^^^^^^

The system has an NDR200 200 Gigabit Interconnect. Communications between nodes and to/from the cluster's storage is sent over this interconnect using the GPFS filesystem.

File systems and Data Infrastructure
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Lovelace uses GPFS for its filesystem. It is a parallel file system desgined to give high
read/write bandwidth for parallel I/O operations.

The GPFS file system has a total of 2 PB available. This is accesible on all nodes.

.. note::

   Data on Lovelace' user file systems are not automatically backed up.

