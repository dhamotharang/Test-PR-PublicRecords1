export Mac_Set_Source_Code(infile,out_layout,source_code,outfile) := macro

#uniquename(set_src)

out_layout %set_src%(infile le) := transform
 
 self.src := source_code;
 self := le;
end;
 
outfile := project(infile,%set_src%(left));

endmacro;