# --- MEMORY LAYOUT --------------------------------------------------
| NUM  | NAME | TYPE | DESCRIPTION
+------+------+------+------------------------------------------------
| ==== | ==== | ==== | REGISTERS ====================================
| 0000 | Z    | NUM  | Result
| 0001 | A    | NUM  | Parameter
| 0002 | B    | NUM  | Parameter
| 0003 | C    | NUM  | Parameter
| 0004 | D    | NUM  | Parameter
| 0005 | E    | NUM  | Non-zero error code
| 0006 | F    | NUM  | Flags
| 0007 | M    | NUM  | Addressing mode. See below
| 0008 | SP   | NUM  | Stack pointer
| 0009 | PC   | NUM  | Program counter
| 0010 | TZ   | TEXT | Result
| 0011 | TA   | TEXT | Parameter
| 0012 | TB   | TEXT | Parameter
| 0013 | TC   | TEXT | Parameter
| 0014 | TD   | TEXT | Parameter
| 0015 | TE   | TEXT | Error message
| ==== | ==== | ==== | VARIABLES ====================================
| 1000 |      | NUM  | Number variables
| 2000 |      | TEXT | Text variables
| ==== | ==== | ==== | CONSTANTS ====================================
| 3000 |      | TEXT | Text literals 

# --- ADDRESSING MODE ------------------------------------------------
| VAL | NAME       | DESCRIPTION
+-----+------------+---------------------------------------------------
|  0  | Memory     | Use number as register/memory location.
|  1  | Immediate  | Use literal value of given number.

# --- REGISTER STYLE -------------------------------------------------
| NAME            | SYNTAX
+-----------------+---------------------------------------------------
| Register Name   | $z, $TA
| Register ID     | #0, #15
| Direct Location | 3010, 10120
| Variable Name   | %bufsize, %Users
| Label           | print-fn, DISPLAY

# --- OPCODES --------------------------------------------------------
| CODE | NAME           | DESCRIPTION
+------+----------------+---------------------------------------------
|  00  | n/a            | n/a
|  01  | JUMP label     | Jump to location of label
|  02  | JIF label      | Jump to label if $z is false
|  03  | JIT label      | Jump to label if $z is true
|  04  | CALL label     | Push location on stack and jump to label
|  05  | RETURN         | Pop loc off top of stack and jump to it 
|  06  | STORE %var $r  | Store value of register r in variable var.
|  07  | EXIT           | Exit program
|  08  | SLEEP n        | Pause for n milliseconds.
|  0A  | PRINT $r       | Print content of register $r
|  0B  | ACCEPT $z      | 
|  0C  | EXEC $ta       | 
|  0D  | READ $ta $tz   | 
|  0E  | WRITE $ta $tb  | 
|  0F  | APPEND $ta $tb |
|  10  | CMP $a $b $z   | Compare $a and $b, result in $z. -1 0 or 1
|  11  | ADD $a $b $z   | Put sum of registers $a and $b in $z
|  12  | SUB $a $b $z   | Subtract value of $b from $a and put in $z.
|  13  | MUL $a $b $z   | Multiplication
|  14  | DIV $a $b $z   | Division. $e will be set to 1 if $b is 0.
|  15  | MOD $a $b $z   | Modulo
|  16  | ABS $a $z      | Put absolute value of register $a in $z
|  17  | CEIL $a $z     | Ceiling
|  18  | FLOOR $a $z    | Flooring
|  19  | RANDOM $z      | Put random number in $z.
|  1A  |                | 
|  20  | LEN $ta $z     | Gets length of string in $ta.
|  21  | JOIN $a $b $tz | Concatenates text in registers.
|  22  | GETC n v $tz   | Gets character at position n in string v. 
|  23  | GETCC n v $z   | Gets numeric character code at n in string v.
|  24  | PUTC $tr n     | Puts ascii character n into register $tr.
