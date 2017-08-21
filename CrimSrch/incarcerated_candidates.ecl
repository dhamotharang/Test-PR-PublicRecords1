import ut, lib_stringlib, crim_common, crimsrch, lib_date;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////JOIN NECESSARY FIELDS
///////////OFFENDER >> offender_key, case_filing_dt, party_status_desc
///////////OFFENSES >> offender_key, court_disp_date, sent_date, court_disp_desc_1, court_disp_code, sent_date, sent_jail
///////////DOC OFFENSES >> offender_key, offense_key, stc_dt, stc_lgth, stc_lgth_desc, inc_adm_dt, min_term, min_term_desc, max_term, max_term_desc
///////////PUNISHMENT >> offender_key, offense_key, punishment_type, event_dt, sent_length, sent_length_desc, cur_stat_inm_desc, cur_loc_inm, latest_adm_dt, sch_rel_dt, ctl_rel_dt, act_rel_dt, par_st_dt
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

export incarcerated_candidates := module

toffender :=	table(distribute(Crim_Common.File_Moxie_Crim_Offender2_Dev, hash(offender_key)), {offender_key, data_type, case_filing_dt, party_status_desc});
toffenses :=	/* no doc */ table(distribute(Crim_Common.File_Moxie_Court_Offenses_Dev, hash(offender_key)), {offender_key, off_date, arr_date, court_disp_date, court_disp_desc_1, court_disp_code, sent_date, sent_jail}); //using accurint, lost incarceration adm date and orig offense key
tdocoffenses :=	table(distribute(Crim_Common.File_Moxie_DOC_Offenses_Dev, hash(offender_key)), {offender_key, offense_key, arr_date, off_date, ct_disp_dt, ct_disp_desc_1, stc_dt, stc_lgth, stc_lgth_desc, inc_adm_dt, min_term, min_term_desc, max_term, max_term_desc});
tpunishment :=	table(distribute(Crim_Common.File_Moxie_DOC_Punishment_Dev, hash(offender_key)), {offender_key, punishment_type, offense_key, event_dt, sent_length, sent_length_desc, inmate_cur_status_desc := cur_stat_inm_desc, inmate_cur_loc := cur_loc_inm, admit_latest_date := latest_adm_dt, sch_rel_dt, ctl_rel_dt, release_actual_date := act_rel_dt, parole_start_date := par_st_dt});

comb_layout := record
toffender.offender_key;
toffender.data_type;
string2 vendor;
DER_case_filing_dt := toffender.case_filing_dt;
DER_party_status_desc :=	toffender.party_status_desc;
SES_off_date := toffenses.off_date;
SES_arr_date := toffenses.arr_date;
SES_court_disp_date :=	toffenses.court_disp_date;
SES_court_disp_desc_1 := toffenses.court_disp_desc_1;
SES_court_disp_code :=	toffenses.court_disp_code;
SES_sent_date :=	toffenses.sent_date;
SES_sent_jail :=	toffenses.sent_jail;
DSES_offense_key := tdocoffenses.offense_key;
DSES_inc_adm_dt := tdocoffenses.inc_adm_dt;
DSES_ct_disp_dt:= tdocoffenses.ct_disp_dt;
DSES_ct_disp_desc_1 := tdocoffenses.ct_disp_desc_1;
DSES_arr_date := tdocoffenses.arr_date;
DSES_off_date := tdocoffenses.off_date;
DSES_stc_dt := tdocoffenses.stc_dt;
DSES_stc_lgth := tdocoffenses.stc_lgth;
DSES_stc_lgth_desc := tdocoffenses.stc_lgth_desc;
DSES_min_term := tdocoffenses.min_term;
DSES_min_term_desc := tdocoffenses.min_term_desc;
DSES_max_term := tdocoffenses.max_term;
DSES_max_term_desc := tdocoffenses.max_term_desc;
PUN_orig_offense_key := tpunishment.offense_key;
PUN_punishment_type := tpunishment.punishment_type;
PUN_event_date :=	tpunishment.event_dt;
PUN_sent_length :=	tpunishment.sent_length;
PUN_sent_length_desc :=	tpunishment.sent_length_desc;
PUN_inmate_cur_status_desc :=	tpunishment.inmate_cur_status_desc;
PUN_inmate_cur_loc :=	tpunishment.inmate_cur_loc;
PUN_admit_latest_date :=	tpunishment.admit_latest_date;
PUN_release_actual_date :=	tpunishment.release_actual_date;
PUN_parole_start_date := tpunishment.parole_start_date;
PUN_sch_rel_dt := tpunishment.sch_rel_dt;
PUN_ctl_rel_dt := tpunishment.ctl_rel_dt;
conviction_override_date := '';
conviction_override_date_type := '';
fcra_conviction_flag := '';
end;

