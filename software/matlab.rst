.. _matlab:

Basics
======

Matlab jobs can be submitted by using a batch script. Matlab is invoked directly from the shell 
within the batch script and an input ``.m`` source file is passed to the matlab executable.
See Section :ref:`Submitting a batch job <matlab-batch-job>` for more information.

There is an alternative way for users to use the ``parcluster`` directive within the cluster's matlab
client or a matlab client installed in their workstations to schedule a job, but this feature is
currently unsupported.

.. _matlab-batch-job:

Submitting a batch job
======================

1. Copy the Matlab project to the cluster. That is, all ``.m`` source code files that are to be passed to matlab for execution. For example, assume the file ``/home/user/test.m`` has the following content:

    .. code-block:: matlab

        p = parpool(str2num(getenv('SLURM_NTASKS')));
        t0 = tic;
        A = 500;
        a = zeros(1000);
        parfor i = 1:1000
        a(i) = max(abs(eig(rand(A))));
        end
        t = toc(t0)
        exit

2. Create a :ref:`batch script <batch_job>`. For example, assume the file ``/home/user/matlab_test.sh`` has the following content:

    .. code-block:: bash

        #!/bin/bash
        #SBATCH -J test_matlab
        #SBATCH -o /home/user/test_matlab-%j.out
        #SBATCH -e /home/user/tmp/test_matlab-%j.err
        #SBATCH -p longjobs
        #SBATCH -n 20
        #SBATCH -t 20:00

        module load matlab/r2023b
        matlab -nosplash -nodesktop < /home/user/test.m

3. Use the ``sbatch`` command to schedule the job. Following the example from previous steps:
   ``sbatch /home/user/matlab_test.sh``.