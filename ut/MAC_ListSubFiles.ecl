export MAC_ListSubFiles(superfile_name) := macro

#uniquename(a)
%a% := 1;
#uniquename(outfile)
ut.MAC_ListSubFiles_seq(superfile_name, %outfile%)
output(%outfile%)

endmacro;