comb_layout combine_files1(toffender l, toffenses r) := transform
	self.offender_key := L.offender_key;
	self.vendor := L.offender_key[1..2];
	self.der_party_status_desc := L.party_status_desc;
	self.DER_case_filing_dt := l.case_filing_dt;
	self.data_type := l.data_type;
	self.SES_sent_date :=	r.sent_date;
	self.SES_sent_jail := r.sent_jail;
	self.SES_court_disp_date := r.court_disp_date;
	self.SES_court_disp_desc_1 := r.court_disp_desc_1;
	self.SES_court_disp_code := r.court_disp_code;
	self := [];
end;

comboutput1 := join(toffender, toffenses, left.offender_key = right.offender_key, combine_files1(left,right), left outer);

comb_layout combine_files2(comb_layout l, tpunishment r) := transform
	self.PUN_orig_offense_key := r.offense_key;
	self.PUN_PUNishment_type := r.PUNishment_type;
	self.PUN_event_date :=	r.event_dt;
	self.PUN_sent_length :=	r.sent_length;
	self.PUN_sent_length_desc :=	r.sent_length_desc;
	self.PUN_inmate_cur_status_desc :=	r.inmate_cur_status_desc;
	self.PUN_inmate_cur_loc :=	r.inmate_cur_loc;
	self.PUN_admit_latest_date :=	r.admit_latest_date;
	self.PUN_release_actual_date :=	r.release_actual_date;
	self.PUN_parole_start_date := r.parole_start_date;
	self.PUN_sch_rel_dt := r.sch_rel_dt;
	self.PUN_ctl_rel_dt := r.ctl_rel_dt;
	self := L;
	// self := [];
end;

comboutput2 := join(comboutput1, tpunishment(punishment_type = 'I'), left.offender_key = right.offender_key, combine_files2(left,right));

comb_layout combine_files3(comb_layout l, tdocoffenses r) := transform
	self.DSES_offense_key := r.offense_key;
	self.DSES_inc_adm_dt := r.inc_adm_dt;
	self.DSES_stc_dt := r.stc_dt;
	self.DSES_stc_lgth := r.stc_lgth;
	self.DSES_stc_lgth_desc := r.stc_lgth_desc;
	self.DSES_min_term := r.min_term;
	self.DSES_min_term_desc := r.min_term_desc;
	self.DSES_max_term := r.max_term;
	self.DSES_max_term_desc := r.max_term_desc;
	self.conviction_override_date := 	map(l.data_type = '1' and (integer)l.PUN_release_actual_date <>0 => l.PUN_release_actual_date,
												l.data_type = '1' and (integer)l.PUN_parole_start_date <>0  => l.PUN_parole_start_date,
												l.data_type = '1' and (integer)l.PUN_admit_latest_date <>0 => l.PUN_admit_latest_date,
												l.data_type = '1' and (integer)r.ct_disp_dt <>0 => r.ct_disp_dt,
												l.data_type = '1' and (integer)r.inc_adm_dt <>0 => r.inc_adm_dt,
												l.data_type = '1' and (integer)r.off_date <>0 => r.off_date,
												l.data_type = '1' and (integer)r.arr_date <>0 => r.arr_date,
												(integer)l.SES_court_disp_date <>0 => l.SES_court_disp_date,
												(integer)l.SES_sent_date <>0 => l.SES_sent_date,
												(integer)l.SES_off_date <>0 => l.SES_off_date,
												(integer)l.SES_arr_date <>0 => l.SES_arr_date,
												(integer)l.DER_case_filing_dt <>0 => l.DER_case_filing_dt,
												'');
	self.conviction_override_date_type := case(self.conviction_override_date,
												l.PUN_release_actual_date => 'R',
												l.PUN_parole_start_date  => 'P',
												l.PUN_admit_latest_date => 'I',
												r.ct_disp_dt => 'D',
												r.inc_adm_dt => 'I',
												r.off_date => 'O',
												r.arr_date => 'A',
												l.SES_court_disp_date => 'D',
												l.SES_sent_date => 'S',
												l.SES_off_date => 'O',
												l.SES_arr_date => 'A',
												l.DER_case_filing_dt => 'F',
												'U');
	self.fcra_conviction_flag := if(l.offender_key[1..2]  not in CrimSrch.sDOC_Vendors_Conviction_Unknown and l.data_type = '1',if(l.Data_Type='1' 												and
										  l.offender_key[1..2] not in CrimSrch.sDOC_Vendors_Conviction_Unknown 	and
										  l.offender_key[1..2] not in CrimSrch.sDOC_Vendors_NoOffense_NoConviction,
										  'Y',
										 'D'
										), 
											if(l.offender_key[1..2] in CrimSrch.sDOC_Vendors_Conviction_Unknown and l.data_type = '1', 'U',
																					  if(l.Data_Type='1' and
										  l.offender_key[1..2] not in CrimSrch.sDOC_Vendors_Conviction_Unknown 	and
										  l.offender_key[1..2] not in CrimSrch.sDOC_Vendors_NoOffense_NoConviction,
										'Y',
										'N'
										))); 
	self := L;
	// self := [];
