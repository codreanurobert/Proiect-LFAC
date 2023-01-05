%{ 
#include <stdlib.h>
#include "y.tab.h"
#include <string.h>
%}

%option noyywrap /*The macro/function yywrap() is called when a lex scanner reaches the end-of-file. */
%option yylineno

%% //acceptable tokens

"int"{yylval.strval=strdup(yytext);return INTEGER;}
"float"{yylval.strval=strdup(yytext);return FLOAT;}
"char"{yylval.strval=strdup(yytext);return CHAR;}
"string"{yylval.strval=strdup(yytext);return STRING;}
"bool"{yylval.strval=strdup(yytext);return BOOL;}

"array" {return ARRAY;} 
"struct" {return STRUCTT;}

"+" {return PLUS;}
"-" {return MINUS;}
"*" {return MULTIPLY;}
"/" {return DIVIDE;}
"%" {return MODULO;}

"<" {return LESS_THAN;}
"<=" {return LESS_EQ_THAN;}
">" {return GREATER_THAN;}
">=" {return GREATER_EQ_THAN;}
"==" {return EQUAL;};
"!=" {return NOT_EQUAL;}
"&&" {return AND;}
"||" {return OR;}
"!" {return NOT;}
"++" {return INCREMENTATION;}
"--" {return DECREMENTATION;}
"true"|"false"|"TRUE"|"FALSE" {return BOOL_VALUE;}
//"-"|"+"|"*"|"/"|"%" {return ARTHM_OPERATOR;}
":=" {return ASIGN;}
":" {return COLON;}
";" {return SEMICOLON;}


"begin" {return BEGIN_P;}
"end" {return END_P;}
"main"{return MAIN_F;}
"define" {return DEFINE;}
"while" {return WHILE;}
"if" {return IF;}
"else" {return ELSE;}
"for" {return FOR;}
"function" {return FUNCTION;}
"print" {return PRINT;}
"begin" {return BEGIN;}
"end" {return END;}

^[-+]?[0-9]* {yylval.intValue = atoi(yytext); return INTEGER_VAL; }
^[-+]?[0-9]*[.][0-9]+$ {yylval.floatValue = atof(yytext);return FLOAT_VAL;}
[\'][a-zA-Z][\'] {yylval.charValue= strdup(yytext); return CHAR_VAL;}
\".*\" {yylval.stringValue=strdup(yytext); return STRING_VAL;}
[a-zA-Z][_a-zA-Z0-9]*   {yylval.stringValue=strdup(yytext); return IDENTIFICATOR;}
[ \t] ;
\n {yylineno++;} //backslash
. {return yytext[0];}

%% //C defined functions
int yyywrap(void) // end of file reached
{
    return 1;
}
void yyerror(char *s)
{
    fprintf(stderr, "\n Error ON LINE %d : \n %s \n",yylineno,s);
    exit(0);
}