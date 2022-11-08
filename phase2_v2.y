%{
int yylex();
void yyerror(const char *s);
#include <stdio.h>
%}

%union{
int integerVal;
char* stringVal;
}
%token SUB
%token ADD
%token MULT
%token DIV
%token MOD
%token EQUIV
%token NOTEQ
%token LT
%token GT
%token LTE
%token GTE
%token SEMICOLON
%token COLON
%token COMMA
%token L_PAREN
%token R_PAREN
%token L_SQUARE_BRACKET
%token R_SQUARE_BRACKET
%token ASSIGN
%token INTEGER
%token ARRAY
%token OF
%token IF
%token THEN
%token ENDIF
%token ELSE
%token WHILE
%token DO
%token BEGINLOOP
%token ENDLOOP
%token FUNCTION
%token BEGINPARAMS
%token ENDPARAMS
%token BEGINLOCALS
%token ENDLOCALS
%token BEGINBODY
%token ENDBODY
%token CONTINUE
%token READ
%token WRITE
%token AND
%token OR
%token NOT
%token TRUE
%token FALSE
%token RETURN
%token BREAK
%token <stringVal> IDENTIFIER
%token <integerVal> DIGITS


%%

Program:    {  }
    		| Program function {  }
    ;

function:   FUNCTION IDENTIFIER SEMICOLON BEGINPARAMS declaration_loop ENDPARAMS BEGINLOCALS declaration_loop ENDLOCALS BEGINBODY statement_loop ENDBODY
            {  }
            ;

declaration_loop: { }
    			  | declaration_loop declaration SEMICOLON {  }
    			  ;

declaration:	 IDENTIFIER COLON INTEGER {  }
				 | IDENTIFIER COLON ARRAY L_SQUARE_BRACKET DIGITS R_SQUARE_BRACKET OF INTEGER { }
				;

statement_loop: statement SEMICOLON {  }
				| statement_loop statement SEMICOLON {  }
				;



statement:	  var ASSIGN expression { }
		| IF bool_expr THEN statement_loop ENDIF { }
		| IF bool_expr THEN statement_loop ELSE statement_loop ENDIF {  }
		| WHILE bool_expr BEGINLOOP statement_loop ENDLOOP {  }
		| DO BEGINLOOP statement_loop ENDLOOP WHILE bool_expr {  }
		| READ var_loop {  }
		| WRITE var_loop {  }
		| CONTINUE {  }
		| RETURN expression {  }
		;

bool_expr:	  Relation_Exps {  }
        | bool_expr OR Relation_Exps {  }
        ;

Relation_Exps:	  		Relation_Exp {  }
        			  | Relation_Exps AND Relation_Exp { ; }
                      ;

Relation_Exp:	  expression comp expression {  }
				  | NOT expression comp expression {  }
				  | TRUE {  }
				  | FALSE {  }
				  | L_PAREN bool_expr R_PAREN {  }
				  ;

comp:	  LT {  }
		| GT {  }
		| LTE {  }
		| GTE {  }
		| NOTEQ {  }
		| EQUIV {  }
		;

expression: mult_expr {  }
        	| expression ADD mult_expr {  }
        	| expression SUB mult_expr {  }
        ;

expression_loop:    expression {  }
    				| expression_loop COMMA expression { }
    				;

mult_expr:	  term  {  }
        	  | mult_expr MULT term {  }
			  | mult_expr DIV term {  }
			  | mult_expr MOD term { }
        ;


term:	var {  }
		| SUB var {  }
		| DIGITS {  }
		| SUB DIGITS {  }
		| L_PAREN expression R_PAREN {  }
		| SUB L_PAREN expression R_PAREN {  }
		| IDENTIFIER L_PAREN expression_loop R_PAREN {  }
		;

var_loop:	  var {  }
			  | var_loop COMMA var {  }
			  ;		
		
var:	  IDENTIFIER {  }
		| IDENTIFIER L_SQUARE_BRACKET expression R_SQUARE_BRACKET {  }
		;

%%

int main(int argc, char ** argv) {

  yyparse();
}
void yyerror(const char *s){

}
