Starting an interactive job
===========================

Among many other functionalities, the ``srun`` command together with options
``-i`` and ``--pty`` is used to launch interactive jobs. Typically, users would
use the following template to form the entire ``srun`` command that launches an 
interactive job:

   .. code-block:: bash
   		
      srun --nodes=<nodes> --ntasks-per-node=<cpus> --time=<walltime> --pty /bin/bash -i

where ``<nodes>`` is the number of nodes to allocate, ``<cpus>`` the number of processors
per node that the job requires, and ``<walltime>`` the maximum amount of time the interactive
session is allowed to be running.