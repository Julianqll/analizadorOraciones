%{
/* Bison declarations */
%}

%token DETERMINANTE SUSTANTIVO_SIMPLE SUSTANTIVO_COMPUESTO SUSTANTIVO_DERIVADO
%token PRONOMBRE VERBO_SER VERBO_ESTAR VERBO_PARECER VERBO_SIMPLE VERBO_CONJUGADO VERBO_IMPERATIVO
%token VERBO_DERIVADO VERBO_PARTICIPIO VERBO_IMPERSONAL ADJETIVO_SIMPLE ADJETIVO_DERIVADO ADVERBIO_SIMPLE ADVERBIO_DERIVADO PREPOSICION
%token CONJUNCION INTERROGACION_ABRIR INTERROGACION_CERRAR EXCLAMACION_ABRIR 
%token EXCLAMACION_CERRAR INTERROGATIVO EXCLAMATIVO DESIDERATIVO DUBITATIVO PUNTO POR

%start S

%%

S : Oracion Punto ;

Oracion : Enunciativa
        | Interrogativa
        | Exclamativa
        | Exhortativa
        | Desiderativa
        | Dubitativa ;

Enunciativa : Simple 
            | Compuesta
            | Sujeto VerbCopulativo Atributo
            | Sujeto Verbo Complemento
            | VerbImpersonal Complemento
            | Pasiva ;

Compuesta : Simple CONJUNCION Simple ;

Interrogativa : INTERROGACION_ABRIR Oracion INTERROGACION_CERRAR
              | INTERROGATIVO Verbo Sujeto INTERROGACION_CERRAR ;

Exclamativa : EXCLAMACION_ABRIR Oracion EXCLAMACION_CERRAR ;

Exhortativa : VerboImperativo Complemento ;

Desiderativa : DESIDERATIVO Complemento ;

Dubitativa : DUBITATIVO Oracion ;

Pasiva : Sujeto VERBO_SER Participio ComplementoPasivo ;

Simple : Sujeto Verbo ;

Sujeto : DETERMINANTE Sustantivo 
       | Sustantivo 
       | PRONOMBRE ;

Sustantivo : SUSTANTIVO_SIMPLE 
           | SUSTANTIVO_COMPUESTO 
           | SUSTANTIVO_DERIVADO ;

VerbCopulativo : VERBO_SER 
               | VERBO_ESTAR 
               | VERBO_PARECER ;

VerbImpersonal : VERBO_IMPERSONAL ;

Verbo : VERBO_SIMPLE 
      | VERBO_CONJUGADO 
      | VERBO_DERIVADO ;

Participio : VERBO_PARTICIPIO ;

VerboImperativo : VERBO_IMPERATIVO ;

Atributo : Sustantivo 
         | Adjetivo ;

ComplementoPasivo : POR Sujeto ;

Complemento : Sustantivo
            | Adjetivo 
            | Adverbio
            | PREPOSICION Complemento ;

Adjetivo : ADJETIVO_SIMPLE 
       | ADJETIVO_DERIVADO ; 

Adverbio : ADVERBIO_SIMPLE
       | ADVERBIO_DERIVADO ;
Punto : PUNTO ;
