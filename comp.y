%{ //header files
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "functions.h"

char TYPE[50];
int flagError=0;
int numOfIdentifiers=0;
struct identifierStructure // ex: int a; -> identifiers[0].value=a && identifiers[0].data_type=int;
{
    char* data_type;
    char* value;
}identifiers[20];

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
    char* dataType;
    char* stringValue;
    bool boolValue;
}

%start s
%token <intValue> INTEGER
%token <floatValue> FLOAT
%token <stringValue> STRING
%token <charValue> CHAR
%token <boolValue> BOOL
%token <stringValue> IDENTIFICATOR

%type <stringValue> DECLARATION
%type <stringValue> EXPRESSION

%left OR
%left AND 
%left LESS_THAN LESS_EQ_THAN GREATER_THAN GREATER_EQ_THAN EQUAL NOT_EQUAL
%left PLUS MINUS
%left MULTIPLY DIVIDE MODULO
%left SQ_BRACKETS_LEFT SQ_BRACKETS_RIGHT
%left LEFT_PARAN RIGHT_PARAN
%right ASIGN


// the order does matter (priority)

%% //rules

s : global_variables functions user_defined_data_types entry_point

global_variables : data_type variable ";"

data_type : 

variable : 

VALUE : INTEGER
      | FLOAT
      | STRING  
      | CHAR    
      | BOOL
      ;

DECLARATION : EXPRESSION SEMICOLON
            | FUNCTION SEMICOLON
            | 

EXP : EXP PLUS EXP {if(isInt($3))  {int a=atoi($1), b=atoi($3); int c=a+b;printf($$, "%d", c);}
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

%%

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