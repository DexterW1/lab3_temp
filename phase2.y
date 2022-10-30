%{
int yylex();
void yyerror(const char *s);
#include <stdio.h>
%}

%token BEGIN_PAR
%token END_PAR
%token BEGIN_LOC
%token END_LOC
%token BEGIN_BOD
%token END_BOD
%token DO
%token WHILE
%token LOOP_BEGIN
%token LOOP_END
%token BREAK
%token RETURN
%token CONTINUE
%token ADD
%token SUBTRACT
%token MULT
%token DIVI
%token MOD
%token ASSIGN
%token BREAK
%token COMMENT
%token INTEGER 
%token FUNCTION
%token IF
%token ELSEIF
%token ENDIF
%token WRITE
%token READ
%token LESST
%token LESSTEQ
%token GREATT
%token GREATTEQ
%token EQUIV 
%token NOTEQ
%token LOOP
%token L_PAREN
%token R_PAREN
%token L_SQUARE_BRACKET
%token R_SQUARE_BRACKET
%token COLON
%token SEMICOLON
%token COMMA
%token NEG
%token TRU
%token FAL
%token NOT
%token AND
%token OR
%token ARRAY

%%

Program:    Function Program
            {printf("Program->Function Program\n");}
            ;
	    
	    
Function:   Function IDENTIFIER SEMICOLON BEGIN_PAR Declaration SEMICOLON END_PAR BEGIN_LOC Declaration SEMICOLON END_LOCALS BEGIN_BOD Statement SEMICOLON END_BOD
            {printf("Function->Function IDENTIFIER SEMICOLON BEGIN_PAR Declaration SEMICOLON END_PAR BEGIN_LOC Declaration SEMICOLON END_LOCALS BEGIN_BOD Statement SEMICOLON END_BOD\n");}
            ;	    
	    
	    
Declaration:    IDENTIFIER COLON INTEGER SEMICOLON
                {printf("Declaration->IDENTIFIER COLON INTEGER SEMICOLON\n");}
                | IDENTIFIER COLON ARRAY L_SQUARE_BRACKET DIGITS R_SQUARE_BRACKET INTEGER SEMICOLON
                {printf("Declaration->IDENTIFIER COLON ARRAY L_SQUARE_BRACKET DIGITS R_SQUARE_BRACKET INTEGER SEMICOLON\n");}
                ;	    
		
		
Statement:     Var ASSIGN Expression SEMICOLON
               {printf("Statement->Var ASSIGN Expression SEMICOLON\n");}
               | IF Bool_Exp THEN Statment SEMICOLON ENDIF SEMICOLON
               {printf("Statement->IF Bool_Exp THEN Statment SEMICOLON ENDIF SEMICOLON\n");}                       
               | IF Bool_Exp THEN Statement SEMICOLON ELSEIF Statement SEMICOLON
               {printf("Statement->IF Bool_Exp THEN Statment SEMICOLON ELSEIF Statement SEMICOLON\n");}
               | Loop_Statement SEMICOLON
               {printf("Statement->Loop_Statement SEMICOLON\n");}
               | READ Var SEMICOLON
               {printf("Statement->READ Var SEMICOLON\n");}
               | WRITE Var SEMICOLON
               {printf("Statement->WRITE Var SEMICOLON\n");}
               | CONTINUE SEMICOLON
               {printf("Statement->CONTINUE SEMICOLON\n");}
               | BREAK SEMICOLON
               {printf("Statement->BREAK SEMICOLON\n");}
               | RETURN Expression SEMICOLON
               {printf("Statement->RETURN Expression SEMICOLON\n");}
               ;	
	       
	       
Expression:   Mult_Exp
		{printf("MultExp\n");}
	      |Mult_Exp ADD Expression
              {printf("Expression->Mult_Exp ADD Expression\n");}
              | Mult_Exp SUB Expression
              {printf("Expression->Mult_Exp SUB Expression\n");}
              ;
	       
	       
Loop_Statement:   DO LOOP_BEGIN Statement SEMICOLON LOOP_END WHILE Bool_Exp
                  {printf("Loop_Statement->DO LOOP_BEGIN Statement SEMICOLON LOOP_END WHILE Bool_Exp\n");}
                  | WHILE Bool_Exp  LOOP_BEGIN Statement SEMICOLON LOOP_END
                  {printf("Loop_Statement->WHILE Bool_Exp LOOP_BEGIN Statement SEMICOLON LOOP_END\n");}
                  ;	       


Comp:   LESST
        {printf("Comp->LESST\n");}
        | LESSTQ
        {printf("Comp->LESSTQ\n");}
        | GREATT
        {printf("Comp->GREATT\n");}
        | GREATTEQ
        {printf("Comp->GREATTEQ\n");}
        | EQUIV
        {printf("Comp->EQUUIV\n");}
        ;
        
	
Term:   Var
        {printf("Term->Var\n");}
        | DIGITS
        {printf("Term->DIGITS\n");}
        | NEG DIGITS
        {printf("Term->NEG DIGITS\n");}
        | NEG L_PAREN Expression R_PAREN
        {printf("Term->NEG L_PAREN Expression R_PAREN\n");}
        | L_PAREN Expression R_PAREN
        {printf("Term->L_PAREN Expression R_PAREN\n");}
        | IDENTIFIER L_PAREN Expression R_PAREN
        {printf("Term->IDENTIFIER L_PAREN Expression R_PAREN\n");}
        ;
	
	
Var:    IDENTIFIER
        {printf("Var->IDENTIFIER\n");}
        | IDENTIFIER L_SQUARE_BRACKET Expression R_SQUARE_BRACKET
        {printf("Var->IDENTIFIER L_SQUARE_BRACKET Expression R_SQUARE_BRACKET\n");}
        ;
        
	
Mult_Exp:   Term
	    {printf("Term\n");}
	    |Term MULT Mult_Exp
            {printf("Mult_Exp->Term MULT Mult_Exp\n");}
            | Term DIV Mult_Exp
            {printf("Mult_Exp->Term DIV Mult_Exp\n");}
            | Term MOD Mult_Exp
            {printf("Mult_Exp->Term MOD Mult_Exp\n");}
            ;
            
              
Bool_Exp:   Relation_Expression
            {printf("Bool_Exp->Relation_Expression\n");}
            | Bool_Exp OR Relation_Exp
            {printf("Bool_Exp->Bool_Exp OR Relation_Exp\n");}
            ;
	    
            
Relation_Exp:   NOT Expression Comp Expression
                {printf("Relation_Exp->NOT Expression Comp Expression\n");}
                | Expression Comp Expression
                {printf("Relation_Exp->Expression Comp Expression\n");}
                | TRU
                {printf("Relation_Exp->TRU\n");}
                | FAL
                {printf("Relation_Exp->FAL\n");}
                | L_PAREN Bool_Exp R_Paren
                {printf("Relation_Exp->L_PAREN Bool_Exp R_Paren\n");}
                | Relation_Exp AND Relation_Exp
                {printf("Relation_Exp->Relation_Exp AND Relation_Exp\n");}
                ;

            
%%
main(int argc, char **argv)
{
  if(argc >= 2){

	yyin = stdin;

  } 

  yyparse();
}
                

    
        
