###################################### 
##
## The project Makefile.
##
######################################

##### Macros

HDIR      := inc
ODIR      := obj
CDIR      := src

SOURCES   := MatImage.cc TextFile.cc util.cc
OBJECTS   := $(SOURCES:%.cc=$(ODIR)/%.o)

LIBRARIES := gtkmm-2.4 opencv openssl
CC        := clang++
CFLAGS    := -O `pkg-config --cflags $(LIBRARIES)` -I$(HDIR)
LFLAGS    := -O `pkg-config --libs $(LIBRARIES)`

vpath %.h $(HDIR)
vpath %.o $(ODIR)
vpath %.cc $(CDIR)


##### Rules

photocrypt: $(OBJECTS) $(ODIR)/main.o $(ODIR)/Win.o
	$(CC) $(LFLAGS) $^ -o $@

cli: steg unsteg

all: photocrypt cli

steg: $(OBJECTS) $(ODIR)/steg.o
	$(CC) $(LFLAGS) $^ -o $@

unsteg: $(OBJECTS) $(ODIR)/unsteg.o
	$(CC) $(LFLAGS) $^ -o $@

$(ODIR)/%.o: %.cc $(HDIR)/*.h
	$(CC) $(CFLAGS) $< -c -o $@

clean:
	if [ -f steg ]; then rm steg; fi
	if [ -f unsteg ]; then rm unsteg; fi
	if [ -f photocrypt ]; then rm gui; fi
	if [ "$(shell ls -A $(ODIR))" ]; then rm $(ODIR)/*; fi

help:
	@echo 	"The Makefile defines the following target:"
	@echo 	"   make        : Builds the GUI program"
	@echo 	"   make cli    : Builds the CLI programs (steg & unsteg)"
	@echo   "   make steg   : Builds the CLI steg program"
	@echo 	"   make unsteg : Builds the CLI unsteg program"
	@echo 	"   make all    : Builds everything"
	@echo	"   make clean  : Cleans the built files"
	@echo	"   make help   : Displays this help text"

