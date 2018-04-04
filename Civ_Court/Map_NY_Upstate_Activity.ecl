IMPORT Civ_Court, civil_court, ut, lib_StringLib, Std;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/ny_civil_downstate_02_update.mp

fCase	:= Civ_Court.Files_In_NY_Upstate.Case_in(idxno <> '');
fAty	:= Civ_Court.Files_In_NY_Upstate.Atty_In(attorney_client <> '');
fMtn	:= Civ_Court.Files_In_NY_Upstate.Mtn_in(justice <> '');
fApr	:= Civ_Court.Files_In_NY_Upstate.Apr_in(justice <> '');

// Lookups
court	:= Civ_Court.Files_In_NY_Upstate.County_lkp;
apr_lkp	:= sort(Civ_Court.Files_In_NY_Upstate.Apr_type_lkp,code);

//Join Case and attorney file
l_temp := RECORD
   string2 	county_code;
   string15	idxno;
	 string2 	court_code;
	 string13 county;
	 string10	rji_dispos_deadline;
   string10	rji_pre_noi_deadline;
   string10 rji_noi_disp_deadline;
	 string10 noi_was_filed;
	 string10 case_began;
   string10 noi_filed;
   string10 noi_due;
   string10 last_pre_tr_conf_sched;
   string10 last_pre_tr_conf_held;
   string10	last_prelim_conf_req;
   string10 last_prelim_conf_sched;
   string10 last_prelim_conf_held;
   string10 last_update_date;
   string10 attorney_retainer;
   string10 date_terminated;
END;

//Do court code lookup because court_type is needed and not stored in final output - will use this as input for all joins due to county field
l_temp	lkpCourt(fCase L, court R)	:= TRANSFORM
	self.county	:= ut.CleanSpacesAndUpper(R.description);
	self := L;
	self := [];
END;

jCaseCourt	:= join(sort(distribute(fCase,hash(county_code)),county_code,local),
										sort(distribute(court,hash(code)),code,local),
										trim(left.county_code,all) = trim(right.code,all),
										lkpCourt(left,right),left outer,lookup,local);

l_temp	tCaseAtty(jCaseCourt L, fAty R)	:= TRANSFORM
   self.county_code					:= trim(L.county_code,all);
   self.idxno								:= trim(L.idxno,all);
	 self.court_code					:= trim(L.court_code,all);
	 self.county							:= L.county;
	 self.rji_dispos_deadline	:= trim(L.rji_dispos_deadline,all);
   self.rji_pre_noi_deadline	:= trim(L.rji_pre_noi_deadline,all);
   self.rji_noi_disp_deadline	:= trim(L.rji_noi_disp_deadline,all);
	 self.noi_was_filed					:= trim(L.noi_was_filed,all);
   self.case_began						:= trim(L.case_began,all);
   self.noi_filed							:= trim(L.noi_filed,all);
   self.noi_due								:= trim(L.noi_due,all);
   self.last_pre_tr_conf_sched	:= trim(L.last_pre_tr_conf_sched,all);
   self.last_pre_tr_conf_held		:= trim(L.last_pre_tr_conf_held,all);
   self.last_prelim_conf_req		:= trim(L.last_prelim_conf_req,all);
   self.last_prelim_conf_sched	:= trim(L.last_prelim_conf_sched,all);
   self.last_prelim_conf_held		:= trim(L.last_prelim_conf_held,all);
   self.last_update_date				:= trim(L.last_update_date,all);
   self.attorney_retainer				:= trim(R.attorney_retainer,all);
   self.date_terminated					:= trim(R.date_terminated,all);
	 self := [];
END;

jCaseAty	:= join(sort(distribute(jCaseCourt,hash(county_code,idxno)),county_code,idxno,local),
									sort(distribute(fAty,hash(county_code,idxno)),county_code,idxno,local),
									trim(left.county_code) = trim(right.county_code) and
									trim(left.idxno) = trim(right.idxno),
									tCaseAtty(left,right), left outer, local);									

fmtsin := [
		'%m/%d/%Y',
		'%m-%d-%Y'
	];
	fmtout:='%Y%m%d';	

Civil_Court.Layout_In_Case_Activity tCase(jCaseAty input, integer1 C) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '30';
self.state_origin				:= 'NY';
self.source_file				:= 'NY-UPSTATE-CIV-COURT';
ClnCase									:= trim(input.county_code,all)+trim(input.idxno,all);
self.case_key					  := '30'+ ClnCase;
self.court_code					:= trim(input.county_code,all);
self.court						  := map(trim(input.court_code) = '0' => 'NEW YORK STATE LOWER CIVIL COURT: '+input.county,
																trim(input.court_code) = '1' => 'NEW YORK STATE SUPREME CIVIL COURT: '+input.county,
																'NEW YORK STATE COURT');
