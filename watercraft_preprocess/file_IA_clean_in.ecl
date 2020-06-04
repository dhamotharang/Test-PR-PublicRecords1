import watercraft, watercraft_preprocess, ut, lib_StringLib;

fIn_raw := watercraft_preprocess.Files_raw.IA;

//Trim and uppercase fields prior to mapping
Watercraft.Layout_IA_new CleanTrimRaw(fIn_raw L) := TRANSFORM
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
self.NAME	:= ut.CleanSpacesAndUpper(L.NAME);
self.FIRST_NAME	:= ut.CleanSpacesAndUpper(L.FIRST_NAME);
self.MID	:= ut.CleanSpacesAndUpper(L.MID);
self.LAST_NAME	:= ut.CleanSpacesAndUpper(L.LAST_NAME);
self.ADDRESS_1	:= ut.CleanSpacesAndUpper(L.ADDRESS_1);
self.CITY	:= ut.CleanSpacesAndUpper(L.CITY);
self.STATE	:= ut.CleanSpacesAndUpper(L.STATE);
self.COUNTY	:= ut.CleanSpacesAndUpper(L.COUNTY);
self.MODEL	:= ut.CleanSpacesAndUpper(REGEXREPLACE('^\'',L.MODEL,''));
self.COLOR	:= ut.CleanSpacesAndUpper(L.COLOR);
//self.NAME2	:= ut.CleanSpacesAndUpper(L.NAME2); //currently blank
self.CUST_EMAIL	:= ut.CleanSpacesAndUpper(L.CUST_EMAIL);
self	:= L;
END;

EXPORT file_IA_clean_in := project(fIn_raw,CleanTrimRaw(left));