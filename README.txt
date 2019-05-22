
                *  *__* _*  *  * _*  *__*_ *__*  *
                * |   \(_)_ _  __\ \ / /  \/  |  *
                * | |) | | ' \/ _ \ V /| |\/| |  *
                * |___/|_|_||_\___/\_/ |_|  |_|  *
                *  *  *  *  *  *  *  *  *  *  *  *

                           An LDPL VM
                           Written in
                              LDPL
                               🦖

=== INTRODUCTION =====================================================

Dino is an interpreter for the LDPL programming language, written in
LDPL. Because LDPL is a compiled language, Dino's goal is to provide a
lightweight, scriptable version of the language that can be used to
quickly prototype ideas, perform system tasks, or compose programs in
an interactive fashion using a REPL. Dino can also be used to run basic
LDPL programs on systems which lack a C++11 compiler.

=== EXAMPLES =========================================================

HELLO:

    $ cat hi.ldpl
    PROCEDURE:
    display "Hey pardner" crlf
    $ dino run hi.ldpl
    Hey pardner

LDPL-SPARK:

    $ git clone https://github.com/photogabble/ldpl-spark
    $ dino run ldpl-spark/spark.ldpl 9 13 5 17 1
    ▄▆▂█▁
    $ dino run ldpl-spark/spark.ldpl 0 30 55 80 33 150
    ▁▂▃▄▂█

LDPL-SPACE-MINES:

    $ git clone https://github.com/photogabble/ldpl-space-mines
    $ dino run ldpl-space-mines/spacemines.ldpl
    ==================================================
    YEAR 1:

    There are 55 people in the colony...

LBI:

    $ git clone https://github.com/Lartu/LBI
    $ dino run LBI/src/LBI.ldpl LBI/examples/fib.b
    dino run ldpl/examples/brainfuck.ldpl LBI/examples/fib.b
    0
    1
    1
    2...
    $ dino run ldpl/examples/brainfuck.ldpl LBI/examples/squares.b
    0
    1
    4
    9...

=== GETTING STARTED ==================================================

You must have version 3.0.5 of the official LDPL compiler installed
in your $PATH:

   https://www.ldpl-lang.org/

Once that's done, clone Dino:

   git clone https://github.com/dvkt/dino

And build it:

   cd dino
   make dino

You should see a "File(s) compiled successfully." message if
everything worked. You now have a `dino` command line program sitting
in the current directory. Run it directly, or add it to your $PATH and
enjoy the fruits of this installation process:

   ./dino -h

For added security, run Dino against the official LDPL Test Battery:

   make test

You should see another "success" message if everything is working
properly. If not, kindly report an issue at this address:

   https://github.com/dvkt/dino/issues

=== HOW IT WORKS =====================================================

Internally, Dino is organized into three parts: compiler, virtual
machine, and tooling, with the `dino` command line program serving as
the primary means of interacting with the suite.

The compiler translates LDPL source code to DinoASM, Dino's simple
assembly language, then to Dinocode, Dino's bytecode format. The
virtual machine loads bytecode into its memory then performs each
instruction, just like your old Nintendo. Tooling includes the `dino`
command line program for running LDPL programs and using the compiler
suite, the REPL, and `dino dis` for displaying / disassembling
dinocode.

The classic bytecode/VM architecture means Dino could (with changes)
support languages other than LDPL in the future, but for now it's
focused on supporting the full LDPL 3.0.5 specification on Linux,
MacOS, Windows, WebAssembly, and Raspberry Pi.

=== BASIC USAGE =====================================================

Let's look at a simple LDPL program:

    $ cat math.ldpl
    DATA:
    x is number
    y is number
    z is number
    PROCEDURE:
    store 1 in x
    store 2 in y
    add x and y in z
    display x "+" y "=" z crlf

First we'll run it using LDPL 3.0.5 as a sanity check:

    $ ldpl math.ldpl
    LDPL: Compiling...
    * File(s) compiled successfully.
    * Saved as math-bin
    $ ./math-bin
    1+2=3

