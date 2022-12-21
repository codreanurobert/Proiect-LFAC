%{ 
#include <stdlib.h>
#include "y.tab.h"
#include <string.h>
%}

%option noyywrap /*The macro/function yywrap() is called when a lex scanner reaches the end-of-file. */
%option yylineno

%% //acceptable tokens

"int"|"float"|"char"|"string"|"bool"{yylval.strval=strdup(yytext);return TYPE;}
"vector" {return ARRAY;} 
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
"true"|"false"|"TRUE"|"FALSE" {return BOOL_VALUE;}
//"-"|"+"|"*"|"/"|"%" {return ARTHM_OPERATOR;}
":=" {return ASIGN;}
":" {return COLON;}
";" {return SEMICOLON;}
"(" {return PARANT_LEFT;}
")" {return PARANT_RIGHT;}
"[" {return SQ_BRACKETS_LEFT;}
"]" {return SQ_BRACKETS_RIGHT;}

"define" {return DEFINE;}
"while" {return WHILE;}
"if" {return IF;}
"else" {return ELSE;}
"for" {return FOR;}
"function" {return FUNCTION;}

"begin" {return BEGIN;}
"end" {return END;}

^[-+]?[0-9]* {yylval.intValue = atoi(yytext); return INTEGER; }
^[-+]?[0-9]*[.][0-9]+$ {yylval.floatValue = atof(yytext);return FLOAT;}
[\'][a-zA-Z][\'] {yylval.charValue= strdup(yytext); return CHAR;}
\".*\" {yylval.stringValue=strdup(yytext); return STRING;}
[a-zA-Z][_a-zA-Z0-9]*   {yylval.stringValue=strdup(yytext); return IDENTIFICATOR}

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