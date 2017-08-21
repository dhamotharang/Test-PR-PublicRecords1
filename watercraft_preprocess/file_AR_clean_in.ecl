import watercraft, watercraft_preprocess, ut, lib_StringLib;

fIn_raw := watercraft_preprocess.Files_raw.AR;

//Trim and uppercase fields prior to mapping
 Watercraft.layout_AR CleanTrimRaw(fIn_raw L) := TRANSFORM
self.STATEABREV	:= ut.CleanSpacesAndUpper(L.STATEABREV);
self.REG_NUM		:= ut.CleanSpacesAndUpper(L.REG_NUM);
self.PROP			:= ut.CleanSpacesAndUpper(L.PROP);
self.VEH_TYPE	:= ut.CleanSpacesAndUpper(L.VEH_TYPE);
self.FUEL			:= ut.CleanSpacesAndUpper(L.FUEL);
tempHullID		:= ut.CleanSpacesAndUpper(L.HULL_ID);
self.HULL_ID	:= IF(REGEXFIND('[^A-Z0-9_]',tempHullID),REGEXREPLACE('[^A-Z0-9_]',tempHullID,''),tempHullID);
self.HULL		:= ut.CleanSpacesAndUpper(L.HULL);
self.USE_1	:= ut.CleanSpacesAndUpper(L.USE_1);
tempMake		:= ut.CleanSpacesAndUpper(L.MAKE);
self.MAKE 	:= StringLib.StringCleanSpaces(IF(StringLib.StringFind(tempMake, '(DBA)',1) > 0,StringLib.StringFindReplace(tempMake, '(DBA)',''),tempMake));
self.TOTAL_INCH := ut.CleanSpacesAndUpper(L.TOTAL_INCH);
self.NAME				:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.NAME,'`',''));
self.ADDRESS_1	:= ut.CleanSpacesAndUpper(IF(REGEXFIND('P O BOX',L.ADDRESS_1), REGEXREPLACE('P O BOX',L.ADDRESS_1,'PO BOX'),L.ADDRESS_1));
self.CITY				:= ut.CleanSpacesAndUpper(L.CITY);
self.STATE			:= ut.CleanSpacesAndUpper(L.STATE);
self.ZIP				:= map(REGEXFIND('[^0-9]',L.ZIP) => REGEXREPLACE('[^0-9]',L.ZIP,''),
											 REGEXFIND('00000|99999',L.ZIP) => REGEXREPLACE('00000|99999',L.ZIP,''),L.ZIP);
self.COUNTY			:= ut.CleanSpacesAndUpper(L.COUNTY);
self.MOTOR			:= ut.CleanSpacesAndUpper(L.MOTOR);
self.SERIAL			:= ut.CleanSpacesAndUpper(L.SERIAL);
self.SecondOwner_LastName		:= ut.CleanSpacesAndUpper(L.SecondOwner_LastName);
self.SecondOwner_FirstName	:= ut.CleanSpacesAndUpper(L.SecondOwner_FirstName);
self.SecondOwner_MidName		:= ut.CleanSpacesAndUpper(L.SecondOwner_MidName);
self := L;
self := [];
END;

EXPORT file_AR_clean_in := project(fIn_raw,CleanTrimRaw(left));