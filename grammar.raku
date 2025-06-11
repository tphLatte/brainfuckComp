
grammar aDSL_comp is aDSL {

}

grammar aDSL  {

  #000000
  token TOP {
    <_function_definition>
  }

  token _function_definition {
    "func" \s+ <_var_name> \s* "(" \s* <_var_list> \s* ")" \s* ":" \s* <_type>
    
  }
  token _var_list {
  <_var_definition> [ \s* ',' \s* <_var_definition> ]*
  }

  token _var_definition { 
    <_var_name> \s* ':' \s* <_type> 
  }

  token _var_name { \w+ }

  token _type {
      <_int8>
  }

  token _int8 { 'int8' }
  token _int16 { 'int16' }
  
  proto token operator  {*}
  token operator:sym<=> {<sym>}
  token operator:sym<+> {<sym>}
  token operator:sym<-> {<sym>}
                        {<sym>}
  token operator:sym<*> {<sym>}
  token operator:sym</> {<sym>}
  token operator:sym<%> {<sym>}
                        {<sym>}
  token operator:sym<^> {<sym>}
  token operator:sym<&> {<sym>}
  token operator:sym<|> {<sym>}



}

grammar IR {

}

my $s = 'func help(a: int8, b:int8):int8';
my $m = aDSL.parse($s);
say $m;
