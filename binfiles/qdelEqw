#!/bin/bash
#$ -cwd
#By: J.He
## qdel specificed state jobs

qstat |awk -v s=$1 '$5==s{print $1}'|xargs qdel

