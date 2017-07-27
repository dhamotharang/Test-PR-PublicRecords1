export MAC_Remove_Withdups_local(infile,infield,thresh,outfile) := macro

#uniquename(spare1)
%spare1% := 1;
#uniquename(spare)
ut.mac_split_withdups_local(infile,infield,thresh,outfile,%spare%)

  endmacro;