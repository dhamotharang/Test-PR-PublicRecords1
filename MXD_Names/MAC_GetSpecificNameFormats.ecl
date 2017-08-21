export MAC_GetSpecificNameFormats(ds,dsNameFormat,dsResult,IdsNotFound) := MACRO
#uniquename(dsSpecificFormats)
#uniquename(dsf_dedup)
#uniquename(dsf)
%dsf% :=TABLE(ds,{name_format});
%dsf_dedup% :=DEDUP(SORT(%dsf%(name_format not in ['FLL','FFLL','FL','FFL']),name_format),name_format);
%dsSpecificFormats% :=%dsf_dedup% + DATASET([{'FLL'},{'FFLL'},{'FL'},{'FFL'}],RECORDOF(%dsf%));

#uniquename(dsRecsetNameFormats)
dsResult :=JOIN(%dsSpecificFormats%, dsNameFormat,
REGEXFIND('^' + RIGHT.name_Format + '$',LEFT.name_format,0) != '',
TRANSFORM(RECORDOF(dsNameFormat),
SELF.name_format:=LEFT.name_format;
SELF := RIGHT;),ALL);

#uniquename(dsFormatsNotFound)
%dsFormatsNotFound% :=JOIN(%dsSpecificFormats%,dsNameFormat,
REGEXFIND('^' + RIGHT.name_Format + '$',LEFT.name_format,0) != '',
TRANSFORM(RECORDOF(dsNameFormat),
SELF.name_format:=LEFT.name_format;
SELF := RIGHT;),left only, ALL);

#uniquename(bad_name_formats)
IdsNotFound:=JOIN(ds,DEDUP(SORT(%dsFormatsNotFound%,name_format),name_format),
LEFT.name_format=RIGHT.name_format,TRANSFORM(RECORDOF(ds),SELF := LEFT),LOOKUP); 

ENDMACRO;