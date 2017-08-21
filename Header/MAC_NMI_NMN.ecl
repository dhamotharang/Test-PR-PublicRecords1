export MAC_NMI_NMN(infile, mname_field,outfile) := macro

#uniquename(nmi_nmn_fix)
typeof(infile) %nmi_nmn_fix%(infile l) := transform
 
 self.mname_field := if(trim(l.mname_field) in ['NMI','NMN','(NMN)','(NMI)'],'',l.mname_field); // bug# 39324 
 self       := l;

end;

outfile := project(infile, %nmi_nmn_fix%(left));

endmacro;