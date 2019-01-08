import watercraft, watercraft_preprocess, ut, lib_StringLib;

fIn_raw := watercraft_preprocess.Files_raw.TX;

//Trim and uppercase all fields prior to mapping
Watercraft.layout_tx_new_18q3 CleanTrimRaw(fIn_raw L) := TRANSFORM
	self.STATEABREV	:= ut.CleanSpacesAndUpper(L.STATEABREV);
	self.REG_NUM		:= ut.CleanSpacesAndUpper(L.REG_NUM);
	self.HULL_ID 		:= ut.CleanSpacesAndUpper(L.HULL_ID);
	self.PROP				:= ut.CleanSpacesAndUpper(L.PROP);
	self.VEH_TYPE		:= ut.CleanSpacesAndUpper(L.VEH_TYPE);
	self.FUEL				:= ut.CleanSpacesAndUpper(IF(L.FUEL = 'GASOLINE','GAS',L.FUEL));	//standardize name of all definitions										
	self.HULL				:= ut.CleanSpacesAndUpper(L.HULL);
	self.USE_1			:= ut.CleanSpacesAndUpper(L.USE_1);
	tempMake				:= ut.CleanSpacesAndUpper(MAP(StringLib.StringFind(L.MAKE, '(DBA)',1) > 0 => StringLib.StringFindReplace(L.MAKE, '(DBA)',''),
																			StringLib.StringFind(L.MAKE, '\'\'',1) > 0 => StringLib.StringFindReplace(L.MAKE, '\'\'','\''),
																			L.MAKE));
	self.MAKE				:= StringLib.StringCleanSpaces(tempMake);
	tempFName				:= ut.CleanSpacesAndUpper(MAP(StringLib.StringFind(L.FIRST_NAME,'`',1) > 0 => StringLib.StringFindReplace(L.FIRST_NAME,'`',''),
																				REGEXFIND('^&',L.FIRST_NAME) => REGEXREPLACE('^&',L.FIRST_NAME,''),
																				L.FIRST_NAME));
	tempMidName			:= ut.CleanSpacesAndUpper(MAP(StringLib.StringFind(L.MID,'.',1) > 0 => StringLib.StringFindReplace(L.MID,'.',''),
																				StringLib.StringFind(L.MID,'`',1) > 0 => StringLib.StringFindReplace(L.MID,'`',''),
																				StringLib.StringFind(L.MID,'$',1) > 0 => StringLib.StringFindReplace(L.MID,'$',''),
																				L.MID));
	tempLName				:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.LAST_NAME,'`',''));
	self.FIRST_NAME	:= IF(REGEXFIND('(_+)&',tempFName),REGEXREPLACE('(_+)&',tempFName,''),
												IF(StringLib.StringFind(tempLName,'&',1)>0 AND tempFName <> '','',
													IF(StringLib.StringFind(tempFName,' LLC',1)>0 AND tempLName <> '','',tempFName)));
	self.MID				:= IF(StringLib.StringFind(tempLName,'&',1)>0 AND tempFName <> '','',tempMidName);
	self.LAST_NAME	:= StringLib.StringCleanSpaces(IF(StringLib.StringFind(tempLName,'&',1)>0 AND tempFName <> '', tempLName+' '+tempFName+' '+tempMidName,
																									IF(StringLib.StringFind(tempFName,' LLC',1)>0 AND tempLName <> '', tempLName+' '+tempFName, tempLName)));
	self.ADDRESS_1	:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.ADDRESS_1),REGEXREPLACE('^[^A-Z0-9_]',L.ADDRESS_1,''),L.ADDRESS_1));
	self.CITY				:= ut.CleanSpacesAndUpper(L.CITY);
	self.STATE			:= ut.CleanSpacesAndUpper(L.STATE);
