export Specificity(infile,infield,ufield,null_value_label,label,bfoul_label,spec_values) := MACRO

#uniquename(h)
shared %h% := distribute(table(infile,{infield,ufield}),hash(ufield));

ngadl.Specificity_Local(%h%,infield,ufield,null_value_label,label,bfoul_label,spec_values)

  ENDMACRO;