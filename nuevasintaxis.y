%{
int yystopparser=0;
%}

%token SUSTANTIVO_DERIVADO SUSTANTIVO_COMPUESTO SUSTANTIVO_SIMPLE
%token VERBO_DERIVADO VERBO_CONJUGADO VERBO_SIMPLE
%token ADJETIVO_DERIVADO ADJETIVO_SIMPLE
%token ADVERBIO_DERIVADO ADVERBIO_SIMPLE
%token PREPOSICION
%token CONJUNCION
%token DETERMINANTE
%token INTERJECCION
%token COMA
%token PUNTO
%token PUNTO_Y_COMA
%token INTERROGACION_ABRIR
%token INTERROGACION_CERRAR
%token EXCLAMACION_ABRIR
%token EXCLAMACION_CERRAR
%token OJALA TALVEZ PUEDA QUISIERA DESEARIA
%token COPULA
%start oracionentrada


%%
oracionentrada			:	oracion
				;
oracion				:	oracionsimple PUNTO
				|	oracioncompuesta
				;
oracionsimple			: 	enunciativa
				|	interrogativa
				|	exclamativa
				|	imperioexhor
				|	desiderativa
				|	optativa
				|	dubitativa
				;
otraoracioncompuesta		: 	/*vacio */
				|	oracioncompuesta
				;		
oracioncompuesta		:	oracion CONJUNCION oracion otraoracioncompuesta
				;
enunciativa			:	sujeto	predicado
				;
interrogativa			:	INTERROGACION_ABRIR sujeto predicado INTERROGACION_CERRAR
				;
exclamativa			:	EXCLAMACION_ABRIR sujeto predicado EXCLAMACION_CERRAR
				;
imperioexhor			:	verbo palabrasujetoobj PUNTO
				;
desiderativa			:	OJALA palabrasujetoobj PUNTO
				;
optativa			:	sujeto predicado puntuacion palabraclave PUNTO
				;
dubitativa			: 	TALVEZ sujeto predicado PUNTO
				;
sujeto				:	nominal
				|	/*vacio */
				;
nominal				:	palabrasujetoobj
				|	palabrasujetoobj CONJUNCION palabrasujetoobj
				;
predicado			:	copulativas
				|	predicativas
				;
copulativas			:	COPULA adjetivo
				|	COPULA sustantivo
				|	COPULA sujeto
				;
predicativas			:	verbo complemento
				|	verbo complemento otrocomplemento
				;
complemento			:	complementodirecto
				|	complementoindirecto
				|	complementocircunstancial
				;
otrocomplemento			:	/*vacio */
				|	complemento
				;
complementodirecto		:	palabrasujetoobj
				;
				;
complementoindirecto		:	PREPOSICION sustantivo
				|	PREPOSICION DETERMINANTE
				;
complementocircunstancial	:	PREPOSICION sustantivo
				|	PREPOSICION adjetivo
				|	PREPOSICION adverbio
				;
palabraclave			:	COPULA
				;
palabrasujetoobj		:	sustantivo
				|	DETERMINANTE	
				;
sustantivo			:	SUSTANTIVO_DERIVADO
				|	SUSTANTIVO_COMPUESTO
				|	SUSTANTIVO_SIMPLE
				;
adjetivo			:	ADJETIVO_DERIVADO
				|	ADJETIVO_SIMPLE
				;
adverbio			:	ADVERBIO_DERIVADO
				|	ADVERBIO_SIMPLE
				;
verbo				:	VERBO_DERIVADO
				|	VERBO_CONJUGADO
				|	VERBO_SIMPLE
				;
puntuacion			:	COMA
				|	PUNTO_Y_COMA
				|	INTERROGACION_ABRIR
				|	INTERROGACION_CERRAR
				|	EXCLAMACION_ABRIR
				|	EXCLAMACION_CERRAR
				;
