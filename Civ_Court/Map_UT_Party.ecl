IMPORT Civ_Court, civil_court, ut, Address, lib_StringLib;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/ut_civ_02_upd.mp

filter_CaseType	:= ['FS','IF','MD','MO','PC','PN','TC','TN'];
fUT := Civ_Court.Files_In_UT.Civil_in(case_type not in filter_CaseType);

Civil_Court.Layout_In_Party tUT(fUT input) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '47';
self.state_origin				:= 'UT';
self.source_file				:= 'UT-STATEWIDE-CIV-CRT';
self.case_key					  := '47'+' '+hash(input.case_num+input.locn_code+input.locn_descr+input.case_type);
self.court_code					:= input.locn_code;
self.court						  := REGEXREPLACE('[0-9]',input.locn_descr,'');
self.case_number				:= trim(input.case_num,left,right);
self.case_type_code			:= input.case_type;
self.case_type					:= '';
filter_LName						:= IF(Civ_Court.IsInvalidName(input.last_name) = 1 ,'',input.last_name);
filter_FName						:= IF(Civ_Court.IsInvalidName(input.first_name) = 1,'',input.first_name);
ClnLName								:= REGEXREPLACE('\\(|\\)|"|`',filter_LName,'');
ClnFName								:= REGEXREPLACE('\\(|\\)|"|`',filter_FName,'');
self.entity_1						:= stringlib.stringcleanspaces(IF(ClnLName <> '' and ClnFName = '',ClnLName,
																												IF(REGEXFIND(' JR$| SR$',ClnFName),ClnLname+' '+ClnFname, ClnFName+' '+ClnLName)));	
self.entity_nm_format_1	:= IF(REGEXFIND(' JR$| SR$',ClnFName),'L','F');
self.entity_type_code_1_orig := input.party_code;
self.entity_type_description_1_orig	:= '';
self.entity_type_code_1_master := map(input.party_code = 'DEF' => '30',
																			input.party_code = 'RES' => '70',
																			input.party_code = 'PET' => '70',
																			input.party_code = 'PLA' => '10',
																			input.party_code = 'DBA' => '51',
																			input.party_code = 'EXM' => '60','90');
self := [];
end;

pUT 	:= project(fUT,tUT(left));

//Various code lookups
srt_CaseType	:= sort(Civ_Court.Files_In_UT.case_type_lkp,code);
srt_UT				:= sort(pUT(entity_1 <> ''),case_number, case_type_code, entity_type_code_1_orig);

j_CaseType	:= join(srt_UT, srt_CaseType,
										trim(left.case_type_code,all) = trim(right.code,all),
										transform({pUT},self.case_type := ut.CleanSpacesAndUpper(right.code_desc); self := left),left outer,lookup);
										
srt_PartyType	:= sort(Civ_Court.Files_In_UT.party_type_lkp,code);

j_PartyType	:= join(j_CaseType, srt_PartyType,
										trim(left.entity_type_code_1_orig,all) = trim(right.code,all),
										transform({pUT},self.entity_type_description_1_orig := ut.CleanSpacesAndUpper(right.code_desc); self := left),left outer,lookup);
										
Civ_court.Civ_Court_Cleaner(j_PartyType,cleanUT);

ddUT 	:= dedup(sort(distribute(cleanUT,hash(case_key)),
                  process_date, case_key, court, case_number, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master,local),
									case_key, court, case_number, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master,local,left):
									PERSIST('~thor_data400::in::civil_utah_party');

EXPORT Map_UT_Party := ddUT;