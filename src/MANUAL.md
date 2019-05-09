# --- REGISTERS ------------------------------------------------------
| NUM  | NAME | TYPE | DESCRIPTION
+------+------+------+------------------------------------------------
| 0000 | Z    | NUM  | Result
| 0001 | A    | NUM  | Parameter
| 0002 | B    | NUM  | Parameter
| 0003 | C    | NUM  | Parameter
| 0004 | D    | NUM  | Parameter
| 0005 | E    | NUM  | Non-zero error code
| 0006 | F    | NUM  | Flags
| 0007 | G    | NUM  | 
| 0008 | H    | NUM  | 
| 0009 | IP   | NUM  | Instruction pointer
| 0010 | TZ   | TEXT | Result
| 0011 | TA   | TEXT | Parameter
| 0012 | TB   | TEXT | Parameter
| 0013 | TC   | TEXT | Parameter
| 0014 | TD   | TEXT | Parameter
| 0015 | TE   | TEXT | Error message

# --- TYPES ----------------------------------------------------------
| VAL    | NAME           | DESCRIPTION
+--------+----------------+-------------------------------------------
| %var   | Variable       | 
| $r     | Register       | 0-15
| #0     | Register       | 0-15
| label  | Label          | 16-255
| "Hiya" | Text           | 255-1000
| 3.14   | Number         | 1000+, -1000

# --- OPCODES --------------------------------------------------------
| VAL  | NAME           | DESCRIPTION
+------+----------------+---------------------------------------------
| 0000 | n/a            | n/a
| 0001 | JUMP label     | Jump to location of label
| 0002 | JIF label      | Jump to label if $z is false
| 0003 | JIT label      | Jump to label if $z is true
| 0004 | CALL label     | Push location on stack and jump to label
| 0005 | RETURN         | Pop loc off top of stack and jump to it 
| 0006 | SET $r v       | Set register to number or text literal 
| 0007 | COPY $b $a     | Copy value of register b into register a
| 0008 | STORE %var $r  | Store value of register r in variable var.
| 0009 | EXIT           | Exit program
| 0010 | PRINT $r       | Print content of register $r
| 0011 | SLEEP n        | Pause for n milliseconds.
| 0012 | ACCEPT $z      | 
| 0013 | EXECUTE $ta    | 
| 0014 | READ $ta $tz   | 
| 0015 | WRITE $ta $tb  | 
| 0016 | APPEND $ta $tb |
| 0017 |                |
| 0018 |                |
| 0019 |                |
| 0020 | ADD $a $b $z   | Put sum of registers $a and $b in $z
| 0021 | SUB $a $b $z   | Subtract value of $b from $a and put in $z.
| 0022 | MUL $a $b $z   | Multiplication
| 0023 | DIV $a $b $z   | Division. $e will be set to 1 if $b is 0.
| 0024 | MOD $a $b $z   | Modulo
| 0025 | ABS $a $z      | Put absolute value of register $a in $z
| 0026 | CEIL $a $z     | Ceiling
| 0027 | FLOOR $a $z    | Flooring
| 0028 | RANDOM $z      | Put random number in $z.
| 0029 |                |
| 0040 | LEN $ta $z     | Gets length of string in $ta.
| 0041 | JOIN $a $b $tz | Concatenates text in registers.
| 0042 | GETC n v $tz   | Gets character at position n in string v. 
| 0043 | GETCC n v $z   | Gets numeric character code at n in string v.
| 0044 | PUTC $tr n     | Puts ascii character n into register $tr.
| 0060 |                |
