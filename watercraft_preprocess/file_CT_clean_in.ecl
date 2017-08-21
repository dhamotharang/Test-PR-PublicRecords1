import watercraft, watercraft_preprocess, ut, lib_StringLib;

fIn_raw := watercraft_preprocess.Files_raw.CT;

InvalidData := '^NONE|^UNKNOWN';
IsCompany := 'L L C|INC | MGT ';
Trusts	:= 'LIVING TRUST |TRUST ';

//Trim and uppercase fields prior to mapping
Watercraft.layout_CT_2015Q3 CleanTrimRaw(fIn_raw L) := TRANSFORM
self.STATEABREV	:= ut.CleanSpacesAndUpper(L.STATEABREV);
self.REG_NUM		:= ut.CleanSpacesAndUpper(L.REG_NUM);
tempHullID			:= ut.CleanSpacesAndUpper(L.HULL_ID);
self.HULL_ID 		:= MAP(REGEXFIND(InvalidData, tempHullID) => REGEXREPLACE(InvalidData,tempHullID,''),
											REGEXFIND('[^A-Z0-9_]',tempHullID) => REGEXREPLACE('[^A-Z0-9_]',tempHullID,''),
											tempHullID);
self.PROP			:= ut.CleanSpacesAndUpper(L.PROP);
self.VEH_TYPE	:= ut.CleanSpacesAndUpper(L.VEH_TYPE);
self.FUEL			:= ut.CleanSpacesAndUpper(L.FUEL);											
self.HULL			:= ut.CleanSpacesAndUpper(L.HULL);
self.USE_1		:= ut.CleanSpacesAndUpper(L.USE_1);
tempMake			:= ut.CleanSpacesAndUpper(MAP(StringLib.StringFind(L.MAKE, '(DBA)',1) > 0 => StringLib.StringFindReplace(L.MAKE, '(DBA)',''),
																	REGEXFIND('^[^A-Z0-9_]',L.MAKE) => REGEXREPLACE('^[^A-Z0-9_]',L.MAKE,''),
																	L.MAKE));
self.MAKE			:= StringLib.StringCleanSpaces(tempMake);
ClnName				:= ut.CleanSpacesAndUpper(MAP(StringLib.StringFind(L.NAME,'`',1) > 0 => StringLib.StringFindReplace(L.NAME,'`',''),
																			StringLib.StringFind(L.NAME,',',1) > 0 =>	REGEXREPLACE(',AND | AND |,OR  | OR | JNT|',L.NAME,''),L.NAME));
ClnSecondName	:= ut.CleanSpacesAndUpper(MAP(StringLib.StringFind(L.SEC_OWNER,'{',1) > 0 => StringLib.StringFindReplace(L.SEC_OWNER,'{',''),
																				REGEXFIND('^OR ',L.SEC_OWNER) => StringLib.StringFindReplace(L.SEC_OWNER,'OR ',''),
																				REGEXFIND('^AND ',L.SEC_OWNER) => StringLib.StringFindReplace(L.SEC_OWNER,'AND ',''),
																				REGEXFIND('^THE ',L.SEC_OWNER) => StringLib.StringFindReplace(L.SEC_OWNER,'THE ',''),L.SEC_OWNER));
self.NAME			:= IF(watercraft_preprocess.is_company(L.NAME)=1 AND trim(L.NAME,left,right) <> trim(L.SEC_OWNER,left,right) AND
										(watercraft_preprocess.is_company(L.SEC_OWNER)=1 or REGEXFIND(IsCompany,L.SEC_OWNER)),
										StringLib.StringCleanSpaces(ClnName+' '+ClnSecondName),
										IF(watercraft_preprocess.is_company(L.NAME)=0 AND REGEXFIND(Trusts,L.SEC_OWNER),StringLib.StringCleanSpaces(ClnName+' '+ClnSecondName),
											IF(REGEXFIND('^AUTHORITY ',L.SEC_OWNER),StringLib.StringCleanSpaces(ClnName+' '+ClnSecondName),ClnName)));
self.FIRST_NAME	:= ut.CleanSpacesAndUpper(L.FIRST_NAME);
self.MID				:= ut.CleanSpacesAndUpper(L.MID);
self.LAST_NAME	:= ut.CleanSpacesAndUpper(L.LAST_NAME);
self.ADDRESS_1	:= ut.CleanSpacesAndUpper(L.ADDRESS_1);
self.CITY				:= ut.CleanSpacesAndUpper(L.CITY);
self.STATE			:= ut.CleanSpacesAndUpper(L.STATE);
self.ZIP				:= StringLib.StringFindReplace(L.ZIP,'00000','');
self.PRIMARY_NAME_SUFFIX		:= ut.CleanSpacesAndUpper(L.PRIMARY_NAME_SUFFIX);
self.PRIMARY_OWNER_ADDRESS1	:= ut.CleanSpacesAndUpper(L.PRIMARY_OWNER_ADDRESS1);
self.PRIMARY_OWNER_ADDRESS2	:= ut.CleanSpacesAndUpper(L.PRIMARY_OWNER_ADDRESS2);
self.PRIMARY_OWNER_CITY			:= ut.CleanSpacesAndUpper(L.PRIMARY_OWNER_CITY);
self.PRIMARY_OWNER_STATE		:= ut.CleanSpacesAndUpper(L.PRIMARY_OWNER_STATE);
self.PRIMARY_OWNER_ZIP			:= StringLib.StringFindReplace(L.PRIMARY_OWNER_ZIP,'00000','');
ClnLastName									:= MAP(REGEXFIND('^OR ',L.SEC_OWNER_LASTNAME) => StringLib.StringFindReplace(L.SEC_OWNER_LASTNAME,'OR ',''),
																	 REGEXFIND('^AND ',L.SEC_OWNER_LASTNAME) => StringLib.StringFindReplace(L.SEC_OWNER_LASTNAME,'AND ',''),
																	 REGEXFIND('^THE ',L.SEC_OWNER_LASTNAME) => StringLib.StringFindReplace(L.SEC_OWNER_LASTNAME,'THE ',''),L.SEC_OWNER_LASTNAME);
