IMPORT Civ_Court, civil_court, crim_common, ut, lib_StringLib, Std;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/wa_ltd_juri_civil_court02_upd.mp
fWAJud := Civ_Court.Files_In_WA.CivJud_in;
fWAPar := Civ_Court.Files_In_WA.CivPar_in;

fmtsin := [
		'%m/%d/%Y',
		'%m-%d-%Y'
	];
	fmtout:='%Y%m%d';	

Civil_Court.Layout_In_Case_Activity tWA(fWAJud input, integer1 C) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '03';
self.state_origin				:= 'WA';
self.source_file				:= 'WA-CIVIL-LTD-JURI';
ClnCase									:= StringLib.StringFindReplace(input.case_number,'.','');
self.case_key					  := '03'+input.dist_mncp_court_code+input.case_type+ClnCase;
self.court_code					:= input.dist_mncp_court_code;
self.court						  := '';
self.case_number				:= ClnCase;
self.event_date					:= CHOOSE(C,Std.Date.ConvertDateFormatMultiple(input.filing_date,fmtsin,fmtout),Std.Date.ConvertDateFormatMultiple(input.judgement_date,fmtsin,fmtout),
																		Std.Date.ConvertDateFormatMultiple(input.judgement_disposition_date,fmtsin,fmtout),Std.Date.ConvertDateFormatMultiple(input.case_disposition_date,fmtsin,fmtout));
self.event_type_code		:= CHOOSE(C,'',input.judgement_type_code, input.judgement_disposition_code, input.case_disposition_code);
self.event_type_description_1	:= CHOOSE(C,'FILING DATE','','','');
self := [];
end;

pWA	:= normalize(fWAJud,4,tWA(left,counter));

//Lookup court
srt_court	:= sort(Civ_Court.Files_In_WA.court_desc,code);
srt_WA		:= dedup(sort(pWA,case_number, court_code, event_type_code));

j_Court	:= join(srt_WA, srt_court,
								trim(left.court_code,all) = trim(right.code,all),
								transform({pWA},self.court := ut.CleanSpacesAndUpper(right.code_desc); self := left),lookup);

//Lookup event_type_description for judgement codes
srt_JudgemntType	:= sort(Civ_Court.Files_In_WA.judgement_type,code);

j_JudgeType	:= join(j_Court, srt_JudgemntType,
										trim(left.event_type_code,all) = trim(right.code,all),
										transform({j_Court},self.event_type_description_1 := ut.CleanSpacesAndUpper(right.code_desc); self := left),lookup);
										
srt_JudgemntDisp	:= sort(Civ_Court.Files_In_WA.judgement_disp,code);

j_JudgeDisp	:= join(j_JudgeType, srt_JudgemntDisp,
										trim(left.event_type_code,all) = trim(right.code,all),
										transform({j_JudgeType},self.event_type_description_1 := ut.CleanSpacesAndUpper(right.code_desc); self := left),lookup);
										
srt_CaseDisp	:= sort(Civ_Court.Files_In_WA.case_desc,code);

j_CaseDisp	:= join(j_JudgeDisp, srt_CaseDisp,
										trim(left.event_type_code,all) = trim(right.code,all),
										transform({j_JudgeDisp},self.event_type_description_1 := ut.CleanSpacesAndUpper(right.code_desc); self := left),lookup);

dWA 	:= dedup(sort(distribute(j_CaseDisp,hash(case_key)),
									process_date,case_key,court,case_number,event_date,event_type_code,event_type_description_1,local),
									case_key,court,case_number,event_date,event_type_code,event_type_description_1,local,left):
									PERSIST('~thor_data400::in::civil_washington_activity');

EXPORT Map_WA_Activity := dWA(event_type_description_1 <> '');