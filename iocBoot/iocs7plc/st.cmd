#!../../bin/linux-x86_64/s7plc

#- You may have to change s7plc to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/s7plc.dbd"
s7plc_registerRecordDeviceDriver pdbbase

## Load record instances
dbLoadTemplate "db/user.substitutions"
dbLoadRecords "db/s7plcVersion.db", "user=lees"
dbLoadRecords "db/dbSubExample.db", "user=lees"
dbLoadRecords "db/example.db"

#- Set this to see messages from mySub
#var mySubDebug 1

#- Run this to trace the stages of iocInit
#traceIocInit

s7plcConfigure Testsystem:0,127.0.0.1,2000,80,80,1,2000,100

cd "${TOP}/iocBoot/${IOC}"
iocInit

## Start any sequence programs
#seq sncExample, "user=lees"
