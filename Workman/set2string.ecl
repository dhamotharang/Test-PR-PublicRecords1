/*
  WorkMan.set2string
    will convert a set of string to a string for use in ecl code.
    only works with set of string now.  if needed, will have to be modified to use set of anything else.
*/

EXPORT set2string(set of string pSet) :=
function

  // #uniquename(ds_norm)
  // #uniquename(ds_rollup)

  ds_norm := normalize(dataset([{''}],{string stuff}) ,count(pSet)  ,transform({string set_prep}
    ,self.set_prep := ',' + '\'' + pSet[counter] + '\''
    // ,self.set_prep := ',' + '\\\'' + pSet[counter] + '\\\''
  ));

  ds_rollup := rollup(ds_norm ,true ,transform(recordof(left),self.set_prep := left.set_prep + right.set_prep));

  return if(count(pSet) > 0 ,'[' + ds_rollup[1].set_prep[2..] + ']' ,'[]');

end;