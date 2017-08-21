import watercraft, watercraft_preprocess, ut, lib_StringLib;

fIn_raw := watercraft_preprocess.Files_raw.CG;

Watercraft.layout_CG CleanTrimRaw(fIn_raw L) := TRANSFORM
	self.STATEABREV	:= ut.CleanSpacesAndUpper(L.STATEABREV);
	self.REG_NUM		:= ut.CleanSpacesAndUpper(L.REG_NUM);
	self.HULL_ID 		:= ut.CleanSpacesAndUpper(MAP(REGEXFIND('^[^A-Z0-9_]',L.HULL_ID) => REGEXREPLACE('^[^A-Z0-9_]',L.HULL_ID,''),
																					REGEXFIND('^NONE|UNKNOWN|NA |UNKWN|UNK ',L.HULL_ID) => REGEXREPLACE('^NONE|UNKNOWN|NA |UNKWN|UNK ',L.HULL_ID,''),
																					L.HULL_ID));
	self.PROP			:= ut.CleanSpacesAndUpper(L.PROP);
	self.VEH_TYPE	:= ut.CleanSpacesAndUpper(L.VEH_TYPE);
	self.FUEL			:= ut.CleanSpacesAndUpper(L.FUEL);
	self.HULL			:= ut.CleanSpacesAndUpper(L.HULL);
	self.USE_1		:= ut.CleanSpacesAndUpper(L.USE_1);
	tempMake			:= ut.CleanSpacesAndUpper(MAP(StringLib.StringFind(L.MAKE, '(DBA)',1) > 0 => StringLib.StringFindReplace(L.MAKE, '(DBA)',''),
																			StringLib.StringFind(L.MAKE, '\'\'',1) > 0 => StringLib.StringFindReplace(L.MAKE, '\'\'','\''),
																			L.MAKE));
	self.MAKE				:= StringLib.StringCleanSpaces(tempMake);
	self.NAME				:= ut.CleanSpacesAndUpper(L.NAME);
	self.FIRST_NAME	:= ut.CleanSpacesAndUpper(L.FIRST_NAME);
	self.MID				:= ut.CleanSpacesAndUpper(L.MID);
	self.LAST_NAME	:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.LAST_NAME,',',' '));
	self.ADDRESS_1	:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.ADDRESS_1), REGEXREPLACE('^[^A-Z0-9_]',L.ADDRESS_1,''),L.ADDRESS_1));
	self.CITY				:= ut.CleanSpacesAndUpper(IF(L.CITY = 'Ã¡altimore', 'BALTIMORE',L.CITY));
	self.STATE			:= ut.CleanSpacesAndUpper(L.STATE);
	self.Vessel_ID						:= ut.CleanSpacesAndUpper(L.Vessel_ID);
	self.Vessel_Database_Key	:= ut.CleanSpacesAndUpper(L.Vessel_Database_Key);
	self.Name_of_Vessel				:= ut.CleanSpacesAndUpper(L.Name_of_Vessel);
	self.Call_Sign						:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.Call_Sign), REGEXREPLACE('^[^A-Z0-9_]',L.Call_Sign,''),L.Call_Sign));
	self.IMO_Number						:= ut.CleanSpacesAndUpper(L.IMO_Number);
	self.Hull_Identification_Number_2	:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.Hull_Identification_Number_2),
																												REGEXREPLACE('^[^A-Z0-9_]',L.Hull_Identification_Number_2,''),
																												L.Hull_Identification_Number_2));
	self.Vessel_Service_Type	:= ut.CleanSpacesAndUpper(L.Vessel_Service_Type);
	self.Flag									:= ut.CleanSpacesAndUpper(L.Flag);
	self.Dead_Weight_Tons_Measure_Unit	:= ut.CleanSpacesAndUpper(L.Dead_Weight_Tons_Measure_Unit);
	self.Measuring_Organization_Name		:= ut.CleanSpacesAndUpper(L.Measuring_Organization_Name);
	self.Hailing_Port										:= ut.CleanSpacesAndUpper(L.Hailing_Port);
	self.Hailing_Port_State							:= ut.CleanSpacesAndUpper(L.Hailing_Port_State);
	self.Hailing_Port_Province					:= ut.CleanSpacesAndUpper(L.Hailing_Port_Province);
	self.Vessel_Complete_Build_City			:= ut.CleanSpacesAndUpper(REGEXREPLACE('^&',L.Vessel_Complete_Build_City,''));
	self.Vessel_Complete_Build_State		:= ut.CleanSpacesAndUpper(L.Vessel_Complete_Build_State);
	self.Vessel_Complete_Build_Province	:= ut.CleanSpacesAndUpper(L.Vessel_Complete_Build_State);
	self.Vessel_Complete_Build_Country	:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.Vessel_Complete_Build_Country,'-',' '));
	self.Vessel_Hull_Build_City					:= ut.CleanSpacesAndUpper(L.Vessel_Hull_Build_City);				
	self.Vessel_Hull_Build_State				:= ut.CleanSpacesAndUpper(L.Vessel_Hull_Build_State);
	tempProvince1												:= StringLib.StringFindReplace(L.Vessel_Hull_Build_Province,'(','');
	tempProvince2												:= StringLib.StringFindReplace(L.Vessel_Hull_Build_Province,')','');
	self.Vessel_Hull_Build_Province			:= ut.CleanSpacesAndUpper(tempProvince2);
	self.Vessel_Hull_Build_Country			:= ut.CleanSpacesAndUpper(L.Vessel_Hull_Build_Country);
	self.Party_Identification_Number		:= ut.CleanSpacesAndUpper(L.Party_Identification_Number);
	self.Organization_Type							:= ut.CleanSpacesAndUpper(L.Organization_Type);
	self.Person_Name_Suffix							:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.Person_Name_Suffix,'.',''));
	self.Street_Address_Line_2					:= ut.CleanSpacesAndUpper(L.Street_Address_Line_2);
	self.Street_Address_Line_3					:= ut.CleanSpacesAndUpper(L.Street_Address_Line_3);
	self.Street_Address_Line_4					:= ut.CleanSpacesAndUpper(L.Street_Address_Line_4);
	self.Province												:= ut.CleanSpacesAndUpper(L.Province);
	self.Country												:= ut.CleanSpacesAndUpper(L.Country);
	self.Propulsion_Type								:= ut.CleanSpacesAndUpper(L.Propulsion_Type);
	self.Ship_Builder										:= ut.CleanSpacesAndUpper(L.Ship_Builder);
	self.Hull_Configuration							:= ut.CleanSpacesAndUpper(L.Hull_Configuration);
	self.Hull_Shape											:= ut.CleanSpacesAndUpper(L.Hull_Shape);
	self.COD_Status											:= ut.CleanSpacesAndUpper(L.COD_Status);
	self := L;
END;

EXPORT file_CG_clean_in := project(fIn_raw,CleanTrimRaw(left));