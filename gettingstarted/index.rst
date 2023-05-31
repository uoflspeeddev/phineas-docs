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

About Scientific Software
=========================

In Linux distributions, program behavior is influenced by dynamic values
known as "environmental variables." These variables can be created, modified,
and removed as needed, playing a crucial role in shaping the functionality of 
programs and services on a computer. For instance, the variable ``PATH`` contains
a list of file system addresses, separated by colons (:), representing folders
where binaries are stored. When a command is executed in the terminal,
the system scans the folders indicated by the addresses within ``PATH``
in search of a corresponding binary. If the system fails to locate the desired binary,
it returns an error message stating "command not found."

In addition, scientific software applications like GROMACS or OpenFOAM often define
their own extensive sets of environmental variables. Managing and keeping track of these variables
and their intended values can be time-consuming and swiftly give rise to complications.
To overcome this challenge, the cluster incorporates the use of *Environmental Modules*,
offering a convenient approach to dynamically adjust users' environments through
the utilization of modulefiles.

To explore the available modules, users can employ the ``module available`` command,
allowing them to examine the assortment of modules at their disposal. Subsequently,
users can load the appropriate module by executing the command ``module load modulename``,
effectively incorporating the desired module into their environment.

About Jobs
==========

Users have the flexibility to submit two distinct types of jobs: interactive and batch.
With an interactive job, the user gains direct access to the node assigned by Slurm,
enabling them to personally execute any desired program. In contrast, batch jobs operate
autonomously and are transmitted to Slurm in the form of BASH scripts,
executing without the need for user intervention.

In the event of a disconnection from the cluster, whether caused by internet complications
or other unforeseen issues, batch jobs remain unaffected, persevering independently.
However, interactive jobs are susceptible to termination, as they rely on the user's
ongoing connection. To circumvent such circumstances and maintain job continuity,
users often resort to employing a terminal multiplexer such as tmux.
By invoking the ``tmux`` command on the head node before initiating an interactive job,
tmux initiates a persistent terminal session on the head node itself.
This session persists even if the connection between the user's personal computer and
the head node becomes severed, ensuring the job remains intact and uninterrupted.