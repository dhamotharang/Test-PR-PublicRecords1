IMPORT Civ_Court, civil_court, ut,  Address, lib_StringLib, Std;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/new_cleaner/az_civil_02_ffreplace2_new_cleaner_no_lookup_sc.mp

fAZ := Civ_Court.Files_In_AZ.Civil_in;

BadName	:= ['CONVERTED','BASKET','UNKNOWN'];

fmtsin := [
		'%m/%d/%Y',
		'%m/%d/%Y'
	];
	fmtout:='%Y%m%d';	

Civil_Court.Layout_In_Party tAZ(fAZ input, integer1 C) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '11';
self.state_origin				:= 'AZ';
self.source_file				:= 'AZ-CRIM-CIVIL-COURT';
self.case_key					  := '11'+trim(input.court_id,all)+trim(input.party_case_search_key,all);
self.court_code					:= input.court_id;
self.court						  := '';
self.case_number				:= input.full_case_num;
self.case_type_code			:= '';
self.case_type					:= input.case_category;
tmpCaseTitle						:= REGEXREPLACE('\\*|!',input.case_title,'');
self.case_title					:= IF(StringLib.StringFind(tmpCaseTitle,' VS',1)>0 AND Civ_Court.IsInvalidName(tmpCaseTitle) = 0,tmpCaseTitle,'');
tmpPartyName						:= IF(Civ_Court.IsInvalidName(input.party_prty_name) = 1, '', input.party_prty_name);
tmpJudgeName						:= IF(Civ_Court.IsInvalidName(input.judicial_officer_name) = 1 OR input.judicial_officer_name in BadName, ''
															,input.judicial_officer_name);
self.entity_1						:= CHOOSE(C,tmpPartyName,tmpJudgeName);
self.entity_nm_format_1 := 'F';
self.entity_type_code_1_orig := CHOOSE(C, If(input.source_system_prty_type_parta <> '' and input.source_system_prty_description <> '' 
																					and input.source_system_prty_description <> 'UNKNOWN',input.source_system_prty_type_parta,''),
																				'');
self.entity_type_description_1_orig := CHOOSE(C,input.source_system_prty_description, 'JUDICIAL OFFICER');
self.entity_type_code_1_master := CHOOSE(C, map(input.source_system_prty_description = 'ATTORNEY' => '50',
																								input.source_system_prty_description = 'CLAIMANT' => '10',
																								input.source_system_prty_description = 'CO-DEFENDANT' => '30',
																								input.source_system_prty_description = 'DEFENDANT' => '30',
																								input.source_system_prty_description = 'RESPONDENT' => '30',
																								input.source_system_prty_description = 'PLAINTIFF' => '10',
																								input.source_system_prty_description = 'PETITIONER' => '10',
																								input.source_system_prty_description = '3RD PARTY DEFENDANT' => '30',
																								input.source_system_prty_description = '3RD PARTY PLAINTIFF' => '10','70'),
																							'60');
self.entity_1_address_1 := CHOOSE(C,trim(input.address_1,left,right),'');
self.entity_1_address_2 := CHOOSE(C,trim(input.address_2,left,right),'');
self.entity_1_address_3 := CHOOSE(C,trim(input.city,left,right)+' '+trim(input.state,left,right)+' '+trim(input.zip,left,right),'');
self.entity_1_dob				:= CHOOSE(C,Std.date.ConvertDateFormatMultiple(input.party_birth_date,fmtsin,fmtout),'');
self := [];
end;

pAZ	:= normalize(fAZ,2,tAZ(left,counter));

filterAZ	:= pAZ(entity_1 <> ''); //filtering here as there are a not of blank entity records due to normalization

Civ_court.Civ_Court_Cleaner(filterAZ,cleanAZ);

ddAZ 	:= dedup(sort(distribute(cleanAZ,hash(case_key)),
                  process_date, case_key, court_code, case_number, case_type, case_title, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master, entity_1_address_1,
									entity_1_address_2, entity_1_address_3 ,entity_1_dob, local),
									case_key, court_code, case_number, case_type, case_title, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master, entity_1_address_1,
									entity_1_address_2, entity_1_address_3 ,entity_1_dob, local,left):
									PERSIST('~thor_data400::in::civil_arizona_party');

EXPORT Map_AZ_Party := ddAZ;