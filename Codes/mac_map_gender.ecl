export mac_map_gender(infile,infield,outfield,outfile) := macro
       
       #uniquename(get_gender)
       typeof(infile) %get_gender%(infile L) := transform
              self.outfield := codes.GENERAL.gender(stringlib.stringtouppercase(l.infield)[1]);
              self := l;
       end;
       
       outfile := project(infile, %get_gender%(LEFT));
endmacro;
