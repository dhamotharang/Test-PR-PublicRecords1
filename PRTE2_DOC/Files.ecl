IMPORT hygenics_crim, ut,hygenics_search,crimsrch, doxie, autokey, lib_stringlib, std;
EXPORT files := module

Export dCrim := dataset('~thor_data400::base::corrections_court_offenses_public', hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory, thor)
								(length(trim(offender_key, left, right))>2);

Export dOffense := dataset('~thor_data400::base::corrections_offenses_public', hygenics_crim.Layout_Base_Offenses_with_OffenseCategory, thor) 
								(length(trim(offender_key, left, right))>2);
								
Export file_lookup_category_file      := DATASET(constants.lookup_category_file, layouts.combined_desc_lookup_layout, FLAT );

EXPORT file_offenders_base_plus					:= DATASET('~PRTE::BASE::corrections::offenders', Layouts.layout_offender_plus,FLAT);

EXPORT file_offenses_base_plus					:= DATASET('~PRTE::BASE::corrections::offenses', Layouts.layout_offenses_base_plus, FLAT);

EXPORT file_activity_base_plus					:= DATASET('~PRTE::BASE::corrections::activity', Layouts.layout_activity_base_plus, FLAT);

EXPORT file_court_offenses_plus					:= DATASET('~PRTE::BASE::corrections::court_offenses', Layouts.layout_court_offenses_base_plus, FLAT );

EXPORT file_punishment_plus 						:= DATASET('~PRTE::BASE::corrections::punishment', Layouts.layout_punishment_plus, FLAT);

EXPORT corrections_activity 						:= Project(file_activity_base_plus, Layouts.layout_corrections_activity_public);

EXPORT file_offenses_keybuilding 				:= Project(file_offenses_base_plus, Layouts.layout_offense_common);

EXPORT corrections_court_offenses 			:= Project(file_court_offenses_plus, Layouts.Layout_Base_CourtOffenses );

EXPORT file_offenders_keybuilding 			:= Project(file_offenders_base_plus, Layouts.layout_offender);

EXPORT corrections_punishment 					:= Project(file_punishment_plus, Layouts.Layout_CrimPunishment);
EXPORT corrections_activity_fcra                                                           := DATASET([], Layouts.layout_corrections_activity_public);

xl := RECORD
	file_offenders_keybuilding;
	unsigned6 i_did;
	zero := 0;
	unsigned4 lookups := ut.bit_set(0,doxie.lookup_bit('CRIM'))| ut.bit_set(0,0);
END;

xl xpand(file_offenders_keybuilding le,integer cntr) := TRANSFORM 
	SELF.i_did := cntr + autokey.did_adder('CRIM'); 
	SELF := le; 
END;

EXPORT file_offenders_keybuilding_fdid := PROJECT(file_offenders_keybuilding,xpand(LEFT,COUNTER));



EXPORT corrections_offenses_IN := DATASET('~PRTE::IN::corrections::offenses', Layouts.prte__DOCKeysOffenses__base, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );

EXPORT corrections_CourtOffenses_IN := DATASET('~PRTE::IN::corrections::CourtOffenses', Layouts.prte__DOCKeysCourtOffenses_base, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );

EXPORT corrections_offenders_IN := DATASET('~PRTE::IN::corrections::offenders', Layouts.prte__DOCKeysOffenders__base, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );

EXPORT corrections_punishment_IN := DATASET('~PRTE::IN::corrections::punishment', Layouts.prte__DOCKeysPunishment_base, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );

EXPORT corrections_activity_IN := DATASET('~PRTE::IN::corrections::activity', Layouts.prte__DOCKeysActivity__base, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );

EXPORT file_punishment_keybuilding := PROJECT(corrections_punishment, Layouts.Layout_CrimPunishment);

EXPORT file_activity_keybuilding := PROJECT(corrections_activity, Layouts.layout_activity);

EXPORT file_court_offenses := PROJECT(corrections_court_offenses , Layouts.Layout_Base_CourtOffenses);

Layouts.layout_corrections_keys xpand(file_offenders_keybuilding le,integer cntr) := TRANSFORM 
	SELF.i_did := cntr + autokey.did_adder('CRIM'); 
	SELF := le; 
END;

EXPORT file_corrections_keys := PROJECT(file_offenders_keybuilding,xpand(LEFT,COUNTER));