//	self.ZIP				:= ut.CleanSpacesAndUpper(REGEXREPLACE('[A-Z]',L.ZIP,''));
	self.RECORD_TYPE	:= ut.CleanSpacesAndUpper(L.RECORD_TYPE);
	self.DECAL_NUMBER	:= ut.CleanSpacesAndUpper(L.DECAL_NUMBER);
	self.TITLE_NUMBER	:= ut.CleanSpacesAndUpper(L.TITLE_NUMBER);
	self.BONDED_TITLE_AUTHORIZATION_NUM	:= ut.CleanSpacesAndUpper(L.BONDED_TITLE_AUTHORIZATION_NUM);
	self.HULL_MATERIAL_OTHER			:= ut.CleanSpacesAndUpper(L.HULL_MATERIAL_OTHER);
	self.HULL_COLOR_PRIMARY				:= ut.CleanSpacesAndUpper(L.HULL_COLOR_PRIMARY);
	self.HULL_COLOR_PRIMARY_OTHER	:= ut.CleanSpacesAndUpper(L.HULL_COLOR_PRIMARY_OTHER);
	// self.HULL_COLOR_SECONDARY			:= ut.CleanSpacesAndUpper(L.HULL_COLOR_SECONDARY);
	// self.HULL_COLOR_SECONDARY_OTHER	:= ut.CleanSpacesAndUpper(L.HULL_COLOR_SECONDARY_OTHER);
	self.PROPULSION_OTHER					:= ut.CleanSpacesAndUpper(L.PROPULSION_OTHER);
	self.FUEL_OTHER								:= ut.CleanSpacesAndUpper(L.FUEL_OTHER);
	self.BOAT_CLASS								:= ut.CleanSpacesAndUpper(L.BOAT_CLASS);
	self.BOAT_TYPE_OTHER					:= ut.CleanSpacesAndUpper(L.BOAT_TYPE_OTHER);
	self.ADMINISTRATIVE_NOTIFICATION	:= ut.CleanSpacesAndUpper(L.ADMINISTRATIVE_NOTIFICATION);
	self.STATE_OF_PRINCIPAL_OP		:= ut.CleanSpacesAndUpper(L.STATE_OF_PRINCIPAL_OP);
	self.MTR_1_OUTDRIVE						:= ut.CleanSpacesAndUpper(REGEXREPLACE('^[^A-Z0-9_]',L.MTR_1_OUTDRIVE,''));
	self.MTR_1_SERIAL							:= ut.CleanSpacesAndUpper(REGEXREPLACE('^[^A-Z0-9_]',L.MTR_1_SERIAL,''));
	self.MTR_2_SERIAL							:= ut.CleanSpacesAndUpper(REGEXREPLACE('^[^A-Z0-9_]',L.MTR_2_SERIAL,''));
	self.STATE_BOAT_IS_FROM				:= ut.CleanSpacesAndUpper(L.STATE_BOAT_IS_FROM);
	self.USCG_DOCUMENT_NUMBER			:= ut.CleanSpacesAndUpper(L.USCG_DOCUMENT_NUMBER);
	self.USCG_TX_MARINE_LICENSEE_NUMBER	:= ut.CleanSpacesAndUpper(L.USCG_TX_MARINE_LICENSEE_NUMBER);
	self.USCG_BOAT_NAME						:= ut.CleanSpacesAndUpper(L.USCG_BOAT_NAME);
	self.USCG_PORT_CITY						:= ut.CleanSpacesAndUpper(L.USCG_PORT_CITY);
	self.USCG_PORT_STATE					:= ut.CleanSpacesAndUpper(L.USCG_PORT_STATE);
	self.PRIMARY_OWNER_SUFFIX			:= ut.CleanSpacesAndUpper(L.PRIMARY_OWNER_SUFFIX);
	self.PRIMARY_OWNER_COMPANY		:= ut.CleanSpacesAndUpper(L.PRIMARY_OWNER_COMPANY);
	self.PRIMARY_OWNER_PROVINCE		:= ut.CleanSpacesAndUpper(L.PRIMARY_OWNER_PROVINCE);
	self.PRIMARY_OWNER_DELIVERY_CODE	:= ut.CleanSpacesAndUpper(L.PRIMARY_OWNER_DELIVERY_CODE);
	self.PRIMARY_OWNER_COUNTRY_NAME		:= ut.CleanSpacesAndUpper(L.PRIMARY_OWNER_COUNTRY_NAME);
	self.PRIMARY_OWNER_ADDRESS_TYPE		:= ut.CleanSpacesAndUpper(L.PRIMARY_OWNER_ADDRESS_TYPE);
	self.PRIMARY_LIEN_LIENHOLDER_TYPE	:= ut.CleanSpacesAndUpper(L.PRIMARY_LIEN_LIENHOLDER_TYPE);
	self.PRIMARY_LIEN_LAST				:= ut.CleanSpacesAndUpper(L.PRIMARY_LIEN_LAST);
	self.PRIMARY_LIEN_FIRST				:= ut.CleanSpacesAndUpper(L.PRIMARY_LIEN_FIRST);
	self.PRIMARY_LIEN_MIDDLE			:= ut.CleanSpacesAndUpper(L.PRIMARY_LIEN_MIDDLE);
	self.PRIMARY_LIEN_SUFFIX			:= ut.CleanSpacesAndUpper(L.PRIMARY_LIEN_SUFFIX);
	self.PRIMARY_LIEN_BUSINESS		:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.PRIMARY_LIEN_BUSINESS,'`',''));
	tempPrimLienAddr1							:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.PRIMARY_LIEN_ADDRESS1),REGEXREPLACE('^[^A-Z0-9_]',L.PRIMARY_LIEN_ADDRESS1,''),L.PRIMARY_LIEN_ADDRESS1));
	self.PRIMARY_LIEN_ADDRESS1		:= IF(StringLib.StringFind(tempPrimLienAddr1,'P BPX',1) > 0, StringLib.StringFindReplace(tempPrimLienAddr1,'P BPX','PO BOX'),tempPrimLienAddr1);	
	self.PRIMARY_LIEN_ADDRESS2		:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.PRIMARY_LIEN_ADDRESS2),REGEXREPLACE('^[^A-Z0-9_]',L.PRIMARY_LIEN_ADDRESS2,''),L.PRIMARY_LIEN_ADDRESS2));
	self.PRIMARY_LIEN_CITY				:= ut.CleanSpacesAndUpper(IF(StringLib.StringFind(L.PRIMARY_LIEN_CITY,';AKE JACKSON',1) >0,StringLib.StringFindReplace(L.PRIMARY_LIEN_CITY,';AKE JACKSON','LAKE JACKSON'),L.PRIMARY_LIEN_CITY));
	self.PRIMARY_LIEN_STATE				:= ut.CleanSpacesAndUpper(L.PRIMARY_LIEN_STATE);
	self.PRIMARY_LIEN_ZIP					:= ut.CleanSpacesAndUpper(REGEXREPLACE('^[^0-9_]',L.PRIMARY_LIEN_ZIP,''));
	self.PRIMARY_LIEN_ZIP4				:= ut.CleanSpacesAndUpper(REGEXREPLACE('^[^0-9_]',L.PRIMARY_LIEN_ZIP4,''));
	self	:= L;
END;

EXPORT file_TX_clean_in := project(fIn_raw,CleanTrimRaw(left));