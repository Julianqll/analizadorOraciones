%{
/* Bison declarations */
#include <stdbool.h>
bool puntoEncontrado = false;
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
       };

Oracion : Enunciativa
       { 
       printf("Regla utilizada: Oracion -> Enunciativa ;\n"); 
       }
        | Interrogativa
        | Exclamativa
        | Exhortativa
        | Desiderativa
        | Dubitativa ;

Enunciativa : Simple 
       { 
       printf("Regla utilizada: Enunciativa -> Simple ;\n"); 
       }
            | Compuesta
            | Sujeto VerbCopulativo Atributo
       { 
       printf("Regla utilizada: Enunciativa -> Sujeto VerbCopulativo Atributo ;\n"); 
       }
            | Sujeto Verbo Complemento
       { 
       printf("Regla utilizada: Enunciativa -> Sujeto Verbo Complemento ;\n"); 
       }
            | VerbImpersonal Complemento
            | Pasiva ;

Compuesta : Simple CONJUNCION Simple { printf("Regla utilizada: Compuesta -> Simple CONJUNCION Simple ;\n"); };

Interrogativa : INTERROGACION_ABRIR Oracion INTERROGACION_CERRAR
              | INTERROGATIVO Verbo Sujeto INTERROGACION_CERRAR ;

Exclamativa : EXCLAMACION_ABRIR Oracion EXCLAMACION_CERRAR { printf("Regla utilizada: Exclamativa -> EXCLAMACION_ABRIR Oracion EXCLAMACION_CERRAR ;\n"); };

Exhortativa : VerboImperativo Complemento { printf("Regla utilizada: Exhortativa -> VerboImperativo Complemento ;\n"); };

Desiderativa : DESIDERATIVO Complemento { printf("Regla utilizada: Desiderativa -> DESIDERATIVO Complemento ;\n"); };

Dubitativa : DUBITATIVO Oracion { printf("Regla utilizada: Dubitativa -> DUBITATIVO Oracion ;\n"); };

Pasiva : Sujeto VERBO_SER Participio ComplementoPasivo { printf("Regla utilizada: Pasiva -> Sujeto VERBO_SER Participio ComplementoPasivo ;\n"); };

Simple : Sujeto Verbo { printf("Regla utilizada: Simple -> Sujeto Verbo ;\n"); };

Sujeto : DETERMINANTE Sustantivo 
       | Sustantivo 
       | PRONOMBRE 
       { 
       printf("Regla utilizada: Sujeto -> PRONOMBRE ;\n"); 
       };

Sustantivo : SUSTANTIVO_SIMPLE 
           | SUSTANTIVO_COMPUESTO 
           | SUSTANTIVO_DERIVADO ;

VerbCopulativo : VERBO_SER 
       { 
       printf("Regla utilizada: VerbCopulativo -> VERBO_SER ;\n"); 
       }
               | VERBO_ESTAR 
               | VERBO_PARECER ;

VerbImpersonal : VERBO_IMPERSONAL { printf("Regla utilizada: VerbImpersonal -> VERBO_IMPERSONAL ;\n"); };

Verbo : VERBO_SIMPLE 
      | VERBO_CONJUGADO 
      | VERBO_DERIVADO ;

Participio : VERBO_PARTICIPIO { printf("Regla utilizada: Participio -> VERBO_PARTICIPIO ;\n"); };

VerboImperativo : VERBO_IMPERATIVO { printf("Regla utilizada: VerboImperativo -> VERBO_IMPERATIVO ;\n"); };

Atributo : Sustantivo 
         | Adjetivo        { 
       printf("Regla utilizada: Atributo -> Adjetivo ;\n"); 
       };

ComplementoPasivo : POR Sujeto { printf("Regla utilizada: ComplementoPasivo -> POR Sujeto ;\n"); };

Complemento : Sustantivo
            | Adjetivo 
            | Adverbio
            | PREPOSICION Complemento ;

Adjetivo : ADJETIVO_SIMPLE 
{ 
       printf("Regla utilizada: Adjetivo -> ADJETIVO_SIMPLE ;\n"); 
       }
       | ADJETIVO_DERIVADO ; 

Adverbio : ADVERBIO_SIMPLE
       | ADVERBIO_DERIVADO ;

Punto : PUNTO { 
       puntoEncontrado = true; printf("Regla utilizada: Punto -> PUNTO;\n"); };