invalid_case_nums := ['&nbsp;'];
offender   := dedup(file_offenders_keybuilding,offender_key,case_num);
court_off  := dedup(file_court_offenses(court_case_number <>'' and court_case_number not in invalid_case_nums ),offender_key,court_case_number);
offense    := dedup(file_offenses_keybuilding(case_num <>'' and case_num not in invalid_case_nums ),offender_key,case_num);

Layouts.casenumber_key_layout slimoffender(offender L) := TRANSFORM
	self.case_num       := hygenics_crim._functions.clean_case_number(L.case_num);
	self.file_indicator := 'O'; // stands for offender
	self := L;
END;

slim_df 	  := project(offender,slimoffender(left));

Layouts.casenumber_key_layout slimcourtoffenses(slim_df L, court_off R) := TRANSFORM
	self.case_num       := hygenics_crim._functions.clean_case_number(R.court_case_number);
	self.file_indicator := 'C'; // stands for court offense
	self := L;
END;

Layouts.casenumber_key_layout slimoffenses(slim_df L, offense R) := TRANSFORM
	self.case_num       := hygenics_crim._functions.clean_case_number(R.case_num);
	self.file_indicator := 'D'; // stands for court offense
	self := L;
END;

slim_dfco 	:= join(slim_df, court_off,
                    left.offender_key =right.offender_key,slimcourtoffenses(left,right));

slim_dfo 	  := join(slim_df, offense,
                   left.offender_key =right.offender_key,slimoffenses(left,right));

EXPORT DS_CaseNumber := dedup(sort(slim_df  (case_num <>'' and case_num not in invalid_case_nums) + 
                 slim_dfco(case_num <>'') + 
								 slim_dfo (case_num <>''),record),offender_key,case_num,RIGHT) ;

shared todaysdate := hygenics_crim._functions.GetDate;

shared checkDays(string8 d1, string8 d2, unsigned2 days) := ut.DaysApart(d1,d2) <= days and d1>d2;

Layouts.crim_slimrec add_doc(file_offenders_keybuilding le) := TRANSFORM
	SELF.criminal_count := 1;
	SELF.crim_case_num := le.case_num;
	self.did := (unsigned6)le.did;
	self.last_criminal_date := (unsigned4)le.case_date;
	self.criminal_count30 := (integer)checkDays(todaysDate,le.case_date,30);
	self.criminal_count90 := (integer)checkDays(todaysDate,le.case_date,90);
	self.criminal_count180 := (integer)checkDays(todaysDate,le.case_date,180);
	self.criminal_count12 := (integer)checkDays(todaysDate,le.case_date,ut.DaysInNYears(1));
	self.criminal_count24 := (integer)checkDays(todaysDate,le.case_date,ut.DaysInNYears(2));
	self.criminal_count36 := (integer)checkDays(todaysDate,le.case_date,ut.DaysInNYears(3));
	self.criminal_count60 := (integer)checkDays(todaysDate,le.case_date,ut.DaysInNYears(5));
	// add arrests here, data_type=5
	isArrest := le.data_type = '5';
	self.arrests_count := (unsigned)isArrest;
	self.date_last_arrest := if(isArrest, (unsigned4)le.case_date, 0);	// using the case date for the arrest date
	self.arrests_count30 := if(isArrest, (unsigned)checkDays(todaysDate,le.case_date,30), 0);
	self.arrests_count90 := if(isArrest, (unsigned)checkDays(todaysDate,le.case_date,90), 0);
	self.arrests_count180 := if(isArrest, (unsigned)checkDays(todaysDate,le.case_date,180), 0);
	self.arrests_count12 := if(isArrest, (unsigned)checkDays(todaysDate,le.case_date,ut.DaysInNYears(1)), 0);
	self.arrests_count24 := if(isArrest, (unsigned)checkDays(todaysDate,le.case_date,ut.DaysInNYears(2)), 0);
	self.arrests_count36 := if(isArrest, (unsigned)checkDays(todaysDate,le.case_date,ut.DaysInNYears(3)), 0);
	self.arrests_count60 := if(isArrest, (unsigned)checkDays(todaysDate,le.case_date,ut.DaysInNYears(5)), 0);
END;

doc_added := PROJECT(file_offenders_keybuilding((integer)did != 0), add_doc(LEFT));

