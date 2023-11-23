%{
#include <stdio.h>

#define SUSTANTIVO_DERIVADO   1
#define SUSTANTIVO_COMPUESTO  2
#define SUSTANTIVO_SIMPLE     3
#define VERBO_DERIVADO        4
#define VERBO_CONJUGADO       5
#define VERBO_SIMPLE          6
#define ADJETIVO_DERIVADO     7
#define ADJETIVO_SIMPLE       8
#define ADVERBIO_DERIVADO     9
#define ADVERBIO_SIMPLE       10
#define PREPOSICION           11
#define CONJUNCION            12
#define DETERMINANTE          13
#define INTERJECCION          14
#define COMA                  15
#define PUNTO                 16
#define PUNTO_Y_COMA          17
#define INTERROGACION_ABRIR   18
#define INTERROGACION_CERRAR  19
#define EXCLAMACION_ABRIR     20
#define EXCLAMACION_CERRAR    21
#define PRONOMBRE 22
#define VERBO_SER 23
#define VERBO_ESTAR 24
#define VERBO_PARECER 25
#define VERBO_IMPERATIVO 26
#define VERBO_PARTICIPIO 27
#define VERBO_IMPERSONAL 28
#define INTERROGATIVO 29
#define EXCLAMATIVO 30
#define DESIDERATIVO 31
#define DUBITATIVO 32
#define POR 33
%}

%option noyywrap

ignora	" "|\t|\n
Prefijo      "in"|"des"|"re"|"sub"|"pre"|"anti"|"auto"|"bi"|"co"|"contra"|"ex"|"extra"|"hiper"|"inter"|"macro"|"micro"|"mono"|"multi"|"neo"|"pos"
Interfijo    "ito"|"illo"|"azo"|"ucho"|"ecito"|"cito"|"ete"|"ico"|"uelo"|"acho"|"ote"|"ejo"|"ijo"|"oso"|"in"|"on"|"ar"|"or"
SufijoNom    "cion"|"sion"|"idad"|"anza"|"ez"|"mento"|"aje"|"amiento"|"imiento"|"atura"|"encia"|"isimo"|"ero"|"ista"|"al"|"ario"
SufijoAdj    "able"|"ible"|"oso"|"osa"|"al"|"ente"|"ico"|"ista"|"ivo"|"iva"|"ezno"|"erno"|"esco"|"izo"|"ante"|"ble"|"dor"
SufijoAdv    "mente"|"amente"|"emente"|"isimamente"
SufijoVerb   "ar"|"er"|"ir"|"ear"|"izar"|"ificar"|"ecer"
TerminacionVerb "o"|"as"|"a"|"amos"|"ais"|"an"|"ia"|"ias"|"iamos"|"iais"|"ian"|"e"|"aste"|"o"|"amos"|"asteis"|"aron"|"ere"|"eras"|"era"
RaizNom      "amor"|"luz"|"mar"|"tiempo"|"pais"|"sol"|"viento"|"flor"|"color"|"valor"|"dolor"|"honor"|"temor"|"humor"|"calor"|"sabor"|"olor"|"error"|"labor"|"vapor"
RaizVerb     "es"|"am"|"lu"|"naveg"|"tiemp"|"pais"|"sol"|"vent"|"flor"|"colore"|"valor"|"dolor"|"honor"|"tem"|"hum"|"cal"|"sab"|"ol"|"err"|"lab"|"vap"
RaizAdj      "amoros"|"lumin"|"marin"|"temporal"|"pacific"|"solead"|"ventos"|"floral"|"colorid"|"valios"|"doloros"|"honorable"|"temeros"|"humoristic"|"caluros"|"sabros"|"oloros"|"erratic"|"laborios"|"vaporos"
RaizAdv      "amoros"|"lumin"|"marin"|"temporal"|"pacific"|"solead"|"ventos"|"floral"|"colorid"|"valios"|"doloros"|"honorable"|"temeros"|"humoristic"|"caluros"|"sabros"|"oloros"|"erratic"|"laborios"|"vaporos"
Por          "por"
Prep         "a"|"ante"|"bajo"|"con"|"contra"|"de"|"desde"|"en"|"entre"|"hacia"|"hasta"|"para"|"segun"|"sin"|"sobre"|"tras"|"durante"|"mediante"|"excepto"
Conj         "y"|"o"|"pero"|"porque"|"aunque"|"ni"|"sino"|"asi que"|"luego"|"mientras"|"cuando"|"antes que"|"despues que"|"tan pronto como"|"hasta que"|"a menos que"|"siempre que"|"en caso de que"|"donde"
Det          "el"|"la"|"los"|"las"|"un"|"una"|"unos"|"unas"|"mi"|"tu"|"su"|"nuestro"|"vuestro"|"este"|"ese"|"aquel"|"mucho"|"poco"|"cada"|"algun"
Interj       "hola"|"ay"|"eh"|"oh"|"vaya"|"caramba"|"uf"|"ups"|"guau"|"bah"|"zaz"|"bingo"|"ole"|"bravo"|"anda"|"cielos"|"caray"|"huy"|"puf"|"orale"
Pron          "yo"|"tú"|"él"
VerbSer       "soy"|"eres"|"es"
VerbEstar      "estoy"|"estas"|"está"
VerbParecer     "parezco"|"pareces"|"parece"
VerbImpe         "haz"
VerbParti       "jugado"
VerbImper         "juega"
Interrogativo       "qué"|"cual"
Exclamativa         "cuanto"
Desider             "Deseo"
Dubita              "Creo"


%%
{ignora}*			{;}
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
{Interj}                                   { return INTERJECCION; }
{Pron}                                      { return PRONOMBRE; }
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


","                                        { return COMA; }
"."                                        { return PUNTO; }
";"                                        { return PUNTO_Y_COMA; }
"¿"                                        { return INTERROGACION_ABRIR; }
"?"                                        { return INTERROGACION_CERRAR; }
"¡"                                        { return EXCLAMACION_ABRIR; }
"!"                                        { return EXCLAMACION_CERRAR; }

%%

int main()
{
  int token;
  char NomArch[30];
  printf("Ingrese nombre de archivo: ");
  gets(NomArch);
  if ((yyin = fopen(NomArch, "rt")) == NULL)  /*yyin:variable que apunta al archivo fuente */
      printf("\nNo se puede abrir el archivo: %s\n", NomArch);
  else
      while((token=yylex())>0)
        printf("TOKEN = %d LEXEMA = %s \n",token,yytext);
  fclose(yyin);
  return 0;
}