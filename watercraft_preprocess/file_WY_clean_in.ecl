import watercraft, watercraft_preprocess, ut, lib_StringLib;

fIn_raw := watercraft_preprocess.Files_raw.WY;

//Trim and uppercase all fields prior to mapping
Watercraft.layout_wy_2015_q1 CleanTrimRaw(fIn_raw L) := TRANSFORM
	self.STATEABREV	:= ut.CleanSpacesAndUpper(L.STATEABREV);
	self.REG_NUM		:= ut.CleanSpacesAndUpper(L.REG_NUM);
	self.HULL_ID 		:= ut.CleanSpacesAndUpper(MAP(REGEXFIND('^[^A-Z0-9_]',L.HULL_ID) => REGEXREPLACE('^[^A-Z0-9_]',L.HULL_ID,''),
																					REGEXFIND('^NONE|UNKNOWN|NA |UNKWN|UNK ',L.HULL_ID) => REGEXREPLACE('^NONE|UNKNOWN|NA |UNKWN|UNK ',L.HULL_ID,''),
																					L.HULL_ID));
	self.PROP			:= ut.CleanSpacesAndUpper(L.PROP);
	self.VEH_TYPE	:= ut.CleanSpacesAndUpper(L.VEH_TYPE);
	self.FUEL			:= ut.CleanSpacesAndUpper(L.FUEL);
	self.HULL			:= ut.CleanSpacesAndUpper(L.HULL);
	self.USE			:= ut.CleanSpacesAndUpper(L.USE);
	tempMake			:= ut.CleanSpacesAndUpper(MAP(StringLib.StringFind(L.MAKE, '(DBA)',1) > 0 => StringLib.StringFindReplace(L.MAKE, '(DBA)',''),
																			StringLib.StringFind(L.MAKE, '\'\'',1) > 0 => StringLib.StringFindReplace(L.MAKE, '\'\'','\''),
																			L.MAKE));
	self.MAKE				:= StringLib.StringCleanSpaces(tempMake);
	self.REG_DATE		:= ut.CleanSpacesAndUpper(L.REG_DATE);
	self.NAME				:= StringLib.StringFindReplace(ut.CleanSpacesAndUpper(L.NAME),' JTWROS','');
	self.FIRST_NAME	:= ut.CleanSpacesAndUpper(L.FIRST_NAME);
	self.MID				:= ut.CleanSpacesAndUpper(L.MID);
	self.LAST_NAME	:= ut.CleanSpacesAndUpper(L.LAST_NAME);
	self.ADDRESS_1	:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.ADDRESS_1), REGEXREPLACE('^[^A-Z0-9_]',L.ADDRESS_1,''),L.ADDRESS_1));
	self.CITY				:= ut.CleanSpacesAndUpper(L.CITY);
	self.STATE			:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.STATE,'XX',''));
	self.ADDBY			:= ut.CleanSpacesAndUpper(L.ADDBY);
	self.BOATMEMO		:= ut.CleanSpacesAndUpper(L.BOATMEMO);
	self.COLORID		:= ut.CleanSpacesAndUpper(L.COLORID);
	self.COOWNERFNAME	:= ut.CleanSpacesAndUpper(L.COOWNERFNAME);
	self.COOWNERLNAME	:= ut.CleanSpacesAndUpper(L.COOWNERLNAME);
	self.COOWNERMNAME	:= ut.CleanSpacesAndUpper(L.COOWNERMNAME);
	self.COOWNERNAME	:= ut.CleanSpacesAndUpper(L.COOWNERNAME);
	self.COOWNERSUFFIX	:= ut.CleanSpacesAndUpper(L.COOWNERSUFFIX);
	self.DEALERBATCH	:= ut.CleanSpacesAndUpper(L.DEALERBATCH);
	self.HININSPECTIONYESNO	:= ut.CleanSpacesAndUpper(L.HININSPECTIONYESNO);
	self.LASTACTION		:= ut.CleanSpacesAndUpper(L.LASTACTION);
	self.MODBY				:= ut.CleanSpacesAndUpper(L.MODBY);
	self.OADDRESS1		:= ut.CleanSpacesAndUpper(L.OADDRESS1);
	self.OADDRESS2		:= ut.CleanSpacesAndUpper(L.OADDRESS2);
	self.OCITY				:= ut.CleanSpacesAndUpper(L.OCITY);
	self.OSTATE				:= ut.CleanSpacesAndUpper(L.OSTATE);
	self.OWNERSUFFIX	:= ut.CleanSpacesAndUpper(L.OWNERSUFFIX);
	self.OZIP					:= REGEXREPLACE('[^0-9]',L.OZIP,'');
	self.OZIPSUFF			:= REGEXREPLACE('[^0-9]',L.OZIPSUFF,''); 
  self.PHONENUMBER	:= ut.CleanSpacesAndUpper(L.PHONENUMBER);   
	self.PREVOWNERFNAME	:= ut.CleanSpacesAndUpper(L.PREVOWNERFNAME);
	self.PREVOWNERLNAME	:= REGEXREPLACE('SAME AS ABOVE|SAME\\*NEW NUMBER ASSIGNED',ut.CleanSpacesAndUpper(L.PREVOWNERLNAME),'');
	self.PREVOWNERSUFFIX	:= ut.CleanSpacesAndUpper(L.PREVOWNERSUFFIX);
	self := L;
END;

EXPORT file_WY_clean_in := project(fIn_raw,CleanTrimRaw(left));