Layouts.crim_slimrec roll_doc(doc_added le, doc_added ri) := TRANSFORM
	SELF.criminal_count := le.criminal_count+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count);
	SELF.criminal_count30 := le.criminal_count30+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count30);
	SELF.criminal_count90 := le.criminal_count90+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count90);
	SELF.criminal_count180 := le.criminal_count180+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count180);
	SELF.criminal_count12 := le.criminal_count12+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count12);
	SELF.criminal_count24 := le.criminal_count24+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count24);
	SELF.criminal_count36 := le.criminal_count36+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count36);
	SELF.criminal_count60 := le.criminal_count60+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count60);
	self.last_criminal_date := max(le.last_criminal_date,ri.last_criminal_date);
	self.arrests_count := le.arrests_count+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count);
	self.arrests_count30 := le.arrests_count30+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count30);
	self.arrests_count90 := le.arrests_count90+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count90);
	self.arrests_count180 := le.arrests_count180+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count180);
	self.arrests_count12 := le.arrests_count12+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count12);
	self.arrests_count24 := le.arrests_count24+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count24);
	self.arrests_count36 := le.arrests_count36+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count36);
	self.arrests_count60 := le.arrests_count60+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count60);
	self.date_last_arrest := max(le.date_last_arrest,ri.date_last_arrest);
	SELF := le;
END;

EXPORT offendersfcrabocashell_did := 
		ROLLUP(doc_added, LEFT.did=RIGHT.did, roll_doc(LEFT,RIGHT));

offender := project(file_offenders_keybuilding, Layouts.old_layout_offender);

offenses_merged := project(file_offenses_keybuilding, transform(Layouts.offense_fields, self.sent_date := left.stc_dt, self := left, self := [])) +
			    project(file_court_offenses, transform(Layouts.offense_fields, self := left, self := []));

today := (STRING8)Std.Date.Today();

earliest_date(string8 date1, string8 date2) := intformat(ut.EarliestDate((integer)date1,(integer)date2),8,1);

offender_with_offenses_data1 := join(offender, offenses_merged, left.offender_key=right.offender_key,
	transform(Layouts.layout_offenders_risk_temp, 
		self := left, 
		self.offense := right;
		date1 := earliest_date(right.off_date, right.arr_disp_date);
		date2 := earliest_date(date1, right.court_disp_date);
		date3 := earliest_date(date2, right.sent_date);
		date4 := earliest_date(date3, right.arr_date);
		date5 := earliest_date(date4, right.appeal_date);
		date6 := earliest_date(date5, left.case_date);
		self.earliest_offense_date := date6;
		
		), left outer);
										
offender_with_offenses_data := offender_with_offenses_data1((integer)did != 0 and data_type in ['1','2','5']);

default_rules := project(offender_with_offenses_data, 
						transform(Layouts.layout_offenders_risk, 
							self.traffic_flag := map(left.data_type='1' => 'N',
										left.vendor in Hygenics_search.sCourt_Vendors_With_No_Traffic => 'N',		
										left.vendor in Hygenics_search.sCourt_Vendors_With_Only_Traffic => 'Y',
										Hygenics_search.fTraffic_Flag_From_Vendor_and_Offense_Level(left.Vendor,left.offense.court_off_lev) = 'Y' => 'Y',
										Hygenics_search.fTraffic_Flag_From_Vendor_and_Offender_Key(left.vendor,left.offender_key) = 'Y' => 'Y',
										left.Vendor in Hygenics_search.sCourt_Vendors_With_Traffic_Based_Upon_Off_Lev or 
										left.Vendor in Hygenics_search.sCourt_Vendors_With_Traffic_Based_Upon_Offender_Key => 'N',  // if the vendor is one these 2 cases and hasn't been set to a Y already, 
																																 // set to N so the lookup isn't done on those records
										'U'),
										
							self.conviction_flag := map(left.data_type='1' and left.vendor in Hygenics_search.sDOC_Vendors_Conviction_Unknown => 'U',
														left.data_type='1' and left.vendor not in Hygenics_search.sDOC_Vendors_Conviction_Unknown 	and
																									 left.vendor not in Hygenics_search.sDOC_Vendors_NoOffense_NoConviction => 'Y',
														left.data_type='1' and trim(left.offense.offender_key)<>'' and left.vendor in Hygenics_search.sDOC_Vendors_NoOffense_NoConviction => 'Y',  // if there is an offense record and source is DOC, there is a conviction in FL									 
														left.data_type='2' and (integer4)left.offense.Sent_Date<>0 and left.Vendor in Hygenics_search.sCourt_Vendors_With_Conviction_Based_Upon_Sent_Date => 'Y',
														left.data_type='2' and (integer4)left.offense.Sent_Date=0 and left.Vendor in Hygenics_search.sCourt_Vendors_With_Conviction_Based_Upon_Sent_Date => 'N',
														'U');									
							self := left,
							self := []) );

