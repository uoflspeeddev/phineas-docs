.. _ansys:

Ansys
#####

Mechanical APDL (MAPDL)
=======================

There are two executables that can be used to invoke the solver from the command line:

- ``mapdl``
- ``ansysYYR`` (``YY`` is the corresponding release's year
  and ``R`` the release number. For instance, for Ansys R2023-1 the
  executable is named ``ansys231``)

Since ``ansysYYR`` is a symlink to ``mapdl``, invoking the solver through either
executable works the same. 

.. note::
   Users may prefer to call `mapdl` on their batch scripts to make them
   portable across ansys versions.

Parallel and distributed modes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

``mapdl`` can be invoked with support for 3 processing mechanisms: *Shared-memory parallel (SMP)*,
*Distributed-memory parallel (DMP)* and *Mixed DMP-SMP*. As per Ansys documentation:

    **DMP mode:** All features in the simulation support distributed-memory parallelism, and it is used throughout the solution. This mode typically provides optimal performance.

    **Mixed mode:** The simulation involves a particular set of computations that do not support DMP processing. Examples include certain equation solvers and remeshing due to mesh nonlinear adaptivity. In these cases, distributed-memory parallelism is used throughout the solution, except for the unsupported set of computations. When that step is reached, the worker processes simply wait while the master process uses shared-memory parallelism to perform the computations. After the computations are finished, the worker processes continue to compute again until the entire solution is completed.

    **SMP mode:** The simulation involves an analysis type or feature that does not support DMP processing. In this case, distributed-memory parallelism is disabled at the onset of the solution, and shared-memory parallelism is used instead. The worker processes are not involved at all in the solution but simply wait while the master process uses shared-memory parallelism to compute the entire solution.

The following table shows the capabilities of each solver to run on each of the aforementioned modes:

.. csv-table:: Parallel Capability in SMP, DMP, and Hybrid Parallel Processing
  :header-rows: 1
  :widths:  8, 2, 8
  :stub-columns: 1
  :file: csv/ansys_mapdl_parallel_capabilities.csv

Command line options
^^^^^^^^^^^^^^^^^^^^

The table below shows some of the most useful options to invoke ``mapdl`` with.

.. csv-table:: Common mapdl options
  :header-rows: 1
  :widths:  3, 8, 8
  :stub-columns: 1
  :file: csv/ansys_mapdl_cmds.csv
