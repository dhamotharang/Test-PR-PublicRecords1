import watercraft, watercraft_preprocess, ut, lib_StringLib;

fIn_raw := watercraft_preprocess.Files_raw.FL;

Watercraft.layout_FL CleanTrimRaw(fIn_raw L) := TRANSFORM
self.STATEABREV	:= ut.CleanSpacesAndUpper(L.STATEABREV);
self.REG_NUM		:= ut.CleanSpacesAndUpper(L.REG_NUM);
tempHullID			:= ut.CleanSpacesAndUpper(L.HULL_ID);
self.HULL_ID 		:= IF(REGEXFIND('^[^A-Z0-9_]',tempHullID),REGEXREPLACE('^[^A-Z0-9_]',tempHullID,''),tempHullID);
self.PROP			:= ut.CleanSpacesAndUpper(L.PROP);
self.VEH_TYPE	:= ut.CleanSpacesAndUpper(L.VEH_TYPE);
self.FUEL			:= ut.CleanSpacesAndUpper(L.FUEL);											
self.HULL			:= ut.CleanSpacesAndUpper(L.HULL);
self.USE_1		:= ut.CleanSpacesAndUpper(L.USE_1);
tempMake			:= ut.CleanSpacesAndUpper(MAP(StringLib.StringFind(L.MAKE, '(DBA)',1) > 0 => StringLib.StringFindReplace(L.MAKE, '(DBA)',''),
																	StringLib.StringFind(L.MAKE, '\'\'',1) > 0 => StringLib.StringFindReplace(L.MAKE, '\'\'','\''),
																	L.MAKE));
self.MAKE			:= StringLib.StringCleanSpaces(tempMake);
self.NAME	:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.NAME,'`',''));
self.ADDRESS_1	:= ut.CleanSpacesAndUpper(L.ADDRESS_1);
self.CITY	:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.CITY,'UNKNOWN',''));
self.STATE	:= ut.CleanSpacesAndUpper(L.STATE);
self.ZIP	:= MAP(length(TRIM(L.ZIP,LEFT,RIGHT)) = 1 => StringLib.StringFindReplace(L.ZIP,'-',''),
								length(TRIM(L.ZIP,LEFT,RIGHT)) = 6 => StringLib.StringFindReplace(L.ZIP,'-',''),
								TRIM(L.ZIP,LEFT,RIGHT));
self.FIRST_REG_DATE := IF(L.FIRST_REG_DATE = '00000000','',L.FIRST_REG_DATE);
self.UNIT_NUMBER := ut.CleanSpacesAndUpper(IF(LENGTH(L.UNIT_NUMBER) = 1 AND REGEXFIND('[^A-Z0-9_]',L.UNIT_NUMBER), REGEXREPLACE('[^A-Z0-9_]',L.UNIT_NUMBER,''),L.UNIT_NUMBER));
self.OWN1_CUST_TYPE := ut.CleanSpacesAndUpper(L.OWN1_CUST_TYPE);
self.OWN1_DOB	:= IF(L.OWN1_DOB = '00000000','',L.OWN1_DOB);
self.OWN1_SEX	:= ut.CleanSpacesAndUpper(L.OWN1_SEX);
self.OWN1_SEX_PREDATOR_FLAG := ut.CleanSpacesAndUpper(L.OWN1_SEX_PREDATOR_FLAG);
self.OWN1_MAIL_SUPP_FLAG	:= ut.CleanSpacesAndUpper(L.OWN1_MAIL_SUPP_FLAG);
self.OWN1_ADDR_NON_DISCLOSE	:= ut.CleanSpacesAndUpper(L.OWN1_ADDR_NON_DISCLOSE); 	
self.OWN1_LAW_ENFOR_FLAG	:= ut.CleanSpacesAndUpper(L.OWN1_LAW_ENFOR_FLAG);
self.OWN1_FOREIGN_FLAG	:= ut.CleanSpacesAndUpper(L.OWN1_FOREIGN_FLAG);
self.OWN2_CUST_TYPE := ut.CleanSpacesAndUpper(L.OWN2_CUST_TYPE);
self.OWN2_CUSTOMER_NAME	:= ut.CleanSpacesAndUpper(L.OWN2_CUSTOMER_NAME);
self.OWN2_DOB	:= IF(L.OWN2_DOB = '00000000','',L.OWN2_DOB);
self.OWN2_SEX	:= ut.CleanSpacesAndUpper(L.OWN2_SEX);
self.OWN2_SEX_PREDATOR := ut.CleanSpacesAndUpper(L.OWN2_SEX_PREDATOR);
self.OWN2_MAIL_SUPP_FLAG	:= ut.CleanSpacesAndUpper(L.OWN2_MAIL_SUPP_FLAG);
self.OWN2_ADDR_NON_DISCLOSE	:= ut.CleanSpacesAndUpper(L.OWN2_ADDR_NON_DISCLOSE); 	
self.OWN2_LAW_ENFOR_FLAG	:= ut.CleanSpacesAndUpper(L.OWN2_LAW_ENFOR_FLAG);
self.OWN2_FOREIGN_FLAG	:= ut.CleanSpacesAndUpper(L.OWN2_FOREIGN_FLAG);
self.OWN2_ADDRESS	:= ut.CleanSpacesAndUpper(L.OWN2_ADDRESS);
self.OWN2_APT_NUMBER	:= ut.CleanSpacesAndUpper(L.OWN2_APT_NUMBER);
self.OWN2_CITY	:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.OWN2_CITY,'UNKNOWN',''));
self.OWN2_STATE	:= ut.CleanSpacesAndUpper(L.OWN2_STATE);
self.OWN2_ZIP	:= MAP(length(TRIM(L.OWN2_ZIP,LEFT,RIGHT)) = 1 => StringLib.StringFindReplace(L.OWN2_ZIP,'-',''),
								length(TRIM(L.OWN2_ZIP,LEFT,RIGHT)) = 6 => StringLib.StringFindReplace(L.OWN2_ZIP,'-',''),
								TRIM(L.OWN2_ZIP,LEFT,RIGHT));
