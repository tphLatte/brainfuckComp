
grammar Operators {
  proto token operator  {*}
  token operator:sym<=> {<sym>}
  token operator:sym<+> {<sym>}
  token operator:sym<-> {<sym>}
  token operator:sym<*> {<sym>}
  token operator:sym</> {<sym>}
  token operator:sym<%> {<sym>}
  token operator:sym<^> {<sym>}
  token operator:sym<&> {<sym>}
  token operator:sym<|> {<sym>}
}
grammar Numbers {
  token number { <[+-]>? \d+ }
}
grammar Strings{
  token string  {\'.*\'} 
  token char {\'.\' }
}

grammar aDSL is Operators is Numbers is Strings {

  #000000
  token TOP { <var_assignment> }

  token function { <_function_definition> '{' <ws> <var_definition> ';' <ws> '}' } 
  token _expression { <var_name> \s* <operator> \s* <var_name>   }
  token _function_definition { "func" \s+ <var_name> \s* <_func_arg_list>  \s* ":" \s* <_type> }
  token _func_arg_list { "(" \s*  <var_definition> [ \s* ',' \s* <_var_definition> ]*  \s* ")" }

  proto token reserved {*}
  token reserved:sym<do> {<sym>}
  token reserved:sym<while> {<sym>}
  token reserved:sym<if> {<sym>}
  token reserved:sym<else> {<sym>}
  token reserved:sym<print> {<sym>}
  token reserved:sym<printc> {<sym>}

  token var_assignment { 
    <var_name> <ws> '=' <ws> <value> <ws> ';' | <var_definition>  <ws>'=' <ws> <value> <ws> ';'
  }

  token value { <number> | <char> | <string> | <var_name> }
  token var_definition { <var_name> \s* ':' \s* <_type> }
  token var_name { \w+ }
  token _type  {  <basic_type> | <_array> }
  token _array   { Array'[' <basic_type> ']' }
  proto token basic_type {*} 
  token basic_type:sym<Int8> { <sym> }

}

class aDSL_actions {
  method type($/){
    make $/;
  }

  method var_definition($/){
    make($/<_type>.made);
  }

  method TOP($/){
    self.var_definition($/);
  }

}


grammar aDSL_comp is aDSL {

}


grammar IR {

}

my $s = 'func help(a: Int8, b:Int8):Int8';
$s = 'a + b';
$s = 'Int8 a';
$s = 'Array[Int8]';
$s = 'func help(a: Int8, b:Int8):Int8 { c : Int8; }';
$s = 'a:Int8 = 1;';
my $m = aDSL.parse($s);
#my $m = aDSL.parse($s, actions => aDSL_actions.new);
say $m;