end;

shared comboutput3 := join(comboutput2, tdocoffenses, left.offender_key = right.offender_key and left.PUN_orig_offense_key = right.offense_key, combine_files3(left,right)) 
						: persist('~thor_data400::persist::crim_court::combined_files2');

export joined_files := comboutput3;


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////************************************////////////////////////////////////////////////////////
//////////////////////////GENERATE FLAGS AND NEW LAYOUTS BELOW////////////////////////////////////////////////////////
//////////////////////////************************************////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////search life/death in sent info
shared flag_ldsearch(string input) := function
	testPass := map(regexfind('(LIFE)|(DEATH)', input) => 50, 
					0);
return testPass;
end;

/////STATUS DESCRIPTION SD
shared flag_statdesc(string input) := function
	testActive := if(regexfind('ACTIVE', stringlib.stringtouppercase(input)) , 1, 0);
	testCust := if(regexfind('(IN +CUSTODY)|(INCARCERATED)|(ATC +CUSTODY)', stringlib.stringtouppercase(input)), 1, 0);
	testInmate := if(regexfind('^INMATE$', stringlib.stringtouppercase(input)) , 1, 0);
	testDeath := if(regexfind('(DEATH)|(EXECUTION)', stringlib.stringtouppercase(input)) , 1, 0);
	testReturn := if(regexfind('(RETURN)', stringlib.stringtouppercase(input)) , 1, 0);
	testFail := if(regexfind('(DISCH)|(NOT +IN +CUSTODY)|(INACTIVE)|(NOT +ACTIVE)', stringlib.stringtouppercase(input)), true, false);
	testPass := map(testActive + testCust + testInmate + testDeath > 0 and ~testFail => 100, 
					~testFail => 50, 
					testFail => -100, 0);
return testPass;
end;

////// PARTY STATUS DESCRIPTION PSD
shared flag_ptystatdesc(string input) := function
	testHeld := if(regexfind('HELD.*IN.*FACILITY', stringlib.stringtouppercase(input)) , 1, 0);
	testActive := if(regexfind('(POPULATION)|(IN +CUSTODY)|(ACT +CUSTODY)|(ACTIVE +INMATE)|(INCARCERATED)', stringlib.stringtouppercase(input)), 1, 0);
	testFail := if(regexfind('(DISCH)|(DEATH)|(DEAD)|(DECEASED)|(RELEASE)|(INACTIVE)|(NOT +ACTIVE)|(NOT +INCARCERATED)', stringlib.stringtouppercase(input)), true, false);
	testPass := map(testHELD  + testActive > 0 and ~testFail=> 100, 0);
return testPass;
end;

////// CURRENT LOCATION DESCRIPTION PCL
shared flag_currloc(string input) := function
	testneutral := if(input = '', true, false);
	testFail := if(regexfind('(DISCH)|(UNKNOWN)|(DEAD)|(DECEASED)|(RELEASE)|(INACTIVE)|(NOT +ACTIVE)|(NOT +INCARCERATED)', stringlib.stringtouppercase(input)), true, false);
	testPass := map(~testFail and ~testneutral => 50 , 0);
return testPass;
end;

////// INC ADM DATE DESCRIPTION PCL
shared flag_incadmdt(string input) := function
	testFail := if(input not between '19000101' and CrimSrch.Version.Development, true, false);
	testPass := map(testFail => 0, 75);
return testPass;
end;

////// SENTENCE DATE PCL
shared flag_sntdt(string input) := function
	testFail := if(input not between '19000101' and CrimSrch.Version.Development, true, false);
	testPass := map(testFail => 0, 50);
return testPass;
end;

////// CASE FILING DATE PCL
shared flag_csfildt(string input) := function
	testFail := if(input not between '19000101' and CrimSrch.Version.Development, true, false);
	testPass := map(testFail => 0, 25);
return testPass;
end;

////// OFFENSE DATE PCL
shared flag_offdt(string input) := function
	testFail := if(input not between '19000101' and CrimSrch.Version.Development, true, false);
	testPass := map(testFail => 0, 25);
return testPass;
end;

////// ARREST DATE PCL
shared flag_arrdt(string input) := function
	testFail := if(input not between '19000101' and CrimSrch.Version.Development, true, false);
	testPass := map(testFail => 0, 25);
return testPass;
end;

////// COURT DISP DATE PCL
shared flag_crtdispdt(string input) := function
	testFail := if(input not between '19000101' and CrimSrch.Version.Development, true, false);
	testPass := map(testFail => 0, 25);
