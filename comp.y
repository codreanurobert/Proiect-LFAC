%{ //header files
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "functions.h"



extern int yylineno;
extern int yylex();
extern char* yytext;

void yyerror(char *msg);


%}

%define parse.lac full
%define parse.error verbose //mai multe detalii legate de eroare

%union
{
    int intValue;
    float floatValue;
    char charValue;
    char* stringValue;
    bool boolValue;
}

%start start
%token <intValue> INTEGER_VAL
%token <floatValue> FLOAT_VAL 
%token <stringValue> STRING_VAL
%token <charValue> CHAR_VAL
%token <boolValue> BOOL_VAL
%token <stringValue> IDENTIFICATOR
%token BEGIN_P END_P MAIN_F INTEGER FLOAT CHAR STRING BOOL 
%token IF WHILE FOR ELSE FUNCTION INCREMENTATION DECREMENTATION PRINT


%left OR 
%left AND NOT
%left LESS_THAN LESS_EQ_THAN GREATER_THAN GREATER_EQ_THAN EQUAL NOT_EQUAL
%left PLUS MINUS
%left MULTIPLY DIVIDE MODULO
%right ASIGN


// the order does matter (priority)

%% //rules

start : program {printf("\nLimbajul este corect dpdv sintactic\n")}
program : BEGIN_P declarations statements functions special_declarations END_P
      ;

declarations : declarations declaration ';'
             | {}
             ;

declaration :  INTEGER IDENTIFICATOR 
            |  INTEGER IDENTIFICATOR '=' INTEGER_VAL
            |  FLOAT IDENTIFICATOR 
            |  FLOAT IDENTIFICATOR '=' FLOAT_VAL
            |  STRING IDENTIFICATOR
            |  STRING IDENTIFICATOR '=' STRING_VAL
            |  CHAR IDENTIFICATOR
            |  CHAR IDENTIFICATOR '=' CHAR_VAL
            |  BOOL IDENTIFICATOR 
            |  BOOL IDENTIFICATOR '=' BOOL_VAL 
            |  types IDENTIFICATOR // pentru array-uri
            ;
types : type  
      | types type 
      ;

type : '[' INTEGER_VAL ']' type // CUM ALOCAM MEMORIE PT ARRAY

statements : statements statement ';'
           | {}
           ;
statement : IF '(' condition ')' instructions
          | IF '(' condition ')' instructions ELSE instructions
          | WHILE '(' condition ')' instructions
          | FOR '(' declaration ';' condition ';' incrementation ')' instructions
          | PRINT '(' printList() ')'
          ;
conditions : condition AND conditions
           | condition OR conditions
           | condition NOT conditions
           | {}
           ;
condition : INTEGER_VAL LESS_THAN INTEGER_VAL 
          | INTEGER_VAL LESS_EQ_THAN INTEGER_VAL 
          | INTEGER_VAL GREATER_THAN INTEGER_VAL 
          | INTEGER_VAL GREATER_EQ_THAN INTEGER_VAL 
          | INTEGER_VAL EQUAL INTEGER_VAL
          | INTEGER_VAL NOT_EQUAL INTEGER_VAL
          | FLOAT_VAL  LESS_THAN FLOAT_VAL
          | FLOAT_VAL  LESS_EQ_THAN FLOAT_VAL
          | FLOAT_VAL  GREATER_THAN FLOAT_VAL
          | FLOAT_VAL  GREATER_EQ_THAN FLOAT_VAL
          | FLOAT_VAL  EQUAL FLOAT_VAL
          | FLOAT_VAL  NOT_EQUAL FLOAT_VAL
          | STRING_VAL LESS_THAN STRING_VAL
          | STRING_VAL LESS_EQ_THAN STRING_VAL
          | STRING_VAL GREATER_THAN STRING_VAL
          | STRING_VAL GREATER_EQ_THAN STRING_VAL
          | STRING_VAL EQUAL STRING_VAL
          | STRING_VAL NOT_EQUAL STRING_VAL
          ;
          
instructions : instructions instruction 
             | {}
             ;
instruction : incrementation 
            | assign
            | statement
            | call_function
            | return, break, daca vrem 10
            ;
incrementation : IDENTIFICATOR INCREMENTATION 
               | INCREMENTATION IDENTIFICATOR
               | IDENTIFICATOR DECREMENTATION
               | DECREMENTATION IDENTIFICATOR 
               ;
assign : IDENTIFICATOR '=' E
       ;

/* EXP : EXP PLUS EXP {if(isInt($3))  {int a=atoi($1), b=atoi($3); int c=a+b;printf($$, "%d", c);}
                      else if(isFloat($3)) {float a=atof($1), b=atof($3); float c=a+b;printf($$, "%f", c);}
                      else
                      {printf("ERROR! Line %d, expected integer or float value.\n", yylineno); flagError = 1;
                                exit(0);}} 

    | EXP MINUS EXP {if(isInt($3))  {int a=atoi($1), b=atoi($3); int c=a-b;printf($$, "%d", c);}
                      else if(isFloat($3)) {float a=atof($1), b=atof($3); float c=a-b;printf($$, "%f", c);}
                      else
                      {printf("ERROR! Line %d, expected integer or float value.\n", yylineno); flagError = 1;
                                exit(0);}} 
    
    | EXP MULTIPLY EXP {if(isInt($3))  {int a=atoi($1), b=atoi($3); int c=a*b;printf($$, "%d", c);}
                      else if(isFloat($3)) {float a=atof($1), b=atof($3); float c=a*b;printf($$, "%f", c);}
                      else
                      {printf("ERROR! Line %d, expected integer or float value.\n", yylineno); flagError = 1;
                                exit(0);}} 
    
    | EXP DIVIDE EXP {if(isInt($3))  {int a=atoi($1), b=atoi($3); int c=a/b;printf($$, "%d", c);}
                      else if(isFloat($3)) {float a=atof($1), b=atof($3); float c=a/b;printf($$, "%f", c);}
                      else
                      {printf("ERROR! Line %d, expected integer or float value.\n", yylineno); flagError = 1;
                                exit(0);}} 

%% */

void yyerror (char *msg)
{
    fprintf(stderr,"%s\n",msg);
    exit(1);
}

int main()
{
    yyparse(); //parsatorul
    return 0;
}