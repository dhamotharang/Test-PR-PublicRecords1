import watercraft, watercraft_preprocess, ut, lib_StringLib;

fIn_raw := watercraft_preprocess.Files_raw.ME;

//Trim and uppercase all fields prior to mapping
Watercraft.layout_me CleanTrimRaw(fIn_raw L) := TRANSFORM
self.STATEABREV	:= ut.CleanSpacesAndUpper(L.STATEABREV);
self.REG_NUM		:= ut.CleanSpacesAndUpper(L.REG_NUM);
tempHullID			:= ut.CleanSpacesAndUpper(L.HULL_ID);
self.HULL_ID 		:= MAP(REGEXFIND('UNKNOWN', tempHullID) => REGEXREPLACE('UNKNOWN',tempHullID,''),
											REGEXFIND('^[^A-Z0-9_]',tempHullID) => REGEXREPLACE('^[^A-Z0-9_]',tempHullID,''),
											tempHullID);
self.PROP			:= ut.CleanSpacesAndUpper(L.PROP);
self.VEH_TYPE	:= ut.CleanSpacesAndUpper(L.VEH_TYPE);
self.FUEL			:= ut.CleanSpacesAndUpper(L.FUEL);											
self.HULL			:= ut.CleanSpacesAndUpper(L.HULL);
self.USE_1		:= ut.CleanSpacesAndUpper(L.USE_1);
tempMake			:= ut.CleanSpacesAndUpper(MAP(StringLib.StringFind(L.MAKE, '(DBA)',1) > 0 => StringLib.StringFindReplace(L.MAKE, '(DBA)',''),
																	StringLib.StringFind(L.MAKE, '\'\'',1) > 0 => StringLib.StringFindReplace(L.MAKE, '\'\'','\''),
																	L.MAKE));
self.MAKE			:= StringLib.StringCleanSpaces(tempMake);
ClnFName			:= ut.CleanSpacesAndUpper(If(REGEXFIND('^[^A-Z0-9_]',L.FIRST_NAME), REGEXREPLACE('^[^A-Z0-9_]',L.FIRST_NAME,''),L.FIRST_NAME));
ClnMName			:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^&|^/',TRIM(L.MID,LEFT,RIGHT)), REGEXREPLACE('&|/',L.MID,'AND '),L.MID));
ClnLName			:= ut.CleanSpacesAndUpper(If(REGEXFIND('^[^A-Z]',L.LAST_NAME), REGEXREPLACE('^[^A-Z]',L.LAST_NAME,''),L.LAST_NAME));
self.NAME			:= StringLib.StringCleanSpaces(StringLib.StringFilterOut((ClnFName+' '+ClnMName+' '+ClnLName+' '+L.SUFFIX),'.'));
self.FIRST_NAME	:= ut.CleanSpacesAndUpper(L.FIRST_NAME);
//self.MID				:= StringLib.StringCleanSpaces(IF(REGEXFIND('[^A-Z0-9_]',ClnMName),REGEXREPLACE('[^A-Z0-9_]',ClnMName,''),ClnMName));
self.MID				:= ut.CleanSpacesAndUpper(L.MID);
self.LAST_NAME	:= ut.CleanSpacesAndUpper(L.LAST_NAME);
self.ADDRESS_1	:= IF(REGEXFIND('^[^A-Z0-9_]',L.ADDRESS_1),REGEXREPLACE('^[^A-Z0-9_]',L.ADDRESS_1,''),ut.CleanSpacesAndUpper(L.ADDRESS_1));
self.CITY				:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[0-9](.*)',L.CITY), REGEXREPLACE('^[0-9](.*)',L.CITY,''),L.CITY));
self.STATE			:= ut.CleanSpacesAndUpper(L.STATE);
self.VEH_TYPE2	:= ut.CleanSpacesAndUpper(L.VEH_TYPE2);
self.TRANSACTION_TYPE	:= ut.CleanSpacesAndUpper(L.TRANSACTION_TYPE);
tempVehStatus		:= ut.CleanSpacesAndUpper(L.VEHICLE_STATUS);
// self.VEHICLE_STATUS	:= MAP(tempVehStatus = 'DISCON' => 'DISCONTINUED',
														// tempVehStatus = 'DESTRO' => 'DESTROYED',
														// tempVehStatus = 'DOCUME' => 'DOCUMENTED',
														// tempVehStatus = 'LOST/S' => 'LOST/STOLEN',
														// tempVehStatus);
self.VEHICLE_STATUS	:= tempVehStatus;
self.CLASS		:= ut.CleanSpacesAndUpper(L.CLASS);
self.WATERS		:= ut.CleanSpacesAndUpper(L.WATERS);
self.COLOR		:= ut.CleanSpacesAndUpper(L.COLOR);
self.SUFFIX		:= ut.CleanSpacesAndUpper(L.SUFFIX);
self.BUSINESS_NAME		:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.BUSINESS_NAME),
																						REGEXREPLACE('^[^A-Z0-9_]',L.BUSINESS_NAME,''),
																						L.BUSINESS_NAME));
self.BUSINESS_CONTACT	:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.BUSINESS_CONTACT),
																						REGEXREPLACE('^[^A-Z0-9_]',L.BUSINESS_CONTACT,''),
																						L.BUSINESS_CONTACT));
self.RESIDENCE_ADDRESS	:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.RESIDENCE_ADDRESS),
																						REGEXREPLACE('^[^A-Z0-9_]',L.RESIDENCE_ADDRESS,''),
																						L.RESIDENCE_ADDRESS));
self.RESIDENCE_ADDRESS2	:= ut.CleanSpacesAndUpper(L.RESIDENCE_ADDRESS2);
self.RESIDENCE_TOWN			:= ut.CleanSpacesAndUpper(L.RESIDENCE_TOWN);
self.RESIDENCE_ST				:= ut.CleanSpacesAndUpper(L.RESIDENCE_ST);
self.RESIDENCE_COUNTRY	:= ut.CleanSpacesAndUpper(L.RESIDENCE_COUNTRY);
self.LEGAL_TOWN					:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.LEGAL_TOWN),
																						REGEXREPLACE('^[^A-Z0-9_]',L.LEGAL_TOWN,''),
																						L.LEGAL_TOWN));
self.LEGAL_ST						:= ut.CleanSpacesAndUpper(L.LEGAL_ST);
self.LEGAL_COUNTRY			:= ut.CleanSpacesAndUpper(L.LEGAL_COUNTRY);
// self.SECONDARY_OWNER		:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[0-9]+',L.SECONDARY_OWNER) AND NOT REGEXFIND('[A-Za-z]+',L.SECONDARY_OWNER),
																							// REGEXREPLACE('[0-9]+',L.SECONDARY_OWNER,''),L.SECONDARY_OWNER));
self.AGENT_NAME					:= ut.CleanSpacesAndUpper(L.AGENT_NAME);
self	:= L;
END;														

EXPORT file_ME_clean_in := project(fIn_raw,CleanTrimRaw(left));