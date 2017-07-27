// Assumes existence of CNT field
export MAC_Field_Specificity(infile,infield,null_values,outlabel) := MACRO
#uniquename(ct0)
//%ct0% := join(infile,null_values,left.infield=right.infield,transform(left),left only,lookup);
%ct0% := infile(infield NOT IN SET(null_values,infield));
#uniquename(ssq)
%ssq% := sum( %ct0%,(real8)cnt*cnt);
#uniquename(sss)
%sss% := sum( %ct0%,(real8)cnt);
outlabel := log(%sss%*%sss%/%ssq%)/log(2);
  ENDMACRO;