self.LIC_PLATE_NUMBER :=  ut.CleanSpacesAndUpper(L.LIC_PLATE_NUMBER);
self.REG_EFFECTIVE_DATE	:= IF(L.REG_EFFECTIVE_DATE = '00000000','',L.REG_EFFECTIVE_DATE);
self.REG_EXPIRE_DATE	:= IF(L.REG_EXPIRE_DATE = '00000000','',L.REG_EXPIRE_DATE);
self.PLATE_ISSUE_DATE	:= IF(L.PLATE_ISSUE_DATE = '00000000','',L.PLATE_ISSUE_DATE);
self.DECAL_TYPE	:= ut.CleanSpacesAndUpper(L.DECAL_TYPE);
self.REG_STUS_CODE	:= ut.CleanSpacesAndUpper(L.REG_STUS_CODE);
self.REG_ONLY_REASON	:= ut.CleanSpacesAndUpper(L.REG_ONLY_REASON);
self.REG_USE	:= ut.CleanSpacesAndUpper(L.REG_USE);
self.VESSEL_RESIDENT_STATUS	:= ut.CleanSpacesAndUpper(L.VESSEL_RESIDENT_STATUS);
self.REGSTRANT1_TYPE	:= ut.CleanSpacesAndUpper(L.REGSTRANT1_TYPE);
self.REG1_NAME := ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.REG1_NAME,'`',''));
self.REG1_DOB	:= IF(L.REG1_DOB = '00000000','',L.REG1_DOB);
self.REG1_SEX	:= ut.CleanSpacesAndUpper(L.REG1_SEX);
self.REG1_SEX_PREDATOR	:= ut.CleanSpacesAndUpper(L.REG1_SEX_PREDATOR);
self.REG1_MAIL_SUPPRESS	:= ut.CleanSpacesAndUpper(L.REG1_MAIL_SUPPRESS);
self.REG1_ADD_NO_RELEASE	:= ut.CleanSpacesAndUpper(L.REG1_ADD_NO_RELEASE);
self.REG1_LAW_ENFORCE	:= ut.CleanSpacesAndUpper(L.REG1_LAW_ENFORCE);
self.REG1_FOREIGN_FLAG	:= ut.CleanSpacesAndUpper(L.REG1_FOREIGN_FLAG);
self.REG1_ADDRESS	:= ut.CleanSpacesAndUpper(L.REG1_ADDRESS);
self.REG1_APT_NO	:= ut.CleanSpacesAndUpper(L.REG1_APT_NO);
self.REG1_CITY	:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.REG1_CITY,'UNKNOWN',''));
self.REG1_STATE	:= ut.CleanSpacesAndUpper(L.REG1_STATE);
self.REG1_ZIP	:= MAP(length(TRIM(L.REG1_ZIP,LEFT,RIGHT)) = 1 => StringLib.StringFindReplace(L.REG1_ZIP,'-',''),
								length(TRIM(L.REG1_ZIP,LEFT,RIGHT)) = 6 => StringLib.StringFindReplace(L.REG1_ZIP,'-',''),
								TRIM(L.REG1_ZIP,LEFT,RIGHT));
