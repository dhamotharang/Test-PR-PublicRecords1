import watercraft, watercraft_preprocess, ut, lib_StringLib;

fIn_raw := watercraft_preprocess.Files_raw.GA;

//Trim and uppercase fields prior to mapping
Watercraft.Layout_GA_new14Q2 CleanTrimRaw(fIn_raw L) := TRANSFORM
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
																	REGEXFIND('^-',L.MAKE) => StringLib.StringFindReplace(L.MAKE, '-',''),
																	L.MAKE));
self.MAKE	:= StringLib.StringCleanSpaces(tempMake);
self.TOTAL_INCH := ut.CleanSpacesAndUpper(L.TOTAL_INCH);
ClnMid		:= StringLib.StringFindReplace(L.MID,'`','');
TempName := watercraft_preprocess.fn_concat_name_GA(L.FIRST_name,L.LAST_name,ClnMid,L.SUFFIX);
self.NAME	:= ut.CleanSpacesAndUpper(TempName);
self.FIRST_NAME	:= ut.CleanSpacesAndUpper(L.FIRST_name);
self.MID	:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.MID,'`',''));
self.LAST_NAME	:= ut.CleanSpacesAndUpper(L.LAST_name);
self.ADDRESS_1	:= IF(REGEXFIND('^-',L.ADDRESS_1),StringLib.StringFindReplace(L.ADDRESS_1, '-',''),ut.CleanSpacesAndUpper(L.ADDRESS_1));
self.CITY	:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^#[0-9](.*)',L.CITY), REGEXREPLACE('^#[0-9](.*)',L.CITY,''),L.CITY));
self.STATE	:= ut.CleanSpacesAndUpper(L.STATE);
self.COUNTY	:= ut.CleanSpacesAndUpper(L.COUNTY);
self.ZIP	:= MAP(length(TRIM(L.ZIP,LEFT,RIGHT)) = 1 => StringLib.StringFindReplace(L.ZIP,'-',''),
								length(TRIM(L.ZIP,LEFT,RIGHT)) = 6 => StringLib.StringFindReplace(L.ZIP,'-',''),
								TRIM(L.ZIP,LEFT,RIGHT));
self.OWN_TYPE	:= ut.CleanSpacesAndUpper(L.OWN_TYPE);
self.LENGTH_CLASS	:= ut.CleanSpacesAndUpper(L.LENGTH_CLASS);
self.PROPULSION	:= ut.CleanSpacesAndUpper(L.PROPULSION);
self.ENGINE_DRIVE	:= ut.CleanSpacesAndUpper(L.ENGINE_DRIVE);
self.TOILET	:= ut.CleanSpacesAndUpper(L.TOILET);
self	:= L;
END;

EXPORT file_GA_clean_in := project(fIn_raw,CleanTrimRaw(left));