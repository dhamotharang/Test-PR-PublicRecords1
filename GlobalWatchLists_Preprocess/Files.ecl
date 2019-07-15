import std, GlobalWatchLists, GlobalWatchLists_Preprocess;

EXPORT Files := MODULE

	EXPORT dsBankOfEngland		:= 	DATASET(GlobalWatchLists_Preprocess.root+'bank_of_england', GlobalWatchLists_Preprocess.Layouts.rInputBOE, CSV(separator(';'),heading(2),quote('"'),TERMINATOR(['\n', '\r\n'])));	
	EXPORT dsOFAC							:=	DATASET(GlobalWatchLists_Preprocess.root+'ofac', GlobalWatchLists_Preprocess.Layouts.rInputOFAC, CSV(HEADING(0),SEPARATOR(''),TERMINATOR(['\n', '\r\n']),QUOTE('"')));
	EXPORT dsDebarredParties 	:= 	DATASET(GlobalWatchLists_Preprocess.root+'debarred_parties', GlobalWatchLists_Preprocess.Layouts.rDebarredParties, CSV(separator('\t'),heading(1),quote('"'),TERMINATOR(['\n', '\r\n'])));
	DeniedEntity				 			:= 	DATASET(GlobalWatchLists_Preprocess.root+'denied_entity', GlobalWatchLists_Preprocess.Layouts.rDeniedEntity, CSV(separator('|'),heading(1),quote('"'),TERMINATOR(['\n', '\r\n'])));
	
	EXPORT dsDeniedEntity 		:= DeniedEntity(Extract_Date <> '' and Extract_Vendor_Code <> '' and Data_Type <> ''
																					and Country <> '' and  Entities <> '' and License_Requirement <> ''
																					and License_Review_Policy <> '' and Federal_Register_Citation <> '');
	
	EXPORT dsDeniedPersons	 	:= 	DATASET(GlobalWatchLists_Preprocess.root+'denied_persons', GlobalWatchLists_Preprocess.Layouts.rDeniedPersons, CSV(separator('\t'),heading(1),quote('"'),TERMINATOR(['\n', '\r\n'])));
	//EXPORT dsOSFICanadaEnt		:=	DATASET(GlobalWatchLists_Preprocess.root+'osfi_canada::entites', GlobalWatchLists_Preprocess.Layouts.rOSFICanadaEnt, CSV(HEADING(0),SEPARATOR(''),TERMINATOR(['\n', '\r\n']),QUOTE('"'),UNICODE));
	//OSFI canada entity file is not in utf-8 encoding format
	EXPORT dsOSFICanadaEnt		:=	DATASET(GlobalWatchLists_Preprocess.root+'osfi_canada::entities', GlobalWatchLists_Preprocess.Layouts.rOSFICanada, CSV(HEADING(0),SEPARATOR(''),TERMINATOR(['\n', '\r\n']),QUOTE('"'),UNICODE));
	EXPORT dsOSFICanadaInd		:=	DATASET(GlobalWatchLists_Preprocess.root+'osfi_canada::individuals', GlobalWatchLists_Preprocess.Layouts.rOSFICanada, CSV(HEADING(0),SEPARATOR(''),TERMINATOR(['\n', '\r\n']),QUOTE('"')));
	
	GlobalWatchLists_Preprocess.Layouts.rOFACPrimary xFormOFACPrimary1(GlobalWatchLists_Preprocess.Layouts.rInputOFAC L) := TRANSFORM
   		self.Record_Type 							:= 'Primary';
			self.SDN_ID 									:= L.row_data[STD.Str.Find(L.row_data, '|', 1) + 1..STD.Str.Find(L.row_data, '|', 2) - 1];
			self.First_Name 							:= L.row_data[STD.Str.Find(L.row_data, '|', 2) + 1..STD.Str.Find(L.row_data, '|', 3) - 1];
			self.Last_Name 								:= L.row_data[STD.Str.Find(L.row_data, '|', 3) + 1..STD.Str.Find(L.row_data, '|', 4) - 1];
			self.Title 										:= L.row_data[STD.Str.Find(L.row_data, '|', 4) + 1..STD.Str.Find(L.row_data, '|', 5) - 1];
			self.AKA_ID 									:= L.row_data[STD.Str.Find(L.row_data, '|', 5) + 1..STD.Str.Find(L.row_data, '|', 6) - 1];
			self.AKA_Type 								:= L.row_data[STD.Str.Find(L.row_data, '|', 6) + 1..STD.Str.Find(L.row_data, '|', 7) - 1];
			self.AKA_Category 						:= L.row_data[STD.Str.Find(L.row_data, '|', 7) + 1..STD.Str.Find(L.row_data, '|', 8) - 1];
			self.GIV_Designator 					:= L.row_data[STD.Str.Find(L.row_data, '|', 8) + 1..STD.Str.Find(L.row_data, '|', 9) - 1];
			self.Remarks 									:= L.row_data[STD.Str.Find(L.row_data, '|', 9) + 1..STD.Str.Find(L.row_data, '|', 10) - 1];
			self.Call_Sign 								:= L.row_data[STD.Str.Find(L.row_data, '|', 10) + 1..STD.Str.Find(L.row_data, '|', 11) - 1];
			self.Vessel_Type 							:= L.row_data[STD.Str.Find(L.row_data, '|', 11) + 1..STD.Str.Find(L.row_data, '|', 12) - 1];
			self.Tonnage 									:= L.row_data[STD.Str.Find(L.row_data, '|', 12) + 1..STD.Str.Find(L.row_data, '|', 13) - 1];
 			self.Gross_Registered_Tonnage := L.row_data[STD.Str.Find(L.row_data, '|', 13) + 1..STD.Str.Find(L.row_data, '|', 14) - 1];
   		self.Vessel_Flag 							:= L.row_data[STD.Str.Find(L.row_data, '|', 14) + 1..STD.Str.Find(L.row_data, '|', 15) - 1];
   		self.Vessel_Owner 						:= L.row_data[STD.Str.Find(L.row_data, '|', 15) + 1..length(L.row_data)];
	END;
   	
  EXPORT dsOFACPrimary1 		:= PROJECT(dsOFAC(STD.Str.Find(row_data, 'Primary', 1) = 1 and STD.Str.FindCount(row_data, '|') = 15), xFormOFACPrimary1(LEFT));
	
	GlobalWatchLists_Preprocess.Layouts.rOFACPrimary xFormOFACPrimary2(GlobalWatchLists_Preprocess.Layouts.rInputOFAC L) := TRANSFORM
   		self.Record_Type 							:= 'Primary';
			self.SDN_ID 									:= L.row_data[STD.Str.Find(L.row_data, '|', 1) + 1..STD.Str.Find(L.row_data, '|', 2) - 1];
			self.First_Name 							:= L.row_data[STD.Str.Find(L.row_data, '|', 2) + 1..STD.Str.Find(L.row_data, '|', 3) - 1];
			self.Last_Name 								:= L.row_data[STD.Str.Find(L.row_data, '|', 3) + 1..STD.Str.Find(L.row_data, '|', 4) - 1];
			self.Title 										:= L.row_data[STD.Str.Find(L.row_data, '|', 4) + 1..STD.Str.Find(L.row_data, '|', 5) - 1];
			self.AKA_ID 									:= L.row_data[STD.Str.Find(L.row_data, '|', 5) + 1..STD.Str.Find(L.row_data, '|', 6) - 1];
			self.AKA_Type 								:= L.row_data[STD.Str.Find(L.row_data, '|', 6) + 1..STD.Str.Find(L.row_data, '|', 7) - 1];
			self.AKA_Category 						:= L.row_data[STD.Str.Find(L.row_data, '|', 7) + 1..STD.Str.Find(L.row_data, '|', 8) - 1];
			self.GIV_Designator 					:= L.row_data[STD.Str.Find(L.row_data, '|', 8) + 1..STD.Str.Find(L.row_data, '|', 9) - 1];
			self.Remarks 									:= L.row_data[STD.Str.Find(L.row_data, '|', 9) + 1..STD.Str.Find(L.row_data, '|', 10) - 1];
			self.Call_Sign 								:= '';
			self.Vessel_Type 							:= '';
			self.Tonnage 									:= '';
 			self.Gross_Registered_Tonnage := '';
   		self.Vessel_Flag 							:= '';
   		self.Vessel_Owner 						:= '';
	END;
	
	EXPORT dsOFACPrimary2 		:= PROJECT(dsOFAC(STD.Str.Find(row_data, 'Primary', 1) = 1 and STD.Str.FindCount(row_data, '|') <> 15), xFormOFACPrimary2(LEFT));
	
	EXPORT dsOFACPrimary			:= dsOFACPrimary1 + dsOFACPrimary2;
	
	GlobalWatchLists_Preprocess.Layouts.rOFACProgram xFormOFACProgram(GlobalWatchLists_Preprocess.Layouts.rInputOFAC L) := TRANSFORM   		
   		self.Record_Type 	:= 'Program';
			self.SDN_ID 			:= L.row_data[STD.Str.Find(L.row_data, '|', 1) + 1..STD.Str.Find(L.row_data, '|', 2) - 1];
			self.Program 			:= L.row_data[STD.Str.Find(L.row_data, '|', 2) + 1..length(L.row_data)];
	END;
	
	EXPORT dsOFACProgram 		:= PROJECT(dsOFAC(STD.Str.Find(row_data, 'Program', 1) = 1), xFormOFACProgram(LEFT));
	
	GlobalWatchLists_Preprocess.Layouts.rOFACAddress xFormOFACAddress(GlobalWatchLists_Preprocess.Layouts.rInputOFAC L) := TRANSFORM   		
   		self.Record_Type 					:= 'Address';
			self.SDN_ID 							:= L.row_data[STD.Str.Find(L.row_data, '|', 1) + 1..STD.Str.Find(L.row_data, '|', 2) - 1];
			self.Address_ID 					:= L.row_data[STD.Str.Find(L.row_data, '|', 2) + 1..STD.Str.Find(L.row_data, '|', 3) - 1];
			self.Address_Line_1 			:= L.row_data[STD.Str.Find(L.row_data, '|', 3) + 1..STD.Str.Find(L.row_data, '|', 4) - 1];
			self.Address_Line_2 			:= L.row_data[STD.Str.Find(L.row_data, '|', 4) + 1..STD.Str.Find(L.row_data, '|', 5) - 1];
			self.Address_Line_3 			:= L.row_data[STD.Str.Find(L.row_data, '|', 5) + 1..STD.Str.Find(L.row_data, '|', 6) - 1];
			self.Address_City 				:= L.row_data[STD.Str.Find(L.row_data, '|', 6) + 1..STD.Str.Find(L.row_data, '|', 7) - 1];
			self.Address_State 				:= L.row_data[STD.Str.Find(L.row_data, '|', 7) + 1..STD.Str.Find(L.row_data, '|', 8) - 1];
			self.Address_Postal_Code 	:= L.row_data[STD.Str.Find(L.row_data, '|', 8) + 1..STD.Str.Find(L.row_data, '|', 9) - 1];
			self.Address_Country 			:= L.row_data[STD.Str.Find(L.row_data, '|', 9) + 1..length(L.row_data)];
	END;
	
	EXPORT dsOFACAddress 		:= PROJECT(dsOFAC(STD.Str.Find(row_data, 'Address', 1) = 1), xFormOFACAddress(LEFT));
	
	GlobalWatchLists_Preprocess.Layouts.rOFACID xFormOFACID(GlobalWatchLists_Preprocess.Layouts.rInputOFAC L) := TRANSFORM   		
   		self.Record_Type 				:= 'ID';
			self.SDN_ID 						:= L.row_data[STD.Str.Find(L.row_data, '|', 1) + 1..STD.Str.Find(L.row_data, '|', 2) - 1];
			self.ID_ID 							:= L.row_data[STD.Str.Find(L.row_data, '|', 2) + 1..STD.Str.Find(L.row_data, '|', 3) - 1];
			self.ID_Type 						:= L.row_data[STD.Str.Find(L.row_data, '|', 3) + 1..STD.Str.Find(L.row_data, '|', 4) - 1];
			self.ID_Number 					:= L.row_data[STD.Str.Find(L.row_data, '|', 4) + 1..STD.Str.Find(L.row_data, '|', 5) - 1];
			self.ID_Country 				:= L.row_data[STD.Str.Find(L.row_data, '|', 5) + 1..STD.Str.Find(L.row_data, '|', 6) - 1];
			self.ID_Issue_Date 			:= L.row_data[STD.Str.Find(L.row_data, '|', 6) + 1..STD.Str.Find(L.row_data, '|', 7) - 1];
			self.ID_Expiration_Date := L.row_data[STD.Str.Find(L.row_data, '|', 7) + 1..length(L.row_data)];
	END;
	
	EXPORT dsOFACID 					:= PROJECT(dsOFAC(STD.Str.Find(row_data, 'ID', 1) = 1), xFormOFACID(LEFT));
	
	GlobalWatchLists_Preprocess.Layouts.rOFACNationality xFormOFACNationality(GlobalWatchLists_Preprocess.Layouts.rInputOFAC L) := TRANSFORM   		
   		self.Record_Type 							:= 'Nationality';
			self.SDN_ID 									:= L.row_data[STD.Str.Find(L.row_data, '|', 1) + 1..STD.Str.Find(L.row_data, '|', 2) - 1];
			self.Nationality_ID 					:= L.row_data[STD.Str.Find(L.row_data, '|', 2) + 1..STD.Str.Find(L.row_data, '|', 3) - 1];
			self.Nationality 							:= L.row_data[STD.Str.Find(L.row_data, '|', 3) + 1..STD.Str.Find(L.row_data, '|', 4) - 1];
			self.Primary_Nationality_Flag := L.row_data[STD.Str.Find(L.row_data, '|', 4) + 1..length(L.row_data)];
	END;
	
	EXPORT dsOFACNationality := PROJECT(dsOFAC(STD.Str.Find(row_data, 'Nationality', 1) = 1), xFormOFACNationality(LEFT));
	
	GlobalWatchLists_Preprocess.Layouts.rOFACCitizenship xFormOFACCitizenship(GlobalWatchLists_Preprocess.Layouts.rInputOFAC L) := TRANSFORM   		
   		self.Record_Type 							:= 'Citizenship';
			self.SDN_ID 									:= L.row_data[STD.Str.Find(L.row_data, '|', 1) + 1..STD.Str.Find(L.row_data, '|', 2) - 1];
			self.Citizenship_ID 					:= L.row_data[STD.Str.Find(L.row_data, '|', 2) + 1..STD.Str.Find(L.row_data, '|', 3) - 1];
			self.Citizenship 							:= L.row_data[STD.Str.Find(L.row_data, '|', 3) + 1..STD.Str.Find(L.row_data, '|', 4) - 1];
			self.Primary_Citizenship_Flag := L.row_data[STD.Str.Find(L.row_data, '|', 4) + 1..length(L.row_data)];
	END;
	
	EXPORT dsOFACCitizenship := PROJECT(dsOFAC(STD.Str.Find(row_data, 'Citizenship', 1) = 1), xFormOFACCitizenship(LEFT));
	
	GlobalWatchLists_Preprocess.Layouts.rOFACDOB xFormOFACDOB1(GlobalWatchLists_Preprocess.Layouts.rInputOFAC L) := TRANSFORM   		
   		self.Record_Type 								:= 'DOB';
			self.SDN_ID 										:= L.row_data[STD.Str.Find(L.row_data, '|', 1) + 1..STD.Str.Find(L.row_data, '|', 2) - 1];
			self.Date_of_Birth_ID 					:= L.row_data[STD.Str.Find(L.row_data, '|', 2) + 1..STD.Str.Find(L.row_data, '|', 3) - 1];
			self.Date_of_Birth 							:= L.row_data[STD.Str.Find(L.row_data, '|', 3) + 1..STD.Str.Find(L.row_data, '|', 4) - 1];
			self.Primary_Date_of_Birth_Flag := L.row_data[STD.Str.Find(L.row_data, '|', 4) + 1..length(L.row_data)];
	END;
	
	EXPORT dsOFACDOB1 		:= PROJECT(dsOFAC(STD.Str.Find(row_data, 'DOB', 1) = 1 and REGEXFIND(' to ', row_data) = false), xFormOFACDOB1(LEFT));
	
	GlobalWatchLists_Preprocess.Layouts.rOFACDOB xFormOFACDOB2(GlobalWatchLists_Preprocess.Layouts.rInputOFAC L) := TRANSFORM   		
   		self.Record_Type 								:= 'DOB';
			self.SDN_ID 										:= L.row_data[STD.Str.Find(L.row_data, '|', 1) + 1..STD.Str.Find(L.row_data, '|', 2) - 1];
			self.Date_of_Birth_ID 					:= L.row_data[STD.Str.Find(L.row_data, '|', 2) + 1..STD.Str.Find(L.row_data, '|', 3) - 1];
			integer len											:= length(L.row_data[STD.Str.Find(L.row_data, '|', 3) + 1..STD.Str.Find(L.row_data, '|', 4) - 1]);
			self.Date_of_Birth 							:= L.row_data[STD.Str.Find(L.row_data, '|', 3) + 1..STD.Str.Find(L.row_data, '|', 4) - 1][len-4..len];
			self.Primary_Date_of_Birth_Flag := L.row_data[STD.Str.Find(L.row_data, '|', 4) + 1..length(L.row_data)];
	END;
	
	EXPORT dsOFACDOB2 		:= PROJECT(dsOFAC(STD.Str.Find(row_data, 'DOB', 1) = 1 and REGEXFIND(' to ', row_data) = true), xFormOFACDOB2(LEFT));
	
	EXPORT dsOFACDOB 			:= dsOFACDOB1 + dsOFACDOB2;
	
	GlobalWatchLists_Preprocess.Layouts.rOFACPOB xFormOFACPOB(GlobalWatchLists_Preprocess.Layouts.rInputOFAC L) := TRANSFORM   		
   		self.Record_Type 									:= 'POB';
			self.SDN_ID 											:= L.row_data[STD.Str.Find(L.row_data, '|', 1) + 1..STD.Str.Find(L.row_data, '|', 2) - 1];
			self.Place_of_Birth_ID 						:= L.row_data[STD.Str.Find(L.row_data, '|', 2) + 1..STD.Str.Find(L.row_data, '|', 3) - 1];
			self.Place_of_Birth 							:= L.row_data[STD.Str.Find(L.row_data, '|', 3) + 1..STD.Str.Find(L.row_data, '|', 4) - 1];
			self.Primary_Place_of_Birth_Flag 	:= L.row_data[STD.Str.Find(L.row_data, '|', 4) + 1..length(L.row_data)];	
	END;
	
	EXPORT dsOFACPOB 				:= PROJECT(dsOFAC(STD.Str.Find(row_data, 'POB', 1) = 1), xFormOFACPOB(LEFT));
	
	EXPORT dsOFACUnknown 		:= dsOFAC(STD.Str.WildMatch(row_data, '^(Primary|Program|Address|ID|Nationality|Citizenship|DOB|POB)', true) );
	
	EXPORT dsUnverified		 			:= 	DATASET(GlobalWatchLists_Preprocess.root+'unverified', GlobalWatchLists_Preprocess.Layouts.rUnverified, CSV(separator('\t'),heading(1),quote('"'),TERMINATOR(['\n', '\r\n'])));
	EXPORT dsWorldBank		 			:= 	DATASET(GlobalWatchLists_Preprocess.root+'world_bank', GlobalWatchLists_Preprocess.Layouts.rWorldBank, CSV(separator('\t'),heading(0),quote('"'),TERMINATOR(['\n', '\r\n'])));
	EXPORT dsInterpolMostWanted	:= 	DATASET(GlobalWatchLists_Preprocess.root+'interpol_most_wanted', GlobalWatchLists_Preprocess.Layouts.rInterpolMostWanted, CSV(separator('|'),heading(1),quote('"'),TERMINATOR(['\n', '\r\n'])));
	EXPORT dsInterpolMostWantedINT	:= 	DATASET(GlobalWatchLists_Preprocess.root+'innovative_systems::INT', GlobalWatchLists_Preprocess.Layouts.rInterpolMostWantedINT, THOR);
	EXPORT dsInnovativeSystemsPEP		:= 	DATASET(GlobalWatchLists_Preprocess.root+'innovative_systems::PEP', GlobalWatchLists_Preprocess.Layouts.rInnovativeSystems, THOR);
	EXPORT dsInnovativeSystemsOSC		:= 	DATASET(GlobalWatchLists_Preprocess.root+'innovative_systems::OSC', GlobalWatchLists_Preprocess.Layouts.rInnovativeSystems, THOR);
	EXPORT dsInnovativeSystemsOCC		:= 	DATASET(GlobalWatchLists_Preprocess.root+'innovative_systems::OCC', GlobalWatchLists_Preprocess.Layouts.rInnovativeSystems, THOR);
	EXPORT dsInnovativeSystemsCFT		:= 	DATASET(GlobalWatchLists_Preprocess.root+'innovative_systems::CFT', GlobalWatchLists_Preprocess.Layouts.rInnovativeSystems, THOR);
