    .data
Upper_Case_Letters:
    .asciiz
	"\tAlpha\n",    "\tBravo\n",    "\tChina\n",   	"\tDelta\n",    "\tEcho\n",
	"\tFoxtrot\n",  "\tGolf\n",    	"\tHotel\n",   	"\tIndia\n",    "\tJuliet\n",
	"\tKilo\n",     "\tLima\n",	    "\tMary\n",    	"\tNovember\n", "\tOscar\n",
	"\tPaper\n",    "\tQuebec\n",  	"\tResearch\n",	"\tSierra\n",   "\tTango\n",
	"\tUniform\n", 	"\tVictor\n",  	"\tWhisky\n",  	"\tX-ray\n",    "\tYankee\n",
	"\tZulu\n"
Upper_Case_Letter_Set:
    .word
	0,	    8,	    16,	    24,	    32,
	39,	    49,	    56,	    64,	    72,
	81,	    88,	    95,	    102,    113,
	121,    129,	138,	149,	158,
	166,    176,    185,    194,    202,
    211
Lower_Case_Letters:
    .asciiz
    "\talpha\n",    "\tbravo\n",    "\tchina\n",    "\tdelta\n",    "\techo\n",
    "\tfoxtrot\n",  "\tgolf\n",     "\thotel\n",    "\tindia\n",    "\tjuliet\n",
    "\tkilo\n",     "\tlima\n",     "\tmary\n",     "\tnovember\n", "\toscar\n",
    "\tpaper\n",    "\tquebec\n",   "\tresearch\n", "\tsierra\n",   "\ttango\n",
    "\tuniform\n",  "\tvictor\n",   "\twhisky\n",   "\tx-ray\n",    "\tyankee\n",
    "\tzulu\n"
Lower_Case_Letter_Set:
    .word
	0,	    8,	    16,	    24,	    32,
	39,	    49,	    56,	    64,	    72,
	81,	    88,	    95,	    102,    113,
	121,    129,	138,	149,	158,
	166,    176,    185,    194,    202,
    211
Numbers:
    .asciiz
    "\tzero\n",     "\tFirst\n",    "\tSecond\n",   "\tThird\n",    "\tFourth\n",
    "\tFifth\n",    "\tSixth\n",    "\tSeventh\n",  "\tEighth\n",   "\tNinth\n"
Number_Set:
    .word
    0,      7,      15,     24,     32,
    41,     49,     57,     67,     76

    .text
    .globl Main
Main:
    li $v0, 12
    syscall
#Distinguish Question Mark
    sub $t1, $v0, 63
    beqz $t1, Exit
    sub $t1, $v0, 48
    slt $s0, $t1, $0
    bnez $s0, Other_Character_Output
#Distinguish Numbers
    sub $t2, $t1, 10
    slt $s1, $t2, $0
    bnez $s1, Number_Output
#Distinguish Upper Case Letters
    sub $t2, $v0, 91
    slt $s3, $t2, $0
    sub $t3, $v0, 64 
    sgt $s4, $t3, $0
    and $s0, $s3, $s4
    bnez $s0, Upper_Case_Letter_Output
#Distinguish Lower Case Letters
    sub $t2, $v0, 123
    slt $s3, $t2, $0
    sub $t3, $v0, 96 
    sgt $s4, $t3, $0
    and $s0, $s3, $s4
    bnez $s0, Lower_Case_Letter_Output
#Distinguish Other Characters
    j Other_Character_Output
#Number Output
Number_Output:
    add $t2, $t2, 10
    sll $t2, $t2, 2
    la $s0, Number_Set
    add $s0, $s0, $t2
    lw $s1, ($s0)
    la $a0, Numbers
    add $a0, $a0, $s1
    li $v0, 4
    syscall
    j Main
#Upper Case Letter Output
Upper_Case_Letter_Output:
    sub $t3, $t3, 1
    sll $t3, $t3, 2
    la $s0, Upper_Case_Letter_Set
    add $s0, $s0, $t3
    lw $s1, ($s0)
    la $a0, Upper_Case_Letters
    add $a0, $s1, $a0
    li $v0, 4
    syscall
    j Main
#Lower Case Letter Output
Lower_Case_Letter_Output:
    sub $t3, $t3, 1
    sll $t3, $t3, 2
    la $s0, Lower_Case_Letter_Set
    add $s0, $s0, $t3
    lw $s1, ($s0)
    la $a0, Lower_Case_Letters
    add $a0, $s1, $a0
    li $v0, 4
    syscall
    j Main
#Other Character Output
Other_Character_Output:
    and $a0, $0, $0
    add $a0, $a0, 9
    li $v0, 1
    li $v0, 11
    syscall
    and $a0, $0, $0
    add $a0, $a0, 42
    li $v0, 1
    li $v0, 11
    syscall
    and $a0, $0, $0
    add $a0, $a0, 10
    li $v0, 1
    li $v0, 11
    syscall
    j Main
#Exit of Program
Exit:
    li $v0, 10
    syscall