return testPass;
end;

////// event DATE PCL
shared flag_eventdt(string input) := function
	testFail := if(input not between '19000101' and CrimSrch.Version.Development, true, false);
	testPass := map(testFail => 0, 10);
return testPass;
end;

////// parole start DATE PCL
shared flag_plstdt(string input) := function
	testFail := if(input not between '19000101' and CrimSrch.Version.Development, true, false);
	testPass := map(testFail => 0, 50);
return testPass;
end;

////// scheduled release DATE PCL
shared flag_schreldt(string input) := function
	testFail := if(input not between '19000101' and CrimSrch.Version.Development, true, false);
	testPass := map(testFail => 0, 25);
return testPass;
end;

////// CONVICTION FLAG PCL
shared flag_convfg(string input) := function
	testFail := input = 'N';
	testNeutral := input in ['U', ''];
	testPass := map(testFail => 0, testNeutral => 20, 100);
return testPass;
end;

////// CONVICTION OVERRIDE FLAG DATE PCL
shared flag_convdt(string input) := function
	testFail := if(input = '', true, false);
	testPass := map(testFail => 0, 20);
return testPass;
end;

////// CONVICTION OVERRIDE DATE FLAG DATE PCL
shared flag_convdttyp(string input) := function
	testFail := input = '';
	testPass := map(testFail => 0, 20);
return testPass;
end;

////// PUNISHMENT TYPE FLAG DATE PCL
shared flag_puntyp(string input) := function
	testFail := input <> 'I';
	testPass := map(testFail => 0, 100);
return testPass;
end;

////// SENT LENGTH DESCRIPTION PCL
shared flag_sentldesc(string input) := function
	testFail := regexfind('(LIFE)|(DEATH)', stringlib.stringtouppercase(input)) or regexfind('(MAX:LIFE)|(MAX: +LIFE)', stringlib.stringtouppercase(input));
	testPass := map(testFail => 0, 50);
return testPass;
end;

////// LATEST ADMITTANCE DATE PCL
shared flag_admitldate(string input) := function
	testFail := if(input between '19000101' and CrimSrch.Version.Development, true, false);
	testPass := map(testFail => 0, 50);
return testPass;
end;

////// ACTUAL RELEASE DATE PCL
shared flag_relactdate(string input) := function
	testFail := if(input between '19000101' and CrimSrch.Version.Development, true, false);
	testPass := map(testFail => 0, 100);
return testPass;
end;

////// CONTROL RELEASE DATE PCL
shared flag_ctlreldate(string input) := function
	testFail := if(input between '19000101' and CrimSrch.Version.Development, true, false);
	testPass := map(testFail => 0, 100);
return testPass;
end;

////// MINIMUM TERM DESCRIPTION PCL
shared flag_mintdesc(string input) := function
	testFail := input = '';
	testPass := map(testFail => 0, 50);
return testPass;
end;

////// SENTENCE DATE PCL
shared flag_docsentdt(string input) := function
	testFail := if(input between '19000101' and CrimSrch.Version.Development, true, false);
	testPass := map(testFail => 0, 50);
return testPass;
end;

////// INC ADMITTANCE DATE DATE PCL
shared flag_docincadmdt(string input) := function
	testFail := if(input between '19000101' and CrimSrch.Version.Development, true, false);
	testPass := map(testFail => 0, 50);
return testPass;
end;

////// DOC SENT LENGTH DESCRIPTION PCL
shared flag_docsentldesc(string input) := function
	testFail := regexfind('(LIFE)|(DEATH)', stringlib.stringtouppercase(input)) or regexfind('(MAX:LIFE)|(MAX: +LIFE)', stringlib.stringtouppercase(input));
	testPass := map(testFail => 0, 50);
return testPass;
end;

////// DOC MIN TERM DESCRIPTION PCL
shared flag_docmintdesc(string input) := function
	testFail := regexfind('(LIFE)|(DEATH)', stringlib.stringtouppercase(input)) or regexfind('(MAX:LIFE)|(MAX: +LIFE)', stringlib.stringtouppercase(input));
	testPass := map(testFail => 0, 50);
return testPass;
end;

////// DOC MAX TERM DESCRIPTION PCL
shared flag_docmaxtdesc(string input) := function
	testFail := regexfind('(LIFE)|(DEATH)', stringlib.stringtouppercase(input)) or regexfind('(MAX:LIFE)|(MAX: +LIFE)', stringlib.stringtouppercase(input));
	testPass := map(testFail => 0, 15);
return testPass;
end;