Okay, that seems right. Next we'll run it using Dino:

    $ dino run math.ldpl
    1+2=3

Great! We can stop there. But if you want to look under the hood a
bit, you can see the tokens produced by Dino's lexer for this file:

    $ dino lex math.ldpl
    tokens (41):
    <DATA:>, <:NL:>
    <X>, <IS>, <NUMBER>, <:NL:>
    <Y>, <IS>, <NUMBER>, <:NL:>
    <Z>, <IS>, <NUMBER>, <:NL:>
    <PROCEDURE:>, <:NL:>
    <STORE>, <1>, <IN>, <X>, <:NL:>
    <STORE>, <2>, <IN>, <Y>, <:NL:>
    <ADD>, <X>, <AND>, <Y>, <IN>, <Z>, <:NL:>
    <DISPLAY>, <X>, <"+">, <Y>, <"=">, <Z>, <"\r\n">, <:NL:>

Pretty fun. The next step is the parser, so let's see the parse tree:

    $ dino parse math.ldpl
    vars (3):
    #<NUM: X>
    #<NUM: Y>
    #<NUM: Z>
    nodes (4):
    STORE
        - a0(NML): 1
        - a1(NUM): X
    STORE
        - a0(NML): 2
        - a1(NUM): Y
    ADD
        - a0(NUM): X
        - a1(NUM): Y
        - a2(NUM): Z
    DISPLAY
        - a0(NUM): X
        - a1(TXL): "+"
        - a2(NUM): Y
        - a3(TXL): "="
        - a4(NUM): Z
        - a5(TXL): "\r\n"

These nodes are used by the generator to emit dinoasm:

    $ dino asm math.ldpl
        SET %var0, 1
        STORE %X, %var0
        SET %var1, 2
        STORE %Y, %var1
        ADD %X, %Y, %Z
        PRINT %X
        PRINT "+"
        PRINT %Y
        PRINT "="
        PRINT %Z
        PRINT "\r\n"
        EXIT

If we want, we can save this output to a .dinoasm file and run it:

    $ dino run math.dinoasm                                                                            master
    1+2=3

This can be helpful in debugging or development of Dino itself.

Finally, the bytecode produced by the assembler:

    $ dino bytes math.ldpl
    76 68 80 76 2 09 17 01 08 18 17 09 19 02 08 20 19 20 18 20 21 31
    18 31 16384 31 20 31 16385 31 21 31 16386 06 "+" "=" "\r\n"

We can also save this output to a .dinocode file and run it directly.
Or, you know, just write code this way:

    $ dino bytes math.ldpl | sed 's/17 01/17 13/g' > math.dinocode
    $ dino run math.dinocode
    13+2=15

There's also `dino dis` which turns dinocode back into dinoasm, kinda.
But those are the main "under the hood" tools.

=== TECHNICAL SPECIFICATION ==========================================

* "Words" are LDPL numbers.
* Instructions are 1-4 words: opcode and then operands.
* Two native types are number and text.
* 11 number registers: $a, $x, $y, $z, $e, $c, $i, $t, $sp, $pc, $ac
* $sp is stack pointer, $pc is program counter, $ac is argc, $e error code
* 5 text registers: @a, @x, @y, @t, @e
* One address space for number registers, number variables, text
  registers, text variables, and text literals.
* Parallel address space for number vectors and text vectors.

=== ISSUES ===========================================================

1. This first iteration plays fast and loose with the "byte" in
   bytecode. The .dinocode files aren't really binary and we're not
   doing any bit shifting or funny stuff like that. Once LDPL supports
   bitwise operations we'll revisit the core design so it's more bit-
   tastic. For now, we're just using numbers.

2. Dino is super slow, but that's okay. Performance may never be a
   priority for our prehistoric VM.

3. The bytecode format, version number, and set of CPU instructions
   are going to change a lot while this is still in development.

4. Extensions are not, and probably won't ever be, supported.

5. Nothing is optimized at all, not even number constants. There are
   way too many instructions generated in most cases.

