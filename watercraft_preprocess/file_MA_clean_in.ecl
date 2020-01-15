import watercraft, watercraft_preprocess, ut, lib_StringLib;

fIn_raw := watercraft_preprocess.Files_raw.MA;

//Trim and uppercase fields prior to mapping
Watercraft.Layout_MA_new CleanTrimRaw(fIn_raw L) := TRANSFORM
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
ClnMidName	:= REGEXREPLACE('^\'',L.MID,'');
TempName		:= Watercraft_preprocess.fn_concat_name_MA(L.FIRST_NAME,ClnMidName,L.LAST_NAME); //Concat names in order to handle business names and multiple names
self.NAME		:= ut.CleanSpacesAndUpper(TempName);
self.FIRST_NAME	:= ut.CleanSpacesAndUpper(IF(length(L.FIRST_NAME)=1 and trim(L.FIRST_NAME,left,right) = '.',
																			StringLib.StringFindReplace(L.FIRST_NAME,'.',''),L.FIRST_NAME));
self.MID	:= ut.CleanSpacesAndUpper(ClnMidName);
self.LAST_NAME	:= ut.CleanSpacesAndUpper(L.LAST_NAME);
ClnPunctAddr		:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.ADDRESS_1,'!',''));
self.ADDRESS_1	:= MAP(REGEXFIND('P O |P.O. |P. O. ',ClnPunctAddr) => REGEXREPLACE('P O |P.O. |P. O. ',ClnPunctAddr,'PO '),
												REGEXFIND('^BOX ',ClnPunctAddr) => REGEXREPLACE('^BOX ',ClnPunctAddr,'PO BOX '),
												ClnPunctAddr);
self.CITY	:= ut.CleanSpacesAndUpper(L.CITY);
self.STATE	:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^A-Z0-9]',L.STATE,''));
self.ZIP	:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.ZIP,'WOODS HOLE',''));
self.DESCRIPTION	:= ut.CleanSpacesAndUpper(L.DESCRIPTION);
self.STATUS	:= ut.CleanSpacesAndUpper(L.STATUS);
self.COLOR_TYP_CODE_PRIMARY	:= ut.CleanSpacesAndUpper(L.COLOR_TYP_CODE_PRIMARY);
self.COLOR_TYP_CODE_SECONDARY	:= ut.CleanSpacesAndUpper(L.COLOR_TYP_CODE_SECONDARY);
self.PCTL_TYP_CODE	:= ut.CleanSpacesAndUpper(L.PCTL_TYP_CODE);
self.STORAGETOWN	:= ut.CleanSpacesAndUpper(L.STORAGETOWN);
self.ENG_MN_TYP_CODE	:= ut.CleanSpacesAndUpper(L.ENG_MN_TYP_CODE);
self.ENG_YEAR	:= REGEXREPLACE('[^0-9]',L.ENG_YEAR,' ');
self.SERIAL_NUMBER	:= StringLib.StringFindReplace(L.SERIAL_NUMBER,'\'','');
self	:= L;
END;

EXPORT file_MA_clean_in := project(fIn_raw,CleanTrimRaw(left));