self.REGIST2_CUST_TYPE := ut.CleanSpacesAndUpper(L.REGIST2_CUST_TYPE);
self.REG2_NAME := ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.REG2_NAME,'`',''));
self.REG2_DOB	:= IF(L.REG2_DOB = '00000000','',L.REG2_DOB);
self.REG2_SEX	:= ut.CleanSpacesAndUpper(L.REG2_SEX);
self.REG2_SEX_PREDATOR	:= ut.CleanSpacesAndUpper(L.REG2_SEX_PREDATOR);
self.REG2_MAIL_SUPPRESS	:= ut.CleanSpacesAndUpper(L.REG2_MAIL_SUPPRESS);
self.REG2_ADD_NO_RELEASE	:= ut.CleanSpacesAndUpper(L.REG2_ADD_NO_RELEASE);
self.REG2_LAW_ENFORCEMENT	:= ut.CleanSpacesAndUpper(L.REG2_LAW_ENFORCEMENT);
self.REG2_FOREIGN_FLAG	:= ut.CleanSpacesAndUpper(L.REG2_FOREIGN_FLAG);
self.REG2_ADDRESS	:= ut.CleanSpacesAndUpper(L.REG2_ADDRESS);
self.REG2_APT_NO	:= ut.CleanSpacesAndUpper(L.REG2_APT_NO);
self.REG2_CITY	:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.REG2_CITY,'UNKNOWN',''));
self.REG2_STATE	:= ut.CleanSpacesAndUpper(L.REG2_STATE);
self.REG2_ZIP	:= MAP(length(TRIM(L.REG2_ZIP,LEFT,RIGHT)) = 1 => StringLib.StringFindReplace(L.REG2_ZIP,'-',''),
								length(TRIM(L.REG2_ZIP,LEFT,RIGHT)) = 6 => StringLib.StringFindReplace(L.REG2_ZIP,'-',''),
								TRIM(L.REG2_ZIP,LEFT,RIGHT));
self.TITLE_ISSUE_DATE	:= IF(L.TITLE_ISSUE_DATE = '00000000','',L.TITLE_ISSUE_DATE);
self.PREVIUS_TITLE_DATE	:= IF(L.PREVIUS_TITLE_DATE = '00000000','',L.PREVIUS_TITLE_DATE);
self.TITLE_STATUS	:= ut.CleanSpacesAndUpper(L.TITLE_STATUS);
self.TITLE_TYPE	:= ut.CleanSpacesAndUpper(L.TITLE_TYPE);
self.PREVS_TITLE_STATE	:= ut.CleanSpacesAndUpper(L.PREVS_TITLE_STATE);
self.TITLE_PENDING	:= ut.CleanSpacesAndUpper(L.TITLE_PENDING);
self.DUP_TITLE_FLAG	:= ut.CleanSpacesAndUpper(L.DUP_TITLE_FLAG);
self.LH1_LIEN_DATE	:= IF(L.LH1_LIEN_DATE = '00000000','',L.LH1_LIEN_DATE);
self.LH1_HOLDR_TYPE	:= ut.CleanSpacesAndUpper(L.LH1_HOLDR_TYPE);
self.LH1_NAME	:= ut.CleanSpacesAndUpper(L.LH1_NAME);
self.LH1_DOB	:= IF(L.LH1_DOB = '00000000','',L.LH1_DOB);
self.LH1_SEX	:= ut.CleanSpacesAndUpper(L.LH1_SEX);
self.LH1_SEX_PREDATOR	:= ut.CleanSpacesAndUpper(L.LH1_SEX_PREDATOR);
self.LH1_MAIL_SUPPRESS	:= ut.CleanSpacesAndUpper(L.LH1_MAIL_SUPPRESS);
self.LH1_ADD_NO_RELEASE	:= ut.CleanSpacesAndUpper(L.LH1_ADD_NO_RELEASE);
self.LH1_LAW_ENFORCEMENT	:= ut.CleanSpacesAndUpper(L.LH1_LAW_ENFORCEMENT);
self.LH1_FOREIGN_FLAG	:= ut.CleanSpacesAndUpper(L.LH1_FOREIGN_FLAG);
self.LH1_ADDRESS	:= ut.CleanSpacesAndUpper(L.LH1_ADDRESS);
self.LH1_APT_NO	:= ut.CleanSpacesAndUpper(L.LH1_APT_NO);
self.LH1_CITY	:= ut.CleanSpacesAndUpper(L.LH1_CITY);
self.LH1_STATE	:= ut.CleanSpacesAndUpper(L.LH1_STATE);
self.LH1_ZIP	:= MAP(length(TRIM(L.LH1_ZIP,LEFT,RIGHT)) = 1 => StringLib.StringFindReplace(L.LH1_ZIP,'-',''),
								length(TRIM(L.LH1_ZIP,LEFT,RIGHT)) = 6 => StringLib.StringFindReplace(L.LH1_ZIP,'-',''),
								TRIM(L.LH1_ZIP,LEFT,RIGHT));
