# need to install subunit, check
#
# file:    Makefile
#
LDLIBS = -lcheck -lsubunit

CFLAGS = -ggdb3

# default build rules:
# .c to .o: $(CC) $(CFLAGS) file.c -c -o file.o
# multiple .o to exe. : $(CC) $(LDFLAGS) file.o [file.o..] $(LDLIBS) -o exe

test: test.o qthread.o switch.o

switch.o: switch.S
	gcc -c switch.S -o switch.o

clean:
	rm -f *.o test
