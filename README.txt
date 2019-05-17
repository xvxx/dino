
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
an interactive fashion using a REPL. Dino can also be used to run LDPL
programs on systems which lack a C++11 compiler.

=== GETTING STARTED ==================================================

You must have the official LDPL compiler installed in your $PATH:

   https://www.ldpl-lang.org/

Once that's done, clone Dino:

   git clone https://github.com/dvkt/dino

And build it:

   cd dino
   make dino

You should see a "File(s) compiled successfully." message if
everything worked.

For extra protection, run the official ldpltests:

   make test

Once again, you should see a "success" message if everything is
working properly. If not, please kindly report an issue at this URL:

   https://github.com/dvkt/dino/issues

Now then, we can start to properly explore Dino:

   $ dino -h

   Usage: $ dino [command] [file]

   Commands:
      run     execute .ldpl, .dino, or .dinocode file
      asm     compile .ldpl file to .dino assembly
      bytes   compile .ldpl or .dino file to .dinocode bytecode
      dis     disassemble .dinocode file to .dino assembly
      lex     lex .ldpl file and print tokens
      parse   parse .ldpl file and print nodes
      help    print help screen
      version print version number

   Examples:
      $ dino run spark.ldpl 1 3 7 12 22 31  # run file with args
      $ dino bytes gild.ldpl                # print bytecode
      $ dino asm spacemines.ldpl            # print assembly code

=== OVERVIEW =========================================================

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

=== ISSUES ===========================================================

1. This first iteration plays fast and loose with the "byte" in
   bytecode. Once LDPL supports bitwise operations we will revisit the
   core design so it's more bit-tastic. When we say "byte" in this
   document, assume we mean "word".

2. We are not considering performance at this time, but rather seeking
   to educate ourselves by creating this prehistoric vm.

3. The bytecode format, version number, and set of CPU instructions
   are going to change a lot while this is still in development.

=== TECHNNICAL SPECIFICATIONS ========================================

* 32 bit words
* 0xFFFF words of memory
* 11 numeric registers (A, X, Y, Z, E, C, I, J, SP, PC, AC)
* 5 text registers (A, X, Y, T, E)
* Registers, variables, and constants share a logical address space:
* Two types: numeric and text. Address determines type.
* Instructions are 1-4 words: One opcode and 0-3 operands.
* ...?

=== PROJECT STATUS ===================================================

+---+-----------+-----------------------------------------------------
| ? | NAME      | STATUS
+---+-----------+-----------------------------------------------------
| = | ========= | COMPILER ===========================================
| X | Lexer     | Operational
| > | Parser    | Underway!
| > | Generator | Underway!!
| X | Assembler | Operational
| = | ========= | VIRTUAL MACHINE ====================================
| X | CPU       | Operational
| X | Memory    | Operational
| = | ========= | TOOLING ============================================
|   | REPL      |
|   | Debugger  |
| X | CLI       | Operational. Lacks options, features.
| X | dis       | Operational: Basic debug, needs labels and real asm
| X | vscode    | Operational: Syntax highlighting. No Tasks.
| = | ========= | DOCUMENTATION ======================================
| > | manual    | In progress.
|   | website   | Need to generate from manual.
|   | man page  | Need to figure out how to generate from manual


=== TODO =============================================================

* [ ] 2nd pass TODO:
   * [ ] validate syntax in parser, eg no ELSE before ELSE IF
   * [ ] much better error messages. like rust's.
* [ ] build each part separately
   * [x] lexer
   * [ ] parser
      * [x] \\ and \" in strings
      * [ ] nodes:
         * [ ] SOLVE
         * [ ] STORE QUOTE
         * [ ] CALL EXTERNAL
         * [ ] EXTERNAL SUB-PROCEDURE
         * [ ] var is EXTERNAL data types
   * [ ] generator
      * [ ] all ldpl statements:
         * [x] STORE
         * [ ] IF
         * [ ] WHILE
         * [ ] SUB-PROCEDURE
         * [x] BREAK
         * [x] CONTINUE
         * [x] CALL
         * [x] RETURN
         * [x] EXIT
         * [x] WAIT
         * [x] GOTO
         * [x] LABEL
         * [x] ADD
         * [x] SUB
         * [x] MUL
         * [x] DIV
         * [x] MOD
         * [x] ABS
         * [x] RAND
         * [x] FLOOR
         * [x] CEIL
         * [x] INCR
         * [x] DECR
         * [ ] SOLVE
         * [ ] JOIN
         * [ ] GET CHAR
         * [ ] STORE LENGTH
         * [ ] STORE CHAR
         * [ ] STORE CHAR QUOTE
         * [ ] STORE QUOTE
         * [ ] IN JOIN
         * [ ] DISPLAY
         * [ ] ACCEPT
         * [ ] ACCEPT UNTIL EOF
         * [ ] EXECUTE
         * [ ] EXECUTE AND STORE OUTPUT
         * [ ] EXECUTE AND STORE EXIT CODE
         * [ ] LOAD FILE
         * [ ] WRITE FILE
         * [ ] APPEND FILE
         * [ ] Extensions...
   * [x] assembler
   * [x] loader
   * [x] memory
   * [x] cpu
   * [x] vscode for dinoasm
