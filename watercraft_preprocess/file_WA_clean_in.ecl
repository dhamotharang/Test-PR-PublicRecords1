import watercraft, watercraft_preprocess, ut, lib_StringLib;

fIn_raw := watercraft_preprocess.Files_raw.WA;

//Trim and uppercase all fields prior to mapping
Watercraft.layout_WA CleanTrimRaw(fIn_raw L) := TRANSFORM
	self.STATEABREV	:= ut.CleanSpacesAndUpper(L.STATEABREV);
	self.REG_NUM		:= ut.CleanSpacesAndUpper(L.REG_NUM);
	tempHullID			:= ut.CleanSpacesAndUpper(REGEXREPLACE('^[^A-Z0-9]',L.HULL_ID,''));
	self.HULL_ID 		:= IF(REGEXFIND('^UNKNOWN|^UNK |^NA |^NONE[0-9]+|^NONE |^SHIRLEY|^X+|^MARI|^DEBBY|^MIKE',tempHullID),
												REGEXREPLACE('^UNKNOWN|^UNK |^NA |^NONE[0-9]+|^NONE |^SHIRLEY|^X+|^MARI|^DEBBY|^MIKE',tempHullID,''),
												tempHullID);
	self.PROP				:= ut.CleanSpacesAndUpper(L.PROP);
	self.VEH_TYPE		:= ut.CleanSpacesAndUpper(L.VEH_TYPE);
	self.FUEL				:= ut.CleanSpacesAndUpper(L.FUEL);									
	self.HULL				:= ut.CleanSpacesAndUpper(L.HULL);
	self.USE				:= ut.CleanSpacesAndUpper(L.USE);
	tempMake				:= ut.CleanSpacesAndUpper(MAP(StringLib.StringFind(L.MAKE, '(DBA)',1) > 0 => StringLib.StringFindReplace(L.MAKE, '(DBA)',''),
																			StringLib.StringFind(L.MAKE, '\'\'',1) > 0 => StringLib.StringFindReplace(L.MAKE, '\'\'','\''),
																			L.MAKE));
	self.MAKE				:= StringLib.StringCleanSpaces(tempMake);
	self.NAME				:= ut.CleanSpacesAndUpper(L.NAME);
	self.ADDRESS_1	:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.ADDRESS_1),REGEXREPLACE('^[^A-Z0-9_]',L.ADDRESS_1,''),L.ADDRESS_1));
	self.CITY				:= ut.CleanSpacesAndUpper(L.CITY);
	self.STATE			:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.STATE,'XX',''));
	self.ZIP				:= ut.CleanSpacesAndUpper(L.ZIP);
	self.COUNTY_OF_MOORAGE	:= ut.CleanSpacesAndUpper(L.COUNTY_OF_MOORAGE);
	self.TITLE_NUMBER				:= ut.CleanSpacesAndUpper(REGEXREPLACE('<SELECTUP>',L.TITLE_NUMBER,''));
	self.REG_OWNER_NAME_2		:= ut.CleanSpacesAndUpper(L.REG_OWNER_NAME_2);
	self.REG_OWNER_ADDRESS_2	:= ut.CleanSpacesAndUpper(REGEXREPLACE('^`|~',L.REG_OWNER_ADDRESS_2,''));
	self.LEGAL_OWNER_NAME_1		:= ut.CleanSpacesAndUpper(L.LEGAL_OWNER_NAME_1);
	self.LEGAL_OWNER_NAME_2		:= ut.CleanSpacesAndUpper(L.LEGAL_OWNER_NAME_2);
	self.LEGAL_OWNER_ADDRESS_1	:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.LEGAL_OWNER_ADDRESS_1,'\\ O BOX','PO BOX'));
	self.LEGAL_OWNER_ADDRESS_2	:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.LEGAL_OWNER_ADDRESS_2,'`',''));
	self.LEGAL_OWNER_ADDRESS_3	:= ut.CleanSpacesAndUpper(L.LEGAL_OWNER_ADDRESS_3);
	self.LEGAL_OWNER_ADDRESS_4	:= ut.CleanSpacesAndUpper(L.LEGAL_OWNER_ADDRESS_4);
	self.LEGAL_OWNER_CITY				:= ut.CleanSpacesAndUpper(L.LEGAL_OWNER_CITY);
	self.LEGAL_OWNER_STATE			:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.LEGAL_OWNER_STATE,'XX',''));
	self.LEGAL_OWNER_ZIP5				:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.LEGAL_OWNER_ZIP5,'X',''));
	self.LEGAL_OWNER_ZIP4				:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.LEGAL_OWNER_ZIP5,'-',''));
	self	:= L;
END;

EXPORT file_WA_clean_in := project(fIn_raw,CleanTrimRaw(left));