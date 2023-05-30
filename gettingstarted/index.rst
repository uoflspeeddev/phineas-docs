Getting Started
###############

HPC system overview
====================

Phineas consists of a total of 10 servers, with one serving as the coordinator,
often referred to as the head node, and the remaining nine functioning as workers. The head node
assumes the crucial role of overseeing state management and orchestrating the distributed
coordination of services across all other servers. Conceptually, it serves as
the intellectual nucleus of the entire cluster, akin to its very own brain.

Given that the head node acts as the exclusive entry point to the system, 
logging into the cluster equates to logging into this head node. 
In order to execute any kind of (scientific) software, such as Ansys, OpenFOAM, GROMACS, or others,
the cluster relies on a sophisticated job scheduling system known as
`Slurm <https://slurm.schedmd.com/quickstart.html>`_. 
Slurm facilitates the equitable sharing of resources among multiple users by
effectively managing node allocation, CPU distribution, memory utilization, and
other vital resources based on individual job requirements.

To safeguard against interference between users' jobs, access to the worker nodes
is restricted exclusively to those users whose jobs are actively running on them.
For instance, if a user named "lk01" submits a job and Slurm allocates the node
"phineas-c01" for its execution, then "lk01" will have the privilege to log into "phineas-c01".

Logging in to the cluster
=========================

Upon creating an account, users are provided with a username and password, 
which they can utilize to access the cluster via SSH (Secure Shell Protocol).
The procedure entails employing an SSH client from their personal computers
to establish a connection with the head node. Notably, Windows (versions 10 and 11)
inherently supports an SSH command-line client within PowerShell. Similarly, 
Mac and Linux operating systems come equipped with a built-in SSH client
accessible via their respective terminals. 
The basic login process remains consistent across all of these platforms:

1. Launch the terminal on your personal computer.
2. Enter the ssh command using the following format: ``ssh username@hostname``. 
   In this particular scenario, the hostname is always phineas.spd.louisville.edu.
   For instance, if the user's name is "lk01," they would input
   ``ssh lk01@phineas.spd.louisville.edu``.
3. Provide your password and press Enter.

Alternatively, users can opt for other popular SSH clients installed on their personal computers,
such as `MobaXterm <https://mobaxterm.mobatek.net/>`_ and `PuTTY <https://www.putty.org/>`_.
PuTTY boasts a straightforward and user-friendly interface, while MobaXterm offers a 
tabbed interface with enhanced functionality, including a dedicated file manager 
that simplifies file management on the cluster and facilitates seamless information
transfer between the personal computer and the cluster.

Submitting Jobs
==============

There are two types of jobs an user can submit: interactive and batch. When submitting
an interactive job, the user is logged in to whatever node slurm assigns to it so that the user
can manually execute any program they want. On the other hand, batch jobs run unattended and are
passed to slurm as BASH scripts.