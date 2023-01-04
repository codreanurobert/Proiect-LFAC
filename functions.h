#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <ctype.h>

void printList()
{
    
}
int isInt(char value[250])
{
    for (int i = 0; i < strlen(value); i++)
        if (!isdigit(value[i]) && value[i] != '-' && value[i] != '+')
            return 0;
    return 1;
}
int isFloat(char value[250])
{
    for (int i = 0; i < strlen(value); i++)
        if (!isdigit(value[i]) && value[i] != '.')
            return 0;
    return 1;
}
