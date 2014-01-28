grammar Language;

tokens{
	ENDCLASS			= 'endclass'	;						
	ENDFUNCTION			= 'endfunction'	;
	ENDIF				= 'endif'	;
	ENDELSE				= 'endelse'	;
	ENDWHILE			= 'endwhile'	;
	ENDFOR				= 'endfor'	;
	IF				= 'if'		;
	ELSE				= 'else'	;
	WHILE				= 'while'	;
	FOR				= 'for'		;
	CLASS				= 'class'	;
	FUNCTION			= 'function'	;
	RETURN				= 'return'	;
	VAR				= 'var'		;
	IF				= 'if'		;
	ARR				= 'arr'		;
	LTE				= '<='		;
	GTE				= '>='		;
	LT				= '<'		;
	GT				= '>'		;
	INCREASE			= '++'		;
	DECREASE			= '--'		;
	SEMICOLON			= ';'		;
	PLUS				= '+'           ;
	MINUS				= '-'           ;
	STAR				= '*'           ;
	SLASH				= '/'           ;
	EQUALS				= '=='		;
	ASSIGN				= '='           ;
	LPAREN				= '('           ;
	RPAREN				= ')'           ;
	COMMA				= ','           ;
}

file:
		CLASS ID func function_list ENDCLASS
		;
		
function_list:
		| func function_list
		;
	
func :	
	 	variable_assignments FUNCTION ID LPAREN param RPAREN variable_assignments compound_statement ENDFUNCTION 
		;

param	:	
		| type ID param_cont 
		;
		
type	:	
		VAR
		| ARR
		;
	
param_cont
	:	
		| COMMA type ID param_cont 
		;

variable_assignments
	:	
		| assignment variable_assignments
		;
		
assignment
	:	
		VAR ID ASSIGN VALUE
		| ARR ID
		;
		
return_statement
	:	
		RETURN term return_cont
		;

return_cont
	:	
		| operator ID LPAREN term_list RPAREN
		;

compound_statement:
		
		|statement compound_statement
		;

statement:	
		arithmatic_expression
		| conditional_expression
		| while_loop_expression
		| for_loop_expression
		| function_expression
		| return_statement
		;

arithmatic_expression
	:	
		ID ASSIGN term arith_recurse
		;
		
arith_recurse
	:	
		| operator term
		| operator LPAREN term arith_recurse RPAREN
		;
		
conditional_expression
	:	
		IF test_expression compound_statement ENDIF ELSE compound_statement ENDELSE
		;
		
test_expression
	:	
		LPAREN ID comparator term RPAREN
		;
		
while_loop_expression
	:	
		WHILE test_expression compound_statement ENDWHILE
		;
		
for_loop_expression
	:	
		FOR LPAREN ID ASSIGN VALUE SEMICOLON ID comparator VALUE SEMICOLON ID increment RPAREN compound_statement ENDFOR
		;

function_expression
	:	
		ID ASSIGN ID LPAREN term_list RPAREN
		| ID ASSIGN VALUE operator ID LPAREN term_list RPAREN
		;
		
comparator
	:	
		EQUALS
		| LT
		| GT
		| LTE
		| GTE
		;
		
increment
	:	
		INCREASE
		| DECREASE
		;

operator:	
		PLUS
		| MINUS
		| STAR
		| SLASH
		;
 
term	:	 
		ID
		| VALUE
 		;
 		
term_list
	:	
		| term arith_recurse term_list_cont
		;
		
term_list_cont
	:	
		| COMMA term arith_recurse term_list_cont
		;
 			
 			/*
*	LEXER RULES
*/


ID				: ('a'..'z' | 'A'..'Z')('0'..'9' | 'a'..'z' | 'A'..'Z' | '[' | ']')*            ;
VALUE				: '-'?('0'..'9')+            ;
WS 				: ( ' ' | '\t' | '\r' | '\n') {$channel=HIDDEN;};