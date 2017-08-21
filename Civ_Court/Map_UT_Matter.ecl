IMPORT Civ_Court, civil_court, ut, lib_StringLib;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/ut_civ_02_upd.mp

filter_CaseType	:= ['FS','IF','MD','MO','PC','PN','TC','TN'];
fUT := Civ_Court.Files_In_UT.Civil_in(case_type not in filter_CaseType);

fmtsin := '%m/%d/%Y';
fmtout := '%Y%m%d';

Civil_Court.Layout_In_Matter tUT(fUT input) := Transform
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
self.filing_date				:= ut.ConvertDate(input.filing_date);
self.judgmt_type_code		:= input.jdmt_code;
self.judgmt_type				:= '';
self.judgmt_disposition_date	:= ut.ConvertDate(input.jdmt_filing_date);
self.disposition_code		:= input.disp_code;
self.disposition_description	:= '';
self.disposition_date		:= ut.ConvertDate(input.disp_date);
self := [];
end;

pUT 	:= project(fUT,tUT(left));

//Various code lookups
srt_CaseType	:= sort(Civ_Court.Files_In_UT.case_type_lkp,code);
srt_UT				:= sort(pUT,case_number, case_type_code, judgmt_type_code, disposition_code);

j_CaseType	:= join(srt_UT, srt_CaseType,
										trim(left.case_type_code,all) = trim(right.code,all),
										transform({pUT},self.case_type := ut.CleanSpacesAndUpper(right.code_desc); self := left),left outer,lookup);
										
srt_JudgmtType	:= sort(Civ_Court.Files_In_UT.judgement_lkp,code);

j_JudgmtType	:= join(j_CaseType, srt_JudgmtType,
											trim(left.judgmt_type_code,all) = trim(right.code,all),
											transform({pUT},self.judgmt_type := ut.CleanSpacesAndUpper(right.code_desc); self := left),left outer,lookup);
											
srt_Disposition	:= sort(Civ_Court.Files_In_UT.disposition_lkp,code);

j_Disp	:= join(j_JudgmtType, srt_Disposition,
								trim(left.disposition_code,all) = trim(right.code,all),
								transform({pUT},self.disposition_description := ut.CleanSpacesAndUpper(right.code_desc); self := left),left outer,lookup);
								
dUT 	:= dedup(sort(distribute(j_Disp,hash(case_key)),
                  process_date, case_key, court, case_number, case_type, 
									filing_date, judgmt_type, judgmt_disposition_date,
									disposition_description, disposition_date,local),
									case_key, court, case_number, case_type, 
									filing_date, judgmt_type, judgmt_disposition_date,
									disposition_description, disposition_date,local,left):
									PERSIST('~thor_data400::in::civil_utah_matter');

EXPORT Map_UT_Matter := dUT;