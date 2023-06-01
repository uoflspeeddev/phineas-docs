Submitting batch jobs
#####################

The command ``sbatch`` serves as the means to submit batch jobs to Slurm,
typically in the form of a shell script written in the bash command language.
It is important to note that a shell script is essentially a text file containing instructions
that are parsed and executed by a shell or command-line interpreter.
When submitting a job to Slurm, the shell script must adhere to the following requirements:

1. The first line of the script should specify the shell to be used.
   This is accomplished by including a shebang (``#!``) followed by ``/bin/env``, a space,
   and the name of the desired shell. For example, for a bash script: ``#!/bin/env bash``.

2. The script should define a set of parameters in the form of comments
   (lines preceded by the ``#`` symbol). These parameters are utilized by Slurm
   to establish job priority and resource requirements. Each parameter should begin
   with the word ``SBATCH`` and should be placed on its own separate line. For instance:

   .. code-block:: bash
   		
      #!/bin/env bash
      #SBATCH --job-name=some_job_name
      #SBATCH --time=01:00

A list of common sbatch options is provided below for convenience:

.. csv-table:: Common sbatch options
  :header-rows: 1
  :widths:  5, 8, 5, 4
  :stub-columns: 1
  :file: csv/sbatch_cmds.csv

For more comprehensive details, please consult 
`Slurm's sbatch manual <https://slurm.schedmd.com/sbatch.html>`_.

Once the necessary parameters have been incorporated into the script,
users should proceed to configure the environment for the application they intend to execute.
If the job involves utilizing a scientific software installed within the cluster,
it is recommended that users load the corresponding modulefiles within the script using
the ``module load <modulefile>`` command.
Alternatively, users have the option to load their custom modulefiles or manually set
the required environmental variables, depending on their preferences and specific needs.
Additionally, any additional tasks such as directory or file creation, among others,
should be performed at this stage. It is important to note that the submission script
essentially functions as a shell script with additional comments at the beginning.
As such, any actions that a user would typically carry out in a regular shell session
can be executed within the script, allowing for flexibility and adaptability to individual
requirements.

Finally, the script should encompass the core job tasks, 
which typically involve executing simulations, experiments, or other relevant operations.
During this phase, users would typically initiate the necessary scientific software required
for their specific needs.

As an illustrative example, consider the following bash script that defines a
job named 2d_driven_cavity_flow:

..  code-block:: bash
    :caption: Example bash script to launch a sbatch job

     #!/bin/bash
     #SBATCH --job-name=2d_driven_cavity_flow
     #SBATCH --error=/home/user/2d_driven_cavity_flow.err.%j
     #SBATCH --output=/home/user/2d_driven_cavity_flow.out.%j
     #SBATCH --time=05:30:00
     #SBATCH --ntasks=16
     #SBATCH --nodes=1
     #SBATCH --partition=longjobs
     
     # START CONFIGURING ENVIRONMENT

     # load Ansys 2023R1 modulefile
     module load ansys/2023r1
     # Generate list of hosts where ansys processes
     # will run
     HOSTLIST="hosts.$SLURM_JOB_ID"
     srun hostname | sort > $HOSTLIST

     # FINISHED CONFIGURING ENVIRONMENT

     # Run Fluent
     fluent 3ddp \
         -g \
         -mpi=openmpi\
         -t $SLURM_NTASKS \
         -cnf=$HOSTLIST \
         -i /home/user/2d_driven_cavity_flow.jou \
         > 2d_driven_cavity_flow.out

In this script, the job is assigned the name *2d_driven_cavity_flow* using the ``#SBATCH --job-name``
directive. The maximum allowed running time is set to 5 hours and 30 minutes through the 
``#SBATCH --time`` directive. The job is configured to utilize 1 node (``#SBATCH --nodes``)
and 16 processors (``#SBATCH --ntasks``). It is intended to run in the *longjobs* queue
(``#SBATCH --partition``). Any encountered error messages are to be stored in the file 
``/home/user/2d_driven_cavity_flow.err.%j``, where ``%j`` is replaced with the job ID assigned by Slurm.
Similarly, non-error messages are directed to the file ``/home/user/2d_driven_cavity_flow.out.%j``
for logging purposes.