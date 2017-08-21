import lib_ziplib;
export Mac_add_orig_state(infile,out_layout,zip_field,st_field,orig_state_field,outfile) := macro

#uniquename(add_state)

out_layout %add_state%(infile le) := transform
 
self.temp_state := if(le.st_field <> '', le.st_field, if(lib_ziplib.ziplib.ZipToState2(le.zip_field)<> '', 
lib_ziplib.ziplib.ZipToState2(le.zip_field),le.orig_state_field));

self := le;
end;
 
outfile := project(infile,%add_state%(left));

endmacro;
