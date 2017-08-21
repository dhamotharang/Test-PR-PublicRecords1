IMPORT Civ_Court, civil_court, crim_common, ut, Address;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/fl_civil_county_orange02.mp

fOrange := Civ_Court.Files_In_FL_Orange.Raw_RecType_1;

Civil_Court.Layout_In_Party tFLOrange(fOrange input, integer1 C) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '42';
self.state_origin				:= 'FL';
self.source_file				:= 'FL-ORANGE_CTY';
UpperCaseNum						:= ut.CleanSpacesAndUpper(input.case_no);
self.case_key					  := '42'+UpperCaseNum;
self.court						  := 'ORANGE COUNTY COURT: '+ut.CleanSpacesAndUpper(input.court);
self.case_number				:= UpperCaseNum;
ClnName									:= IF(REGEXFIND('UNKNOWN',input.name),'',input.name); //No benefit to have an 'UNKNOWN' name record
self.entity_1						:= ut.CleanSpacesAndUpper(CHOOSE(C, ClnName, input.judge_name));
self.entity_nm_format_1	:= 'L';
self.entity_type_code_1_orig	:= CHOOSE(C,ut.CleanSpacesAndUpper(input.party_type),'');
self.entity_type_description_1_orig := CHOOSE(C, map(input.party_type = 'ATTY' => 'ATTORNEY',
																											input.party_type = 'DEF' => 'DEFENDANT',
																											input.party_type = 'PLTF' => 'PLAINTIFF', 'UNSPECIFIED'),
																											'JUDGE');
self.entity_type_code_1_master := CHOOSE(C, map(input.party_type = 'ATTY' => '50',
																											input.party_type = 'DEF' and input.party_number = '001' => '30',
																											input.party_type = 'DEF' and input.party_number != '001' => '35',
																											input.party_type = 'PLTF' and input.party_number = '001' => '10',
																											input.party_type = 'PLTF' and input.party_number != '001' => '15','70'),
																											'60');
self := [];
end;

pOrange	:= normalize(fOrange,IF(trim(left.judge_name,left,right) = '',1,2),tFLOrange(left,counter));

fOrangeNew := Civ_Court.Files_In_FL_Orange.new_raw;

// Party Transform
Civil_Court.Layout_In_Party tFLOrangeNew(fOrangeNew input) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '42';
self.state_origin				:= 'FL';
self.source_file				:= 'FL-ORANGE_CTY';
self.case_key					  := '42'+ input.CaseNumber;
self.court						  := 'ORANGE COUNTY COURT';
self.case_number				:= input.CaseNumber;
self.case_title					:= input.CaseStyle;
self.entity_1						:= if(regexfind('UNKNOWN',input.PartyName), '', input.PartyName);
self.entity_nm_format_1	:= 'F';
self.entity_type_description_1_orig := ut.CleanSpacesAndUpper(input.PartyType);
self.entity_type_code_1_master := map(input.PartyType = 'Defendant' => '30',
																			input.PartyType = 'Plaintiff' => '10',
																			'70');
a := stringlib.StringFind(input.Address, '    ', 1);

self.entity_1_address_1  := input.Address[1..a];
self.entity_1_address_2  := input.Address[a.. ];																										                  
self := [];
end;

pOrangeNewParty 	:= project(fOrangeNew,tFLOrangeNew(left));

// Judge Transform
fOrangeNewJudge := Civ_Court.Files_In_FL_Orange.new_raw(trim(Judge)[1..5] <> 'PANEL' and Judge <> '');

Civil_Court.Layout_In_Party tFLOrangeNewJudge(fOrangeNewJudge input) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '42';
self.state_origin				:= 'FL';
self.source_file				:= 'FL-ORANGE_CTY';
self.case_key					  := '42'+ input.CaseNumber;
self.court						  := 'ORANGE COUNTY COURT';
self.case_number				:= input.CaseNumber;
self.case_title					:= input.CaseStyle;
self.entity_1						:= input.Judge;
self.entity_nm_format_1	:= 'F';
self.entity_type_description_1_orig := 'JUDGE';
self.entity_type_code_1_master := '60';
//a := stringlib.StringFind(input.Address, '    ', 1);

//self.entity_1_address_1  := input.Address[1..a];
//self.entity_1_address_2  := input.Address[a.. ];																										                  
self := [];
end;

pOrangeNewJudge 	:= project(fOrangeNewJudge,tFLOrangeNewJudge(left));

// Attorney Transform
fOrangeNewAtty := Civ_Court.Files_In_FL_Orange.new_raw(trim(LeadAttorney) <> '');

Civil_Court.Layout_In_Party tFLOrangeNewAtty(fOrangeNewAtty input) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '42';
self.state_origin				:= 'FL';
self.source_file				:= 'FL-ORANGE_CTY';
self.case_key					  := '42'+ input.CaseNumber;
self.court						  := 'ORANGE COUNTY COURT';
self.case_number				:= input.CaseNumber;
self.case_title					:= input.CaseStyle;
self.entity_1						:= input.Judge;
self.entity_nm_format_1	:= 'F';
self.entity_type_description_1_orig := 'ATTORNEY';
self.entity_type_code_1_master := '50';
//a := stringlib.StringFind(input.Address, '    ', 1);

//self.entity_1_address_1  := input.Address[1..a];
//self.entity_1_address_2  := input.Address[a.. ];																										                  
self := [];
end;

pOrangeNewAtty 	:= project(fOrangeNewAtty,tFLOrangeNewAtty(left));

pOrangeAll := pOrange + pOrangeNewParty + pOrangeNewJudge + pOrangeNewAtty;

Civ_court.Civ_Court_Cleaner(pOrangeAll,cleanOrange);

ddOrange 	:= dedup(sort(distribute(cleanOrange,hash(case_key)),
                  process_date,case_key,court, case_number, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master,local),
									case_key, court, case_number, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master,local,left):
									PERSIST('~thor_data400::in::civil_FL_Orange_party');


EXPORT Map_FL_Orange_Party := ddOrange(entity_1 <> '');