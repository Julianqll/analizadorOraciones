%{
/* Bison declarations */

#include <stdbool.h>
bool puntoEncontrado = false;
bool adverbioDerivadoEncontrado = false;
bool adverbioSimpleEncontrado = false;
bool adjetivoDerivadoEncontrado = false;
bool adjetivoSimpleEncontrado = false;
bool preposicionEncontrado = false;
bool porEncontrado = false;
bool verboImperativoEncontrado = false;
bool verboParticipioEncontrado = false;  
bool verboDerivadoEncontrado = false;  
bool verboConjugadoEncontrado = false;  
bool verboSimpleEncontrado = false;  
bool verboImpersonalEncontrado = false;  
bool verboSerEncontrado = false;  
bool verboEstarEncontrado = false;  
bool verboParecerEncontrado = false;  
bool sustantivoSimpleEncontrado = false;
bool sustantivoCompuestoEncontrado = false;
bool sustantivoDerivadoEncontrado = false;  
bool determinanteEncontrado = false;
bool pronombreEncontrado = false;
bool desiderativoEncontrado = false;      
bool dubitativoEncontrado = false;
bool interrogacionAbrirEncontrado = false;
bool interrogativoEncontrado = false;
bool interrogacionCerrarEncontrado = false;
bool exclamacionAbrirEncontrado = false;
bool exclamacionCerrarEncontrado = false;
bool conjuncionEncontrado = false;
%}
%define "parse.error" "verbose"

%token DETERMINANTE SUSTANTIVO_SIMPLE SUSTANTIVO_COMPUESTO SUSTANTIVO_DERIVADO
%token PRONOMBRE VERBO_SER VERBO_ESTAR VERBO_PARECER VERBO_SIMPLE VERBO_CONJUGADO VERBO_IMPERATIVO
%token VERBO_DERIVADO VERBO_PARTICIPIO VERBO_IMPERSONAL ADJETIVO_SIMPLE ADJETIVO_DERIVADO ADVERBIO_SIMPLE ADVERBIO_DERIVADO PREPOSICION
%token CONJUNCION INTERROGACION_ABRIR INTERROGACION_CERRAR EXCLAMACION_ABRIR 
%token EXCLAMACION_CERRAR INTERROGATIVO EXCLAMATIVO DESIDERATIVO DUBITATIVO PUNTO POR

%start S

%%

S : Oracion Punto { 
       printf("Regla utilizada: S -> Oracion Punto ;\n"); 
       }; | Oracion Punto S

Oracion : Enunciativa
       { 
       printf("Regla utilizada: Oracion -> Enunciativa ;\n"); 
       }
        | Interrogativa
       { 
       printf("Regla utilizada: Oracion -> Interrogativa ;\n"); 
       }
        | Exclamativa
       { 
       printf("Regla utilizada: Oracion -> Exclamativa ;\n"); 
       }
        | Exhortativa
       { 
       printf("Regla utilizada: Oracion -> Exhortativa ;\n"); 
       }
        | Desiderativa
       { 
       printf("Regla utilizada: Oracion -> Desiderativa ;\n"); 
       }
        | Dubitativa
       { 
       printf("Regla utilizada: Oracion -> Dubitativa ;\n"); 
       }
	;

Enunciativa : Simple 
       { 
       printf("Regla utilizada: Enunciativa -> Simple ;\n"); 
       }
            | Compuesta
       { 
       printf("Regla utilizada: Enunciativa -> Compuesta ;\n"); 
       }
            | Sujeto VerbCopulativo Atributo
       { 
       printf("Regla utilizada: Enunciativa -> Sujeto VerbCopulativo Atributo ;\n"); 
       }
            | Sujeto Verbo Complemento
       { 
       printf("Regla utilizada: Enunciativa -> Sujeto Verbo Complemento ;\n"); 
       }
            | VerbImpersonal Complemento
       { 
       printf("Regla utilizada: Enunciativa -> VerbImpersonal Complemento ;\n"); 
       }
            | Pasiva 
       { 
       printf("Regla utilizada: Enunciativa -> Pasiva ;\n"); 
       }
	    ;

Compuesta : Simple CONJUNCION Simple 
       { 
              conjuncionEncontrado = true;
              printf("Regla utilizada: Compuesta -> Simple CONJUNCION Simple ;\n");
       };

Interrogativa : INTERROGACION_ABRIR Oracion INTERROGACION_CERRAR 
       { 
              interrogacionAbrirEncontrado = true;
              interrogacionCerrarEncontrado = true;
              printf("Regla utilizada: Interrogativa -> INTERROGACION_ABRIR Oracion INTERROGACION_CERRAR ;\n"); 
       }
              | INTERROGACION_ABRIR INTERROGATIVO Verbo Sujeto INTERROGACION_CERRAR 
       {
              interrogacionAbrirEncontrado = true;
              interrogativoEncontrado = true;
              interrogacionCerrarEncontrado = true;
              printf("Regla utilizada: Interrogativa -> INTERROGATIVO Verbo Sujeto INTERROGACION_CERRAR ;\n"); 
       };

Exclamativa : EXCLAMACION_ABRIR Oracion EXCLAMACION_CERRAR 
       { 
              exclamacionAbrirEncontrado = true;
              exclamacionCerrarEncontrado = true;
              printf("Regla utilizada: Exclamativa -> EXCLAMACION_ABRIR Oracion EXCLAMACION_CERRAR ;\n");
       };

Exhortativa : VerboImperativo Complemento 
       { 
              printf("Regla utilizada: Exhortativa -> VerboImperativo Complemento ;\n"); 
       };

Desiderativa : DESIDERATIVO Complemento 
       { 
              desiderativoEncontrado = true;       
              printf("Regla utilizada: Desiderativa -> DESIDERATIVO Complemento ;\n"); 
       };

