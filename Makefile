#****************************************************************************
# Project Info
#****************************************************************************

# Makefile for "$Project NAME" ($Project NAME Abbreviation) $Project FILE.
Project              := Dictionaries Database Tool
Project_Abbreviation := DDT
Author               := Invincible Studio - 迗丅兂敵
Version              := 1.0(Beta)
Copyright            := Copyleft © 2012 - 2013 Invincible Studio. All Rights Reserved.
Official_Website     :=
#
# This is a GNU make (gmake) makefile
#****************************************************************************

#****************************************************************************
# Total Options
#****************************************************************************

# DEBUG can be set to YES to include debugging info!
DEBUG          := NO

# Set Install Path
INSLPH         := 

# Set Compiler Prefix
PREFIX         := 

#****************************************************************************
# Toolchain
#****************************************************************************

AS       := ${PREFIX}as
AR       := ${PREFIX}ar
LD       := ${PREFIX}ld
CC       := ${PREFIX}cc
CPP      := ${PREFIX}c++
CXX      := ${PREFIX}g++
NM       := ${PREFIX}nm
STRIP    := ${PREFIX}strip
OBJCOPY  := ${PREFIX}objcopy
OBJDUMP  := ${PREFIX}objdump
RANLIB   := ${PREFIX}ranlib
SIZE     := ${PREFIX}size

#****************************************************************************
# Compile Options
#****************************************************************************

DEBUG_CFLAGS     := -fPIC -g3 -ggdb3 -gstabs3 -p -pg -Q -ftime-report -fmem-report -fmem-report-wpa \
-fpre-ipa-mem-report -fpost-ipa-mem-report --coverage -DDEBUG
RELEASE_CFLAGS   := -fPIC -O3

DEBUG_CPPFLAGS   := -fPIC -g3 -ggdb3 -gstabs3 -p -pg -Q -ftime-report -fmem-report -fmem-report-wpa \
-fpre-ipa-mem-report -fpost-ipa-mem-report --coverage -DDEBUG
RELEASE_CPPFLAGS := -fPIC -O3

DEBUG_CXXFLAGS   := -fPIC -g3 -ggdb3 -gstabs3 -p -pg -Q -ftime-report -fmem-report -fmem-report-wpa \
-fpre-ipa-mem-report -fpost-ipa-mem-report --coverage -DDEBUG
RELEASE_CXXFLAGS := -fPIC -O3

DEBUG_ARFLAGS   := -r -c -v -g3 -ggdb3 -gstabs3 -p -pg -Q -ftime-report -fmem-report -fmem-report-wpa \
-fpre-ipa-mem-report -fpost-ipa-mem-report --coverage -DDEBUG
RELEASE_ARFLAGS := -r -c -v -O3

DEBUG_LDFLAGS   := -shared -g3 -ggdb3 -gstabs3 -p -pg -Q -ftime-report -fmem-report -fmem-report-wpa \
-fpre-ipa-mem-report -fpost-ipa-mem-report --coverage -DDEBUG
RELEASE_LDFLAGS := -shared -O3

ifeq (YES, ${DEBUG})
   CFLAGS       := ${DEBUG_CFLAGS}
   CPPFLAGS     := ${DEBUG_CPPFLAGS}
   CXXFLAGS     := ${DEBUG_CXXFLAGS}
   ARFLAGS      := ${DEBUG_ARFLAGS}
   LDFLAGS      := ${DEBUG_LDFLAGS}
else
   CFLAGS       := ${RELEASE_CFLAGS}
   CPPFLAGS     := ${RELEASE_CPPFLAGS}
   CXXFLAGS     := ${RELEASE_CXXFLAGS}
   ARFLAGS      := ${RELEASE_ARFLAGS}
   LDFLAGS      := ${RELEASE_LDFLAGS}
endif

#****************************************************************************
# Include Paths
#****************************************************************************

INCS := 

#****************************************************************************
# Library Paths
#****************************************************************************

LIBS := 

#****************************************************************************
# Target Name
#****************************************************************************

TARGET := ddt

#****************************************************************************
# Source files
#****************************************************************************