Layouts.layout_offenders_risk final_calculations(Layouts.layout_offenders_risk le) := transform		
	set_off := ['V','I','C','T'];
	traffic_flag := if(le.offense_score in set_Off,'Y',le.traffic_flag );
	conviction_flag	:= if(le.Conviction_Flag<>'',
									  if(le.Conviction_Flag='D'
									  or (le.Data_Type='1' and
										  le.Vendor not in Hygenics_search.sDOC_Vendors_Conviction_Unknown 	and
										  le.Vendor not in Hygenics_search.sDOC_Vendors_NoOffense_NoConviction
										 ),
										 'Y',
										 le.Conviction_Flag
										),
									  if(le.Data_Type='1' 												and
										  le.Vendor not in Hygenics_search.sDOC_Vendors_Conviction_Unknown 	and
										  le.Vendor not in Hygenics_search.sDOC_Vendors_NoOffense_NoConviction,
										'Y',
										'N'
										)
									 );
	
	self.traffic_flag := traffic_flag;
	self.conviction_flag := conviction_flag;
	self.criminal_offender_level := map(traffic_flag='Y' AND conviction_flag<>'Y' => '1',  //1 = traffic, not-convicted
									  traffic_flag='Y' AND conviction_flag='Y' => '2',// 2 = traffic, convicted
									  traffic_flag<>'Y' AND conviction_flag<>'Y' => '3',// 3 = non-traffic, not-convicted
									  traffic_flag<>'Y' AND conviction_flag='Y' => '4',// 4 = non-traffic, convicted
									  '0');  // shouldn't get any of these, all of the cases should be coverd in the first 4
	self := le;
end;
 
export File_Offenders_Risk := project(default_rules, final_calculations(left));

Layouts.autokey_layout_w_extra_city_field get_ssn_and_states(file_offenders_keybuilding l,unsigned1 C):=transform
	self.ssn := if(l.ssn_appended<>'',l.ssn_appended,l.ssn);
	self.dob := if(l.pty_typ='2',l.dob_alias,l.dob);
	self.did := (unsigned6) l.did;
	self.state := map(C=1=>l.st,
										C=2 => ut.st2abbrev(stringlib.stringtouppercase(l.orig_state)),
										ut.st2abbrev(stringlib.stringtouppercase(l.place_of_birth)));									
	self := l;				
end;

norm_file_states := normalize(file_offenders_keybuilding,
				map((left.orig_state=left.st and left.orig_state=  ut.st2abbrev(stringlib.stringtouppercase(left.place_of_birth)))
						or (left.orig_state='' and left.place_of_birth='')	
					=>1,
						left.st=ut.st2abbrev(stringlib.stringtouppercase(left.place_of_birth)) or
						left.orig_state =ut.st2abbrev(stringlib.stringtouppercase(left.place_of_birth)) or
						left.place_of_birth=''
					=>2,
						3),
				get_ssn_and_states(left,counter));
 
dup_file_states := dedup(sort(norm_file_states,offender_key,record),record); 

Layouts.autokey_layout get_cities(dup_file_states l,unsigned1 C):=transform
	self.v_city_name := if(C=1,l.p_city_name,l.v_city_name);
	self:= l;
	end;

norm_file_cities := normalize(dup_file_states,if(left.p_city_name=left.v_city_name or left.v_city_name='',1,2), get_cities(left,counter));

EXPORT File_offenders_autokey := dedup(sort(norm_file_cities,offender_key,record),record); 

