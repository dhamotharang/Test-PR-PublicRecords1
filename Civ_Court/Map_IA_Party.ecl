IMPORT Civ_Court, civil_court, ut,  Address, lib_StringLib, STD;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/ia_civil_02.mp

fIA := Civ_Court.Files_In_IA.Civil_in;

fmtsin := '%d-%b-%y';
fmtout := '%Y%m%d';

Civil_Court.Layout_In_Party tIA(fIA input, integer1 C)	:= TRANSFORM
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '88';
self.state_origin				:= 'IA';
self.source_file				:= 'IA STATEWIDE';
self.case_key					  := '88'+trim(input.case_number,left,right);
self.court_code					:= '';
self.court						  := 'IOWA CIVIL COURT';
self.case_number				:= trim(input.case_number,left,right);
self.case_title					:= trim(input.case_title,left,right);
self.ruled_for_against_code	:= trim(input.judmt_indicator,left,right);
self.ruled_for_against	:= IF(self.ruled_for_against_code = 'A', 'AGAINST',
															IF(self.ruled_for_against_code = 'F', 'FOR',''));
self.entity_1 					:= CHOOSE(C,trim(input.last_name,left,right)+' '+trim(input.first_name,left,right)+' '+trim(input.middle_name,left,right),
																	trim(input.atty_last_name,left,right)+' '+trim(input.atty_first_name,left,right)+' '+trim(input.atty_middle_name,left,right));
self.entity_nm_format_1	:= 'L';
self.entity_type_code_1_orig	:= CHOOSE(C,trim(input.people_role_code,left,right),trim(input.atty_role_code,left,right));
self.entity_type_description_1_orig 	:= CHOOSE(C,map(self.entity_type_code_1_orig = 'ADMN' => 'ADMINISTRATOR',
																								self.entity_type_code_1_orig = 'BOND' => 'BOND', 
																								self.entity_type_code_1_orig = 'CHLD' => 'CHILD', 
																								self.entity_type_code_1_orig = 'DECE' => 'DECEASED', 
																								self.entity_type_code_1_orig = 'DEFT' => 'DEFENDANT', 
																								self.entity_type_code_1_orig = 'EXEC' => 'EXECUTOR', 
																								self.entity_type_code_1_orig = 'GUAR' => 'GUARDIAN', 
																								self.entity_type_code_1_orig = 'JUDG' => 'JUDGE', 
																								self.entity_type_code_1_orig = 'PETT' => 'PETTITIONER', 
																								self.entity_type_code_1_orig = 'PHYS' => 'PHYSICIAN', 
																								self.entity_type_code_1_orig = 'PL' => 'PLANTIFF', 
																								self.entity_type_code_1_orig = 'PLA' => 'PLANTIFF', 
																								self.entity_type_code_1_orig = 'PLAF' => 'PLANTIFF', 
																								self.entity_type_code_1_orig = 'PLAG' => 'PLANTIFF', 
																								self.entity_type_code_1_orig = 'PLAT' => 'PLANTIFF', 
																								self.entity_type_code_1_orig = 'PLF' => 'PLANTIFF', 
																								self.entity_type_code_1_orig = 'PLFA' => 'PLANTIFF', 
																								self.entity_type_code_1_orig = 'PLFI' => 'PLANTIFF', 
																								self.entity_type_code_1_orig = 'PLFT' => 'PLANTIFF', 
																								self.entity_type_code_1_orig = 'PLTF' => 'PLANTIFF', 
																								self.entity_type_code_1_orig = 'RESP' => 'RESPONDENT', 
																								self.entity_type_code_1_orig = 'TRST' => 'TRUST', 
																								self.entity_type_code_1_orig = 'WARD' => 'WARD', 
																								self.entity_type_code_1_orig = 'WITD' => 'WITNESS', 
																								self.entity_type_code_1_orig = 'WITN' => 'WITNESS', 
																								self.entity_type_code_1_orig = 'WITP' => 'WITNESS', 
																								self.entity_type_code_1_orig = 'WITS' => 'WITNESS', ''),
																						map(self.entity_type_code_1_orig = 'ATPL' => 'ATTORNEY FOR PLAINTIFF',
																								self.entity_type_code_1_orig = 'ATDF' => 'ATTORNEY FOR DEFENDANT',
																								self.entity_type_code_1_orig = 'ATRE' => 'ATTORNEY FOR RESPONDENT',
																								self.entity_type_code_1_orig = 'ATPE' => 'ATTORNEY FOR PETITIONER', 'ATTORNEY'));

