IMPORT Civ_Court, civil_court, ut, Address, lib_StringLib;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/wa_ltd_juri_civil_court02_upd.mp
fWAJud := Civ_Court.Files_In_WA.CivJud_in;
fWAPar := Civ_Court.Files_In_WA.CivPar_in;

Civil_Court.Layout_In_Party tWA(fWAPar input, integer1 C) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '03';
self.state_origin				:= 'WA';
self.source_file				:= 'WA-CIVIL-LTD-JURI';
ClnCase									:= StringLib.StringFindReplace(input.case_number,'.','');
self.case_key					  := '03'+input.dist_mncp_court_code+input.case_type+ClnCase;
self.court_code					:= input.dist_mncp_court_code;
self.court						  := '';
self.case_number				:= ClnCase;
self.case_type_code			:= input.case_type;
self.case_type					:= IF(input.case_type = 'SC','SMALL CLAIMS','CIVIL');
self.case_title					:= input.case_title;
self.ruled_for_against_code := input.judgement_rule_code;
self.ruled_for_against 	:= IF(trim(input.judgement_rule_code,all) = 'F','FOR',
															IF(trim(input.judgement_rule_code,all) = 'A','AGAINST',''));
TempName								:= IF(REGEXFIND('AKA|DBA',input.participant_name),REGEXFIND('(.*)(AKA|DBA)(.*)',input.participant_name,1),input.participant_name);
TempAKA									:= IF(REGEXFIND('AKA|DBA',input.participant_name),REGEXFIND('(.*)(AKA|DBA)(.*)',input.participant_name,3),'');
self.entity_1						:= trim(CHOOSE(C,TempName,TempAKA),left,right);
self.entity_nm_format_1	:= IF(StringLib.StringFind(self.entity_1,',',1) > 0,'L','U');
self.entity_type_code_1_orig := input.participant_type_code;
self.entity_type_description_1_orig := '';
self.entity_type_code_1_master := map(input.participant_type_code = 'CCL' => '10',
																			input.participant_type_code = 'CDF' => '30',
																			input.participant_type_code = 'DBA' => '70',
																			input.participant_type_code = 'DEF' => '30',
																			input.participant_type_code = 'NEW' => '70',
																			input.participant_type_code = 'OLD' => '70',
																			input.participant_type_code = 'PET' => '70',
																			input.participant_type_code = 'PLA' => '10',
																			input.participant_type_code = 'RSP' => '70',
																			input.participant_type_code = 'XCL' => '10',
																			input.participant_type_code = 'XDF' => '30','90');
self := [];
end;

pWA 	:= normalize(fWAPar,2,tWA(left,counter));

//Various code lookups
srt_court	:= sort(Civ_Court.Files_In_WA.court_desc,code);
srt_WA		:= dedup(sort(pWA(entity_1 <> ''),case_key,court_code,entity_type_code_1_orig));

j_Court	:= join(srt_WA, srt_court,
								trim(left.court_code,all) = trim(right.code,all),
								transform({pWA},self.court := ut.CleanSpacesAndUpper(right.code_desc); self := left),left outer,lookup);
								
srt_ParticipantType	:= sort(Civ_Court.Files_In_WA.participant_type,code);

j_PartyType	:= join(j_Court, srt_ParticipantType,
										trim(left.entity_type_code_1_orig,all) = trim(right.code,all),
										transform({pWA},self.entity_type_description_1_orig := ut.CleanSpacesAndUpper(right.code_desc); self := left),left outer,lookup);
										
Civ_court.Civ_Court_Cleaner(j_PartyType,cleanWA);

ddWA 	:= dedup(sort(distribute(cleanWA,hash(case_key)),
                  process_date, case_key, court, case_number, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master,local),
									case_key, court, case_number, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master,local,left):
									PERSIST('~thor_data400::in::civil_washington_party');

EXPORT Map_WA_Party := ddWA;