//	EXPORT dsInnovativeSystemsCFT		:= 	DATASET(GlobalWatchLists_Preprocess.root+'innovative_systems::CFT', GlobalWatchLists.Layout_GlobalWatchLists, THOR); //history file
	EXPORT dsInnovativeSystemsFIN_GWL := DATASET(GlobalWatchLists_Preprocess.root+'innovative_systems::FIN_GWL', GlobalWatchLists.Layout_GlobalWatchLists, THOR); //history file
	EXPORT dsInnovativeSystemsFBI		:= 	DATASET(GlobalWatchLists_Preprocess.root+'innovative_systems::FBI', GlobalWatchLists_Preprocess.Layouts.rInnovativeSystems, THOR);
	EXPORT dsInnovativeSystemsUNS		:= 	DATASET(GlobalWatchLists_Preprocess.root+'innovative_systems::UNS', GlobalWatchLists_Preprocess.Layouts.rInnovativeSystems, THOR);

	EXPORT dsEUterroristListPerson	:= DATASET(GlobalWatchLists_Preprocess.root+'eu_terrorist_list::persons', GlobalWatchLists_Preprocess.Layouts.rEUterroristListPerson,CSV(SEPARATOR('|'),heading(1),quote('"')));
	EXPORT dsEUterroristListGroup		:= DATASET(GlobalWatchLists_Preprocess.root+'eu_terrorist_list::groups',GlobalWatchLists_Preprocess.Layouts.rEUterroristListGroup,CSV(separator('|'),heading(1),quote('"')));
	
	EXPORT dsStDeptTerroristExcl		:= DATASET(GlobalWatchLists_Preprocess.root+'state_department_terrorist_exclusion',GlobalWatchLists_Preprocess.Layouts.rStateDeptOfTerrorists,
																						CSV(separator('|'),heading(0),quote('"')));
	EXPORT dsStDeptTerrorist				:= DATASET(GlobalWatchLists_Preprocess.root+'state_department_terrorist',GlobalWatchLists_Preprocess.Layouts.rStateDeptOfTerrorists,
																						CSV(separator('|'),heading(0),quote('"')));
	EXPORT dsOFACPLC	:= DATASET(GlobalWatchLists_Preprocess.root+'ofac::new_plc',GlobalWatchLists_Preprocess.Layouts.rInputOFAC, CSV(HEADING(0),SEPARATOR(''),TERMINATOR(['\n', '\r\n']),QUOTE('"')));
	
	EXPORT dsFAFP	:= DATASET(GlobalWatchLists_Preprocess.root+'foreign_agents_registration::fp',GlobalWatchLists_Preprocess.Layouts.rFAPrincipals, CSV(HEADING(1),SEPARATOR(','),TERMINATOR(['\n', '\r\n']),QUOTE('"')));
	EXPORT dsFARE	:= DATASET(GlobalWatchLists_Preprocess.root+'foreign_agents_registration::re',GlobalWatchLists_Preprocess.Layouts.rFARegistrants, CSV(HEADING(1),SEPARATOR(','),TERMINATOR(['\n', '\r\n']),QUOTE('"')));
	EXPORT dsFASRE := DATASET(GlobalWatchLists_Preprocess.root+'foreign_agents_registration::sre',GlobalWatchLists_Preprocess.Layouts.rFAShortFormRegs, CSV(HEADING(1),SEPARATOR(','),TERMINATOR(['\n', '\r\n']),QUOTE('"')));
END;