self.case_number				:= ClnCase;
self.event_date					:= Std.Date.ConvertDateFormatMultiple(CHOOSE(C,input.rji_dispos_deadline,
																									input.rji_pre_noi_deadline,
																									input.rji_noi_disp_deadline,
																									input.noi_was_filed,
																									input.case_began,
																									input.noi_filed,
																									input.noi_due,
																									input.last_pre_tr_conf_sched,
																									input.last_pre_tr_conf_held,
																									input.last_prelim_conf_req,
																									input.last_prelim_conf_sched,
																									input.last_prelim_conf_held,
																									input.last_update_date,
																									input.date_terminated,
																									input.attorney_retainer),fmtsin,fmtout);
self.event_type_code		:= '';
self.event_type_description_1 := CHOOSE(C,'CALCULATED DEADLINE DATE FOR ',
																					'FROM REQUEST FOR JUDICIAL INTERVENTION TIL ',
																					'POST NOTE OF ISSUE TO DISPOSITION DEADLINE DATE',
																					'NOTE OF ISSUE WAS FILED DATE',
																					'DATE CASE COMMENCED',
																					'NOTE OF ISSUE FILE DATE',
																					'DATE NOTE OF ISSUE FILE DATE IS DUE',
																					'LAST PRE-TRIAL CONFERENCE SCHEDULED',
																					'LAST PRE-TRIAL CONFERENCE HELD',
																					'LAST PRELIMINARY CONFERENCE REQUESTED',
																					'LAST PRELIMINARY CONFERENCE SCHEDULED',
																					'LAST PRELIMINARY CONFERENCE HELD',
																					'DATE CASE WAS LAST UPDATED BY COURT',
																					'DATE ATTORNEY WAS TERMINATED FROM CASE',
																					'DATE ATTORNEY WAS RETAINED');

self.event_type_description_2 := CHOOSE(C,'REQUEST FOR JUDICIAL INTERVENTION TO DISPOSITION',
																					'PRE NOTE OF ISSUE DEADLINE DATE',
																					'','','','','','','','','','','','','');
self := [];
END;

pCase	:= normalize(jCaseAty,15,tCase(left,counter));

//Run Motion file - *Note - running each file individually as there are too many input fields involved which is causing long run times
//Join to case to get county info and make sure there are no orphan records
l_temp2	:= RECORD
	 string2 	county_code;
   string15	idxno;
	 string2 	court_code;
	 string13 county;
	 string10 submission_date;
   string10 applying_filed;
   string10 opposing_filed;
   string10 date_of_decision;
   string255 	essentials_of_decision;
   string10 	order_signed_date;
   string10 	motion_due_date;
   string10 	original_motion_date;
END;

l_temp2	tCaseMtn(jCaseCourt L, fMtn R) := TRANSFORM
   self.county_code					:= L.county_code;
   self.idxno								:= L.idxno;
	 self.court_code					:= L.court_code;
	 self.county							:= L.county;
	 self.submission_date			:= trim(R.submission_date,all);
   self.applying_filed			:= trim(R.applying_filed,all);
   self.opposing_filed			:= trim(R.opposing_filed,all);
   self.date_of_decision		:= trim(R.date_of_decision,all);
   self.essentials_of_decision := ut.CleanSpacesAndUpper(R.essentials_of_decision);
   self.order_signed_date		:= trim(R.order_signed_date,all);
   self.motion_due_date			:= trim(R.motion_due_date,all);
   self.original_motion_date	:= trim(R.original_motion_date,all);
END;

jCaseMtn	:= join(sort(distribute(jCaseCourt,hash(county_code,idxno)),county_code,idxno,local),
									sort(distribute(fMtn,hash(county_code,idxno)),county_code,idxno,local),
									trim(left.county_code) = trim(right.county_code) and
									trim(left.idxno) = trim(right.idxno),
									tCaseMtn(left,right), left outer, local);
	 
