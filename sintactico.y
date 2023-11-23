%{
/* Código C para la inclusión en la parte superior del archivo generado */
#include <stdio.h>
#include <stdlib.h>

/* Definiciones de tokens, posiblemente importadas desde un archivo de encabezado */
%}

%token SUSTANTIVO ADJETIVO VERBO PRONOMBRE PREPOSICION INTERROGACION EXCLAMACION PUNTO
%token COMA PUNTO_Y_COMA DOS_PUNTOS PARENTESIS_ABRIR PARENTESIS_CERRAR
%token CORCHETE_ABRIR CORCHETE_CERRAR LLAVE_ABRIR LLAVE_CERRAR GUION GUION_DOBLE PUNTOS_SUSPENSIVOS
%token COMILLAS APOSTROFE CONJ COPULA VERBOACTIVO VERBOSER PARTICIPIOPASADO
%token OJALA TALVEZ PUEDA QUISIERA DESEARIA

%%

/* Aquí van las reglas de producción de la gramática */

O:
    OSimple PUNTO
  | OCompuesta
  ;

OSimple:
    Enunciativa
  | Interrogativa
  | Exclamativa
  | Imperativa
  | Exhortativa
  | Desiderativa
  | Optativa
  | Dubitativa
  ;

OCompuesta:
    O CONJ O
  | O CONJ O OCompuesta
  ;

Enunciativa:
    S P
  ;

Interrogativa:
    INTERROGACION_ABRIR S P INTERROGACION_CERRAR
  ;

Exclamativa:
    EXCLAMACION_ABRIR S P EXCLAMACION_CERRAR
  ;

Imperativa:
    VERBO Objeto PUNTO
  ;

Exhortativa:
    VERBO Objeto PUNTO
  ;

Desiderativa:
    OJALA S P PUNTO
  ;

Optativa:
    S P Puntuacion PalabraClave PUNTO
  ;

Dubitativa:
    TALVEZ S P PUNTO
  ;

S:
    Nominal
  | /* empty */
  ;

Nominal:
    PalabraSujeto
  | PalabraSujeto Conector PalabraSujeto
  ;

P:
    Copulativas
  | Predicativas
  ;

Copulativas:
    COPULA ADJETIVO
  | COPULA SUSTANTIVO
  | COPULA S
  ;

Predicativas:
    V C*
  | VERBOSER PARTICIPIOPASADO POR S
  ;

V:
    VERBOACTIVO C*
  | VERBOSER PARTICIPIOPASADO POR S
  ;

C:
    CD
  | CI
  | CC
  ;

CD:
    SUSTANTIVO
  | PRONOMBRE
  ;

CI:
    PREPOSICION SUSTANTIVO
  | PREPOSICION PRONOMBRE
  ;

CC:
    PREPOSICION SUSTANTIVO
  | PREPOSICION ADJETIVO
  | PREPOSICION ADVERBIO
  ;

ConectorCompuesto:
    CONJ
  ;

Conector:
    CONJ
  ;

PalabraClave:
    PUEDA
  | QUISIERA
  | DESEARIA
  ;

PalabraSujeto:
    SUSTANTIVO
  | PRONOMBRE
  ;

PalabraPredicado:
    VERBO
  | ADJETIVO VERBO
  ;

Objeto:
    SUSTANTIVO
  | PRONOMBRE
  ;

Puntuacion:
    COMA
  | PUNTO_Y_COMA
  | INTERROGACION_ABRIR
  | INTERROGACION_CERRAR
  | EXCLAMACION_ABRIR
  | EXCLAMACION_CERRAR
  ;

%%

/* Código C adicional para el archivo generado, como subrutinas auxiliares */

int main(int argc, char **argv) {
    // Inicialización y llamada al analizador sintáctico
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error de análisis: %s\\n", s);
}