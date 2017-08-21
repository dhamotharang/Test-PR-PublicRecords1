IMPORT Civ_Court, civil_court, crim_common, Data_Services, ut, Address, lib_stringlib; 

#option('multiplePersistInstances',FALSE);

fSantaBarbara := Civ_court.File_In_CA_SantaBarbara(party_type <> 'Extended Connection');

Civil_Court.Layout_In_Party  tSantaBarbara(fSantaBarbara input) := TRANSFORM
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '24';
self.state_origin				:= 'CA';
self.source_file				:= 'CA-CIV-SA-BARBARA-CO';
self.case_key					  := '24'+ input.case_num;
self.court_code         := '';
self.court						  := 'SANTA BARBARA COUNTY';
self.case_number				:= input.case_num;
self.case_type					:= input.case_type;
self.case_title					:= input.case_title;
self.entity_1						:= input.party;
self.entity_nm_format_1	:= 'L';
self.entity_type_description_1_orig	:= input.party_type;
self.entity_type_code_1_master := map(trim(input.party_type,all) = 'Associated Trust Party' => '70',
                                      trim(input.party_type,all) = 'Conservatee' => '70',
                                      trim(input.party_type,all) = 'Cross Complainant' => '70',
                                      trim(input.party_type,all) = 'Cross Defendant' => '30',
                                      trim(input.party_type,all) = 'Decedent' => '70',
                                      trim(input.party_type,all) = 'Defendant' => '30',
                                      trim(input.party_type,all) = 'Other Parent' => '70',
                                      trim(input.party_type,all) = 'Person Seeking Order/To Be Protected' => '70',
                                      trim(input.party_type,all) = 'Person to be Protected' => '70',
                                      trim(input.party_type,all) = 'Person to be Restrained' => '70',
                                      trim(input.party_type,all) = 'Petitioner' => '10',
                                      trim(input.party_type,all) = 'Petitioner 2' => '10',
                                      trim(input.party_type,all) = 'Plaintiff' => '10',
                                      trim(input.party_type,all) = 'Plaintiff to be Protected' => '10',
                                      trim(input.party_type,all) = 'Respondent' => '30', '70');
self := [];
END;

pSantaBarbara 	:= project(fSantaBarbara,tSantaBarbara(left));

Civ_court.Civ_Court_Cleaner(pSantaBarbara,cleanSantaBarbara);

ddSantaBarbara 	:= dedup(sort(distribute(cleanSantaBarbara,hash(case_key)),
								process_date,case_key, court, case_number, case_type, entity_1, entity_nm_format_1, 
								entity_type_description_1_orig, entity_type_code_1_master, local),
								case_key, court, case_number, case_type, entity_1, entity_nm_format_1, 
								entity_type_description_1_orig, entity_type_code_1_master, local,left):
								PERSIST('~thor_data400::in::civil_CA_Santa_Barbara_party');

EXPORT Map_CA_Santa_Barbara_Party := ddSantaBarbara(entity_1 <> '');