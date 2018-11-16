/*
  returns a field parsed out.  
  'ds_me[1].fein' = ',ds_me,1,fein'
  4 ways
  cleave_corpkey
  cleave_corpkey PossibleCleaves[1].count_possibles_active_domestic_corp_key
  PossibleCleaves[1].count_possibles_active_domestic_corp_key
  PossibleCleaves.count_possibles_active_domestic_corp_key
  varname,resultname,index,field_name

*/
EXPORT parsefieldname(

  string pFieldString

) :=
function
  
  trimstring   := trim(pFieldString,left,right);
  lregex       := '^(([[:alnum:]_ ]*) )?(([[:alnum:]_ ]*)(\\[([[:digit:]]+)\\])?[.]([[:alnum:]_]*))?$';
  ECLPARSE     := regexreplace(lregex,trimstring,'$2,$4,$6,$7',nocase);

  return ECLPARSE;
  
end;