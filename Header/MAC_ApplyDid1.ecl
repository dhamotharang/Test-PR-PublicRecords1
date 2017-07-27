export MAC_ApplyDid1(infile1,did_field,infile2,outfile) := macro

#uniquename(jti)
%jti% := 9;
ut.MAC_Patch_Id(infile1,did_field,infile2,old_rid,new_rid,outfile)

endmacro;