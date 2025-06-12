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
  token _number { <[+-]>? \d+ }
}


grammar aDSL is Operators is Numbers {

  #000000
  token TOP {
    <_var_definition>
  }

  token _function {
    <_function_definition> '{' <ws> <_var_definition> ';' <ws> '}'
  } 
  token _expression { <_var_name> \s* <operator> \s* <_var_name>   }

  token _function_definition {
    "func" \s+ <_var_name> \s* "(" \s* <_func_arg_list> \s* ")" \s* ":" \s* <_type>
    
  }

  token _func_arg_list { <_var_definition> [ \s* ',' \s* <_var_definition> ]* }

  proto token reserved {*}
  token reserved:sym<do> {<sym>}
  token reserved:sym<while> {<sym>}
  token reserved:sym<if> {<sym>}
  token reserved:sym<else> {<sym>}
  token reserved:sym<print> {<sym>}
  token reserved:sym<printc> {<sym>}

  token _var_definition { <_var_name> \s* ':' \s* <_type> }

  token _var_name { \w+ }
  token _type  {  <_basic_type> | <_array> }

  token _array   { Array'[' <_basic_type> ']' }

  proto token _basic_type {*} 
  token _basic_type:sym<Int8> { <sym> }

  #token _int16 { 'int16' }


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
$s = 'a:Int8';
my $m = aDSL.parse($s);
say $m;
