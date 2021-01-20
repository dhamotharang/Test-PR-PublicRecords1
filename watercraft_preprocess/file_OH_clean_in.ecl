import watercraft, watercraft_preprocess, ut, lib_StringLib;

fIn_raw := watercraft_preprocess.Files_raw.OH;

//Trim and uppercase all fields prior to mapping
Watercraft.layout_OH_20Q3 CleanTrimRaw(fIn_raw L) := TRANSFORM
	self.STATEABREV	:= ut.CleanSpacesAndUpper(L.STATEABREV);
	self.REG_NUM		:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.REG_NUM), REGEXREPLACE('^[^A-Z0-9_]',L.REG_NUM,''), L.REG_NUM));
	self.HULL_ID 		:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.HULL_ID), REGEXREPLACE('^[^A-Z0-9_]',L.HULL_ID,''), L.HULL_ID));
	self.PROP				:= ut.CleanSpacesAndUpper(L.PROP);
	self.VEH_TYPE		:= ut.CleanSpacesAndUpper(L.VEH_TYPE);
	self.FUEL				:= ut.CleanSpacesAndUpper(L.FUEL);											
	self.HULL				:= ut.CleanSpacesAndUpper(L.HULL);
	self.USE_1			:= ut.CleanSpacesAndUpper(L.USE_1);
	tempMake				:= ut.CleanSpacesAndUpper(MAP(StringLib.StringFind(L.MAKE, '(DBA)',1) > 0 => StringLib.StringFindReplace(L.MAKE, '(DBA)',''),
																			StringLib.StringFind(L.MAKE, '\'\'',1) > 0 => StringLib.StringFindReplace(L.MAKE, '\'\'','\''),
																			L.MAKE));
	self.MAKE				:= StringLib.StringCleanSpaces(tempMake);
	self.REG_DATE		:= IF(L.REG_DATE = '21400819', '20140819',L.REG_DATE);
	tempFName				:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.FIRST_NAME,'`',''));
	tempMidName			:= ut.CleanSpacesAndUpper(MAP(StringLib.StringFind(L.MID,'.',1) > 0 => StringLib.StringFindReplace(L.MID,'.',''),
																				StringLib.StringFind(L.MID,'`',1) > 0 => StringLib.StringFindReplace(L.MID,'`',''),
																				L.MID));
	tempLName				:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.LAST_NAME,'`',''));
	self.FIRST_NAME	:= IF(tempFName = '&',tempLName,tempFName);
	self.MID				:= IF(tempFName = '&',tempFName,tempMidName);
	self.LAST_NAME	:= IF(tempFName = '&',tempMidName,tempLName);
	self.ADDRESS_1	:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.ADDRESS_1),REGEXREPLACE('^[^A-Z0-9_]',L.ADDRESS_1,''),L.ADDRESS_1));
	ClnCity					:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.CITY,'`',''));
	self.CITY				:= IF(ClnCity = ',ASON','MASON',ClnCity);
	ClnState				:= ut.CleanSpacesAndUpper(L.STATE);
	self.STATE			:= MAP(ClnState = 'O' => 'OH',
													ClnState = 'H' => 'OH',
													ClnState);
	self.ZIP				:= ut.CleanSpacesAndUpper(L.ZIP);
	self.WATER_USE	:= ut.CleanSpacesAndUpper(L.WATER_USE);
	self.MODEL			:= ut.CleanSpacesAndUpper(L.MODEL);
	self.REG_STATUS	:= ut.CleanSpacesAndUpper(L.REG_STATUS);
	self.EXPIRATION_DATE	:= IF(L.EXPIRATION_DATE = '20700301','20170301',
															IF(L.EXPIRATION_DATE = '70000201','20170301',L.EXPIRATION_DATE));
	self	:= L;
END;

EXPORT file_OH_clean_in := project(fIn_raw,CleanTrimRaw(left));