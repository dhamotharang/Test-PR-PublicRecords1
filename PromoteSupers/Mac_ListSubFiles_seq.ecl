export MAC_ListSubFiles_seq(superfile_name, seq) := macro

seq := FileServices.SuperFileContents(superfile_name,true);

endmacro;