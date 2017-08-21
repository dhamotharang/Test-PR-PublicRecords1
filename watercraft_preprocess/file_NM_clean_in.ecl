import watercraft, watercraft_preprocess, ut, lib_StringLib;

fIn_raw := watercraft_preprocess.Files_raw.NM;

//Trim and uppercase all fields prior to mapping
Watercraft.layout_nm CleanTrimRaw(fIn_raw L) := TRANSFORM
	self.STATEABREV	:= ut.CleanSpacesAndUpper(L.STATEABREV);
	self.REG_NUM		:= ut.CleanSpacesAndUpper(L.REG_NUM);
	self.HULL_ID 		:= ut.CleanSpacesAndUpper(L.HULL_ID);
	self.PROP				:= ut.CleanSpacesAndUpper(L.PROP);
	self.VEH_TYPE		:= ut.CleanSpacesAndUpper(L.VEH_TYPE);
	self.FUEL				:= ut.CleanSpacesAndUpper(L.FUEL);									
	self.HULL				:= ut.CleanSpacesAndUpper(L.HULL);
	self.USE_1			:= ut.CleanSpacesAndUpper(L.USE_1);
	tempMake				:= ut.CleanSpacesAndUpper(MAP(StringLib.StringFind(L.MAKE, '(DBA)',1) > 0 => StringLib.StringFindReplace(L.MAKE, '(DBA)',''),
																			StringLib.StringFind(L.MAKE, '\'\'',1) > 0 => StringLib.StringFindReplace(L.MAKE, '\'\'','\''),
																			L.MAKE));
	self.MAKE				:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(tempMake, '\\ARSON','LARSON'));
  self.TOTAL_INCH := ut.CleanSpacesAndUpper(L.TOTAL_INCH);
	self.REG_DATE   := ut.CleanSpacesAndUpper(L.REG_DATE);
	self.YEAR       := ut.CleanSpacesAndUpper(L.YEAR);
	self.NAME				:= ut.CleanSpacesAndUpper(L.NAME);
	self.FIRST_NAME	:= ut.CleanSpacesAndUpper(L.FIRST_NAME);
	self.MID				:= ut.CleanSpacesAndUpper(L.MID);
	self.LAST_NAME	:= ut.CleanSpacesAndUpper(L.LAST_NAME);
	self.ADDRESS_1	:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.ADDRESS_1),REGEXREPLACE('^[^A-Z0-9_]',L.ADDRESS_1,''),L.ADDRESS_1));
	UpperCity				:= ut.CleanSpacesAndUpper(L.CITY);
	self.CITY				:= REGEXREPLACE('[^A-Z0-9_]',UpperCity,'');
	self.STATE			:= ut.CleanSpacesAndUpper(L.STATE);
	self.ZIP		  	:= ut.CleanSpacesAndUpper(L.ZIP);
	self.COUNTY			:= ut.CleanSpacesAndUpper(L.COUNTY);
  self.FIPS 			:= ut.CleanSpacesAndUpper(L.FIPS);
	self.MODEL			:= ut.CleanSpacesAndUpper(L.MODEL);
	self.HORSE_POWER			:= ut.CleanSpacesAndUpper(L.HORSE_POWER);	
	self.ENGINE_NUMBER		:= ut.CleanSpacesAndUpper(REGEXREPLACE('^[^A-Z0-9_]',L.ENGINE_NUMBER,''));
	self.BEAM_WIDTH			:= ut.CleanSpacesAndUpper(L.BEAM_WIDTH);	
	self.TRANSOM_DEPTH  := ut.CleanSpacesAndUpper(L.TRANSOM_DEPTH);
	self.NUMBER_OF_PEOPLE	:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^A-Z0-9_]',L.NUMBER_OF_PEOPLE,''));
	self.PERSON_CAPACITY_LBS  := ut.CleanSpacesAndUpper(L.PERSON_CAPACITY_LBS);
	self.BOAT_STATUS  := ut.CleanSpacesAndUpper(L.BOAT_STATUS);
	self.UNIQUE_VESSEL_KEY  := ut.CleanSpacesAndUpper(L.UNIQUE_VESSEL_KEY);
	self.REG_STATUS  := ut.CleanSpacesAndUpper(L.REG_STATUS);
	// self.STATE_OF_USE			:= ut.CleanSpacesAndUpper(L.STATE_OF_USE);
	// self.PREVIOUS_HULL		:= ut.CleanSpacesAndUpper(L.PREVIOUS_HULL);
	
	self.PREVIOUS_REG_NUMBER	:= ut.CleanSpacesAndUpper(L.PREVIOUS_REG_NUMBER);
	// self.CLERK								:= ut.CleanSpacesAndUpper(L.CLERK);
	// self.FIELD_OFFICE					:= ut.CleanSpacesAndUpper(L.FIELD_OFFICE);
	// self.ISSUE_REG_NUMBER 			:= ut.CleanSpacesAndUpper(L.ISSUE_REG_NUMBER);      
	// self.ISSUE_STICKER 					:= ut.CleanSpacesAndUpper(L.ISSUE_STICKER);         
	// self.OVERRIDE  							:= ut.CleanSpacesAndUpper(L.OVERRIDE);             
	self.TITLE_STATUS 					:= ut.CleanSpacesAndUpper(L.TITLE_STATUS);          
	self.PREVIOUS_TITLE_NUMBER	:= ut.CleanSpacesAndUpper(L.PREVIOUS_TITLE_NUMBER);  
	self.PREVIOUS_TITLE_STATE		:= ut.CleanSpacesAndUpper(L.PREVIOUS_TITLE_STATE);   
	self.TITLE_NUMBER						:= ut.CleanSpacesAndUpper(L.TITLE_NUMBER);           
	// self.MODIFY_FEES						:= ut.CleanSpacesAndUpper(L.MODIFY_FEES);            
	self.TRADE_IN 							:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^A-Z0-9_]',L.TRADE_IN,''));              
	// self.ISSUE_HULL_ID 					:= ut.CleanSpacesAndUpper(L.ISSUE_HULL_ID);         
	self.SECONDARY_NAME 				:= ut.CleanSpacesAndUpper(L.SECONDARY_NAME);        
	// self.CITIZENSHIP						:= ut.CleanSpacesAndUpper(L.CITIZENSHIP);            
	// self.NONRES_MILITARY				:= ut.CleanSpacesAndUpper(L.NONRES_MILITARY);        
	// self.LIEN_CODE 							:= ut.CleanSpacesAndUpper(L.LIEN_CODE);             
	self.LIEN_NAME 							:= ut.CleanSpacesAndUpper(L.LIEN_NAME);             
	self.LIEN_ADDRESS 					:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.LIEN_ADDRESS),
																										REGEXREPLACE('^[^A-Z0-9_]',L.LIEN_ADDRESS,''),L.LIEN_ADDRESS));  
	self.LIEN_ADDRESS_2					:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.LIEN_ADDRESS_2),
																										REGEXREPLACE('^[^A-Z0-9_]',L.LIEN_ADDRESS_2,''),L.LIEN_ADDRESS_2)); 																									
	self.LIEN_CITY 							:= ut.CleanSpacesAndUpper(L.LIEN_CITY);            
	self.LIEN_STATE							:= ut.CleanSpacesAndUpper(L.LIEN_STATE);             
	self.LIEN_NAME2 						:= ut.CleanSpacesAndUpper(L.LIEN_NAME2);            
	self.LIEN_ADDRESS2					:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.LIEN_ADDRESS2),
																										REGEXREPLACE('^[^A-Z0-9_]',L.LIEN_ADDRESS2,''),L.LIEN_ADDRESS2));   
	self.LIEN_ADDRESS2_2 		 	  := ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Z0-9_]',L.LIEN_ADDRESS2_2),
																										REGEXREPLACE('^[^A-Z0-9_]',L.LIEN_ADDRESS2_2,''),L.LIEN_ADDRESS2_2)); 																										
	self.LIEN_CITY2							:= ut.CleanSpacesAndUpper(L.LIEN_CITY2);             
	self.LIEN_STATE2						:= ut.CleanSpacesAndUpper(L.LIEN_STATE2);
	self	:= L;
END;

EXPORT file_NM_clean_in := project(fIn_raw,CleanTrimRaw(left));