/////// INCARCERATION FLAGS LAYOUT
shared append_incar_layout := record
integer2	fDER_case_filing_dt := 0;
integer2	fDER_party_status_desc := 0;
integer2	fSES_off_date := 0;
integer2	fSES_arr_date := 0;
integer2	fSES_court_disp_date := 0;
integer2	fSES_court_disp_desc_1 := 0;
integer2	fSES_court_disp_code := 0;
integer2	fSES_sent_date := 0;
integer2	fSES_sent_jail := 0;
integer2	fDSES_offense_key := 0;
integer2	fDSES_inc_adm_dt := 0;
integer2	fDSES_ct_disp_dt := 0;
integer2	fDSES_ct_disp_desc_1 := 0;
integer2	fDSES_arr_date := 0;
integer2	fDSES_off_date := 0;
integer2	fDSES_stc_dt := 0;
integer2	fDSES_stc_lgth := 0;
integer2	fDSES_stc_lgth_desc := 0;
integer2	fDSES_min_term := 0;
integer2	fDSES_min_term_desc := 0;
integer2	fDSES_max_term := 0;
integer2	fDSES_max_term_desc := 0;
integer2	fPUN_orig_offense_key := 0;
integer2	fPUN_punishment_type := 0;
integer2	fPUN_event_date := 0;
integer2	fPUN_sent_length := 0;
integer2	fPUN_sent_length_desc := 0;
integer2	fPUN_inmate_cur_status_desc := 0;
integer2	fPUN_inmate_cur_loc := 0;
integer2	fPUN_admit_latest_date := 0;
integer2	fPUN_release_actual_date := 0;
integer2	fPUN_parole_start_date := 0;
integer2	fPUN_sch_rel_dt := 0;
integer2	fPUN_ctl_rel_dt := 0;
integer2	fconviction_override_date := 0;
integer2	fconviction_override_date_type := 0;
integer2	ffcra_conviction_flag := 0;
integer2	totalcnt := 0;
string80		incar_appr_rel_date := '';
string50	incar_appr_rel_date_ind := '';
end;

////// NEW COMBINED LAYOUT
shared comb_layout_with_flags := record
comboutput3;
append_incar_layout;
end;

shared fixdate(string inrdate) := function
indate := regexreplace('[^0-9]', inrdate, '');
date8y := if(length(indate) = 8 and indate[1..2] between '19' and '20' and indate[5..6] between '01' and '12'  and indate[7..8] between '01' and '31',indate, '');
date8m := if(length(indate) = 8 and indate[5..6] between '19' and '20' and indate[1..2] between '01' and '12'  and indate[3..4] between '01' and '31',indate, '');
date6y := if(length(indate) = 6 and indate[1..2] between '00' and '99' and indate[3..4] between '01' and '12'  and indate[5..6] between '01' and '31',indate, '');
date6m := if(length(indate) = 6 and indate[5..6] between '00' and '99' and indate[1..2] between '01' and '12'  and indate[3..4] between '01' and '31',indate, '');
outDate := if(date8y <> '', date8y,
				if(date8m <> '', date8m[5..8] + date8m[1..4],
					if(date6y <> '' and date6y[1..2] > StringLib.GetDateYYYYMMDD()[1..2], '19' + date6y,
					if(date6y <> '' and date6y[1..2] <= StringLib.GetDateYYYYMMDD()[1..2], '20' + date6y,
						if(date6m <> '' and date6m[5..6] > StringLib.GetDateYYYYMMDD()[1..2], '19' + date6m[5..6] + date6m[1..4],
						if(date6m <> '' and date6m[5..6] <= StringLib.GetDateYYYYMMDD()[1..2], '20' + date6m[5..6] + date6m[1..4],''))))));
return outdate;
end;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////***********************************////////////////////////////////////////////////////////
////////////////////////// APPLY FLAGS AND NEW LAYOUTS BELOW ////////////////////////////////////////////////////////
//////////////////////////***********************************////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


comb_layout_with_flags addincflagses(comboutput3 l) := transform

