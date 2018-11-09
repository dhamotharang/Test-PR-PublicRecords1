import watercraft, watercraft_preprocess, ut, lib_StringLib;

fIn_raw := watercraft_preprocess.Files_raw.MS;
setValidSuffix	:= ['JR','SR','II','III','IV','VI','VII','VIII','IX'];
setNamePrefix		:= ['MC ','LA ','DE ','O '];
SetNameTitle		:= ['MRS','SHERIFF'];
CompSuffixFirst	:= ['AFB','CO ','WELFARE'];
CompSuffixMid		:= ['RENTALS','FARMS','FARM','CONST ','SUPPLY','RESORT','FISHERIES','SERVICE','REPAIR','HARBOR','WATER ','FUND ','CONSTRUCTORS',
										'RECREATIONS','NAVY','LINCOLN CO','SUPPORT','TIMBER','AUTO ','CIVIL ','BOATS'];
CompSuffixLast	:= ['INC','COMPANY','BEACH','RECREATION',' LLC','CORPORATION','STORE',' DEPT','INSURANCE','DISTRICT','SUPERVISOR','SALES',' DIST','AND MAPPING LLC'];

//Trim and uppercase all fields prior to mapping
Watercraft.layout_ms_new CleanTrimRaw(fIn_raw L) := TRANSFORM
self.STATEABREV	:= ut.CleanSpacesAndUpper(L.STATEABREV);
self.REG_NUM		:= ut.CleanSpacesAndUpper(REGEXREPLACE('^[^A-Z0-9]',L.REG_NUM,''));
self.HULL_ID		:= ut.CleanSpacesAndUpper(L.HULL_ID);
self.PROP			:= ut.CleanSpacesAndUpper(L.PROP);
self.VEH_TYPE	:= ut.CleanSpacesAndUpper(L.VEH_TYPE);
self.FUEL			:= ut.CleanSpacesAndUpper(L.FUEL);											
self.HULL			:= ut.CleanSpacesAndUpper(L.HULL);
self.USE_1		:= ut.CleanSpacesAndUpper(L.USE_1);
tempMake			:= ut.CleanSpacesAndUpper(MAP(StringLib.StringFind(L.MAKE, '(DBA)',1) > 0 => StringLib.StringFindReplace(L.MAKE, '(DBA)',''),
																		StringLib.StringFind(L.MAKE, '\'\'',1) > 0 => StringLib.StringFindReplace(L.MAKE, '\'\'','\''),
																		L.MAKE));
self.MAKE			:= StringLib.StringCleanSpaces(tempMake);

//Clean parsed name and use key words to try and concat company name from parsed name
tempFName			:= ut.CleanSpacesAndUpper(L.FIRST_NAME);
tempMid				:= StringLib.StringFindReplace(ut.CleanSpacesAndUpper(L.MID),'NULL','');
tempLName			:= ut.CleanSpacesAndUpper(L.LAST_NAME);
SetFirst			:= IF(tempLName in SetNameTitle,tempLName,
										IF(tempLName in setNamePrefix and tempMid not in setValidSuffix,tempMid,
											IF(tempLName in setNamePrefix and tempMid in setValidSuffix,tempLName,tempFName)));
SetMid				:= IF(tempLName in SetNameTitle,tempFName,
										IF(tempLName in setNamePrefix and tempMid in setValidSuffix,tempFName,
											IF(tempLName in setNamePrefix and tempMid not in setValidSuffix,tempLName,tempMid)));
SetLast				:= IF(tempLName in SetNameTitle,tempMid,
										IF(tempLName not in setNamePrefix and tempLName not in SetNameTitle and tempMid not in setValidSuffix,tempLName,
											IF(tempLName in setNamePrefix and tempMid not in setValidSuffix,tempFName,tempMid)));
tempName			:= If(SetFirst in CompSuffixFirst, SetMid+' '+SetLast+' '+SetFirst,
										IF(SetMid in CompSuffixMid and SetLast not in CompSuffixLast and SetFirst <> 'STATE', SetLast+' '+SetFirst+' '+SetMid,
											SetFirst+' '+SetMid+' '+SetLast));
self.NAME			:= StringLib.StringCleanSpaces(tempName);
self.FIRST_NAME	:= tempFName;
self.MID				:= tempMid;
self.LAST_NAME	:= tempLName;
self.ADDRESS_1	:= IF(REGEXFIND('^[^A-Z0-9_]',L.ADDRESS_1),REGEXREPLACE('^[^A-Z0-9_]',L.ADDRESS_1,''),ut.CleanSpacesAndUpper(L.ADDRESS_1));
self.CITY				:= ut.CleanSpacesAndUpper(L.CITY);
self.STATE			:= ut.CleanSpacesAndUpper(L.STATE);
// self.BOAT_TYPE_CODE	:= ut.CleanSpacesAndUpper(L.BOAT_TYPE_CODE);		//DF-19984 - Layout change, deleted
// self.STATUS			:= ut.CleanSpacesAndUpper(L.STATUS);										//DF-19984 - Layout change, deleted
self.SUFFIX			:= ut.CleanSpacesAndUpper(L.SUFFIX);											//DF-19984 - Layout change, new field
self	:= L;
END;

EXPORT file_MS_clean_in := project(fIn_raw,CleanTrimRaw(left));