self.LH2_LIEN_DATE	:= IF(L.LH2_LIEN_DATE = '00000000','',L.LH2_LIEN_DATE);
self.LH2_HOLDR_TYPE	:= ut.CleanSpacesAndUpper(L.LH2_HOLDR_TYPE);
self.LH2_NAME	:= ut.CleanSpacesAndUpper(L.LH2_NAME);
self.LH2_DOB	:= IF(L.LH2_DOB = '00000000','',L.LH2_DOB);
self.LH2_SEX	:= ut.CleanSpacesAndUpper(L.LH2_SEX);
self.LH2_SEX_PREDATOR	:= ut.CleanSpacesAndUpper(L.LH2_SEX_PREDATOR);
self.LH2_MAIL_SUPPRESS	:= ut.CleanSpacesAndUpper(L.LH2_MAIL_SUPPRESS);
self.LH2_ADD_NO_RELEASE	:= ut.CleanSpacesAndUpper(L.LH2_ADD_NO_RELEASE);
self.LH2_LAW_ENFORCEMENT	:= ut.CleanSpacesAndUpper(L.LH2_LAW_ENFORCEMENT);
self.LH2_FOREIGN_FLAG	:= ut.CleanSpacesAndUpper(L.LH2_FOREIGN_FLAG);
self.LH2_ADDRESS	:= ut.CleanSpacesAndUpper(L.LH2_ADDRESS);
self.LH2_APT_NO	:= ut.CleanSpacesAndUpper(L.LH2_APT_NO);
self.LH2_CITY	:= ut.CleanSpacesAndUpper(L.LH2_CITY);
self.LH2_STATE	:= ut.CleanSpacesAndUpper(L.LH2_STATE);
self.LH2_ZIP	:= MAP(length(TRIM(L.LH2_ZIP,LEFT,RIGHT)) = 1 => StringLib.StringFindReplace(L.LH2_ZIP,'-',''),
								length(TRIM(L.LH2_ZIP,LEFT,RIGHT)) = 6 => StringLib.StringFindReplace(L.LH2_ZIP,'-',''),
								TRIM(L.LH2_ZIP,LEFT,RIGHT));
self.LH3_LIEN_DATE	:= IF(L.LH3_LIEN_DATE = '00000000','',L.LH3_LIEN_DATE);
self.LH3_CUST_TYPE	:= ut.CleanSpacesAndUpper(L.LH3_CUST_TYPE);
self.LH3_NAME	:= ut.CleanSpacesAndUpper(L.LH3_NAME);
self.LH3_DOB	:= IF(L.LH3_DOB = '00000000','',L.LH3_DOB);
self.LH3_SEX	:= ut.CleanSpacesAndUpper(L.LH3_SEX);
self.LH3_SEX_PREDATOR	:= ut.CleanSpacesAndUpper(L.LH3_SEX_PREDATOR);
self.LH3_MAIL_SUPPRESS	:= ut.CleanSpacesAndUpper(L.LH3_MAIL_SUPPRESS);
self.LH3_ADD_NO_RELEASE	:= ut.CleanSpacesAndUpper(L.LH3_ADD_NO_RELEASE);
self.LH3_LAW_ENFORCEMENT	:= ut.CleanSpacesAndUpper(L.LH3_LAW_ENFORCEMENT);
self.LH3_FOREIGN_FLAG	:= ut.CleanSpacesAndUpper(L.LH3_FOREIGN_FLAG);
self.LH3_ADDRESS	:= ut.CleanSpacesAndUpper(L.LH3_ADDRESS);
self.LH3_APT_NO	:= ut.CleanSpacesAndUpper(L.LH3_APT_NO);
self.LH3_CITY	:= ut.CleanSpacesAndUpper(L.LH3_CITY);
self.LH3_STATE	:= ut.CleanSpacesAndUpper(L.LH3_STATE);
self.LH3_ZIP	:= MAP(length(TRIM(L.LH3_ZIP,LEFT,RIGHT)) = 1 => StringLib.StringFindReplace(L.LH3_ZIP,'-',''),
								length(TRIM(L.LH3_ZIP,LEFT,RIGHT)) = 6 => StringLib.StringFindReplace(L.LH3_ZIP,'-',''),
								TRIM(L.LH3_ZIP,LEFT,RIGHT));								
self := L;
END;

EXPORT file_FL_clean_in := project(fIn_raw,CleanTrimRaw(left));