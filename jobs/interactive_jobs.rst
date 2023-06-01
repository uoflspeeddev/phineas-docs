Starting an interactive job
###########################

In addition to its various capabilities, the ``srun`` command,
in conjunction with the options ``-i`` and ``--pty``,
facilitates the launching of interactive jobs.
Typically, users employ the following template to construct the complete ``srun``
command for initiating an interactive job:

..  code-block:: bash

     srun --nodes=<nodes> --ntasks-per-node=<cpus> --time=<walltime> --pty /bin/bash -i

In the template, ``<nodes>`` represents the desired number of nodes to be allocated,
``<cpus>`` denotes the number of processors per node required by the job, and
``<walltime>`` designates the maximum duration permitted for the interactive session to run.


Alternatively, users have the flexibility to include additional options, 
such as ``--mem``, to further customize the job requirements if the default settings are insufficient.
However, it is important to note that interactive jobs are primarily intended for testing purposes.
For more substantial workloads, it is highly recommended to submit batch jobs.

Upon initiation of an interactive job, the system will provide feedback in the form of output
similar to the following:

..  code-block::

    srun: job 12345 queued and waiting for resources
    srun: job 12345 has been allocated resources


Subsequently, the user will be logged into one of the nodes allocated specifically for the job.
Note that concluding the command prompt session will result in the termination of the job.
Furthermore, if the job surpasses the defined limits in terms of walltime or memory usage,
it will be automatically aborted.

Keeping an interactive job alive
================================

To prevent the premature termination of interactive jobs due to a disruption
in the connection between the user's personal computer and the login node,
the utilization of a terminal multiplexer such as tmux is highly recommended.
Follow the steps outlined below to employ tmux effectively:

1. Log into the cluster using your credentials.
2. Execute the command ``tmux`` to initiate a tmux session.
3. Launch the interactive job within the tmux session.

In the event of a disconnection caused by internet issues or any other unforeseen problems,
users can effortlessly resume their work by reconnecting to the login node and reattaching to
the tmux session using the command ``tmux attach``. Additionally, if there are multiple
tmux sessions running, users can utilize the command ``tmux list-session``
to obtain a list of all sessions and subsequently attach to their desired session
by executing ``tmux attach –t SESSION_NUMBER``.

