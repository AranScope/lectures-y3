# LT7 - C
[cdecl.org](https://cdecl.org) converts code into plain english.

## Pointers
A pointer is a variable which "points" to another variable.

\* - Follow the pointer and give the value it points to, **dereference**

& - Get the address of the pointer

```
// x is an integer, sets aside memory on the stack
int x;

// x is a pointer to an integer, memory is not allocated
int *x;


int x; int *x_p = &x;
*x_p = 3

int array[] = {63, 43, 32};
int *pointer = (int *) &array;
```

## Arrays
Arrays are just syntactic sugar for pointers, so `int a[100]` reserves space for 100 integers and **a** is a pointer to that space.

So `a[7]` = `*(a+7)`

Arrays are almost always zero filled, but don't rely on this, if you need something to be zero filled then do it yourself.

## Pointer arithmetic
Pointers are assumed to point to a type twhich hasaknown size, so when multiplying they are really multiplied by the size of the type.

## Debugging
### Assert
```
#include <assert.h> // this should be everywhere
```
Use assert **everywhere**, asserts in, asserts out, asserts all about. If an assert fails then the code immediately exists, with a core dump if possible. Use it on arguments, return values, items in structures etc. If you can check return values and use `perror` this will help with debugging.

This helps to avoid code limping on and dying at a later time, making it difficult to trace the source of the error.

- Assert pointers are non-null
- Assert sizes of objects are what you expect
- Assert that malloc has worked properly

### GDB
You have to compile with `-g`, you can also do post mortem debugging by loading the core dump with gdb.

## Structures
A **struct** is a composite which contains elements of various types.

If you declare a struct you can dot access it and it is immediately stack allocated. If you declare a pointer to a struct you have to manually malloc it and you use the 

It's worth using **typedef** as its tidier and makes code more readable. 

You can take the address of individual elements in a struct. `&(pair_p->y)`

## Strings
C strings are syntactic sugar for strings, that by convention are arrays of chars followed by a zero byte.

```
// these both represent the same string
char *s = "abc";
char s[4] = {'a', 'b', 'c', '\0'}
```

If you have an array of char which includes a zero byte then you need to use `write`, `send` or `fwrite`. The same applies to all the other string routines `strcmp`, `strcpy` etc. Instead use `memcpy`, `memcmp` and so on.

This is common with files such as PDFs so avoid hacks like trying to add a `\0` to the end of the buffer and call a string :(

## Function Pointers
Functions in C are **call by value**. Changes made to arguments are not propogated back to the caller, as the arguments are copied into the function.

If you want to be able to modify the arguments then **you have to pass a pointer** to the original data.

By convention you should not pass structures to functions, this used to not be permitted. Instead you should pass pointers to structures.

## Threads
Threads have their own stack, so don't access other threads stack. When using `pthread_create`, it's always best to pass in malloc'd space, not a pointer to anything else.
