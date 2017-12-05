IMPORT Civ_Court, civil_court, ut, lib_StringLib, std;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/wa_ltd_juri_civil_court02_upd.mp
fWAJud := Civ_Court.Files_In_WA.CivJud_in;
fWAPar := Civ_Court.Files_In_WA.CivPar_in;

fmtsin := [
		'%m/%d/%Y',
		'%m/%d/%Y'
	];
	fmtout:='%Y%m%d';	

Civil_Court.Layout_In_Matter tWA(fWAJud input) := Transform
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
self.case_cause_code		:= input.case_cause_number;
self.case_cause					:= '';
TempFileDte							:= Std.Date.ConvertDateFormatMultiple(input.filing_date,fmtsin,fmtout);
self.filing_date				:= If(STD.DATE.IsValidDate((INTEGER) TempFileDte),TempFileDte,'');
TempJudmtDte						:= Std.Date.ConvertDateFormatMultiple(input.judgement_date,fmtsin,fmtout);
self.judgmt_date				:= If(STD.DATE.IsValidDate((INTEGER) TempJudmtDte),TempJudmtDte,'');
self.judgmt_type_code 	:= input.judgement_type_code;
self.judgmt_type 				:= '';
TempJudgmtDte						:= Std.Date.ConvertDateFormatMultiple(input.judgement_disposition_date,fmtsin,fmtout);
self.judgmt_disposition_date :=	If(STD.DATE.IsValidDate((INTEGER) TempJudgmtDte),TempJudgmtDte,'');
self.judgmt_disposition_code := input.judgement_disposition_code;
self.judgmt_disposition := '';
self.disposition_code		:= input.case_disposition_code;
self.disposition_description := '';
TempDispDte							:= Std.Date.ConvertDateFormatMultiple(input.case_disposition_date,fmtsin,fmtout);
self.disposition_date 	:= If(STD.DATE.IsValidDate((INTEGER) TempDispDte),TempDispDte,'');
self := [];
end;

pWA 	:= project(fWAJud,tWA(left));

//Various code lookups
srt_court	:= sort(Civ_Court.Files_In_WA.court_desc,code);
srt_WA		:= dedup(sort(pWA,case_key,court_code,case_cause_code,judgmt_type_code,judgmt_disposition_code,disposition_code));

j_Court	:= join(srt_WA, srt_court,
								trim(left.court_code,all) = trim(right.code,all),
								transform({pWA},self.court := ut.CleanSpacesAndUpper(right.code_desc); self := left),left outer,lookup);
								
srt_CaseCause	:= sort(Civ_Court.Files_In_WA.cause_desc,code);

j_Cause	:= join(j_Court, srt_CaseCause,
								trim(left.case_cause_code,all) = trim(right.code,all),
								transform({pWA},self.case_cause := ut.CleanSpacesAndUpper(right.code_desc); self := left),left outer,lookup);
								
srt_JudgemntType	:= sort(Civ_Court.Files_In_WA.judgement_type,code);

j_JudgeType	:= join(j_Cause, srt_JudgemntType,
										trim(left.judgmt_type_code,all) = trim(right.code,all),
										transform({pWA},self.judgmt_type := ut.CleanSpacesAndUpper(right.code_desc); self := left),left outer,lookup);
										
srt_JudgemntDisp	:= sort(Civ_Court.Files_In_WA.judgement_disp,code);

j_JudgeDisp	:= join(j_JudgeType, srt_JudgemntDisp,
										trim(left.judgmt_disposition_code,all) = trim(right.code,all),
										transform({pWA},self.judgmt_disposition := ut.CleanSpacesAndUpper(right.code_desc); self := left),left outer,lookup);
										
srt_CaseDisp	:= sort(Civ_Court.Files_In_WA.case_desc,code);

j_CaseDisp	:= join(j_JudgeDisp, srt_CaseDisp,
										trim(left.disposition_code,all) = trim(right.code,all),
										transform({pWA},self.disposition_description := ut.CleanSpacesAndUpper(right.code_desc); self := left),left outer,lookup);
										
dWA 	:= dedup(sort(distribute(j_CaseDisp,hash(case_key)),
                  process_date, case_key, court, case_number, case_type, case_title, case_cause, 
									filing_date, judgmt_date, judgmt_type, judgmt_disposition_date, judgmt_disposition,
									disposition_description, disposition_date,local),
									case_key, court, case_number, case_type, case_title, case_cause, 
									filing_date, judgmt_date, judgmt_type, judgmt_disposition_date, 
									judgmt_disposition, disposition_description, disposition_date,local,left):
									PERSIST('~thor_data400::in::civil_washington_matter');


EXPORT Map_WA_Matter := dWA(case_number <> '');