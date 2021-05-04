EXPORT _BWR_BuildHeaderFlagFile(string pversion='',boolean pUseProd=false) := function

ds := DATASET([],{string1 x});

return output(ds,,'~thor_data400::in::ida::header::flag',OVERWRITE,compressed);
end;