self.entity_type_code_1_master := CHOOSE(C,map(self.entity_type_code_1_orig = 'ADMN' => '70',
																								self.entity_type_code_1_orig = 'BOND' => '70', 
																								self.entity_type_code_1_orig = 'CHLD' => '70', 
																								self.entity_type_code_1_orig = 'DECE' => '70', 
																								self.entity_type_code_1_orig = 'DEFT' => '30', 
																								self.entity_type_code_1_orig = 'EXEC' => '70', 
																								self.entity_type_code_1_orig = 'GUAR' => '70', 
																								self.entity_type_code_1_orig = 'JUDG' => '60', 
																								self.entity_type_code_1_orig = 'PETT' => '10', 
																								self.entity_type_code_1_orig = 'PHYS' => '70', 
																								self.entity_type_code_1_orig = 'PL' => '10', 
																								self.entity_type_code_1_orig = 'PLA' => '10', 
																								self.entity_type_code_1_orig = 'PLAF' => '10', 
																								self.entity_type_code_1_orig = 'PLAG' => '10', 
																								self.entity_type_code_1_orig = 'PLAT' => '10', 
																								self.entity_type_code_1_orig = 'PLF' => '10', 
																								self.entity_type_code_1_orig = 'PLFA' => '10', 
																								self.entity_type_code_1_orig = 'PLFI' => '10', 
																								self.entity_type_code_1_orig = 'PLFT' => '10', 
																								self.entity_type_code_1_orig = 'PLTF' => '10', 
																								self.entity_type_code_1_orig = 'RESP' => '30', 
																								self.entity_type_code_1_orig = 'TRST' => '70', 
																								self.entity_type_code_1_orig = 'WARD' => '70', 
																								self.entity_type_code_1_orig = 'WITD' => '70', 
																								self.entity_type_code_1_orig = 'WITN' => '70', 
																								self.entity_type_code_1_orig = 'WITP' => '70', 
																								self.entity_type_code_1_orig = 'WITS' => '70', '70'),
																						map(self.entity_type_code_1_orig = 'ATPL' => '20',
																								self.entity_type_code_1_orig = 'ATDF' => '40','50'));
tempDOB							:= CHOOSE(C,ut.ConvertDate(input.birth_date,fmtsin,fmtout),'');
self.entity_1_dob		:= IF(STD.DATE.IsValidDate((INTEGER)tempDOB),tempDOB,'');
self := [];
end;

pIA	:= normalize(fIA,IF(trim(left.atty_last_name,left,right) = '',1,2),tIA(left,counter));

Civ_court.Civ_Court_Cleaner(pIA,cleanIA);

ddIA 	:= dedup(sort(distribute(cleanIA,hash(case_key)),
                  process_date, case_key, court, case_number, entity_1, entity_nm_format_1,entity_type_code_1_orig, 
									entity_type_description_1_orig, entity_type_code_1_master, entity_1_dob, local),
									case_key, court, case_number, entity_1, entity_nm_format_1,entity_type_code_1_orig, 
									entity_type_description_1_orig, entity_type_code_1_master, entity_1_dob, local,left):
									PERSIST('~thor_data400::in::civil_IA_party');

EXPORT Map_IA_Party := ddIA(entity_1 <> '');