import watercraft, watercraft_preprocess, ut, lib_StringLib;

fIn_raw := watercraft_preprocess.Files_raw.NE;

//Trim and uppercase all fields prior to mapping
Watercraft.layout_ne_20q1_new CleanTrimRaw(fIn_raw L) := TRANSFORM
	self.STATEABREV	:= ut.CleanSpacesAndUpper(L.STATEABREV);
	self.REG_NUM		:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.REG_NUM), REGEXREPLACE('^[^A-Z0-9_]',L.REG_NUM,''), L.REG_NUM));
	self.HULL_ID 		:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.HULL_ID), REGEXREPLACE('^[^A-Z0-9_]',L.HULL_ID,''), L.HULL_ID));
	self.PROP				:= ut.CleanSpacesAndUpper(L.PROP);
	self.FUEL				:= ut.CleanSpacesAndUpper(L.FUEL);											
	self.HULL				:= ut.CleanSpacesAndUpper(L.HULL);
	tempMake				:= ut.CleanSpacesAndUpper(MAP(StringLib.StringFind(L.MAKE, '(DBA)',1) > 0 => StringLib.StringFindReplace(L.MAKE, '(DBA)',''),
																			StringLib.StringFind(L.MAKE, '\'\'',1) > 0 => StringLib.StringFindReplace(L.MAKE, '\'\'','\''),
																			L.MAKE));
	self.MAKE				:= StringLib.StringCleanSpaces(tempMake);
	self.NAME				:= ut.CleanSpacesAndUpper(L.NAME);
	self.ADDRESS_1	:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Za-z0-9_]',L.ADDRESS_1), REGEXREPLACE('^[^A-Za-z0-9_]',L.ADDRESS_1,''),L.ADDRESS_1));
	self.CITY				:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.CITY, '?',''));
	self.STATE			:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.STATE, '?',''));
	self.ZIP				:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.ZIP, '?',''));
	self.COUNTY			:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.COUNTY, '?',''));
	self.MODEL_DESC	:= ut.CleanSpacesAndUpper(L.MODEL_DESC);
	self.TITLE_TYPE	:= ut.CleanSpacesAndUpper(L.TITLE_TYPE);
	self.PREVIOUS_TITLE_ZIP	:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.PREVIOUS_TITLE_ZIP, '?',''));
	self.TITLE_STATE				:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.TITLE_STATE, '?',''));
	self.OWNER_TYPE					:= ut.CleanSpacesAndUpper(L.OWNER_TYPE);
	self.TITLE_REG					:= ut.CleanSpacesAndUpper(L.TITLE_REG);
	self.PREVIOUS_OWNER			:= ut.CleanSpacesAndUpper(L.PREVIOUS_OWNER);
	self.TITLE_ADDRESS_2		:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Za-z0-9_]',L.TITLE_ADDRESS_2), REGEXREPLACE('^[^A-Za-z0-9_]',L.TITLE_ADDRESS_2,''),L.TITLE_ADDRESS_2));
	self.PREVIOUS_TITLE_CITY	:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.PREVIOUS_TITLE_CITY, '?',''));
	SELF.TITLE_NUMBER					:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.TITLE_NUMBER, '?',''));
	SELF.PREVIOUS_TITLE_STATE	:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.PREVIOUS_TITLE_STATE, '?',''));
	//self.DUPLICATE_TITLE		:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.DUPLICATE_TITLE, '?',''));
	//self.PREVIOUS_OWNER_STATE	:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.PREVIOUS_OWNER_STATE, '?',''));
	self	:= L;
END;

EXPORT file_NE_clean_in := project(fIn_raw,CleanTrimRaw(left));