choose_incar_appr_rel_date(string offender_key, string punishment_type,
	string DER_case_filing_dt,
	string DER_party_status_desc,
	string SES_off_date,
	string SES_arr_date,
	string SES_court_disp_date,
	string SES_court_disp_desc_1,
	string SES_court_disp_code,
	string SES_sent_date,
	string SES_sent_jail,
	string DSES_offense_key,
	string DSES_inc_adm_dt,
	string DSES_ct_disp_dt,
	string DSES_ct_disp_desc_1,
	string DSES_arr_date,
	string DSES_off_date,
	string DSES_stc_dt,
	string DSES_stc_lgth,
	string DSES_stc_lgth_desc,
	string DSES_min_term,
	string DSES_min_term_desc,
	string DSES_max_term,
	string DSES_max_term_desc,
	string PUN_orig_offense_key,
	string PUN_punishment_type,
	string PUN_event_date,
	string PUN_sent_length,
	string PUN_sent_length_desc,
	string PUN_inmate_cur_status_desc,
	string PUN_inmate_cur_loc,
	string PUN_admit_latest_date,
	string PUN_release_actual_date,
	string PUN_parole_start_date,
	string PUN_sch_rel_dt,
	string PUN_ctl_rel_dt,
	string conviction_override_date,
	string conviction_override_date_type,
	string fcra_conviction_flag
) := function

	time_to_add					:= 
	if(regexfind('(LIFE)|(DEATH)', DSES_min_term_desc + DSES_max_term_desc + DSES_min_term + DSES_max_term + dses_stc_lgth + PUN_sent_length + PUN_sent_length_desc + SES_sent_jail + DSES_stc_lgth_desc), '999 YEARS', 
		if(SES_sent_jail > '', SES_sent_jail,
			if(DSES_min_term_desc > '', DSES_min_term_desc, 
				if(DSES_stc_lgth_desc > '', DSES_stc_lgth_desc,
					if(PUN_sent_length_desc > '', PUN_sent_length_desc,
						if(DSES_max_term_desc > '', DSES_max_term_desc, 
						'')
						)))
						)
						);
	vrDER_case_filing_dt :=		fixdate(DER_case_filing_dt);
	vrSES_off_date :=			fixdate(SES_off_date);
	vrSES_arr_date :=			fixdate(SES_arr_date);
	vrSES_court_disp_date :=	fixdate(SES_court_disp_date);
	vrSES_sent_date :=			fixdate(SES_sent_date);
	vrDSES_inc_adm_dt :=		fixdate(DSES_inc_adm_dt);
	vrDSES_ct_disp_dt :=		fixdate(DSES_ct_disp_dt);
	vrDSES_arr_date :=			fixdate(DSES_arr_date);
	vrDSES_off_date :=			fixdate(DSES_off_date);
	vrDSES_stc_dt :=			fixdate(DSES_stc_dt);
	vrPUN_event_date :=			fixdate(PUN_event_date);
	vrPUN_admit_latest_date :=	fixdate(PUN_admit_latest_date);
	vrPUN_release_actual_date :=fixdate(PUN_release_actual_date);
	vrPUN_parole_start_date :=	fixdate(PUN_parole_start_date);
	vrPUN_sch_rel_dt :=			fixdate(PUN_sch_rel_dt);
	vrPUN_ctl_rel_dt :=			fixdate(PUN_ctl_rel_dt);
	vrder_party_status_desc		:= fixdate(if(length(trim(regexfind(' [0-9][0-9][0-9][0-9][0-9][0-9]+ ', ' '+regexreplace('[^0-9 ]', der_party_status_desc, '') + ' ', 0),left, right)) between 6 and 8,
									regexfind(' [0-9][0-9][0-9][0-9][0-9][0-9]+ ', ' '+regexreplace('[^0-9 ]', der_party_status_desc, '') + ' ', 0), ''));
	// choosen_date				:= trim(MAX([vrDSES_inc_adm_dt + 'DSES_inc_adm_dt', vrDSES_stc_dt + 'DSES_stc_dt', vrSES_inc_adm_date + 'SES_inc_adm_date', vrSES_sent_date + 'SES_sent_date', vrDER_party_status_desc + 'DER_party_status_desc', vrPUN_admit_latest_date + 'PUN_admit_latest_date'])[9..50], all);
	prestatus_date					:= ut.date_add( time_to_add, MAP(
								vrPUN_admit_latest_date between '19010101' and  CrimSrch.Version.Development=> vrPUN_admit_latest_date,
								vrDSES_inc_adm_dt between '19010101' and  CrimSrch.Version.Development=> vrDSES_inc_adm_dt,
								vrSES_sent_date between '19010101' and  CrimSrch.Version.Development=> vrSES_sent_date,
								vrDSES_stc_dt between '19010101' and  CrimSrch.Version.Development=> vrDSES_stc_dt,
								vrSES_court_disp_date between '19010101' and  CrimSrch.Version.Development=> vrSES_court_disp_date,
								vrDSES_ct_disp_dt between '19010101' and  CrimSrch.Version.Development  => vrDSES_ct_disp_dt,
								vrder_party_status_desc between '19010101' and  CrimSrch.Version.Development  => vrder_party_status_desc,
								vrDER_case_filing_dt between '19010101' and  CrimSrch.Version.Development=> vrDER_case_filing_dt,
								vrSES_arr_date between '19010101' and  CrimSrch.Version.Development  => vrSES_arr_date,
								vrDSES_arr_date between '19010101' and  CrimSrch.Version.Development  => vrDSES_arr_date,
								vrSES_off_date between '19010101' and  CrimSrch.Version.Development  => vrSES_off_date,
								vrDSES_off_date between '19010101' and  CrimSrch.Version.Development  => vrDSES_off_date,
								vrPUN_event_date between '19010101' and  CrimSrch.Version.Development  => vrPUN_event_date, '')) + 
								map(vrPUN_admit_latest_date between '19010101' and  CrimSrch.Version.Development  =>  'PUNadmitlatestdate',
								vrDSES_inc_adm_dt between '19010101' and  CrimSrch.Version.Development  =>  'DSESincadmdt',
								vrSES_sent_date between '19010101' and  CrimSrch.Version.Development  =>  'SESsentdate',
								vrDSES_stc_dt between '19010101' and  CrimSrch.Version.Development  =>  'DSESstcdt',
								vrSES_court_disp_date between '19010101' and  CrimSrch.Version.Development  =>  'SEScourtdispdate',
								vrDSES_ct_disp_dt between '19010101' and  CrimSrch.Version.Development  =>  'DSESctdispdt',
								vrder_party_status_desc  between '19010101' and  CrimSrch.Version.Development  =>  'DERpartystatusdesc',
								vrDER_case_filing_dt between '19010101' and  CrimSrch.Version.Development  =>  'DERcasefilingdt',
								vrSES_arr_date between '19010101' and  CrimSrch.Version.Development  =>  'SESarrdate',
								vrDSES_arr_date between '19010101' and  CrimSrch.Version.Development  =>  'DSESarrdate',
								vrSES_off_date between '19010101' and  CrimSrch.Version.Development  =>  'SESoffdate',
								vrDSES_off_date  between '19010101' and  CrimSrch.Version.Development  =>  'DSESoffdate',
								vrPUN_event_date between '19010101' and  CrimSrch.Version.Development =>  'PUNeventdate', '');
	refresh_list := ['al', 'az', 'dc', 'mi', 'mn', 'mo', 'oh', 'ok', 'or', 'fl', 'ga', 'id', 'il', 'ks', 'ky', 'ms', 'mt', 'nc', 'ne', 'nj', 'nv', 'pa', 'ri', 'sc', 'tn', 'ut', 'wa'];
	autoDATE :=	if(stringlib.stringtolowercase(offender_key[1..2]) in refresh_list and punishment_type = 'I' and fcra_conviction_flag in ['Y', 'D'] and vrPUN_release_actual_date + vrPUN_sch_rel_dt + vrPUN_ctl_rel_dt +  vrPUN_parole_start_date > '19010101',
					if(vrPUN_parole_start_date between '19010101' and  CrimSrch.Version.Development, vrPUN_parole_start_date,
						if(vrPUN_release_actual_date between '19010101' and  CrimSrch.Version.Development, vrPUN_release_actual_date,
							if(vrPUN_sch_rel_dt between '19010101' and  CrimSrch.Version.Development, vrPUN_sch_rel_dt,
								if(vrPUN_ctl_rel_dt between '19010101' and  CrimSrch.Version.Development, vrPUN_ctl_rel_dt, '')))),
						'');
	pkstatus_date := map(vrPUN_parole_start_date > '00000000' => vrPUN_parole_start_date + 'PUN_parole_start_date',
						vrPUN_release_actual_date > '00000000'=> vrPUN_release_actual_date + 'PUN_release_actual_date',
						vrPUN_sch_rel_dt > '00000000'=> vrPUN_sch_rel_dt + 'PUN_sch_rel_dt',
						vrPUN_ctl_rel_dt > '00000000'=> vrPUN_ctl_rel_dt + 'PUN_ctl_rel_dt', 
						prestatus_date > '27000000' => '99999999', prestatus_date);
	choose_date := if(autodate > '00000000', autodate, pkstatus_date);
