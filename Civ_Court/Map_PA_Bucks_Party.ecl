IMPORT Civ_Court, civil_court, crim_common, ut, Address; 

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/pa_civil_county_bucks_02.mp
fBucks := Civ_Court.Files_In_PA_Bucks.Civil_join;

Civil_Court.Layout_In_Party tBucks(fBucks input, integer1 C) := TRANSFORM
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '60';
self.state_origin				:= 'PA';
self.source_file				:= 'PA-BUCKS-CIVIL-COURT';
UpperCaseNum						:= ut.CleanSpacesAndUpper(input.dock_no);
self.case_key					  := '60'+UpperCaseNum;
self.court						  :=	'PA BUCKS COUNTY CIVIL COURT';
self.case_number				:= UpperCaseNum;
self.case_type_code			:= ut.CleanSpacesAndUpper(input.d_class_type);
self.case_type					:= ut.CleanSpacesAndUpper(input.d_class_desc);
UpperName								:= ut.CleanSpacesAndUpper(IF(trim(input.n_last_name,all) <> '' and trim(input.n_corp_code,all) <> 'C', 
																							trim(input.n_first_name,left,right)+' '+trim(input.n_last_name,left,right),
																							trim(input.n_last_name,left,right)+' '+trim(input.n_first_name,left,right)));
UpperAttyName						:= ut.CleanSpacesAndUpper(If(trim(input.n_atty_last_name,all) <> '' and not regexfind('NONE|UNKNOWN',input.n_atty_last_name),
																							trim(input.n_atty_first_name,left,right)+' '+trim(input.n_atty_last_name,left,right),''));
UpperJudgeName					:= ut.CleanSpacesAndUpper(If(trim(input.d_judge_name,left,right) <> '' and not regexfind('NONE|Miscellaneous',input.d_judge_name),
																							trim(input.d_judge_name,left,right),''));
self.entity_1						:= CHOOSE(C,Uppername, UpperAttyName,UpperJudgeName);
self.entity_nm_format_1	:='F';
self.entity_type_code_1_orig				:= ut.CleanSpacesAndUpper(CHOOSE(C,input.n_name_type, input.n_atty_state_code,'')); 																							
self.entity_type_description_1_orig	:= CHOOSE(C,map(input.n_name_type[1] = 'D' => 'DEFENDANT', input.n_name_type[1] = 'P' => 'PLAINTIFF',''),
																								map(input.n_name_type[1] = 'D' => 'DEFENDANT ATTORNEY', input.n_name_type[1] = 'P' => 'PLAINTIFF ATTORNEY',''),
																								'JUDGE');
self.entity_type_code_1_master		  := CHOOSE(C,map(input.n_name_type[1] = 'P' => '10', input.n_name_type[1] = 'D' => '30',''),
																								map(input.n_name_type[1] = 'P' => '20', input.n_name_type[1] = 'D' => '40','50'),
																									'70');
self.entity_1_address_1 := CHOOSE(C,IF(regexfind('UNKNOWN',input.n_addr1),'',ut.CleanSpacesAndUpper(input.n_addr1)),'','');
self.entity_1_address_2	:= CHOOSE(C,IF(regexfind('UNKNOWN',input.n_addr2),'',ut.CleanSpacesAndUpper(input.n_addr2)),'','');
self.entity_1_address_3	:= CHOOSE(C,ut.CleanSpacesAndUpper(IF(regexfind('UNKNOWN',input.n_addr3),'',
																		trim(input.n_addr3,left,right)+' '+IF(trim(input.n_zip,left,right)<>'99999',trim(input.n_zip,left,right),''))),
																		'','');
self := [];
END;

pBucks	:= normalize(fbucks,IF(trim(left.n_atty_last_name,left,right) <> '' and trim(left.d_judge_name,left,right) <> '',3,
															IF(trim(left.n_atty_last_name,left,right) <> '' and trim(left.d_judge_name,left,right) = '',2,
															IF(trim(left.n_atty_last_name,left,right) = '' and trim(left.d_judge_name,left,right) <> '',2,1))),tBucks(left,counter));

Civ_court.Civ_Court_Cleaner(pBucks,cleanBucks);

ddBucks 	:= dedup(sort(distribute(cleanBucks,hash(case_key)),
                  process_date,case_key,court, case_number, case_type_code, case_type, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master,
									entity_1_address_1, entity_1_address_2, entity_1_address_3, local),
									case_key, court, case_number, case_type_code, case_type, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master,
									entity_1_address_1, entity_1_address_2, entity_1_address_3, local,left):
									PERSIST('~thor_data400::in::civil_PA_Bucks_party');

EXPORT Map_PA_Bucks_Party := ddBucks(entity_1 <> '');