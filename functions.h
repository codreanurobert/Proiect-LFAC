#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <ctype.h>

int index_name=0,current_depth=1,nr_block_depth[100];
int var_id = 0, function_id = 0 ,j = 0, i = 0, k = 0, p = 0;

struct table_elements
{
    char symbol_type[100];
    char symbol_name[100];
    int block_depth;
    int block_num;
    int value;
}table[100];

struct functions
{
    char types[100][100];
    char name[100];
    int nr_parameters;
}function_name[100];

struct called_functions
{
    char types[100][100];
    char name[100];
    int nr_parameters;
}called_function_name[100];

struct table_elem_functions
{
    char signature[100]; //nu stim ce face
}table_name[100];

int cauta(char *name)
{
  int cauta_nr_bloc = nr_bloc_adancime[adancime_curenta - 1], cauta_adancime = adancime_curenta;
     for (i = indiceVar - 1; i >= 0; i--)
     {
         if (table[i].block_depth < cauta_adancime)
         {
             cauta_adancime = table[i].block_depth;
             cauta_nr_bloc = table[i].nr_bloc;
         }
          else if (table[i].block_depth == cauta_adancime && table[i].nr_bloc == cauta_nr_bloc &&
                   strcmp(table[i].nume_simbol, name) == 0)
               return i;
          
     }
     return -1;
}

int insereaza(char *tip, char *id, int valoare)
{
     if (cauta(id) != -1)
     {
          printf("  Eroare: variabila %s %s a fost deja declarata.\n", tip, id);
          return 0;
     }
     table[var_id].nr_bloc = nr_bloc_adancime[adancime_curenta - 1];
     table[var_id].block_depth = adancime_curenta;
     strcpy(table[var_id].tip_simbol, tip);
     strcpy(table[var_id].nume_simbol, id);
     table[var_id].valoare = valoare;
    var_id++;
     return 0;
}
    int getIntVal(char *nume)
    {
        for(int i = 0; i < nrVariabile; i++)
        {
            if(strcmp(variabile[i].nume, nume) == 0)
                return variabile[i].valoare;
        }
        char rasp[100] = "variabila ";
        strcat(rasp, nume);
        strcat(rasp, " nu exista.");
        yyerror(rasp);
        return 0;
    }
    int setIntVal(char *nume, int valoare)
    {
        for(int i = 0; i < nrVariabile; i++)
        {
            if(strcmp(variabile[i].nume, nume) == 0 && strcmp(variabile[i].tip, "int") == 0) {
                variabile[i].valoare = valoare;
                return 0;
            }
        }
        char rasp[100] = "variabila ";
        strcat(rasp, nume);
        strcat(rasp, " nu exista sau are alt tip.");
        yyerror(rasp);
        return 1;
    }