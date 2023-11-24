%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.h"
%}

%option noyywrap

ignora	" "|\t|\n
Prefijo      "in"|"des"|"re"|"sub"|"pre"|"anti"|"auto"|"bi"|"co"|"contra"|"ex"|"extra"|"hiper"|"inter"|"macro"|"micro"|"mono"|"multi"|"neo"|"pos"|"en"
Interfijo    "ito"|"illo"|"azo"|"ucho"|"ecito"|"cito"|"ete"|"ico"|"uelo"|"acho"|"ote"|"ejo"|"ijo"|"oso"|"osa"|"in"|"on"|"ar"|"or"
SufijoNom    "cion"|"sion"|"idad"|"anza"|"ez"|"mento"|"aje"|"amiento"|"imiento"|"atura"|"encia"|"isimo"|"ero"|"ista"|"al"|"ario"
SufijoAdj    "able"|"ible"|"oso"|"osa"|"al"|"ente"|"ico"|"ista"|"ivo"|"iva"|"ezno"|"erno"|"esco"|"izo"|"ante"|"ble"|"dor"|"ador"
SufijoAdv    "mente"|"amente"|"emente"|"isimamente"|"isimo"|"isima"
SufijoVerb   "ar"|"er"|"ir"|"ear"|"izar"|"ificar"|"ecer"|"iguar"
TerminacionVerb "o"|"as"|"a"|"ais"|"an"|"ia"|"ias"|"iamos"|"iais"|"ian"|"e"|"aste"|"o"|"amos"|"asteis"|"aron"|"ere"|"eras"|"era"
RaizNom      "amor"|"luz"|"mar"|"tiempo"|"pais"|"sol"|"viento"|"flor"|"color"|"valor"|"dolor"|"honor"|"temor"|"humor"|"calor"|"sabor"|"olor"|"error"|"labor"|"vapor"
RaizVerb     "es"|"am"|"lu"|"naveg"|"tiemp"|"pais"|"sol"|"vent"|"flor"|"colore"|"valor"|"dolor"|"honor"|"tem"|"hum"|"cal"|"sab"|"ol"|"err"|"lab"|"vap"|"haces"
RaizAdj      "amoros"|"lumin"|"marin"|"temporal"|"pacific"|"solead"|"ventos"|"floral"|"colorid"|"valios"|"doloros"|"honorable"|"temeros"|"humoristic"|"caluros"|"sabros"|"oloros"|"erratic"|"laborios"|"vaporos"|"herm"|"am"|"vig"|"vali"|"montañ|"camp"|"ciud"|"cost"|"volcan"|"arrecif"|"encant"|"dolor"|"trabaj"|"fund"|"explor"|"luch"|contempl"|"cread"|"decor"|"escuch"|"habl"|"jug"|"narr"|"observ"
RaizAdv      "amoros"|"lumin"|"marin"|"temporal"|"pacific"|"solead"|"ventos"|"floral"|"colorid"|"valios"|"doloros"|"honorable"|"temeros"|"humoristic"|"caluros"|"sabros"|"oloros"|"erratic"|"laborios"|"vaporos"
Por          "por"
Prep         "a"|"ante"|"bajo"|"con"|"contra"|"de"|"desde"|"en"|"entre"|"hacia"|"hasta"|"para"|"segun"|"sin"|"sobre"|"tras"|"durante"|"mediante"|"excepto"
Conj         "y"|"o"|"pero"|"porque"|"aunque"|"ni"|"sino"|"asi que"|"luego"|"mientras"|"cuando"|"antes que"|"despues que"|"tan pronto como"|"hasta que"|"a menos que"|"siempre que"|"en caso de que"|"donde"
Det          "el"|"la"|"los"|"las"|"un"|"una"|"unos"|"unas"|"mi"|"tu"|"su"|"nuestro"|"vuestro"|"este"|"ese"|"aquel"|"mucho"|"poco"|"cada"|"algun"
Interj       "hola"|"ay"|"eh"|"oh"|"vaya"|"caramba"|"uf"|"ups"|"guau"|"bah"|"zaz"|"bingo"|"ole"|"bravo"|"anda"|"cielos"|"caray"|"huy"|"puf"|"orale"
Pron          "yo"|"tú"|"él"|"ella"|"usted"
VerbSer       "soy"|"eres"|"es"|"sido"|"somos"|"era"|"eramos"|"seria"
VerbEstar      "estoy"|"estas"|"está"
VerbParecer     "parezco"|"pareces"|"parece"
VerbImpe         "haz"
VerbParti       "jugado"|"comido"|"vivido"|"bebido"|"escrito"|"dicho"|"abierto"|"vuelto"|"resuelto"
VerbImper         "juega"|"come"|"escribe"|"hable"|"llueve"|"hace"|"haces" 
Interrogativo       "qué"|"cual"
Exclamativa         "cuanto"
Desider             "deseo"|"quiero"|"quisiera"|"anhelo"
Dubita              "creo"|"considero"|"pienso"|"imagino"