Layouts.crim_slimrec2 add_doc2(File_Offenders_Risk le) := TRANSFORM
	isFelony := le.criminal_offender_level='4' and le.offense_score='F';
	SELF.criminal_count := 1;
	SELF.felony_count := if(isFelony,1, 0);
	SELF.crim_case_num := le.case_num;
	self.did := (unsigned6)le.did;
	self.last_criminal_date := (unsigned4)le.earliest_offense_date;
	self.last_felony_date := if(isFelony,(unsigned4)le.earliest_offense_date, 0);
	self.criminal_count30 := if(isFelony and checkDays(todaysDate,le.earliest_offense_date,30), 1, 0);
	self.criminal_count90 := if(isFelony and checkDays(todaysDate,le.earliest_offense_date,90), 1, 0);
	self.criminal_count180 := if(isFelony and checkDays(todaysDate,le.earliest_offense_date,180), 1, 0);
	self.criminal_count12 := if(isFelony and checkDays(todaysDate,le.earliest_offense_date,ut.DaysInNYears(1)), 1, 0);
	self.criminal_count24 := if(isFelony and checkDays(todaysDate,le.earliest_offense_date,ut.DaysInNYears(2)), 1, 0);
	self.criminal_count36 := if(isFelony and checkDays(todaysDate,le.earliest_offense_date,ut.DaysInNYears(3)), 1, 0);
	self.criminal_count60 := if(isFelony and checkDays(todaysDate,le.earliest_offense_date,ut.DaysInNYears(5)), 1, 0);
	// add arrests here, data_type=5
	isArrest := le.data_type = '5';
	self.arrests_count := (unsigned)isArrest;
	self.date_last_arrest := if(isArrest, (unsigned4)le.earliest_offense_date, 0);	// using the case date for the arrest date
	self.arrests_count30 := if(isArrest and checkDays(todaysDate,le.earliest_offense_date,30), 1, 0);
	self.arrests_count90 := if(isArrest and checkDays(todaysDate,le.earliest_offense_date,90), 1, 0);
	self.arrests_count180 := if(isArrest and checkDays(todaysDate,le.earliest_offense_date,180), 1, 0);
	self.arrests_count12 := if(isArrest and checkDays(todaysDate,le.earliest_offense_date,ut.DaysInNYears(1)), 1, 0);
	self.arrests_count24 := if(isArrest and checkDays(todaysDate,le.earliest_offense_date,ut.DaysInNYears(2)), 1, 0);
	self.arrests_count36 := if(isArrest and checkDays(todaysDate,le.earliest_offense_date,ut.DaysInNYears(3)), 1, 0);
	self.arrests_count60 := if(isArrest and checkDays(todaysDate,le.earliest_offense_date,ut.DaysInNYears(5)), 1, 0);
END;

doc_added2 := PROJECT(File_Offenders_Risk((integer)did != 0), add_doc2(LEFT));

Layouts.crim_slimrec2 roll_crim_counts2(doc_added2 le, doc_added2 ri) := TRANSFORM
	SELF.criminal_count := le.criminal_count+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count);
	SELF.criminal_count30 := le.criminal_count30+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count30);
	SELF.criminal_count90 := le.criminal_count90+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count90);
	SELF.criminal_count180 := le.criminal_count180+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count180);
	SELF.criminal_count12 := le.criminal_count12+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count12);
	SELF.criminal_count24 := le.criminal_count24+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count24);
	SELF.criminal_count36 := le.criminal_count36+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count36);
	SELF.criminal_count60 := le.criminal_count60+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count60);
	self.last_criminal_date := max(le.last_criminal_date,ri.last_criminal_date);
	self.last_felony_date := max(le.last_felony_date,ri.last_felony_date);
	SELF.felony_count := le.felony_count+IF(le.crim_case_num=ri.crim_case_num,0,ri.felony_count);
	SELF := ri;
END;

crim_sorted2 := SORT(doc_added2,did,crim_case_num,-felony_count, -last_felony_date, -criminal_count, -last_criminal_date);
crim_counts_rolled2 := ROLLUP(crim_sorted2, LEFT.did=RIGHT.did, roll_crim_counts2(LEFT,RIGHT));

