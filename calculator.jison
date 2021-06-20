/* description: Parses end executes mathematical expressions. */

/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'

"Qual é o"            return 'aux_question'
"?"                   return 'aux_question_symbol'
"de"                  return 'aux_of'
"elemento da série"   return 'aux_range'
"Se"                  return 'aux_if'
"senão"               return 'aux_else'
"é"                   return 'aux_its'
"que"|a               return 'aux_that'

"maior"
|"menor"
|"igual"              return 'condition'

"escreva"             return 'action'

"dobro"
|"triplo"             return 'op_mult'

"primeiro"
|"segundo"
|"terceiro"
|"quarto"
|"quinto"
|"sexto"
|"sétimo"
|"oitavo"
|"nono"
|"décimo"             return 'ordinal'

"um"
|"dois"
|"três"
|"quatro"
|"cinco"
|"seis"
|"sete"
|"oito"
|"nove"
|"dez"                return 'num'

\w+                   return 'STRING'

"["                   return "["
"]"                   return "]"
", "                  return 'comma'

"\""                  return 'single_quote'
"*"                   return '*'
"/"                   return '/'
"-"                   return '-'
"+"                   return '+'
"^"                   return '^'
"("                   return '('
")"                   return ')'
"PI"                  return 'PI'
"E"                   return 'E'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%left '+' '-'
%left '*' '/'
%left '^'
%left UMINUS
%left 'single_quote'
%left STRING

%start expressions

%% /* language grammar */

expressions
    : e EOF
        {return $1;}
    ;
e
    : 'aux_question' 'op_mult' 'aux_of' e 'aux_question_symbol'
        {{
          $$ = function f(op, n) {
            console.log(`Computing op_mult(${op}) for ${n}...`);
            switch(op) {
              case 'dobro': return n * 2;
              case 'triplo': return n * 3;
            }
          }($2, $4);
        }}
    | 'aux_question' 'condition' 'aux_range' e 'aux_question_symbol'
        {{
          $$ = function f(range, items) {
            console.log(`Computing condition(${range}) for ${items}...`);
            switch(range) {
              case 'menor': return Math.min.apply(Math, items);
              case 'maior': return Math.max.apply(Math, items);
            }
          }($2, $4);
        }}
    | 'aux_question' 'ordinal' 'aux_range' e 'aux_question_symbol'
        {{
          $$ = function f(range, items) {
            console.log(`Computing ordinal(${range}) for ${items}...`);
            switch(range) {
              case 'primeiro': return items[0];
              case 'segundo': return items[1];
              case 'terceiro': return items[2];
              case 'quarto': return items[3];
              case 'quinto': return items[4];
              case 'sexto': return items[5];
              case 'sétimo': return items[6];
              case 'oitavo': return items[7];
              case 'nono': return items[8];
              case 'décimo': return items[9];
            }
          }($2, $4);
        }}
    | 'aux_if' e 'aux_its' 'condition' 'aux_that' e 'action' e aux_else 'action' e
        {{
          $$ = function f(num1, condition, num2, actionTrue, valTrue, actionFalse, valFalse) {
            console.log(`Computing condition(${condition}) for ${num1} and ${num2}...`);
            function makeAction(action, val) {
              switch (action) {
                case 'escreva': console.log(val);
              }
            };

            switch (condition) {
              case 'maior':
                if (num1 > num2) makeAction(actionTrue, valTrue);
                else makeAction(actionFalse, valFalse);
                break;
              case 'menor':
                if (num1 < num2) makeAction(actionTrue, valTrue);
                else makeAction(actionFalse, valFalse);
                break;
              case 'igual':
                if (num1 === num2) makeAction(actionTrue, valTrue);
                else makeAction(actionFalse, valFalse);
                break;
            }

            return null;
          }($2, $4, $6, $7, $8, $10, $11);
        }}
    | e '+' e
        {$$ = $1+$3;}
    | e '-' e
        {$$ = $1-$3;}
    | e '*' e
        {$$ = $1*$3;}
    | e '/' e
        {$$ = $1/$3;}
    | e '^' e
        {$$ = Math.pow($1, $3);}
    | '-' e %prec UMINUS
        {$$ = -$2;}
    | '(' e ')'
        {$$ = $2;}
    | NUMBER
        {$$ = Number(yytext);}
    | STRING
        {$$ = String(yytext);}
    | single_quote STRING single_quote
        {$$ = $2;}
    | num
        {{
          $$ = function f(n) {
            console.log(`Computing num for ${n}...`);
            switch(n.toString()) {
              case 'um': return 1;
              case 'dois': return 2;
              case 'três': return 3;
              case 'quatro': return 4;
              case 'cinco': return 5;
              case 'seis': return 6;
              case 'sete': return 7;
              case 'oito': return 8;
              case 'nove': return 9;
              case 'dez': return 10;
            }
          }($1)
        }}
    | '[' e ']'
        {$$  = $2;}
    | e comma e
        {{
          $$ = function f(a, b) {
            if (Array.isArray(b)) return [a, ...b];
            return [a, b];
          }($1, $3)
        }}
    | e
        {$$ = $1;}
    | E
        {$$ = Math.E;}
    | PI
        {$$ = Math.PI;}
    ;
