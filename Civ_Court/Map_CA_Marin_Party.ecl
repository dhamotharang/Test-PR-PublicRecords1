IMPORT Civ_Court, civil_court, crim_common, ut, Address; 

#option('multiplePersistInstances',FALSE);

fMarin := Civ_court.File_In_CA_Marin;

Civil_Court.Layout_In_Party  tMarin(fMarin input) := TRANSFORM
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '38';
self.state_origin				:= 'CA';
self.source_file				:= 'CA-MARIN_CTY';
UpperCaseNum						:= ut.CleanSpacesAndUpper(input.case_number);
self.case_key					  := '38'+UpperCaseNum;
self.court						  := 'MARIN COUNTY, CA MUNICIPAL COURT';
self.case_number				:= UpperCaseNum;
self.case_type					:= ut.CleanSpacesAndUpper(input.case_type);
self.entity_1						:= ut.CleanSpacesAndUpper(input.name);
self.entity_nm_format_1	:= 'F';
self.entity_type_description_1_orig	:= ut.CleanSpacesAndUpper(input.party_type);
self.entity_type_code_1_master := map(trim(input.party_type,all) = 'PLAINTIFF' => '10',
																			trim(input.party_type,all) = 'PETITIONER' => '10',
																			trim(input.party_type,all) = 'PETITIONE' => '10',
																			trim(input.party_type,all) = 'DEFENDANT' => '30', '70');
self := [];
END;

pMarin 	:= project(fMarin,tMarin(left));

Civ_court.Civ_Court_Cleaner(pMarin,cleanMarin);

ddMarin 	:= dedup(sort(distribute(cleanMarin,hash(case_key)),
								process_date,case_key, court, case_number, case_type, entity_1, entity_nm_format_1, 
								entity_type_description_1_orig, entity_type_code_1_master, local),
								case_key, court, case_number, case_type, entity_1, entity_nm_format_1, 
								entity_type_description_1_orig, entity_type_code_1_master, local,left):
								PERSIST('~thor_data400::in::civil_CA_Marin_party');

EXPORT Map_CA_Marin_Party := ddMarin(entity_1 <> '');