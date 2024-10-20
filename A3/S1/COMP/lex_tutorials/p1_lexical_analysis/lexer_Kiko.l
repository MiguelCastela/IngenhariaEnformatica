%{
    /* place here any C variables and definitions */
    #define YY_USER_ACTION \
        for (int i=0; i<yyleng; i++) { \
            if (yytext[i] == '\n') { \
                cur_line++; \
                cur_column = 0; \
            } else { \
                cur_column++; \
            } \
        }


    int cur_column = 0;
    int cur_line = 1;
%}




whitespace  [ \t\n]
digit       [0-9]
letter      [a-zA-Z]
punctuation [()=,*/+-]

%%
{whitespace}*                   { ; }


"integer"                       { printf("INTEGER\n"); }
"double"                        { printf("DOUBLE\n"); }
"if"                            { printf("IF\n"); }
"then"                          { printf("THEN\n"); }
"else"                          { printf("ELSE\n"); }


{punctuation}                   { printf("PUNCTUATION(\"%s\")\n", yytext); }


{digit}+                        { printf("NATURAL(%s)\n", yytext); }
{digit}*"."{digit}+             { printf("DECIMAL(%s)\n", yytext); }
{letter}({letter}|{digit})*     { printf("IDENTIFIER(%s)\n", yytext); }


.                               { printf("ERROR: line %d, collumn %d: unrecognized token \"%s\"\n", cur_line, cur_column, yytext); }
%%




extern int yylex();
int main() {
    yylex();    /* run the lexical analysis automaton */
    return 0;
}
int yywrap() {  /* called on EOF, return 1 to terminate */
    return 1;
}