import watercraft, watercraft_preprocess, ut, lib_StringLib;

fIn_raw := watercraft_preprocess.Files_raw.VA;

//Trim and uppercase all fields prior to mapping
Watercraft.layout_va CleanTrimRaw(fIn_raw L) := TRANSFORM
	self.STATEABREV	:= ut.CleanSpacesAndUpper(L.STATEABREV);
	self.REG_NUM		:= ut.CleanSpacesAndUpper(L.REG_NUM);
	self.HULL_ID 		:= ut.CleanSpacesAndUpper(MAP(REGEXFIND('^[^A-Z0-9_]',L.HULL_ID) => REGEXREPLACE('^[^A-Z0-9_]',L.HULL_ID,''),
																					REGEXFIND('^NONE|UNKNOWN|NA ',L.HULL_ID) => REGEXREPLACE('^NONE|UNKNOWN|NA ',L.HULL_ID,''),
																					L.HULL_ID));
	self.PROP				:= ut.CleanSpacesAndUpper(L.PROP);
	self.VEH_TYPE		:= ut.CleanSpacesAndUpper(L.VEH_TYPE);
	self.FUEL				:= ut.CleanSpacesAndUpper(L.FUEL);											
	self.HULL				:= ut.CleanSpacesAndUpper(L.HULL);
	self.USE_1			:= ut.CleanSpacesAndUpper(L.USE_1);
	tempMake				:= ut.CleanSpacesAndUpper(MAP(StringLib.StringFind(L.MAKE, '(DBA)',1) > 0 => StringLib.StringFindReplace(L.MAKE, '(DBA)',''),
																			StringLib.StringFind(L.MAKE, '\'\'',1) > 0 => StringLib.StringFindReplace(L.MAKE, '\'\'','\''),
																			L.MAKE));
	self.MAKE				:= StringLib.StringCleanSpaces(tempMake);
	self.REG_DATE		:= ut.CleanSpacesAndUpper(L.REG_DATE);
	self.FIRST_NAME	:= ut.CleanSpacesAndUpper(L.FIRST_NAME);
	self.MID				:= ut.CleanSpacesAndUpper(IF(L.MID <> '&' AND REGEXFIND('^[^A-Z]',L.MID), REGEXREPLACE('^[^A-Z]',L.MID,''),L.MID));
	self.LAST_NAME	:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.LAST_NAME,'`',''));
	self.ADDRESS_1	:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.ADDRESS_1), REGEXREPLACE('^[^A-Z0-9_]',L.ADDRESS_1,''),L.ADDRESS_1));
	self.CITY				:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.CITY), REGEXREPLACE('^[^A-Z0-9_]',L.CITY,''),L.CITY));
	self.STATE			:= ut.CleanSpacesAndUpper(L.STATE);
	self.ZIP				:= ut.CleanSpacesAndUpper(IF(REGEXFIND('[^0-9_]',L.ZIP), REGEXREPLACE('[^0-9_]',L.ZIP,''),L.ZIP));
	self.ENGINEMAKE	:= ut.CleanSpacesAndUpper(L.ENGINEMAKE);
	self.ENGSERIAL	:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.ENGSERIAL), REGEXREPLACE('^[^A-Z0-9_]',L.ENGSERIAL,''),L.ENGSERIAL));
	self.BOAT_CST		:= ut.CleanSpacesAndUpper(L.BOAT_CST);
	self.PREV_NUM		:= ut.CleanSpacesAndUpper(L.PREV_NUM);
	self.ADDRESS2		:= ut.CleanSpacesAndUpper(MAP(StringLib.StringFind(L.ADDRESS2,'.',1) > 0 => StringLib.StringFindReplace(L.ADDRESS2,'.',''),
																				 LENGTH(TRIM(L.ADDRESS2,LEFT,RIGHT)) = 1 => '',L.ADDRESS2));
	self.ACT_MIL		:= ut.CleanSpacesAndUpper(L.ACT_MIL);
	self.HOME_PHONE := ut.CleanPhone(L.HOME_PHONE);
	self.WORK_PHONE	:= ut.CleanPhone(L.WORK_PHONE);
	self.FIPS_DOCKED	:= ut.CleanSpacesAndUpper(L.FIPS_DOCKED);
	self.FIPS_USED		:= ut.CleanSpacesAndUpper(L.FIPS_USED);
	self := L;
END;

EXPORT file_VA_clean_in := project(fIn_raw,CleanTrimRaw(left));