return choose_date;
end;	

self.fDER_case_filing_dt :=		flag_csfildt(l.DER_case_filing_dt);
self.fDER_party_status_desc :=		flag_ptystatdesc(l.DER_party_status_desc);
self.fSES_off_date :=			flag_offdt(l.SES_off_date);
self.fSES_arr_date :=			flag_arrdt(l.SES_arr_date);
self.fSES_court_disp_date :=		flag_crtdispdt(l.SES_court_disp_date);
self.fSES_sent_date :=			flag_sntdt(l.SES_sent_date);
self.fSES_sent_jail :=			flag_docmintdesc(l.SES_sent_jail);
self.fDSES_inc_adm_dt :=		flag_incadmdt(l.DSES_inc_adm_dt);
self.fDSES_ct_disp_dt :=		flag_crtdispdt(l.DSES_ct_disp_dt);
self.fDSES_arr_date :=			flag_arrdt(l.DSES_arr_date);
self.fDSES_off_date :=			flag_offdt(l.DSES_off_date);
self.fDSES_stc_dt :=			flag_docsentdt(l.DSES_stc_dt);
self.fDSES_stc_lgth_desc :=		flag_docsentldesc(l.DSES_stc_lgth_desc);
self.fDSES_min_term :=			flag_ldsearch(l.DSES_min_term);
self.fDSES_min_term_desc :=		flag_docmintdesc(l.DSES_min_term_desc);
self.fDSES_max_term :=			flag_ldsearch(l.DSES_max_term);
self.fDSES_max_term_desc :=		flag_docmaxtdesc(l.	DSES_max_term_desc);
self.fPUN_punishment_type :=		flag_puntyp(l.PUN_punishment_type);
self.fPUN_event_date :=			flag_eventdt(l.PUN_event_date);
self.fPUN_sent_length :=		flag_ldsearch(l.PUN_sent_length);
self.fPUN_sent_length_desc :=		flag_sentldesc(l.PUN_sent_length_desc);
self.fPUN_inmate_cur_status_desc :=	flag_statdesc(l.PUN_inmate_cur_status_desc);
self.fPUN_inmate_cur_loc :=		flag_currloc(l.PUN_inmate_cur_loc);
self.fPUN_admit_latest_date :=		flag_admitldate(l.PUN_admit_latest_date);
self.fPUN_release_actual_date :=	flag_relactdate(l.PUN_release_actual_date);
self.fPUN_parole_start_date :=		flag_plstdt(l.PUN_parole_start_date);
self.fPUN_sch_rel_dt :=			flag_schreldt(l.PUN_sch_rel_dt);
self.fPUN_ctl_rel_dt :=			flag_ctlreldate(l.PUN_ctl_rel_dt);
self.fconviction_override_date :=	flag_convdt(l.conviction_override_date);
self.fconviction_override_date_type :=	flag_convdttyp(l.conviction_override_date_type);
self.ffcra_conviction_flag :=		flag_convfg(l.fcra_conviction_flag);
	
	
	self.incar_appr_rel_date			:= 
					choose_incar_appr_rel_date( l.offender_key,
 l.PUN_punishment_type,
 l.DER_case_filing_dt,
 l.DER_party_status_desc,
 l.SES_off_date,
 l.SES_arr_date,
 l.SES_court_disp_date,
 l.SES_court_disp_desc_1,
 l.SES_court_disp_code,
 l.SES_sent_date,
 l.SES_sent_jail,
 l.DSES_offense_key,
 l.DSES_inc_adm_dt,
 l.DSES_ct_disp_dt,
 l.DSES_ct_disp_desc_1,
 l.DSES_arr_date,
 l.DSES_off_date,
 l.DSES_stc_dt,
 l.DSES_stc_lgth,
 l.DSES_stc_lgth_desc,
 l.DSES_min_term,
 l.DSES_min_term_desc,
 l.DSES_max_term,
 l.DSES_max_term_desc,
 l.PUN_orig_offense_key,
 l.PUN_punishment_type,
 l.PUN_event_date,
 l.PUN_sent_length,
 l.PUN_sent_length_desc,
 l.PUN_inmate_cur_status_desc,
 l.PUN_inmate_cur_loc,
 l.PUN_admit_latest_date,
 l.PUN_release_actual_date,
 l.PUN_parole_start_date,
 l.PUN_sch_rel_dt,
 l.PUN_ctl_rel_dt,
 l.conviction_override_date,
 l.conviction_override_date_type,
 l.fcra_conviction_flag);
	self.incar_appr_rel_date_ind		:= self.incar_appr_rel_date[9..50];
	self := l;
