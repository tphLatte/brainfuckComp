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
  
  token operator { 

    <_add>| 
    <_sub>| 
    <_mul>| 
    <_div>| 
    <_mod>| 
    <_xor>| 
    <_and>| 
    <_or>

  }


  token _asign { '=' }

  token _add { '+' }
  token _sub { '-' }

  token _mul { '*' }
  token _div { '/' }
  token _mod { '%' }

  token _xor { '^' }
  token _and { '&' }
  token _or { '|' }



}

grammar IR {

}

my $s = 'func help(a: int8, b:int8):int8';
my $m = aDSL.parse($s);
say $m;
