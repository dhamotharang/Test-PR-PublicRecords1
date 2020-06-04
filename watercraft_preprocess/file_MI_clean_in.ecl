import watercraft, watercraft_preprocess, ut, lib_StringLib;

fIn_raw := watercraft_preprocess.Files_raw.MI;

InvalidData := ['UNK','UN ','NONE','NA ','0 ','UNKOWN','BADHINGIVEN','N/A'];

//Trim and uppercase all fields prior to mapping
Watercraft.layout_mi_new CleanTrimRaw(fIn_raw L) := TRANSFORM
self.STATEABREV	:= ut.CleanSpacesAndUpper(L.STATEABREV);
self.REG_NUM		:= ut.CleanSpacesAndUpper(L.REG_NUM);
ClnHull					:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.HULL_ID), REGEXREPLACE('^[^A-Z0-9_]',L.HULL_ID,''), L.HULL_ID));
self.HULL_ID 		:= MAP(StringLib.StringFind(ClnHull,'UNKNOWN',1) > 0 => StringLib.StringFindReplace(ClnHull,'UNKNOWN',''),
											StringLib.StringFind(ClnHull,'UNK ',1) > 0 => StringLib.StringFindReplace(ClnHull,'UNK ',''),
											StringLib.StringFind(ClnHull,'UN ',1) > 0 => StringLib.StringFindReplace(ClnHull,'UN ',''),
											StringLib.StringFind(ClnHull,'NONE',1) > 0 => StringLib.StringFindReplace(ClnHull,'NONE',''),
											StringLib.StringFind(ClnHull,'NA ',1) > 0 => StringLib.StringFindReplace(ClnHull,'NA ',''),
												REGEXFIND('^0+',ClnHull) => REGEXREPLACE('^0+',ClnHull,''),ClnHull);
self.PROP			:= ut.CleanSpacesAndUpper(L.PROP);
self.VEH_TYPE	:= ut.CleanSpacesAndUpper(L.VEH_TYPE);
self.FUEL			:= ut.CleanSpacesAndUpper(L.FUEL);											
self.HULL			:= ut.CleanSpacesAndUpper(L.HULL);
self.USE_1		:= ut.CleanSpacesAndUpper(L.USE_1);
tempMake			:= ut.CleanSpacesAndUpper(MAP(StringLib.StringFind(L.MAKE, '(DBA)',1) > 0 => StringLib.StringFindReplace(L.MAKE, '(DBA)',''),
																	StringLib.StringFind(L.MAKE, '\'\'',1) > 0 => StringLib.StringFindReplace(L.MAKE, '\'\'','\''),
																	L.MAKE));
self.MAKE			:= StringLib.StringCleanSpaces(tempMake);
self.NAME			:= REGEXREPLACE(' AND$',ut.CleanSpacesAndUpper(L.NAME),'');
self.ADDRESS_1	:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Za-z0-9_]',L.ADDRESS_1), REGEXREPLACE('^[^A-Za-z0-9_]',L.ADDRESS_1,''),L.ADDRESS_1));
self.CITY				:= ut.CleanSpacesAndUpper(L.CITY);
self.STATE			:= ut.CleanSpacesAndUpper(L.STATE);
self.ZIP				:= ut.CleanSpacesAndUpper(L.ZIP);
self := L;
END;

EXPORT file_MI_clean_in := project(fIn_raw,CleanTrimRaw(left));