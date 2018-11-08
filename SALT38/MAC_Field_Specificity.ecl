// Assumes existence of CNT field
export MAC_Field_Specificity(infile,infield,null_values,outlabel) := MACRO
#uniquename(ct0)
//%ct0% := join(infile,null_values,left.infield=right.infield,transform(left),left only,lookup);
%ct0% := infile(infield NOT IN SET(null_values,infield));
#uniquename(spc)
%spc% := LOG((REAL)TotalClusters/(REAL)infile.cnt)/LOG(2);
#uniquename(aver)
%aver% := SUM( %ct0%,%spc%*cnt);
#uniquename(sss)
%sss% := SUM( %ct0%,(real8)cnt);
outlabel := %aver%/%sss%;
  ENDMACRO;
