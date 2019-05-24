# 👷🏾 LDPL Test Battery
The LDPL Test Battery is a collection of tests and an automated tester used to
test new releases of the [LDPL programming language](https://github.com/lartu/ldpl).

## Tests used
The following tests are used to test the language:
 - **conflow.ldpl**: test basic control flow statements.
 - **basicar.ldpl**: test basic arithmetic statements.
 - **basictx.ldpl**: test basic text statements.
 - **vector.ldpl**: test vector statements.
 - **file.ldpl**: create a file, open a file, write to it, append to it.
 - **fibo.ldpl**: calculate the first 50 fibonacci numbers.
 - **explode.ldpl**: splits a string.
 - **sqrt.ldpl**: calculate a square root using the Babylonian Method.
 - **quine.ldpl**: a quine program.
 - **exec.ldpl**: tests execution and system statements.

## Statements not being tested

 - `ACCEPT`
 - `ACCEPT - UNTIL EOF`
 - `STORE RANDOM IN`
 - `WAIT - MILLINSECONDS`
 - C++ extension compatibility.

## How to compile the tester
The tester is written in LDPL. To compile and run it you should run

`sh compileAndRunTester.sh`

preferably with a stable version of LDPL.

To use a development version of LDPL, set the `LDPLBIN` environment 
variable: 

`env LDPLBIN=/path/to/dev/ldpl sh compileAndRunTester.sh`

## How to run the tester
Run `$ ./tester`.
