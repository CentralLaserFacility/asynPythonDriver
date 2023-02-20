#!../../bin/linux-x86_64/scope

## You may have to change python to something else
## everywhere it appears in this file

< envPaths

## add python module paths
epicsEnvSet PYTHONPATH,${TOP}/python:${ASYNPYTHON}/python

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/scope.dbd"
scope_registerRecordDeviceDriver pdbbase

asynPythonDriverConfigure("PY1", "scope", 18)
asynPythonDriverConfigure("PY2", "test", 1)

## Load record instances
dbLoadRecords("${TOP}/db/scope.template", "P=MTEST:,R=SCOPE:,PORT=PY1,ADDR=0,NPOINTS=1000,TIMEOUT=1")
dbLoadRecords("${TOP}/db/test.template", "PORT=PY2,ADDR=0,TIMEOUT=1")

cd ${TOP}/iocBoot/${IOC}
iocInit

## Start any sequence programs
