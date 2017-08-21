import watercraft, watercraft_preprocess, ut, lib_StringLib;

fIn_raw := watercraft_preprocess.Files_raw.WI;

//Trim and uppercase all fields prior to mapping
Watercraft.Layout_WI_new.common CleanTrimRaw(fIn_raw L) := TRANSFORM
	self.STATEABREV	:= ut.CleanSpacesAndUpper(L.STATEABREV);
	tempRegNum			:= ut.CleanSpacesAndUpper(L.REG_NUM);
	self.REG_NUM		:= MAP(StringLib.StringFind(L.REG_NUM,'ROW',1)>0 => '',
													StringLib.StringFind(L.REG_NUM,'RP TEA',1)>0 => '',
													L.REG_NUM);
	self.HULL_ID 		:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^NONE|UNKNOWN|NA|UNKN|UNK|NONEFOUND',L.HULL_ID), REGEXREPLACE('^NONE|UNKNOWN|NA|UNKN|UNK|NONEFOUND',L.HULL_ID,''),
																					L.HULL_ID));
	self.PROP				:= ut.CleanSpacesAndUpper(L.PROP);
	self.VEH_TYPE		:= ut.CleanSpacesAndUpper(L.VEH_TYPE);
	self.FUEL				:= ut.CleanSpacesAndUpper(L.FUEL);											
	self.HULL				:= ut.CleanSpacesAndUpper(L.HULL);
	self.USE_1			:= ut.CleanSpacesAndUpper(L.USE_1);
	tempMake				:= ut.CleanSpacesAndUpper(MAP(StringLib.StringFind(L.MAKE, '(DBA)',1) > 0 => StringLib.StringFindReplace(L.MAKE, '(DBA)',''),
																			StringLib.StringFind(L.MAKE, '\'\'',1) > 0 => StringLib.StringFindReplace(L.MAKE, '\'\'','\''),
																			L.MAKE));
	self.MAKE				:= StringLib.StringCleanSpaces(REGEXREPLACE('^[^A-Z0-9_]',tempMake,''));
	self.YEAR				:= REGEXREPLACE('[^0-9]',L.YEAR,'');
	self.NAME				:= StringLib.StringCleanSpaces(ut.CleanSpacesAndUpper(L.FIRST_NAME+' '+L.MID+' '+L.LAST_NAME));
	self.FIRST_NAME	:= ut.CleanSpacesAndUpper(L.FIRST_NAME);
	self.MID				:= ut.CleanSpacesAndUpper(L.MID);
	self.LAST_NAME	:= ut.CleanSpacesAndUpper(L.LAST_NAME);
	self.ADDRESS_1	:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.ADDRESS_1), REGEXREPLACE('^[^A-Z0-9_]',L.ADDRESS_1,''),L.ADDRESS_1));
	self.CITY				:= ut.CleanSpacesAndUpper(L.CITY);
	self.STATE			:= ut.CleanSpacesAndUpper(IF(LENGTH(TRIM(L.STATE,LEFT,RIGHT))<2, '',
																			IF(REGEXFIND('^[^A-Z]',L.STATE), REGEXREPLACE('^[^A-Z]',L.STATE,''),L.STATE)));
  self.ZIP				:= ut.CleanSpacesAndUpper(IF(L.ZIP = 'Y', '',L.ZIP));
	self.REG_STATUS	:= ut.CleanSpacesAndUpper(L.REG_STATUS);
	self.REG_TYPE_CODE	:= ut.CleanSpacesAndUpper(L.REG_TYPE_CODE);
	self.EXPIRE_YEAR		:= ut.CleanSpacesAndUpper(IF(LENGTH(TRIM(L.EXPIRE_YEAR,LEFT,RIGHT))=1, '', L.EXPIRE_YEAR));
	self.CGID						:= ut.CleanSpacesAndUpper(L.CGID);
	self.FLEETID				:= '';
	self.MODEL					:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.MODEL), REGEXREPLACE('^[^A-Z0-9_]',L.MODEL,''),L.MODEL));
	self.BOATNAME				:= ut.CleanSpacesAndUpper(L.BOATNAME);
	self.PORTNAME				:= ut.CleanSpacesAndUpper(L.PORTNAME);
	self.PUR_DATE				:= ut.CleanSpacesAndUpper(L.PUR_DATE);
	self.NODISCLOSURE		:= ut.CleanSpacesAndUpper(L.NODISCLOSURE);
	self.DOB						:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.DOB,'NULL',''));
	self.BUSINESS				:= ut.CleanSpacesAndUpper(L.BUSINESS);
	self.COUNTRY_NAME		:= ut.CleanSpacesAndUpper(L.COUNTRY_NAME);
	self.CONTACT				:= '';
	self.ADDRESS2				:= '';
	self	:= L;
	self	:= [];
END;

EXPORT file_WI_clean_in := project(fIn_raw,CleanTrimRaw(left));