Dubitativa : DUBITATIVO Oracion 
       { 
              dubitativoEncontrado = true;
              printf("Regla utilizada: Dubitativa -> DUBITATIVO Oracion ;\n"); 
       };

Pasiva : Sujeto VERBO_SER Participio ComplementoPasivo 
       { 
              verboSerEncontrado = true;
              printf("Regla utilizada: Pasiva -> Sujeto VERBO_SER Participio ComplementoPasivo ;\n");
       };

Simple : Sujeto Verbo 
       {
               printf("Regla utilizada: Simple -> Sujeto Verbo ;\n"); 
       };

Sujeto : DETERMINANTE Sustantivo
       { 
              determinanteEncontrado = true;
              printf("Regla utilizada: Sujeto -> DETERMINANTE Sustantivo ;\n"); 
       } 
       | Sustantivo
       { 
              printf("Regla utilizada: Sujeto -> Sustantivo;\n"); 
       } 
       | PRONOMBRE 
       { 
              pronombreEncontrado = true;
              printf("Regla utilizada: Sujeto -> PRONOMBRE ;\n"); 
       };

Sustantivo : SUSTANTIVO_SIMPLE 
       {
              sustantivoSimpleEncontrado = true;
              printf("Regla utilizada: Sustantivo -> SUSTANTIVO_SIMPLE ;\n"); 
       }
       | SUSTANTIVO_COMPUESTO 
       { 
              sustantivoCompuestoEncontrado = true;
              printf("Regla utilizada: Sustantivo -> SUSTANTIVO_COMPUESTO ;\n");
       }
       | SUSTANTIVO_DERIVADO 
       {
              sustantivoDerivadoEncontrado = true;  
              printf("Regla utilizada: Sustantivo -> SUSTANTIVO_DERIVADO ;\n"); 
       };

VerbCopulativo : VERBO_SER 
       { 
              verboSerEncontrado = true;  
              printf("Regla utilizada: VerbCopulativo -> VERBO_SER ;\n"); 
       }
       | VERBO_ESTAR
       { 
              verboEstarEncontrado = true;  
              printf("Regla utilizada: VerbCopulativo -> VERBO_ESTAR ;\n"); 
       } 
       | VERBO_PARECER 
       { 
              verboParecerEncontrado = true;  
              printf("Regla utilizada: VerbCopulativo -> VERBO_PARECER ;\n"); 
       };

VerbImpersonal : VERBO_IMPERSONAL 
       { 
              verboImpersonalEncontrado = true;  
              printf("Regla utilizada: VerbImpersonal -> VERBO_IMPERSONAL ;\n"); 
       };

Verbo : VERBO_SIMPLE 
       { 
              verboSimpleEncontrado = true;  
              printf("Regla utilizada: Verbo -> VERBO_SIMPLE ;\n"); 
       }
      | VERBO_CONJUGADO 
      { 
              verboConjugadoEncontrado = true;  
              printf("Regla utilizada: Verbo -> VERBO_CONJUGADO ;\n"); 
       }
      | VERBO_DERIVADO 
      {       
              verboDerivadoEncontrado = true;  
              printf("Regla utilizada: Verbo -> VERBO_DERIVADO ;\n"); 
       };

Participio : VERBO_PARTICIPIO 
       { 
              verboParticipioEncontrado = true;  
              printf("Regla utilizada: Participio -> VERBO_PARTICIPIO ;\n"); 
       };

VerboImperativo : VERBO_IMPERATIVO 
       {
              verboImperativoEncontrado = true;
              printf("Regla utilizada: VerboImperativo -> VERBO_IMPERATIVO ;\n");
       };

Atributo : Sustantivo 
       {      
              printf("Regla utilizada: Atributo -> Sustantivo;\n"); 
       }
         | Adjetivo        
       { 
              printf("Regla utilizada: Atributo -> Adjetivo ;\n"); 
       };

ComplementoPasivo : POR Sujeto 
       {               
              porEncontrado = true;
              printf("Regla utilizada: ComplementoPasivo -> POR Sujeto ;\n"); 
       };

Complemento : Sustantivo 
       { 
              printf("Regla utilizada: Complemento -> Sustantivo ;\n"); 
       }
            | Adjetivo 
       {      
              printf("Regla utilizada: Complemento -> Adjetivo ;\n"); 
       }
            | Adverbio 
       { 
              printf("Regla utilizada: Complemento -> Adverbio ;\n"); 
       }
            | PREPOSICION Complemento 
       { 
              preposicionEncontrado = true;
              printf("Regla utilizada: Verbo -> PREPOSICION Complemento ;\n"); 
       };

Adjetivo : ADJETIVO_SIMPLE 
       { 
              adjetivoSimpleEncontrado = true;
              printf("Regla utilizada: Adjetivo -> ADJETIVO_SIMPLE ;\n"); 
       }
       | ADJETIVO_DERIVADO 
       { 
              adjetivoDerivadoEncontrado = true;
              printf("Regla utilizada: Adjetivo -> ADJETIVO_DERIVADO ;\n"); 
       };
Adverbio : ADVERBIO_SIMPLE
       { 
              adverbioSimpleEncontrado = true;
              printf("Regla utilizada: Adverbio -> ADVERBIO_SIMPLE ;\n"); 
       }
       | ADVERBIO_DERIVADO 
       {
              adverbioDerivadoEncontrado = true;
              printf("Regla utilizada: Adverbio -> ADVERBIO_DERIVADO  ;\n"); 
       };

Punto : PUNTO { puntoEncontrado = true; printf("Regla utilizada: Punto -> PUNTO;\n"); };
