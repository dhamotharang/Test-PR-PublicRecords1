import watercraft, watercraft_preprocess, ut, lib_StringLib;

fIn_raw := watercraft_preprocess.Files_raw.OR_;

//Trim and uppercase all fields prior to mapping
Watercraft.layout_or_new_14q3 CleanTrimRaw(fIn_raw L) := TRANSFORM
	self.STATEABREV	:= ut.CleanSpacesAndUpper(L.STATEABREV);
	self.REG_NUM		:= ut.CleanSpacesAndUpper(L.REG_NUM);
	tempHullId			:= ut.CleanSpacesAndUpper(L.HULL_ID);
	self.HULL_ID 		:= IF(REGEXFIND('NHN|UNK|UNKNOWN',tempHullId), REGEXREPLACE('NHN|UNK|UNKNOWN',tempHullId,''), tempHullId);
	self.PROP				:= ut.CleanSpacesAndUpper(L.PROP);
	self.VEH_TYPE		:= ut.CleanSpacesAndUpper(L.VEH_TYPE);
	self.FUEL				:= ut.CleanSpacesAndUpper(L.FUEL);											
	self.HULL				:= ut.CleanSpacesAndUpper(L.HULL);
	self.USE_1			:= ut.CleanSpacesAndUpper(L.USE_1);
	tempMake				:= ut.CleanSpacesAndUpper(MAP(StringLib.StringFind(L.MAKE, '(DBA)',1) > 0 => StringLib.StringFindReplace(L.MAKE, '(DBA)',''),
																			StringLib.StringFind(L.MAKE, '\'\'',1) > 0 => StringLib.StringFindReplace(L.MAKE, '\'\'','\''),
																			L.MAKE));
	self.MAKE				:= StringLib.StringCleanSpaces(tempMake);
	self.NAME				:= ut.CleanSpacesAndUpper(L.NAME);
	self.ADDRESS_1	:= IF(REGEXFIND('^[^A-Z0-9_]',L.ADDRESS_1),REGEXREPLACE('^[^A-Z0-9_]',L.ADDRESS_1,''),ut.CleanSpacesAndUpper(L.ADDRESS_1));
	self.CITY				:= ut.CleanSpacesAndUpper(L.CITY);
	self.STATE			:= ut.CleanSpacesAndUpper(L.STATE);
	self.ZIP				:= ut.CleanSpacesAndUpper(L.ZIP);
	self.VESSEL_NAME				:= ut.CleanSpacesAndUpper(L.VESSEL_NAME);
	self.PUBLIC_ASSET_FLAG	:= ut.CleanSpacesAndUpper(L.PUBLIC_ASSET_FLAG);
	self.PUBLIC_OWNER				:= ut.CleanSpacesAndUpper(L.PUBLIC_OWNER);
	self.PROPULSION					:= ut.CleanSpacesAndUpper(L.PROPULSION);
	self.ENGINE_DRIVE_TYPE	:= ut.CleanSpacesAndUpper(L.ENGINE_DRIVE_TYPE);
	self.CO_OWNER						:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.CO_OWNER,'|','&'));
	self.LIENHOLDER					:= ut.CleanSpacesAndUpper(L.LIENHOLDER);
	self	:= L;
END;

EXPORT file_OR_clean_in := project(fIn_raw,CleanTrimRaw(left));