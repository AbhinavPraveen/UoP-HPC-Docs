.. include:: ../siteinclude.rst

HPC system policy
====================

HPC Usage Policy
--------------------
The administrators reserve the right to make amendments to this usage policy without notice, as required to ensure availability, security and fair usage of the services provided.

#. All jobs must be run via the queuing system. You can log directly on the compute nodes only if you have an active job running on them.
#. Intensive tasks must not be run on the head/login nodes; these should be reserved for editing code and job scripts, code compiliation, data movement, submitting jobs and managing the queuing system.    
#. Job submissions must only request required resources, waste of cluster resources by poorly scheduled jobs may result in your jobs being held or deleted.        
#. Job submissions must only use their allocated resources, using additional resources not allocated by the scheduler may result in the job being automatically or manually deleted. 
#. Use of the cluster is granted for academic purposes related to work or study at the University only  
#. Teaching on the HPC cluster is by prior arrangement only. Please let the `HPC team <mailto:hpcsupport@plymouth.ac.uk>`_  know about your teaching by following the HPC teaching application process at least 6 weeks before any course begins.  
#. Jobs or processes that are having an adverse effect on the cluster may be deleted / killed / held as required by HPC team with no prior notification. 
#. Cryptocurrency mining and blockchain research must not be run on -University of Plymouth Systems except by prior arrangement and approval as outlined in the University’s Information Security Policy.
#. All new users should complete the Intro to HPC training course (or equivalent) before submitting any jobs to the clusters.   
#. Accounts are private and should not be share under any circumstances with anyone.
#. Acknowledge all papers that make use of the UoP HPC facility.
#. Users are responsible for data backup.  Please ensure that data is removed from the HPC when it is no longer required.  Please inform the HPC support team if your account is no longer required.  Note: accounts will be removed should you leave the university and not give the HPC support team prior notice.


HPC account suspension
------------------------

Users found to be in breach of any statute in this usage policy will be reported to the HPC Executive for a decision regarding the suspension of their HPC access.  

Suspended users may be reinstated at the discretion of HPC Executive; requests for reinstatement must come from the user's supervisor, line manager or sponsor. 

 Please note that in addition to this HPC usage policy users must also comply with the University’s Information Security Policy for Acceptable Use of University Information Systems and Data Protection polices.


Acknowledging Lovelace in Publications
--------------------------------------
When you write articles about your research for publication, conference proceedings or for other reasons, please acknowledge use of the HPC facility by including the following:

This work was carried out using the computational facilities of the High Performance Computing Centre, University of Plymouth- https://www.plymouth.ac.uk/about-us/university-structure/faculties/science-engineering/hpc.


Allocation policy
------------------

Currently two sets of queues are available to users. These are the standard queues (:plaintext:`cpu`, :plaintext:`cpu_highmem`, :plaintext:`gpu_h100`, :plaintext:`gpu_l40s`) and the billed queues (:plaintext:`cpu-billed`, :plaintext:`cpu_highmem-billed`, :plaintext:`gpu_h100-billed`, :plaintext:`gpu_l40s-billed`).


If you have any questions on how to run jobs on foseres do not hesitate
to contact the HPC Support at `hpcsupport@plymouth.ac.uk <mailto:hpcsupport@plymouth.ac.uk>`_.
