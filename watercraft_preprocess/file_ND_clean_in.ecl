import watercraft, watercraft_preprocess, ut, lib_StringLib;

fIn_raw := watercraft_preprocess.Files_raw.ND;

CompSuffix		:= '(FARM|SUPPLY|SERVICE$|REPAIR|FUND |COOPERATIVE|CONSTRUCTORS| CO$|AUTO |^BOAT|PROPERTIES|ENGINEERING|'+
									 ' LLC$|,LLC$|^INC | INC$| TRUST$|PRODUCTS|MARINE|MARINA|^OF |CITY |CREDIT UNION|BROTHERS|EQUIPMENT|'+
									'TELEPHONE|REALTY|RECREATION|FIRE DEPT|SCHOOL$| LTD$|LAKE|ENTERPRISE|CENTER$|SPORT|PARK|COMMUNITY|^CITY)';

//Trim and uppercase all fields prior to mapping
Watercraft.layout_ND_20Q3 CleanTrimRaw(fIn_raw L) := TRANSFORM
self.STATEDATA	:= ut.CleanSpacesAndUpper(L.STATEDATA);
self.REG_NUM		:= ut.CleanSpacesAndUpper(L.REG_NUM);
self.HULL_ID		:= ut.CleanSpacesAndUpper(REGEXREPLACE('^[^A-Z0-9]',L.HULL_ID,''));
self.PROP			:= ut.CleanSpacesAndUpper(L.PROP);
self.VEH_TYPE	:= ut.CleanSpacesAndUpper(L.VEH_TYPE);
self.FUEL			:= ut.CleanSpacesAndUpper(L.FUEL);											
self.HULL			:= ut.CleanSpacesAndUpper(L.HULL);
self.USE_1		:= ut.CleanSpacesAndUpper(L.USE_1);
tempMake			:= ut.CleanSpacesAndUpper(MAP(StringLib.StringFind(L.MAKE, '(DBA)',1) > 0 => StringLib.StringFindReplace(L.MAKE, '(DBA)',''),
																		StringLib.StringFind(L.MAKE, '\'\'',1) > 0 => StringLib.StringFindReplace(L.MAKE, '\'\'','\''),
																		L.MAKE));
self.MAKE			:= StringLib.StringCleanSpaces(tempMake);
tempFName			:= ut.CleanSpacesAndUpper(L.FIRST_NAME);
tempMidName		:= ut.CleanSpacesAndUpper(MAP(StringLib.StringFind(L.MID,'.',1) > 0 => StringLib.StringFindReplace(L.MID,'.',''),
																				StringLib.StringFind(L.MID,'`',1) > 0 => StringLib.StringFindReplace(L.MID,'`',''),
																				L.MID));
tempLName			:= ut.CleanSpacesAndUpper(L.LAST_NAME);
//Attempt to put business name in the proper order using key words
self.NAME				:= StringLib.StringCleanSpaces(MAP(L.FIRST_NAME = '&' => tempLName+' '+tempFName+' '+tempMidName,
																								L.FIRST_NAME = 'US ' => tempFName+' '+tempLName,
																								REGEXFIND('^INC',L.FIRST_NAME) => tempLName+' '+tempFName,
																								L.MID = '&' => tempLName+' '+tempFName,
																								StringLib.StringFind(L.LAST_NAME,'&',1)> 0 => tempLName+' '+tempFName+' '+tempMidName,
																								REGEXFIND('^INC',L.LAST_NAME) => tempFName+' '+tempLName,
																								watercraft_preprocess.is_company(L.LAST_NAME)=1 AND StringLib.StringFind(L.LAST_NAME,'CITY',1)>0 => tempLName+' '+tempFName,
																								watercraft_preprocess.is_company(L.LAST_NAME)=1 AND StringLib.StringFind(L.LAST_NAME,'COUNTY',1)>0 => tempLName+' '+tempFName,
																								watercraft_preprocess.is_company(L.FIRST_NAME)=1 AND REGEXFIND(CompSuffix,tempFName) => tempLName+' '+tempFName+' '+tempMidName,
																								tempFName+' '+tempMidName+' '+tempLName));
												
self.FIRST_NAME	:= tempFName;
self.MID				:= tempMidName;
self.LAST_NAME	:= tempLName;
self.ADDRESS_1	:= IF(REGEXFIND('^[^A-Z0-9_]',L.ADDRESS_1),REGEXREPLACE('^[^A-Z0-9_]',L.ADDRESS_1,''),ut.CleanSpacesAndUpper(L.ADDRESS_1));
self.CITY				:= ut.CleanSpacesAndUpper(L.CITY);
self.STATE			:= ut.CleanSpacesAndUpper(L.STATE);
self.ZIP				:= ut.CleanSpacesAndUpper(L.ZIP);
self.US_MANUFACTURED	:= ut.CleanSpacesAndUpper(L.US_MANUFACTURED);
self.USE_STATE				:= ut.CleanSpacesAndUpper(L.USE_STATE);
self.ND_PURCHASE_TYPE_CD	:= ut.CleanSpacesAndUpper(L.ND_PURCHASE_TYPE_CD);
self	:= L;
END;

EXPORT file_ND_clean_in := project(fIn_raw,CleanTrimRaw(left));