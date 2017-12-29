#include <stdio.h>
main()
{
char string[30];
while(1){
printf("Eingabe:");
scanf("%[+-01-9]",string);
while(getchar()!=10);
printf("...%s..%d..\n",string,atoi(string));
string[0]='\0';
}
}
