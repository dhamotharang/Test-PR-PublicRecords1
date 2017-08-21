import watercraft, watercraft_preprocess, ut, lib_StringLib;

fIn_raw := watercraft_preprocess.Files_raw.KS;

//Trim and uppercase fields prior to mapping
Watercraft.Layout_KS CleanTrimRaw(fIn_raw L) := TRANSFORM
self.STATEABREV	:= ut.CleanSpacesAndUpper(L.STATEABREV);
self.REG_NUM	:= ut.CleanSpacesAndUpper(L.REG_NUM);
self.HULL_ID	:= ut.CleanSpacesAndUpper(L.HULL_ID);
self.PROP	:= ut.CleanSpacesAndUpper(L.PROP);
self.VEH_TYPE	:= ut.CleanSpacesAndUpper(L.VEH_TYPE);
self.FUEL	:= ut.CleanSpacesAndUpper(L.FUEL);											
self.HULL	:= ut.CleanSpacesAndUpper(L.HULL);
self.USE_1	:= ut.CleanSpacesAndUpper(L.USE_1);
tempMake	:= ut.CleanSpacesAndUpper(MAP(StringLib.StringFind(L.MAKE, '(DBA)',1) > 0 => StringLib.StringFindReplace(L.MAKE, '(DBA)',''),
																	StringLib.StringFind(L.MAKE, '\'\'',1) > 0 => StringLib.StringFindReplace(L.MAKE, '\'\'','\''),
																	L.MAKE));
self.MAKE	:= StringLib.StringCleanSpaces(tempMake);
TempName	:= Watercraft_preprocess.fn_concat_name_KS(L.FIRST_NAME,L.LAST_NAME); //Trying to piece together buiness names in the correct order
self.NAME	:= ut.CleanSpacesAndUpper(TempName);
self.FIRST_NAME	:= ut.CleanSpacesAndUpper(L.FIRST_NAME);
self.MID	:= ut.CleanSpacesAndUpper(L.MID);
self.LAST_NAME	:= ut.CleanSpacesAndUpper(L.LAST_NAME);
self.ADDRESS_1	:= ut.CleanSpacesAndUpper(IF(StringLib.StringFind(L.ADDRESS_1,'HIWAY',1) > 0, StringLib.StringFindReplace(L.ADDRESS_1,'HIWAY','HIGHWAY'),L.ADDRESS_1));
self.CITY	:= ut.CleanSpacesAndUpper(L.CITY);
self.STATE	:= ut.CleanSpacesAndUpper(L.STATE);
self.TOILET	:= ut.CleanSpacesAndUpper(L.TOILET);
self.HP	:= REGEXREPLACE('[0-9]',L.HP,'');
self.STATUS	:= ut.CleanSpacesAndUpper(L.status);
self	:= L;
END;

EXPORT file_KS_clean_in := project(fIn_raw,CleanTrimRaw(left));