6. There is hardly any error checking yet, so you might end up
   generating bytecode that can't be run without knowing why.

7. Nested vectors don't work yet, like: `vec1:vec2:2`

8. The `IN - SOLVE` instruction doesn't work yet.

=== REFERENCE ========================================================

# --- ADDRESS SYNTAX -------------------------------------------------
| NAME            | SYNTAX
+-----------------+---------------------------------------------------
| Number Register | $a, $pc
| Number Variable | %bufsize, %Users
| Text Variable   | @name, @City
| Text Literal    | "heya", "LDPL rox!"
| Label           | print-fn, DISPLAY

# ----- MEMORY ADDRESSES ---------------------------------------------
| 1ST  | LAST | TYPE | DESCRIPTION
+------+------+---------------------------------------------------
| 0000 | 000F | NUM  | Registers ($x, $y, $a, $pc)
| 0010 | 2FFF | NUM  | Variables (%count, %item-size)
| 3000 | 300F | TEXT | Registers (@A, @X, @E)
| 3010 | 3010 | TVEC | Command line arguments @argv
| 3020 | 3FFF | TEXT | Variables (@beer, @name, @label)
| 4000 | FFFF | TEXT | Literals ("Hiya", "SCORE", "????")

# --- REGISTERS ------------------------------------------------------
| NUM  | NAME | DESCRIPTION
+------+------+-------------------------------------------------------
| 0000 | $A   | Accumulator
| 0001 | $X   | Parameter
| 0002 | $Y   | Parameter
| 0003 | $Z   | Parameter
| 0004 | $E   | Non-zero error code
| 0005 | $C   | Carry
| 0006 | $I   | Incrementor
| 0007 | $T   | Temporary value
| 0008 | $SP  | Stack pointer
| 0009 | $PC  | Program counter
| 0010 | $AC  | Num of command line arguments given aka ARGC. 8 max.
| 0010 |      | Number variables
| .... |      |
| 3000 | @A   | Text accumulator
| 3001 | @X   | Text register
| 3002 | @Y   | Text register
| 3003 | @T   | Text register
| 3004 | @E   | Error message
| .... |      |
| 3010 | @argv| Command line arguments vector
| .... |      |
| 3020 |      | Text variables
| .... |      |
| 4000 |      | Text literals
| .... |      |
| FFFF |      | Final address

# --- BYTECODE FORMAT ------------------------------------------------
| BYTE | DATA | DESCRIPTION
+------+------+-------------------------------------------------------
| 0000 |  76  | First four bytes are char codes for "LDPL"
| 0001 |  68  |
| 0002 |  80  |
| 0003 |  76  |
| 0004 |  01  | Bytecode version number
| 0005 |      | First instruction
| 0006+|      | Program instructions
| 00XX |  06  | Final EXIT
| 00XX |      | Sub-procedure definitions
| 00XX |      | Text literals

