GNU Parallel
===================================

Here is a short tutorial for GNU parallel written by D. Vadacchino

From Parallel website: "GNU parallel is a shell tool for executing jobs in parallel using one or more computers. A job can be a single command or a small script that has to be run for each of the lines in the input. The typical input is a list of files, a list of hosts, a list of users, a list of URLs, or a list of tables. A job can also be a command that reads from a pipe. GNU parallel can then split the input and pipe it into commands in parallel."

To load GNU parallel on the cluster, type

::
  
  module load parallel

GNU parallel is useful when a program must be executed many times, independently, with 
different inputs. In those cases, one can either effectively launch manually several
concurrent executions, as follows
::

  echo A
  >A
  echo B
  >B
  echo C
  >C

which can be summarized in
::

 for i in A B C; do echo ${i}; done

or one can let GNU parallel manage the parallel execution of the program with different
inputs, as follows

::

 parallel echo ::: A B C
  >A
  >B
  >C

Below we try to explain the basics of using GNU parallel. From the above note the use of the divisor :::
that separates the name of the executable from the set of different inputs. This is the most basic
case. We can specifiy the number of processes to be run with the option -j N_processes, as follows

::

  $parallel -j 2 echo ::: A B C
  >A
  >B
  >C

the output will be the same, with a number of simultaneous executions of echo equal to two. Clearly,
this is useful when the number of inputs is large, but the number of cores to be used is limited.
For example, for 8 inputs and 2 cores one would launch,

::

 parallel -j 2 echo ::: A B C D E F G H
  >A
  >B
  >C
  >D
  >E
  >F
  >G
  >H

This will execute the program in parallel with the 8 different inputs, with two parallel
executions at any given time.

One can also use more complicated input patterns, like for example

::

 parallel echo ::: A B C ::: D E F
  > A D
  > A E
  > A F
  > B D
  > B E
  > B F
  > C D
  > C E
  > C F

Or, by linking different inputs, as follows,

::
  
  $parallel echo ::: A B C :::+ D E F
  > A D
  > B E
  > C F

where :::+ makes its appearance. This divisor tells parallel to execute the program echo
using the first input in the first set along with the first in the second set, then the second
in the first set and the second in the second set, and so on. The inputs
are thus **linked**.

The inputs can also be specified and read from files. For example given

::

 cat input-1
  > A
  > B
  > C
  cat input-2
  > D
  > E
  > F

Then the same output as before can be obtained with the following
command

::

 parallel -a input-1 -a input-2 echo
  > A D
  > A E
  > A F
  > B D
  > B E
  > B F
  > C D
  > C E
  > C F

while for linked input, one has to specify the option --link, as
follows


::

 parallel -a input-1 -a input-2 --link echo
  > A D
  > B E
  > C F

It is also possible to execute in parallel a list of commands contained in a file.
For example given,

::

 cat commands.sh
  >echo A
  >echo B
  >echo C
  >echo D
  >echo E
  >echo F

then one can start two concurrent executions with

::

 parallel -j 2 < commands.sh
  >A
  >B
  >C
  >D
  >E
  >F

Further resources and options can be found at https://www.gnu.org/software/parallel/parallel_tutorial.html
and reference therein.

