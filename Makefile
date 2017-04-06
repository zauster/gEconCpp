
#
# Most of this is copied from the
# - Makevars files and the 
# - R Makeconf in /usr/lib64/R/make

PREFIX =.

#
# Set all objects that have to be compiled
# 

INCLUDE_GECON = -I$(PREFIX)
OBJECTS_GECON = \
$(PREFIX)/gecon_info.o \
$(PREFIX)/modelparser.o

INCLUDE_SYMBOLIC = -I$(PREFIX)/symbolic
OBJECTS_SYMBOLIC = \
$(PREFIX)/symbolic/utils.o \
$(PREFIX)/symbolic/stringhash.o \
$(PREFIX)/symbolic/ex_base.o \
$(PREFIX)/symbolic/ex_num.o \
$(PREFIX)/symbolic/ex_delta.o \
$(PREFIX)/symbolic/ex_symb.o \
$(PREFIX)/symbolic/ex_symbidx.o \
$(PREFIX)/symbolic/ex_vart.o \
$(PREFIX)/symbolic/ex_vartidx.o \
$(PREFIX)/symbolic/ex_pow.o \
$(PREFIX)/symbolic/ex_func.o \
$(PREFIX)/symbolic/ex_e.o \
$(PREFIX)/symbolic/num_ex_pair_vec.o \
$(PREFIX)/symbolic/ex_add.o \
$(PREFIX)/symbolic/ex_mul.o \
$(PREFIX)/symbolic/idx_set_impl.o \
$(PREFIX)/symbolic/idx_set.o \
$(PREFIX)/symbolic/idx_ex.o \
$(PREFIX)/symbolic/ex_sum.o \
$(PREFIX)/symbolic/ex_prod.o \
$(PREFIX)/symbolic/ex_idx.o \
$(PREFIX)/symbolic/ptr_base.o \
$(PREFIX)/symbolic/ops_mk.o \
$(PREFIX)/symbolic/ops_trans.o \
$(PREFIX)/symbolic/ops_search.o \
$(PREFIX)/symbolic/ex.o

INCLUDE_PARSER = -I$(PREFIX)/parser -I$(PREFIX)/parser/antlr_include -I$(PREFIX)/parser/grammar
OBJECTS_PARSER = \
$(PREFIX)/parser/grammar/gEconLexer.o \
$(PREFIX)/parser/grammar/gEconParser.o \
$(PREFIX)/parser/model_parse.o \
$(PREFIX)/parser/gecon_tokens.o \

INCLUDE_MODEL = -I$(PREFIX)/model
OBJECTS_MODEL = \
$(PREFIX)/model/model_block.o \
$(PREFIX)/model/model.o \
$(PREFIX)/model/model_doit.o \
$(PREFIX)/model/model_write.o

OBJECTS_QZ = \
$(PREFIX)/qz/zgges_interface.o \
$(PREFIX)/qz/lapack/zunmqr.o \
$(PREFIX)/qz/lapack/ztgsyl.o \
$(PREFIX)/qz/lapack/ztgsy2.o \
$(PREFIX)/qz/lapack/ztgsen.o \
$(PREFIX)/qz/lapack/zlatdf.o \
$(PREFIX)/qz/lapack/zhgeqz.o \
$(PREFIX)/qz/lapack/zgghrd.o \
$(PREFIX)/qz/lapack/zgesc2.o \
$(PREFIX)/qz/lapack/zgetc2.o \
$(PREFIX)/qz/lapack/ztgexc.o \
$(PREFIX)/qz/lapack/ztgex2.o \
$(PREFIX)/qz/lapack/zgges.o \
$(PREFIX)/qz/lapack/zggbal.o \
$(PREFIX)/qz/lapack/zggbak.o



ALL_INCLUDES = $(INCLUDE_GECON) $(INCLUDE_SYMBOLIC) \
$(INCLUDE_PARSER) $(INCLUDE_MODEL)

OBJECTS = $(OBJECTS_GECON) $(OBJECTS_SYMBOLIC) \
$(OBJECTS_PARSER) $(OBJECTS_MODEL) $(OBJECTS_QZ)

#
# General Settings
# 

BLAS_LIBS = -lblas

# C/C++
CC = gcc
CFLAGS = -march=native -mtune=generic -O2 -pipe -fstack-protector-strong $(LTO)
CPICFLAGS = -fpic
CPPFLAGS = -D_FORTIFY_SOURCE=2
CXX = g++
CXXCPP = $(CXX) -E
CXXFLAGS = -march=native -mtune=generic -O2 -pipe -fstack-protector-strong $(LTO)
CXXPICFLAGS = -fpic
CXX1X = g++
CXX1XFLAGS = -march=native -mtune=generic -O2 -pipe -fstack-protector-strong
CXX1XPICFLAGS = -fpic

# FORTRAN
FC = gfortran
FCFLAGS = -g -O2 $(LTO)
FCLIBS = 
F77 = gfortran
F77_VISIBILITY = -fvisibility=hidden
FFLAGS = -g -O2 $(LTO)
FLIBS =  -lgfortran -lm -lquadmath
FCPICFLAGS = -fpic
FPICFLAGS = -fpic

LAPACK_LIBS = -llapacke

LIBM = -lm
LDFLAGS = -Wl,-O1,--sort-common,--as-needed,-z,relro
LTO = 

# linking
MAIN_LD = $(CC)
MAIN_LDFLAGS = -Wl,--export-dynamic -fopenmp
MAIN_LINK = $(MAIN_LD) $(MAIN_LDFLAGS) $(LDFLAGS)

OBJC = 
OBJCFLAGS =  $(LTO)
OBJC_LIBS = 
OBJCXX = 

RANLIB = ranlib
SAFE_FFLAGS = -g -O2 -ffloat-store
SED = /usr/bin/sed
SHELL = /bin/sh

# Collect the options
ALL_CFLAGS = $(PKG_CFLAGS) $(CPICFLAGS) $(CFLAGS)
ALL_CPPFLAGS = $(ALL_INCLUDES) $(CPPFLAGS) $(CLINK_CPPFLAGS)
ALL_CXXFLAGS = $(PKG_CXXFLAGS) $(CXXPICFLAGS) $(CXXFLAGS)
ALL_OBJCFLAGS = $(PKG_OBJCFLAGS) $(CPICFLAGS) $(OBJCFLAGS)
ALL_OBJCXXFLAGS = $(PKG_OBJCXXFLAGS) $(CXXPICFLAGS) $(OBJCXXFLAGS)
ALL_FFLAGS = $(PKG_FFLAGS) $(FPICFLAGS) $(FFLAGS)

PKG_LIBS = $(LAPACK_LIBS) $(BLAS_LIBS) $(FLIBS) -lstdc++

.SUFFIXES:
.SUFFIXES: .c .cpp .f .o

.PHONY: clean

all: link

.c.o:
	@echo "making $@ from $<"
	$(CC) $(ALL_CPPFLAGS) $(ALL_CFLAGS) -c $< -o $@

.cpp.o:
	@echo "making $@ from $<"
	$(CXX) $(ALL_CPPFLAGS) $(ALL_CXXFLAGS) -I/usr/include -L/usr/lib/ -c $< -o $@

.f.o:
	$(F77) $(ALL_FFLAGS)  $(PKG_LIBS) -c $< -o $@

link: $(OBJECTS)
	$(CXX) $(OBJECTS) -o gEconModelParser  -L/usr/lib/ $(ALL_CXXFLAGS) $(MAIN_LDFLAGS) $(LDFLAGS) $(PKG_LIBS)

clean:
	-@rm $(OBJECTS)