# --- INSTRUCTIONS ---------------------------------------------------
| CODE | NAME              | DESCRIPTION
+------+-------------------+------------------------------------------
|  00  | n/a               | n/a
| ==== | ================= | CONTROL FLOW ============================
|  01  | JUMP label        | Jump to location of label
|  02  | JIF label         | Jump to label if $a is 0 (false)
|  03  | JIT label         | Jump to label if $a is 1 (true)
|  04  | CALL label        | Push location on stack and jump to label
|  05  | RETURN            | Pop loc off top of stack and jump to it
|  06  | EXIT              | Exit program
|  07  | WAIT $r           | Pause for milliseconds in register.
| ==== | ================= | MEMORY COMMANDS =========================
|  10  | STORE %var $r     | %var = value at address $r
|  11  | SET $r 314        | Set $r to a literal number value
|  12  | FETCH $r $x       | Set $r to the value at address in $x. Like a pointer.
|  13  | PUSH $x           | Push $x onto the stack.
|  14  | POP $a            | Pop off the stack into $a.
|  15  | STOREV %vec $r %v | Set %vec:$r to value of %v. %vec:@t and @v work too.
|  16  | PUTV %vec $r %a   | Put %vec:$r into %a. %vec:@t and @v work too.
| ==== | ================= | ARITHMETIC ==============================
|  20  | EQ $x $y $a       | Set $a=1 if $x == $y
|  21  | GT $x $y $a       | Set $a=1 if $x > $y
|  22  | GTE $x $y $a      | Set $a=1 if $x > $y
|  23  | LT $x $y $a       | Set $a=1 if $x < $y
|  24  | LTE $x $y $a      | Set $a=1 if $x < $y
|  25  | ADD $x $y $a      | Set $x + $y to $a
|  26  | SUB $x $y $a      | Set $x - $y to $a
|  27  | MUL $x $y $a      | Set $x * $y to $a
|  28  | DIV $x $y $a      | Set $x / $y to $a, $e will be set to 1 if $y is 0.
|  29  | MOD $x $y $a      | Set $x % $y to $a
|  2A  | ABS $x            | Convert $x to its absolute value.
|  2B  | CEIL $x           | Round $x to next whole number.
|  2C  | FLOOR $x          | Round $x to previous whole number.
|  2D  | RANDOM $a         | Put random number in $a.
|  2E  | INCR $x           | Add 1 to $x.
|  2F  | DECR $x           | Subtract 1 from $x.
| ==== | ================= | I/O COMMANDS ============================
|  30  | PRINT $x          | Print content of register $x
|  31  | PRINL $x          | Print content of register $x and newline.
|  32  | ACCEPT $x         | Accept user input into num or text var.
|  33  | ACCEOF $x         | Accept user input until EOF.
|  34  | EXEC @x @a        | Run @x and put output in @a.
|  35  | EXECC @x $a       | Run @x and put exit code in $a.
|  36  | READ @x @a        | Read file at path @x into @a. Sets $e, @e
|  37  | WRITE @x @y       | Write @x to file at path @y.
|  38  | APPEND @x @y      | Append @x to file at path @y.
| ==== | ================  | TEXT OPERATIONS ========================
|  40  | LEN @x $a         | Get length of string in @x.
|  41  | JOIN @x @y @a     | Concatenate text in registers into @a.
|  42  | GETC $x @str @a   | Get character in @str at $x and put into @a.
|  43  | GETCC @str $a     | Get character code of @str and put into @a.
|  44  | GETIDX @x @y $a   | Get index of @x in @y, put in $a.
|  45  | PUTCC $x @a       | Put ascii character with code $x into @a.
|  46  | COUNT @x @y $a    | Count occurrences of @x in @y, put in $a.
|  47  | SUBSTR @x $x $y @a| Put @x[$x..$y] into @a.
|  48  | SPLIT @x @y @a    | Split @x by @y and put in vector @a
|  49  | REPLCE @x @y @z @a| Replace @x from @y with @z in @a
|  4A  | TRIM @x @a        | Strip L/R whitespace from @x, put in @a.

=== TODO =============================================================

* [ ] IN - SOLVE
* [ ] LDPL Test Battery:
   * [ ] basicar.ldpl
      * [ ] SOLVE
* [ ] LDPL Programs:
   * [ ] beKnowledge
      * [x] parser bug (milliseconds)
      * [x] escape codes
      * [ ] bug in JOIN phase
      * [ ] bug in clear
* [ ] parser errors 2nd pass (only show broken line) (like rust's.)
* [ ] docs 2nd pass
* [ ] lex errors 2nd pass
* [ ] gen errors 2nd pass
* [ ] asm errors 2nd pass
* [ ] function docs 2nd pass
* [ ] error on:
   * [ ] CALL EXTERNAL
   * [ ] EXTERNAL SUB-PROCEDURE
   * [ ] var is EXTERNAL data types
* [ ] REPL
   * [ ] >> input
   * [ ] == output
   * [ ] readline
   * [ ] history
   * [ ] multi-lines
   * [ ] asm mode