Layouts.crim_slimrec2 roll_arrest_counts2(doc_added2 le, doc_added2 ri) := TRANSFORM
	self.arrests_count := le.arrests_count+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count);
	self.arrests_count30 := le.arrests_count30+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count30);
	self.arrests_count90 := le.arrests_count90+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count90);
	self.arrests_count180 := le.arrests_count180+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count180);
	self.arrests_count12 := le.arrests_count12+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count12);
	self.arrests_count24 := le.arrests_count24+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count24);
	self.arrests_count36 := le.arrests_count36+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count36);
	self.arrests_count60 := le.arrests_count60+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count60);
	self.date_last_arrest := max(le.date_last_arrest,ri.date_last_arrest);
	SELF := ri;
END;

arrests_sorted2 := SORT(doc_added2,did,crim_case_num,-arrests_count, -date_last_arrest);
arrest_counts_rolled2 := ROLLUP(arrests_sorted2, LEFT.did=RIGHT.did, roll_arrest_counts2(LEFT,RIGHT));
export DS_riskbocashell_did := join(crim_counts_rolled2, 
					arrest_counts_rolled2, 
					left.did=right.did,
					transform(Layouts.crim_slimrec2,
						SELF.criminal_count := left.criminal_count;
						SELF.criminal_count30 := left.criminal_count30;
						SELF.criminal_count90 := left.criminal_count90;
						SELF.criminal_count180 := left.criminal_count180;
						SELF.criminal_count12 := left.criminal_count12;
						SELF.criminal_count24 := left.criminal_count24;
						SELF.criminal_count36 := left.criminal_count36;
						SELF.criminal_count60 := left.criminal_count60;
						self.last_criminal_date := left.last_criminal_date;
						self.last_felony_date := left.last_felony_date;
						SELF.felony_count := left.felony_count;
						SELF := right;));

shared f := file_offenders_keybuilding(Vendor not in hygenics_search.sCourt_Vendors_To_Omit);
o := file_court_offenses (Vendor not in hygenics_search.sCourt_Vendors_To_Omit and (stringlib.stringfind(court_disp_desc_1, 'DISMISSED', 1) > 0 or stringlib.stringfind(court_disp_desc_2, 'DISMISSED', 1) > 0));
d := file_offenses_keybuilding (Vendor not in hygenics_search.sCourt_Vendors_To_Omit and (stringlib.stringfind(ct_disp_desc_1, 'DISMISSED', 1) > 0 or stringlib.stringfind(ct_disp_desc_2, 'DISMISSED', 1) > 0));

	Layouts.layout_offense_fcra ctOff(o l):= transform
	  self.case_number := l.court_case_number;
		self := l;
	end;

	o_offense := project(o, ctOff(left));
	
	Layouts.layout_offense_fcra docOff(d l):= transform
	  self.case_number := l.case_num;
		self := l;
	end;
	
	d_offense := project(d, docOff(left));
	
shared offenses := o_offense + d_offense;

Layouts.layout_rollup_offenders add_doc(f le, offenses ri) := TRANSFORM
	SELF.criminal_count := DATASET([{(unsigned4)le.fcra_date, le.offender_key, le.case_num, 
																		le.fcra_conviction_flag, le.fcra_traffic_flag, le.offense_score}],Layouts.layout_date);
	SELF.offender_key := le.offender_key;
	self.did := (unsigned6)le.did;
END;

// only need 1 of the offense records for that offender key to be "dismissed" to throw this record out
dismissed_offenses := offenses;//crimsrch.File_Moxie_Offenses_Dev( stringlib.stringfind(court_disp_desc, 'DISMISSED', 1) > 0 );

// left only join to dismissed_offenses to filter out any cases which have been dismissed															 
doc_added := join(
	f((integer)did != 0 AND fcra_date<>'' AND offender_key <> ''), 
	dismissed_offenses, 
	left.offender_key=right.offender_key, 
	add_doc(LEFT, RIGHT), left only);

Layouts.layout_rollup_offenders roll_doc (Layouts.layout_rollup_offenders le, Layouts.layout_rollup_offenders ri) := TRANSFORM
  boolean sameOffender := le.offender_key=ri.offender_key;
	SELF.criminal_count := CHOOSEN (le.criminal_count + IF(~sameOffender, ri.criminal_count),100);
	SELF := le;
END;

doc_rolled 	:= ROLLUP(SORT(doc_added,did,offender_key), LEFT.did=RIGHT.did, roll_doc(LEFT,RIGHT));
export DS_offendersfcrabocashell_did 	:= PROJECT (doc_rolled, transform (Layouts.slimrec_offenders, SELF := Left));

END;