SRCS := $(wildcard ./src/*.cpp)

#****************************************************************************
# Obj files
#****************************************************************************

OBJS := $(addsuffix .o,$(basename ${SRCS}))

#****************************************************************************
# Gcov files
#****************************************************************************

GCOVS := $(addsuffix .gcov,${SRCS})

#****************************************************************************
# Install Path
#****************************************************************************

ifeq (,${INSLPH})
INSLPH := /usr/local
endif

#****************************************************************************
# Compiling rules
#****************************************************************************

# Rules for compiling source files to object files

%.o : %.c
	@echo -e "\n\e[32mBuild ${SRCS} to the $@ \e[0m"
	@${CC} -c ${CFLAGS} ${INCS} $< -o $@

%.o : %.cc
	@echo -e "\n\e[32mBuild ${SRCS} to the $@ \e[0m"
	@${CXX} -c ${CXXFLAGS} ${INCS} $< -o $@

%.o : %.cp
	@echo -e "\n\e[32mBuild ${SRCS} to the $@ \e[0m"
	@${CXX} -c ${CXXFLAGS} ${INCS} $< -o $@

%.o : %.cxx
	@echo -e "\n\e[32mBuild ${SRCS} to the $@ \e[0m"
	@${CXX} -c ${CXXFLAGS} ${INCS} $< -o $@

%.o : %.cpp
	@echo -e "\n\e[32mBuild ${SRCS} to the $@ \e[0m"
	@${CPP} -c ${CXXFLAGS} ${INCS} $< -o $@

%.o : %.CPP
	@echo -e "\n\e[32mBuild ${SRCS} to the $@ \e[0m"
	@${CPP} -c ${CXXFLAGS} ${INCS} $< -o $@

%.o : %.c++
	@echo -e "\n\e[32mBuild ${SRCS} to the $@ \e[0m"
	@${CPP} -c ${CXXFLAGS} ${INCS} $< -o $@

%.o : %.C
	@echo -e "\n\e[32mBuild ${SRCS} to the $@ \e[0m"
	@${CXX} -c ${CXXFLAGS} ${INCS} $< -o $@

# Rules for compiling object files to target

${TARGET}: ${OBJS}
	@echo -e "\n\e[1;31mLinking Obj files to the $@ \e[0m"
	@${CXX} -o $@ ${OBJS} ${LIBS} ${INCS} ${CXXFLAGS}
	@echo -e "\n\e[1;33mBuild ${TARGET} is done! \e[0m\n"

#****************************************************************************
# Total Commands
#****************************************************************************

.PHONY : all
all:
	-@clear
	${TARGET}

.PHONY : run
run:
	-@clear
	-@time ./${TARGET}
	-@gprof ${TARGET}
	-@gcov -a -b -c ${SRCS}
	-@cat ${GCOVS}

.PHONY : install
install:
	-@cp -f ${TARGET} ${INSLPH}

.PHONY : uninstall
uninstall:
	-@rm -f ${INSLPH}/${TARGET}

.PHONY : clean
clean:
	-@echo -e "\n\e[1;31mRemove ${OBJS} ${GCOVS} gmon.out ${TARGET}\e[0m"
	-@rm -f core ${OBJS} ${TARGET} ${GCOVS} ./*.gcov ./gmon.out ./*.gcda ./*gcno

.PHONY : help
help:
	-@echo -e "\e[0mall        Build ${Project}! Compiler Prefix is \e[1;4;31m${PREFIX}\e[0m . Default is NONE!\e[0m"
	-@echo -e "\e[0m           If you want to change compiler prefix,you need to set \e[1;35mPREFIX\e[0m variable in this Makefile's Total Options! \e[0m"
	-@echo -e "\e[0minstall    Install ${Project}! Install Path is \e[1;4;31m${INSLPH}\e[0m . Default is /usr/local !\e[0m"
	-@echo -e "\e[0m           If you want to change install path,you need to set \e[1;35mINSLPH\e[0m variable in this Makefile's Total Options! \e[0m"
	-@echo -e "\e[0muninstall  Uninstall ${Project}! \e[0m"
	-@echo -e "\e[0mclean      Clear build ${Project} generate files! \e[0m"
	-@echo -e "\e[0mhelp       Print this message. \e[0m"
	-@echo -e "\e[0minfo       Print ${Project} info! \e[0m"

.PHONY : info
info:
	-@echo -e "\n\e[1mName:             \e[1;31m${Project}(${Project_Abbreviation}) \e[0m"
	-@echo -e "\n\e[1mAuthor:           \e[1;33m${Author}  \e[0m"
	-@echo -e "\n\e[1mVersion:          ${Version}  \e[0m"
	-@echo -e "\n\e[1mCopyright:        ${Copyright} \e[0m"
	-@echo -e "\n\e[1mOfficial Website: \e[1;4m${Official_Website} \e[0m"