* [x] assembly -> bytecode $ dino bytes examples/99.dino
   * [x] strip comments
   * [x] trim line
   * [x] tokenize file
   * [x] support strings
   * [-] :newline: token  (don't need)
   * [x] accept file from command line
   * [x] tokens -> bytecode
   * [x] print raw bytecode
   * [ ] error checking:
      * [ ] arity
      * [ ] labels?
   * [x] relative jumps
   * [ ] save bytecode to file
* [ ] REPL
   * [ ] >> input
   * [ ] == output
   * [ ] readline
   * [ ] history
   * [ ] multi-lines
   * [ ] asm mode
* [x] bytecode -> assembly $ dino dis file.dinocode
   * [x] load bytecode from file
* [ ] RAM
   * [ ] vectors?
* [ ] CPU
   * [x] load bytecode from file
   * [x] run bytecode
   * [ ] vectors?
   * [x] Instructions:
      * [x] JUMP
      * [x] JIF
      * [x] JIT
      * [x] CALL
      * [x] RETURN
      * [x] EXIT
      * [x] WAIT
      * [x] STORE
      * [x] SET
      * [x] EQ
      * [x] GT
      * [x] LT
      * [x] ADD
      * [x] SUB
      * [x] MUL
      * [x] DIV
      * [x] MOD
      * [x] ABS
      * [x] CEIL
      * [x] FLOOR
      * [x] RANDOM
      * [x] PRINT
      * [x] ACCEPT
      * [x] EXEC
      * [x] READ
      * [x] WRITE
      * [x] APPEND
      * [x] LEN
      * [x] JOIN
      * [x] GETC
      * [x] GETCC
      * [x] PUTC
      * [x] PUSH
      * [x] POP
      * [x] INCR
      * [x] DECR

=== APPENDIX =========================================================

# --- ADDRESS SYNTAX -------------------------------------------------
| NAME            | SYNTAX
+-----------------+---------------------------------------------------
| Number Register | $z, $pc
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
| 3010 | 301F | TEXT | Command line arguments (@arg0, @arg1...@arg8)
| 3020 | 3FFF | TEXT | Variables (@beer, @name, @label)
| 4000 | FFFF | TEXT | Literals ("Hiya", "SCORE", "????")

# --- REGISTERS ------------------------------------------------------
| NUM  | NAME | DESCRIPTION
+------+------+-------------------------------------------------------
| 0000 | $A   | Accumulator
| 0001 | $X   | Parameter
| 0002 | $Y   | Parameter
| 0003 | $Z   | $a = 0?
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
| 3010 | @arg0| First command line argument (ARGV)
| 3011 | @arg1| Second...
| 3017 | @arg7| Penultimate
| 3018 | @arg8| Final command line argument
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
|  10  | STORE %var $r     | Store value of register r in variable var.
|  11  | SET $r 314        | Set $r to literal number value.
|  12  | FETCH $r $x       | Set $r to value of memory at address in $x.
|  13  | PUSH $x           | Push $x onto the stack.
|  14  | POP $a            | Pop off the stack into $a.
| ==== | ================= | ARITHMETIC ==============================
|  20  | EQ $x $y $a       | Set $a=1 if $x == $y
|  21  | GT $x $y $a       | Set $a=1 if $x > $y
|  22  | GTE $x $y $a       | Set $a=1 if $x > $y
|  23  | LT $x $y $a       | Set $a=1 if $x < $y
|  24  | LTE $x $y $a       | Set $a=1 if $x < $y
|  25  | ADD $x $y $a      | Put sum of registers $x and $y in $a
|  26  | SUB $x $y $a      | Subtract value of $y from $x and put in $a.
|  27  | MUL $x $y $a      | Multiplication
|  28  | DIV $x $y $a      | Division. $e will be set to 1 if $y is 0.
|  29  | MOD $x $y $a      | Modulo
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
|  33  | EXEC @x @a        | Run @x and put output in @a.
|  34  | EXECC @x $a       | Run @x and put exit code in $a.
|  35  | READ @x @a        | Read file at path @x into @a. Sets $e, @e
|  36  | WRITE @x @y       | Write @y to file at path @x.
|  37  | APPEND @x @y      | Append @y to file at path @x.
| ==== | ================  | TEXT OPERATIONS ========================
|  40  | LEN @x $a         | Get length of string in @x.
|  41  | JOIN @x @y @a     | Concatenate text in registers into @a.
|  42  | GETC n @str @a    | Get character in @str at n and put into @a.
|  43  | GETCC @str $a     | Get character code of @str and put into @a.
|  44  | PUTCC n @a        | Put ascii character with code n into @a.
