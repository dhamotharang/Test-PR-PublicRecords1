import watercraft, watercraft_preprocess, ut, lib_StringLib;

fIn_raw := watercraft_preprocess.Files_raw.AL;

InvalidData := '^NONE|^NA |PLEASE PROVIDE|NOTLISTED|^UKN |^UNKN |^UNK |UNKNOWN|^NOSN |^NO SN|^NS |^INC |^UK ';

//Trim and uppercase fields prior to mapping
Watercraft.Layout_AL_fixed CleanTrimRaw(fIn_raw L) := TRANSFORM
self.STATEABREV		:= ut.CleanSpacesAndUpper(L.STATEABREV);
self.REG_NUM			:= ut.CleanSpacesAndUpper(L.REG_NUM);
tempHullID				:= ut.CleanSpacesAndUpper(L.HULL_ID);
self.HULL_ID 			:= MAP(REGEXFIND(InvalidData, tempHullID) => REGEXREPLACE(InvalidData,tempHullID,''),
												REGEXFIND('^X+',tempHullID) => REGEXREPLACE('X',tempHullID,''),
												REGEXFIND('[^A-Z0-9_]',tempHullID) => REGEXREPLACE('[^A-Z0-9_]',tempHullID,''),
												tempHullID);
self.PROP					:= ut.CleanSpacesAndUpper(L.PROP);
self.VEH_TYPE			:= ut.CleanSpacesAndUpper(L.VEH_TYPE);
self.FUEL					:= ut.CleanSpacesAndUpper(L.FUEL);											
self.HULL					:= ut.CleanSpacesAndUpper(L.HULL);
self.USE_1				:= ut.CleanSpacesAndUpper(L.USE_1);
tempMake					:= ut.CleanSpacesAndUpper(MAP(StringLib.StringFind(L.MAKE, '(DBA)',1) > 0 => StringLib.StringFindReplace(L.MAKE, '(DBA)',''),
																				StringLib.StringFind(L.MAKE, '\'\'',1) > 0 => StringLib.StringFindReplace(L.MAKE, '\'\'','\''),
																				REGEXFIND('^0',L.MAKE) => StringLib.StringFindReplace(L.MAKE, '0',''),
																				L.MAKE));
self.MAKE					:= StringLib.StringCleanSpaces(tempMake);
self.TOTAL_INCH 	:= ut.CleanSpacesAndUpper(L.TOTAL_INCH);
self.NAME					:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.NAME,'`',''));
self.ADDRESS_1		:= ut.CleanSpacesAndUpper(L.ADDRESS_1);
self.CITY					:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.CITY,'*',''));
self.STATE				:= ut.CleanSpacesAndUpper(L.STATE);
self.ZIP					:= MAP(StringLib.StringFind(L.ZIP,'.',1) > 0 => StringLib.StringFindReplace(L.ZIP,'.',''),
												StringLib.StringFind(L.ZIP,'`',1) > 0 => StringLib.StringFindReplace(L.ZIP,'`',''),
												L.ZIP);
self.COUNTY				:= ut.CleanSpacesAndUpper(L.COUNTY);
tempEngineNum			:= ut.CleanSpacesAndUpper(L.ENGINE_NUM);
self.ENGINE_NUM 	:= MAP(REGEXFIND('[^A-Z0-9_]',tempEngineNum) => REGEXREPLACE('[^A-Z0-9_]',tempEngineNum,''),
													REGEXFIND('^X+',tempEngineNum) => REGEXREPLACE('X',tempEngineNum,''),
													REGEXFIND(InvalidData, tempEngineNum) => REGEXREPLACE(InvalidData,tempEngineNum,''),tempEngineNum);
tempEngineMake		:= ut.CleanSpacesAndUpper(L.ENGINE_MAKE);
self.ENGINE_MAKE	:= MAP(REGEXFIND('^X+',tempEngineMake) => REGEXREPLACE('X',tempEngineMake,''),
												 REGEXFIND('^PLEASE PROVIDE',tempEngineMake) => REGEXREPLACE('PLEASE PROVIDE',tempEngineMake,''),
													REGEXFIND('^0+',tempEngineMake) => REGEXREPLACE('0',tempEngineMake,''),tempEngineMake);
self.DOB					:= IF(L.DOB = '20000101', '', L.DOB);		//logic taken from watercraft.fn_clnName	
self := L;
END;

EXPORT file_AL_clean_in := project(fIn_raw,CleanTrimRaw(left));