/*
 * file:        switch.s
 * description: generic context switch code for CS 5600
 */
#ifdef __aarch64__
#include "switch-aarch64.S"
#endif

#ifdef __amd64__
#include "switch-x86_64.S"
#endif
