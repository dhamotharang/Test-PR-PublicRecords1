export MAC_ListSubFiles_seq(superfile_name, seq) := macro

#uniquename(rec)
#uniquename(filename)
%rec% := record
 string %filename%;
end;

#uniquename(rec2)
#uniquename(one)
%rec2% := record
 string1 %one%;
end;

#uniquename(do)
%rec% %do%(%rec2% L, integer c) := transform
self.%filename% := fileservices.GetSuperFileSubName(superfile_name,c);
end;

#uniquename(subnamelist)
%subnamelist% := normalize(dataset([{''}],%rec2%), fileservices.GetSuperFileSubCount(superfile_name),%do%(left,counter));

seq := %subnamelist%;

endmacro;