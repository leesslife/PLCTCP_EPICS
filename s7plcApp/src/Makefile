TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Use typed rset structure (see 3.16.1 release notes)
USR_CPPFLAGS += -DUSE_TYPED_RSET

# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord

# Install xxxSupport.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Build an IOC support library
LIBRARY_IOC += s7plcSupport

# Compile and add code to the support library
s7plcSupport_SRCS += xxxRecord.c
s7plcSupport_SRCS += devXxxSoft.c
s7plcSupport_SRCS += drvS7plc.c
s7plcSupport_SRCS += devS7plc.c
HTMLS +=s7plc.html

# Link locally-provided code into the support library,
# rather than directly into the IOC application, that
# causes problems on Windows DLL builds
s7plcSupport_SRCS += dbSubExample.c
s7plcSupport_SRCS += devs7plcVersion.c
s7plcSupport_SRCS += s7plcHello.c
s7plcSupport_SRCS += initTrace.c

s7plcSupport_LIBS += $(EPICS_BASE_IOC_LIBS)

# Auto-generate a header file containing a version string.
# Version comes from the VCS if available, else date+time.
GENVERSION = s7plcVersion.h
# Macro name
GENVERSIONMACRO = s7plcVERSION

# Build the IOC application
PROD_IOC = s7plc

# s7plc.dbd will be created and installed
DBD += s7plc.dbd

# s7plc.dbd will include these files:
s7plc_DBD += base.dbd
s7plc_DBD += xxxSupport.dbd
s7plc_DBD += dbSubExample.dbd
s7plc_DBD += devs7plcVersion.dbd
s7plc_DBD += s7plcHello.dbd
s7plc_DBD += initTrace.dbd

# s7plc_registerRecordDeviceDriver.cpp derives from s7plc.dbd
s7plc_SRCS += s7plc_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
s7plc_SRCS_DEFAULT += s7plcMain.cpp
s7plc_SRCS_vxWorks += -nil-

# Link in the code from our support library
s7plc_LIBS += s7plcSupport

# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncExample into s7plcSupport
    sncExample_SNCFLAGS += +r
    s7plc_DBD += sncExample.dbd
    # A .stt sequence program is *not* pre-processed:
    s7plcSupport_SRCS += sncExample.stt
    s7plcSupport_LIBS += seq pv
    s7plc_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    # A .st sequence program *is* pre-processed:
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Finally link IOC to the EPICS Base libraries
s7plc_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

# Explicit dependency needed for generated header file
devs7plcVersion$(DEP): $(COMMON_DIR)/$(GENVERSION)
