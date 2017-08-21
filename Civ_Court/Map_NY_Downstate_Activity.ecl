IMPORT Civ_Court, civil_court, ut, lib_StringLib;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/ny_civil_downstate_02_update.mp

fCase	:= Civ_Court.Files_In_NY_Downstate.Case_in;
fAty	:= Civ_Court.Files_In_NY_Downstate.Atty_In;
fApr	:= Civ_Court.Files_In_NY_Downstate.Apr_in;
fMtn	:= Civ_Court.Files_In_NY_Downstate.Mtn_in;
court	:= sort(Civ_Court.Files_In_NY_Downstate.Cnty_Codes_lkp,code);

//Join files to get fields needed for Activity output
l_temp	:= RECORD
	string2	county_code;
	string11	idxno;
	string3		seqno;
	string1		court_type;
	string60  court;
	string8		date_NOI_filed;
	string8		date_issue_joined;
	string8		jury_status_request_date1;
	string8		dte_atty_terminated_from_case;
	string8		dte_attys_closing_statement_filed;
	string8		orig_date;
	string8		date_decision_rendered;
	string8		date_order_signed;
	string8		settlement_date;
	string20	decision_comment;
	string8		appear_date;
	string6		appearance_type;
	string20	appearance_comment1;
	string20	appearance_comment2;
END;

l_temp tCaseAty(fCase L, fAty R) := TRANSFORM
	self.county_code	:= L.county_code;
	self.idxno				:= L.idxno;
	self.seqno				:= L.seqno;
	self.court_type		:= L.court_type;
	self.date_NOI_filed							:= IF(L.date_NOI_filed = '00000000','',L.date_NOI_filed);
	self.date_issue_joined 					:= IF(L.date_issue_joined = '00000000','',L.date_issue_joined);
	self.jury_status_request_date1	:= IF(L.jury_status_request_date1 = '00000000','',L.jury_status_request_date1);
	self.dte_atty_terminated_from_case			:= IF(R.date_atty_terminated_from_case = '00000000','',R.date_atty_terminated_from_case);
	self.dte_attys_closing_statement_filed	:= IF(R.date_attys_closing_statement_filed = '00000000','',R.date_attys_closing_statement_filed);
	self := L;
	self := [];
END;

jCaseAty	:= join(sort(distribute(fCase(idxno <> ''),hash(idxno,seqno,county_code)),idxno,seqno,county_code,court_type,local),
									sort(distribute(fAty,hash(idxno,seqno,county_code)),idxno,seqno,county_code,local),
									trim(left.county_code,all) = trim(right.county_code,all) and
									trim(left.idxno,all) = trim(right.idxno,all) and
									trim(left.seqno,all) = trim(right.seqno,all),
									tCaseAty(left,right),left outer,local);
									
l_temp tCaseMtn(jCaseAty L, fMtn R) := TRANSFORM
	self.orig_date							:= IF(R.orig_date = '00000000','',R.orig_date);
	self.date_decision_rendered	:= IF(R.date_decision_rendered = '00000000','',R.date_decision_rendered);
	self.date_order_signed			:= IF(R.date_order_signed = '00000000','',R.date_order_signed);
	self.settlement_date				:= IF(R.settlement_date = '00000000','',R.settlement_date);
	self.decision_comment				:= ut.CleanSpacesAndUpper(R.decision_comment);
	self := L;
END;

jCaseMtn	:= join(jCaseAty,
									sort(distribute(fMtn,hash(idxno,seqno,county_code)),idxno,seqno,county_code,local),
									trim(left.county_code,all) = trim(right.county_code,all) and
									trim(left.idxno,all) = trim(right.idxno,all) and
									trim(left.seqno,all) = trim(right.seqno,all),
									tCaseMtn(left,right),left outer,local);
									
l_temp tCaseApr(jCaseMtn L, fApr R)	:= TRANSFORM
	self.appear_date			:= IF(R.appear_date = '00000000','',R.appear_date);
	self.appearance_comment1	:= ut.CleanSpacesAndUpper(R.comment1);
	self.appearance_comment2	:= ut.CleanSpacesAndUpper(R.comment2);
	self	:= L;
END;

jCaseApr	:= join(jCaseMtn,
									sort(distribute(fApr,hash(idxno,seqno,county_code)),idxno,seqno,county_code,local),
									trim(left.county_code,all) = trim(right.county_code,all) and
									trim(left.idxno,all) = trim(right.idxno,all) and
									trim(left.seqno,all) = trim(right.seqno,all),
									tCaseApr(left,right),left outer,local);
									
//Do court code lookup because court_type is needed and not stored in final output
l_temp	lkpCourt(jCaseApr L, court R)	:= TRANSFORM
	self.court	:= map(trim(L.court_type) = '0' => ut.CleanSpacesAndUpper(R.description)+' COUNTY, NY COUNTY COURT',
										trim(L.court_type) = '1' => ut.CleanSpacesAndUpper(R.description)+' COUNTY, NY SUPERIOR COURT',
										ut.CleanSpacesAndUpper(R.description)+' COUNTY, NY COURT');
	self := L;
END;

jCaseCourt	:= join(jCaseApr, court,
										trim(left.county_code,all) = trim(right.code,all),
										lkpCourt(left,right),left outer,lookup);

Civil_Court.Layout_In_Case_Activity tNY(jCaseCourt input, integer1 C) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '25';
self.state_origin				:= 'NY';
self.source_file				:= 'NY-STATEWIDE-CIV-CRT';
ClnCase									:= trim(input.county_code,all)+trim(input.idxno,all)+trim(input.seqno,all);
self.case_key					  := '25'+ ClnCase;
self.court_code					:= trim(input.county_code,all);
self.court						  := trim(input.court);
self.case_number				:= ClnCase;
self.event_date					:= CHOOSE(C,input.date_NOI_filed,
																		input.date_issue_joined,
																		input.jury_status_request_date1,
																		input.dte_atty_terminated_from_case,
																		input.dte_attys_closing_statement_filed,
																		input.orig_date,
																		input.date_decision_rendered,
																		input.date_order_signed,
																		input.settlement_date,
																		input.appear_date);			
self.event_type_description_1	:= CHOOSE(C,'NOTE OF ISSUE FILED',
																					'ISSUE JOINED',
																					'JURY STATUS REQUESTED',
																					'ATTORNEY TERMINATED FROM CASE',
																					'CLOSING STATEMENT FILED WITH COUNTRY CLERK',
																					'MOTION ORIGINAL FILE DATE',
																					'DATE DECISION RENDERED ON MOTION',
																					'DATE ORDER SIGNED',
																					'SETTLEMENT DATE',
																					'APPEARANCE DATE');
self.event_type_description_2	:= CHOOSE(C,'','','','','','','','',input.decision_comment,
																					trim(input.appearance_comment1,left,right)+' '+trim(input.appearance_comment2,left,right));
self := [];
end;

pNY	:= normalize(jCaseCourt,10,tNY(left,counter));

dNY 	:= dedup(sort(distribute(pNY(event_date <> ''),hash(case_key)),
									process_date,case_key,court,case_number,event_date,event_type_description_1,local),
									case_key,court,case_number,event_date,
									event_type_description_1,event_type_description_2,local,left):
									PERSIST('~thor_data400::in::civil_NY_Downstate_activity');

EXPORT Map_NY_Downstate_Activity := dNY;