Civil_Court.Layout_In_Case_Activity tMtn(jCaseMtn input, integer1 C) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '30';
self.state_origin				:= 'NY';
self.source_file				:= 'NY-UPSTATE-CIV-COURT';
ClnCase									:= trim(input.county_code,all)+trim(input.idxno,all);
self.case_key					  := '30'+ ClnCase;
self.court_code					:= trim(input.county_code,all);
self.court						  := map(trim(input.court_code) = '0' => 'NEW YORK STATE LOWER CIVIL COURT: '+input.county,
																trim(input.court_code) = '1' => 'NEW YORK STATE SUPREME CIVIL COURT: '+input.county,
																'NEW YORK STATE COURT');
self.case_number				:= ClnCase;
self.event_date					:= Std.Date.ConvertDateFormatMultiple(CHOOSE(C,input.submission_date,
																									input.applying_filed,
																									input.opposing_filed,
																									input.date_of_decision,
																									input.order_signed_date,
																									input.motion_due_date,
																									input.original_motion_date),fmtsin,fmtout);
self.event_type_code		:= '';
self.event_type_description_1 := CHOOSE(C,'DATE MOTION SUBMITTED FOR DECISION',
																					'APPLYING PARTY FILED MOTION',
																					'OPPOSING PARTY FILED MOTION',
																					input.essentials_of_decision,
																					'DATE THE ORDER WAS SIGNED',
																					'DATE MOTION DECISION IS DUE',
																					'ORIGINAL MOTION DATE');

self.event_type_description_2 := '';
self := [];
END;

pMtn	:= normalize(jCaseMtn,7,tMtn(left,counter));

//Run Appearance file
l_temp3	:= RECORD
	 string2 	county_code;
   string15	idxno;
	 string2 	court_code;
	 string13 county;
	 string10 appearance_date;
	 string6 	appearance_type;
	 string20 appearance_comment1;
	 string20 appearance_comment2;
END;

l_temp3	tCaseApr(jCaseCourt L, fApr R) := TRANSFORM
   self.county_code					:= L.county_code;
   self.idxno								:= L.idxno;
	 self.court_code					:= L.court_code;
	 self.county							:= L.county;
	 self.appearance_date			:= trim(R.appearance_date,all);
	 self.appearance_type			:= ut.CleanSpacesAndUpper(R.appearance_type);
	 self.appearance_comment1	:= ut.CleanSpacesAndUpper(R.appearance_comment1);
	 self.appearance_comment2	:= ut.CleanSpacesAndUpper(R.appearance_comment2);
END;

jCaseApr	:= join(sort(distribute(jCaseCourt,hash(county_code,idxno)),county_code,idxno,local),
									sort(distribute(fApr(appearance_date <> ''),hash(county_code,idxno)),county_code,idxno,local),
									trim(left.county_code) = trim(right.county_code) and
									trim(left.idxno) = trim(right.idxno),
									tCaseApr(left,right), left outer, local);
									
Civil_Court.Layout_In_Case_Activity tApr(jCaseApr L, apr_lkp R) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '30';
self.state_origin				:= 'NY';
self.source_file				:= 'NY-UPSTATE-CIV-COURT';
ClnCase									:= trim(L.county_code,all)+trim(L.idxno,all);
self.case_key					  := '30'+ ClnCase;
self.court_code					:= trim(L.county_code,all);
self.court						  := map(trim(L.court_code) = '0' => 'NEW YORK STATE LOWER CIVIL COURT: '+L.county,
																trim(L.court_code) = '1' => 'NEW YORK STATE SUPREME CIVIL COURT: '+L.county,
																'NEW YORK STATE COURT');
self.case_number				:= ClnCase;
self.event_date					:= Std.Date.ConvertDateFormatMultiple(L.appearance_date,fmtsin,fmtout);
self.event_type_code		:= L.appearance_type;
self.event_type_description_1 := ut.CleanSpacesAndUpper(R.description);
self.event_type_description_2 := trim(L.appearance_comment1,left,right)+' '+trim(L.appearance_comment2,left,right);
self := [];
END;

pApr	:= join(sort(distribute(jCaseApr,hash(appearance_type)),appearance_type,local),
							sort(distribute(apr_lkp,hash(code)),code,local),
							trim(left.appearance_type,all) = trim(right.code,all),
							tApr(left,right),left outer,lookup,local);
							
//Concat all three files
jAll	:= pCase+pMtn+pApr;

dNY 	:= dedup(sort(distribute(jAll(event_date <> ''),hash(case_key)),
									process_date,case_key,court,case_number,event_date,event_type_description_1,local),
									case_key,court,case_number,event_date,
									event_type_description_1,event_type_description_2,local,left):
									PERSIST('~thor_data400::in::civil_NY_Upstate_activity');
	 

EXPORT Map_NY_Upstate_Activity := dNY;