end;

flagged_comboutput3 := project(comboutput3, addincflagses(left));

comb_layout_with_flags totalcnt(comb_layout_with_flags l) := transform
	self.incar_appr_rel_date := l.incar_appr_rel_date[1..8];
	self.totalcnt := l.fDER_case_filing_dt +
l.fDER_party_status_desc +
l.fSES_off_date +
l.fSES_arr_date +
l.fSES_court_disp_date +
l.fSES_sent_date +
l.fSES_sent_jail +
l.fDSES_inc_adm_dt +
l.fDSES_ct_disp_dt +
l.fDSES_arr_date +
l.fDSES_off_date +
l.fDSES_stc_dt +
l.fDSES_stc_lgth_desc +
l.fDSES_min_term +
l.fDSES_min_term_desc +
l.fDSES_max_term +
l.fDSES_max_term_desc +
l.fPUN_punishment_type +
l.fPUN_event_date +
l.fPUN_sent_length +
l.fPUN_sent_length_desc +
l.fPUN_inmate_cur_status_desc +
l.fPUN_inmate_cur_loc +
l.fPUN_admit_latest_date +
l.fPUN_release_actual_date +
l.fPUN_parole_start_date +
l.fPUN_sch_rel_dt +
l.fPUN_ctl_rel_dt +
l.fconviction_override_date +
l.fconviction_override_date_type +
l.ffcra_conviction_flag;
	self := l;
end;

export outfiles := project(flagged_comboutput3, totalcnt(left)); ////////EXPORT JOINED FILES
/////////////
end;



