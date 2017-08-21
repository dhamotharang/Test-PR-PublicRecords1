IMPORT Civ_Court, civil_court, crim_common, ut, lib_StringLib, Address;

#option('multiplePersistInstances',FALSE);

fHall := Civ_court.File_In_GA_Hall;

Civil_Court.Layout_In_Party  tHall(fHall input) := TRANSFORM
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '62';
self.state_origin				:= 'GA';
self.source_file				:= 'GA-HALL_CTY-CIV-CRT';
UpperCaseNum						:= ut.CleanSpacesAndUpper(input.docket_number);
self.case_key					  := '62'+UpperCaseNum;
self.court_code					:= '';
self.court							:= 'HALL COUNTY COURT';
self.case_number				:= UpperCaseNum;
self.case_type					:= ut.CleanSpacesAndUpper(input.case_type);
self.entity_1						:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(input.entity_nm,';',','));
self.entity_nm_format_1	:='L';
self.entity_type_code_1_orig	:= ut.CleanSpacesAndUpper(input.entity_type);
self.entity_type_description_1_orig := IF(self.entity_type_code_1_orig = 'PLA','PLAINTIFF',
																					IF(self.entity_type_code_1_orig = 'DEF','DEFENDENT',''));
self.entity_type_code_1_master		  := IF(self.entity_type_code_1_orig = 'PLA','10',
																					IF(self.entity_type_code_1_orig = 'DEF','30',''));
self := [];
END;

pHall 	:= project(fHall,tHall(left));

Civ_court.Civ_Court_Cleaner(pHall,cleanHall);

ddHall 	:= dedup(sort(distribute(cleanHall,hash(case_key)),
                  process_date,case_key, court, case_number, case_type, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master, local),
									case_key, court, case_number, case_type, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master, local,left):
									PERSIST('~thor_data400::in::civil_GA_Hall_party');

EXPORT Map_GA_Hall_Party := ddHall(trim(entity_1,all) <> '');