IMPORT Civ_Court, civil_court, ut,  Address, lib_StringLib;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/md_civil_02.mp

fMD := Civ_Court.File_In_MD;

Civil_Court.Layout_In_Party tMD(fMD input, integer1 C)	:= TRANSFORM
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '61';
self.state_origin				:= 'MD';
self.source_file				:= 'MD-CIVIL-COURT';
self.case_key					  := '61'+trim(input.case_number,left,right);
self.court_code					:= ut.CleanSpacesAndUpper(input.case_number)[1..4];
self.court						  := MAP(self.court_code = '0101' => 'BALTIMORE CITY COURT',
															self.court_code = '0103' => 'BALTIMORE CITY COURT',
															self.court_code = '0201' => 'DORCHESTER COUNTY COURT',
															self.court_code = '0202' => 'SOMERSET COUNTY COURT',
															self.court_code = '0203' => 'WICOMICO COUNTY COURT',
															self.court_code = '0204' => 'WORCESTER COUNTY COURT',
															self.court_code = '0205' => 'WORCESTER COUNTY COURT',
															self.court_code = '0302' => 'CECIL COUNTY COURT',
															self.court_code = '0303' => 'KENT COUNTY COURT',
															self.court_code = '0304' => 'QUEEN ANNES COUNTY COURT',
															self.court_code = '0305' => 'TALBOT COUNTY COURT',
															self.court_code = '0306' => 'CAROLINE COUNTY COURT',
															self.court_code = '0307' => 'QUEEN ANNES COUNTY COURT',
															self.court_code = '0401' => 'CALVERT COUNTY COURT',
															self.court_code = '0402' => 'CHARLES COUNTY COURT',
															self.court_code = '0403' => 'SAINT MARYS COUNTY COURT',
															self.court_code = '0501' => 'PRINCE GEORGES COUNTY COURT',
															self.court_code = '0502' => 'PRINCE GEORGES COUNTY COURT',
															self.court_code = '0601' => 'MONTGOMERY COUNTY COURT',
															self.court_code = '0602' => 'MONTGOMERY COUNTY COURT',
															self.court_code = '0701' => 'ANNE ARUNDEL COUNTY COURT',
															self.court_code = '0702' => 'ANNE ARUNDEL COUNTY COURT',
															self.court_code = '0801' => 'BALTIMORE COUNTY COURT',
															self.court_code = '0802' => 'BALTIMORE COUNTY COURT',
															self.court_code = '0803' => 'BALTIMORE COUNTY COURT',
															self.court_code = '0804' => 'BALTIMORE COUNTY COURT',
															self.court_code = '0805' => 'BALTIMORE COUNTY COURT',
															self.court_code = '0901' => 'HARFORD COUNTY COURT',
															self.court_code = '1001' => 'HOWARD COUNTY COURT',
															self.court_code = '1002' => 'CARROLL COUNTY COURT',
															self.court_code = '1101' => 'FREDERICK COUNTY COURT',
															self.court_code = '1102' => 'WASHINGTON COUNTY COURT',
															self.court_code = '1201' => 'ALLEGANY COUNTY COURT',
															self.court_code = '1202' => 'GARRETT COUNTY COURT', 'MD STATEWIDE COURT');
self.case_number				:= trim(input.case_number,left,right);
self.case_title					:= IF(trim(input.plaintiff_nm) <> '' and input.party_cd in ['TAD','DEF','AKA'], ut.CleanSpacesAndUpper(input.plaintiff_nm)+' VS '+ut.CleanSpacesAndUpper(input.party_name),'');
self.entity_1						:= ut.CleanSpacesAndUpper(CHOOSE(C,input.plaintiff_nm,input.party_name,input.plt_atty_name,input.def_atty_name));
IsPlaintComp						:= Civ_Court.fIsCompany(input.plaintiff_nm);
self.entity_nm_format_1	:= CHOOSE(C,IF(IsPlaintComp,'F','L'),IF(input.is_company = '','L','F'),'L','L');
self.entity_type_description_1_orig	:= CHOOSE(C,IF(input.plaintiff_nm <> '','PLAINTIFF',''),IF(input.plaintiff_nm = input.party_name,'PLAINTIFF',
																																																IF(input.party_cd in ['TAD','DEF','AKA'],'DEFENDANT','OTHER')),
																									IF(input.plt_atty_name <> '','PLAINTIFF ATTORNEY',''),
																									IF(input.def_atty_name <> '','DEFENDANT ATTORNEY',''));
self.entity_type_code_1_master := CHOOSE(C,IF(input.plaintiff_nm <> '','10',''),IF(input.plaintiff_nm = input.party_name,'10',
																																									IF(input.party_cd in ['TAD','DEF','AKA'],'30','90')),
																						IF(input.plt_atty_name <> '','20',''),
																						IF(input.def_atty_name <> '','40',''));
TempAddr1								:= ut.CleanSpacesAndUpper(CHOOSE(C,IF(REGEXFIND('AKA|A/K/A',input.plaintiff_addr),'',input.plaintiff_addr),
																										IF(REGEXFIND('AKA|A/K/A',input.party_addr),'',input.party_addr),
																										input.plt_atty_firm,
																										input.def_atty_firm));
TempAddr2								:= ut.CleanSpacesAndUpper(CHOOSE(C,input.plaintiff_street,input.party_street,input.plt_atty_addr,input.def_atty_addr));

//Had to move address2 to address1 if address1 was blank because cleaner wasn't working properly with address1 blank
self.entity_1_address_1 := CHOOSE(C,IF(REGEXFIND('[0-9]',TempAddr1),TempAddr1,TempAddr2),
																		IF(REGEXFIND('[0-9]',TempAddr1),TempAddr1,TempAddr2),
																		IF(REGEXFIND('[0-9]',TempAddr1),TempAddr1,TempAddr2),
																		IF(REGEXFIND('[0-9]',TempAddr1),TempAddr1,TempAddr2));
self.entity_1_address_2	:= CHOOSE(C,IF(REGEXFIND('[0-9]',TempAddr1),TempAddr2,''),
																		IF(REGEXFIND('[0-9]',TempAddr1),TempAddr2,''),
																		IF(REGEXFIND('[0-9]',TempAddr1),TempAddr2,''),
																		IF(REGEXFIND('[0-9]',TempAddr1),TempAddr2,''));
self.entity_1_address_3	:= ut.CleanSpacesAndUpper(CHOOSE(C,input.plaintiff_city+' '+input.plaintiff_state+' '+input.plaintiff_zip,
																										input.party_city+' '+input.party_state+' '+input.party_zip,
																										input.plt_atty_city+' '+input.plt_atty_state+' '+input.plt_atty_zip,
																										input.def_atty_city+' '+input.def_atty_state+' '+input.def_atty_zip));
self := [];
end;

pMD	:= normalize(fMD,4,tMD(left,counter));

//Remove records with blank name prior to clean.
filterMD	:= pMD(entity_1 <> '');

Civ_court.Civ_Court_Cleaner(filterMD,cleanMD);

ddMD 	:= dedup(sort(distribute(cleanMD,hash(case_key)),
                  process_date, case_key, court, case_number, entity_1, entity_nm_format_1, 
									entity_type_description_1_orig, entity_type_code_1_master, entity_1_address_1,
									entity_1_address_2,entity_1_address_3, local),
									case_key, court, case_number, entity_1, entity_nm_format_1,entity_type_description_1_orig,
									entity_type_code_1_master, entity_1_address_1,entity_1_address_2,entity_1_address_3, local,left):
									PERSIST('~thor_data400::in::civil_MD_party');

EXPORT Map_MD_Party := ddMD;