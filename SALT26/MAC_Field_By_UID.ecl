export MAC_Field_By_UID(infile,ufield,infield) := MACRO
  dedup ( sort(table(infile,{infield,ufield}),ufield,infield,local), ufield,infield,local )
endmacro;