self.SEC_OWNER_LASTNAME			:= ut.CleanSpacesAndUpper(ClnLastName);
self.SEC_OWNER_FIRSTNAME		:= ut.CleanSpacesAndUpper(L.SEC_OWNER_FIRSTNAME);
self.SEC_OWNER_MIDDLENAME		:= ut.CleanSpacesAndUpper(L.SEC_OWNER_MIDDLENAME);
self.SEC_OWNER_NAME_SUFFIX	:= ut.CleanSpacesAndUpper(L.SEC_OWNER_NAME_SUFFIX);
self.SEC_OWNER						:= IF(watercraft_preprocess.is_company(L.NAME)=1 AND watercraft_preprocess.is_company(L.SEC_OWNER)=1,'',
																IF(REGEXFIND(Trusts,L.SEC_OWNER) or REGEXFIND(IsCompany,L.SEC_OWNER),'',
																	IF(REGEXFIND('^AUTHORITY ',L.SEC_OWNER),REGEXREPLACE('AUTHORITY ',L.SEC_OWNER,''),ClnSecondName)));;
self.SEC_OWNER_ADDRESS1			:= ut.CleanSpacesAndUpper(L.SEC_OWNER_ADDRESS1);
self.SEC_OWNER_ADDRESS2			:= ut.CleanSpacesAndUpper(L.SEC_OWNER_ADDRESS2);
self.SEC_OWNER_CITY					:= ut.CleanSpacesAndUpper(L.SEC_OWNER_CITY);
self.SEC_OWNER_STATE				:= ut.CleanSpacesAndUpper(L.SEC_OWNER_STATE);
self.SEC_OWNER_ZIP					:= StringLib.StringFindReplace(L.SEC_OWNER_ZIP,'00000','');
self.HP					:= REGEXREPLACE('[^0-9]',L.HP,'');
self.MODEL			:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.MODEL), REGEXREPLACE('^[^A-Z0-9_]',L.MODEL,''),L.MODEL));
self.PRIMARY_COLOR		:= ut.CleanSpacesAndUpper(L.PRIMARY_COLOR);
self.SECONDARY_COLOR	:= ut.CleanSpacesAndUpper(L.SECONDARY_COLOR);
self.STATUS						:= ut.CleanSpacesAndUpper(L.STATUS);
self.FEE1_DESCRIPTION	:= ut.CleanSpacesAndUpper(L.FEE1_DESCRIPTION);
self.FEE2_DESCRIPTION	:= ut.CleanSpacesAndUpper(L.FEE2_DESCRIPTION);
self.FEE3_DESCRIPTION	:= ut.CleanSpacesAndUpper(L.FEE3_DESCRIPTION);
self.FEE4_DESCRIPTION	:= ut.CleanSpacesAndUpper(L.FEE4_DESCRIPTION);
self.FEE5_DESCRIPTION	:= ut.CleanSpacesAndUpper(L.FEE5_DESCRIPTION);
self.FEE6_DESCRIPTION	:= ut.CleanSpacesAndUpper(L.FEE6_DESCRIPTION);
self.FEE7_DESCRIPTION	:= ut.CleanSpacesAndUpper(L.FEE7_DESCRIPTION);
self.FEE8_DESCRIPTION	:= ut.CleanSpacesAndUpper(L.FEE8_DESCRIPTION);
self.FEE9_DESCRIPTION	:= ut.CleanSpacesAndUpper(L.FEE9_DESCRIPTION);
self.FEE10_DESCRIPTION	:= ut.CleanSpacesAndUpper(L.FEE10_DESCRIPTION);
self.LIENHOLDER1_FIRSTNAME	:= ut.CleanSpacesAndUpper(L.LIENHOLDER1_FIRSTNAME);
self.LIENHOLDER1_LASTNAME		:= ut.CleanSpacesAndUpper(L.LIENHOLDER1_LASTNAME);
self.LIENHOLDER1_MIDDLENAME	:= ut.CleanSpacesAndUpper(L.LIENHOLDER1_MIDDLENAME);
self.LIENHOLDER1_SUFFIX			:= ut.CleanSpacesAndUpper(L.LIENHOLDER1_SUFFIX);
self.LIENHOLDER1_ORG_NAME		:= ut.CleanSpacesAndUpper(L.LIENHOLDER1_ORG_NAME);
self.LIENHOLDER1_ADDRESS1		:= ut.CleanSpacesAndUpper(L.LIENHOLDER1_ADDRESS1);
self.LIENHOLDER1_ADDRESS2		:= ut.CleanSpacesAndUpper(L.LIENHOLDER1_ADDRESS2);
self.LIENHOLDER1_CITY				:= ut.CleanSpacesAndUpper(L.LIENHOLDER1_CITY);
self.LIENHOLDER1_STATE			:= ut.CleanSpacesAndUpper(L.LIENHOLDER1_STATE);
self.LIENHOLDER1_ZIP				:= StringLib.StringFindReplace(L.LIENHOLDER1_ZIP,'00000','');
self		:= L;
END;

EXPORT file_CT_clean_in := project(fIn_raw,CleanTrimRaw(left));