%%
{ignora}*    {;}
{Prefijo}{Interfijo}{RaizNom}  { return SUSTANTIVO_DERIVADO; }
{RaizNom}{Interfijo}{SufijoNom}  { return SUSTANTIVO_DERIVADO; }
{Prefijo}{RaizNom}{SufijoNom}  { return SUSTANTIVO_DERIVADO; }
{Prefijo}{Interfijo}{RaizNom}{SufijoNom}  { return SUSTANTIVO_DERIVADO; }
{RaizNom}{RaizNom}  { return SUSTANTIVO_COMPUESTO; }
{RaizNom}  { return SUSTANTIVO_SIMPLE; }
{Prefijo}{Interfijo}{RaizVerb}             { return VERBO_DERIVADO; }
{RaizVerb}{Interfijo}{SufijoVerb}          { return VERBO_DERIVADO; }
{RaizVerb}{TerminacionVerb}                { return VERBO_CONJUGADO; }
{RaizVerb}                                 { return VERBO_SIMPLE; }
{Prefijo}{Interfijo}{RaizAdj}              { return ADJETIVO_DERIVADO; }
{RaizAdj}{Interfijo}{SufijoAdj}            { return ADJETIVO_DERIVADO; }
{Prefijo}{RaizAdj}{SufijoAdj}              { return ADJETIVO_DERIVADO; }
{Prefijo}{Interfijo}{RaizAdj}{SufijoAdj}   { return ADJETIVO_DERIVADO; }
{RaizAdj}{Interfijo}                     { return ADJETIVO_SIMPLE; }
{RaizAdj}                                  { return ADJETIVO_SIMPLE; }
{RaizAdv}{Interfijo}{SufijoAdv}  { return ADVERBIO_DERIVADO; }
{RaizAdv}{SufijoAdv}  { return ADVERBIO_DERIVADO; }
{Prep}                                     { return PREPOSICION; }
{Conj}                                     { return CONJUNCION; }
{Det}                                      { return DETERMINANTE; }
{Pron}         { return PRONOMBRE; }
{VerbSer}       {return VERBO_SER; }
{VerbEstar}      {return VERBO_ESTAR; }
{VerbParecer}     {return VERBO_PARECER; }
{VerbImpe}         {return VERBO_IMPERATIVO; }
{VerbParti}       {return VERBO_PARTICIPIO; }
{VerbImper}        {return VERBO_IMPERSONAL; }
{Interrogativo}       {return INTERROGATIVO; }
{Exclamativa}         {return EXCLAMATIVO; }
{Desider}            {return DESIDERATIVO; }
{Dubita}            {return DUBITATIVO; }
{Por}               {return POR;}


"."                                        { return PUNTO; }
"¿"                                        { return INTERROGACION_ABRIR; }
"?"                                        { return INTERROGACION_CERRAR; }
"¡"                                        { return EXCLAMACION_ABRIR; }
"!"                                        { return EXCLAMACION_CERRAR; }

%%
extern puntoEncontrado;
void yyerror (const char *s) {
    if (!puntoEncontrado) {
        fprintf(stderr, "Error de sintaxis: Falta token PUNTO\n");
    }
    else {
        fprintf(stderr, "%s\n", s);
    }
}
int main()
{
  char NomArch[30];
  printf("Ingrese nombre de archivo: ");
  gets(NomArch);
  if ((yyin = fopen(NomArch, "rt")) == NULL)  /*yyin:variable que apunta al archivo fuente */
      printf("\nNo se puede abrir el archivo: %s\n", NomArch);
  else
      yyparse();
  fclose(yyin);
  return 0;
}