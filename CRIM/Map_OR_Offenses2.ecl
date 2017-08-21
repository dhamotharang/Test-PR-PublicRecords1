import crim_common;

/////////////////INPUTS

// output(choosen(CRIM.File_OR_Raw_Amounts, 200));
// output(choosen(CRIM.File_OR_Raw_Attorneys, 200)); 
// output(choosen(CRIM.File_OR_Raw_Case, 200));
// output(choosen(CRIM.File_OR_Raw_Charges, 200));
// output(choosen(CRIM.File_OR_Raw_Events, 200));
// output(choosen(CRIM.File_OR_Raw_Laws, 200));
// output(choosen(CRIM.File_OR_Raw_Party, 200));
// output(choosen(CRIM.File_OR_Raw_Sentences, 200));

////////////////NEW COMBINED LAYOUT

Layout_Combined := record
// export Layout_OR_Amounts := record
	string1 Court_Type;
	string3 Court_Location;
	string10 Case_Number;
	string3 Record_Type_amt;
	string5 Amount_Id;
	string3 Related_Record_Type;
	string5 Related_Record_Id;
	string4 Amount_Type;
	string4 Amount_Modifier;
	string1 Amount_Unit;
	string11 Dollars;
	string9 Non_Dollars;
	string5 Related_Jgm_Amount_Id;
	string9 Related_Receivable_Number;
	string3 Related_Receivable_Sequence;
	string1 Judgment_Flag;
	string7 Record_Changed_Date;
	string5 Record_Changed_Time;
	string10 User_Id;
	string10 Command_Name;
// export Layout_OR_Charges := RECORD
  // string1 court_type;
  // string3 court_location;
  // string10 case_number;
  string3 record_type_chg;
  string5 charge_id;
  string5 previous_charge_id;
  string5 charge_count;
  string7 incident_date;
  string7 citation_issue_date;
  string4 law_agency;
  string8 law_number;
  string4 law_code;
  string4 charge_modifier_agency;
  string8 charge_modifier_number;
  string10 citation_number;
  string4 original_agency;
  string10 original_agency_report_num;
  string6 bpst_number;
  string2 license_plate_state;
  string8 license_plate_number;
  string1 accident_related;
  string1 employment_related;
  string4 charge_status;
  string7 charge_status_date;
  string7 record_changed_date_chg;
  string5 record_changed_time_chg;
  // string10 user_id;
  // string10 command_name;
// export Layout_OR_Laws := record
	// string4  Law_Agency; -- use for mapping
	// string8  Law_Number; -- use for mapping
	string30 Description;
	string4  OUCR_Code;
	string1  Penalty_Class;
	string3  Penalty_Code;
	// string4  Law_Code; -- use for mapping
	string4  Financial_Agency;
	string1  Law_Type;
	string7  Record_Change_Date_law;
	string5  Record_Change_Time_law;
	// string10 User_Id;
	string7  Date_Effective;
	string9  Use_Count;
	string3  Court_Location_law;
// export Layout_OR_Party := record
	// string1  Court_Type;
	// string1  Court_Type;
	// string3  Court_Location;
	// string10 Case_Number;
	string3  Party_Side;
	string5  Party_Id;
	string30 Name;
	string1  Business_Name_Flag;
	string7  Date_of_Birth;
	string3  Party_Role;
	string1  Name_Flag;
	string1  Judgment_Flag_pty;
	string4  Custody_Status;
	string7  Custody_Date;
	string3  Related_Party_Side;
	string5  Related_Party_Id;
	string4  Agency;
	string6  Bar_BPST_Number;
	string3  Initials;
	string4  Person_Status_on_Case;
	string7  Record_Changed_Date_pty;
	string5  Record_Changed_Time_pty;
	// string10 User_Id;
	// string10 Command_Name;
	string2  Case_Class;
	string2  Case_Type;
	string1  Return_Address_Flag;
	string1  Trust_Flag;
	string1  Receivable_Flag;
	string6  Vendor_Number;
	string7  Account_Number;
	string4  General_Ledger_Id;
// export Layout_OR_Sentences := record
	// string1  Court_Type;
	// string3  Court_Location;
	// string10 Case_Number;
	string3  Record_Type_SNT;
	string5  Charge_Id_snt;// -- map using this field
	string5  Sentence_Id;
	string4  Decision_Type;
	string7  Decision_Date;
	string1  Finacinal_System_Flag;
	string7  Due_Date;
	string4  Decision_Status;
	string7  Decision_Status_Date;
	string7  Record_Changed_Date_snt;
	string5  Record_Changed_Time_snt;
	// string10 User_Id;
	// string10 Command_Name;
//PARTY_ID
	string Drivers_License_Number;
	string Drivers_License_State;
	string Arrest_Date;
	string Booking_Number;
	//LOOKUP FIELDS
	string law_agency_desc;
	string charge_status_desc;
	string decision_type_desc;
	string decision_status_desc;

end;

// Layout_Combined first_join(CRIM.File_OR_Raw_Charges l, CRIM.File_OR_Raw_Sentences r) := transform
	// self.charge_id_snt := r.charge_id;
	// self.law_agency := l.law_agency;
	// self.law_code := l.law_code;
	// self.law_number := l.law_number;
	// self.record_type_chg := l.record_type;
	// self.record_changed_date_chg := l.record_changed_date;
	// self.record_changed_time_chg := l.record_changed_time;
	// self.Record_Type_SNT := r.Record_Type;
	// self.Record_Changed_Date_snt := r.Record_Changed_Date;
	// self.Record_Changed_Time_snt := r.Record_Changed_Time;
	// self.decision_date := r.decision_date;
	// self.charge_modifier_agency := if(l.charge_modifier_agency <> '', l.charge_modifier_agency, l.original_agency);
	// self := l;
	// self := r;
	// self := [];
// end;

// first_join_comp := join(distribute(CRIM.File_OR_Raw_Charges(court_type = 'C' and case_number <> ''), hash(case_number)), distribute(CRIM.File_OR_Raw_Sentences, hash(case_number)), 
						// left.court_type= right.court_type and 
						// left.court_location = right.court_location and
						// left.case_number = right.case_number and
						// left.charge_id = right.charge_id,
						// first_join(left, right), left outer, local);
						
						
////////////////////////////////////////////////////////////////////////////////

Layout_Combined first_joina(CRIM.File_OR_Raw_amounts l, CRIM.File_OR_Raw_Sentences r) := transform
self.Court_Type := r.Court_Type;
self.Court_Location := r.Court_Location;
self.Case_Number := r.Case_Number;
self.Record_Type_amt := l.Record_Type;
self.Amount_Id := l.Amount_Id;
self.Related_Record_Type := l.Related_Record_Type;
self.Related_Record_Id := l.Related_Record_Id;
self.Amount_Type := l.Amount_Type;
self.Amount_Modifier := l.Amount_Modifier;
self.Amount_Unit := l.Amount_Unit;
self.Dollars := l.Dollars;
self.Non_Dollars := l.Non_Dollars;
self.Related_Jgm_Amount_Id := l.Related_Jgm_Amount_Id;
self.Related_Receivable_Number := l.Related_Receivable_Number;
self.Related_Receivable_Sequence := l.Related_Receivable_Sequence;
self.Judgment_Flag := l.Judgment_Flag;
self.Record_Changed_Date := l.Record_Changed_Date;
self.Record_Changed_Time := l.Record_Changed_Time;
self.User_Id := l.User_Id;
self.Command_Name := l.Command_Name;
self.Record_Type_SNT := r.Record_Type;
self.Charge_Id_snt := r.Charge_Id;
self.Sentence_Id := r.Sentence_Id;
self.Decision_Type := r.Decision_Type;
self.Decision_Date := r.Decision_Date;
self.Finacinal_System_Flag := r.Finacinal_System_Flag;
self.Due_Date := r.Due_Date;
self.Decision_Status := r.Decision_Status;
self.Decision_Status_Date := r.Decision_Status_Date;
self.Record_Changed_Date_snt := r.Record_Changed_Date;
self.Record_Changed_Time_snt := r.Record_Changed_Time;
	self := l;
	self := r;
	self := [];
end;

first_join_compa := join(distribute(CRIM.File_OR_Raw_Amounts(court_type = 'C' and case_number <> ''), hash(case_number)), distribute(CRIM.File_OR_Raw_Sentences, hash(case_number)), 
						left.court_type= right.court_type and 
						left.court_location = right.court_location and
						left.case_number = right.case_number and
						left.Related_Record_Id = right.sentence_id,
						first_joina(left, right), right outer, local);

Layout_Combined first_joinb(CRIM.File_OR_Raw_Charges l, CRIM.File_OR_Raw_amounts r) := transform
self.Court_Type := l.Court_Type;
self.Court_Location := l.Court_Location;
self.Case_Number := l.Case_Number;
self.record_type_chg := l.record_type;
self.charge_id := l.charge_id;
self.previous_charge_id := l.previous_charge_id;
self.charge_count := l.charge_count;
self.incident_date := l.incident_date;
self.citation_issue_date := l.citation_issue_date;
self.law_agency := l.law_agency;
self.law_number := l.law_number;
self.law_code := l.law_code;
self.charge_modifier_agency := l.charge_modifier_agency;
self.charge_modifier_number := l.charge_modifier_number;
self.citation_number := l.citation_number;
self.original_agency := l.original_agency;
self.original_agency_report_num := l.original_agency_report_num;
self.bpst_number := l.bpst_number;
self.license_plate_state := l.license_plate_state;
self.license_plate_number := l.license_plate_number;
self.accident_related := l.accident_related;
self.employment_related := l.employment_related;
self.charge_status := l.charge_status;
self.charge_status_date := l.charge_status_date;
self.record_changed_date_chg := l.record_changed_date;
self.record_changed_time_chg := l.record_changed_time;
self.Record_Type_amt := r.Record_Type;
self.Amount_Id := r.Amount_Id;
self.Related_Record_Type := r.Related_Record_Type;
self.Related_Record_Id := r.Related_Record_Id;
self.Amount_Type := r.Amount_Type;
self.Amount_Modifier := r.Amount_Modifier;
self.Amount_Unit := r.Amount_Unit;
self.Dollars := r.Dollars;
self.Non_Dollars := r.Non_Dollars;
self.Related_Jgm_Amount_Id := r.Related_Jgm_Amount_Id;
self.Related_Receivable_Number := r.Related_Receivable_Number;
self.Related_Receivable_Sequence := r.Related_Receivable_Sequence;
self.Judgment_Flag := r.Judgment_Flag;
self.Record_Changed_Date := r.Record_Changed_Date;
self.Record_Changed_Time := r.Record_Changed_Time;
self.User_Id := r.User_Id;
self.Command_Name := r.Command_Name;
	self := l;
	self := r;
	self := [];
end;

first_join_compb := join(distribute(CRIM.File_OR_Raw_Charges(court_type = 'C' and case_number <> ''), hash(case_number)), distribute(CRIM.File_OR_Raw_amounts, hash(case_number)), 
						left.court_type= right.court_type and 
						left.court_location = right.court_location and
						left.case_number = right.case_number and
						left.charge_id = right.Related_Record_Id,
						first_joinb(left, right), left outer, local);	
						
Layout_Combined secondjoin(Layout_Combined l, Layout_Combined r) := transform
self.Court_Type := l.Court_Type;
self.Court_Location := l.Court_Location;
self.Case_Number := l.Case_Number;
self.record_type_chg := l.record_type_chg;
self.charge_id := l.charge_id;
self.previous_charge_id := l.previous_charge_id;
self.charge_count := l.charge_count;
self.incident_date := l.incident_date;
self.citation_issue_date := l.citation_issue_date;
self.law_agency := l.law_agency;
self.law_number := l.law_number;
self.law_code := l.law_code;
self.charge_modifier_agency := l.charge_modifier_agency;
self.charge_modifier_number := l.charge_modifier_number;
self.citation_number := l.citation_number;
self.original_agency := l.original_agency;
self.original_agency_report_num := l.original_agency_report_num;
self.bpst_number := l.bpst_number;
self.license_plate_state := l.license_plate_state;
self.license_plate_number := l.license_plate_number;
self.accident_related := l.accident_related;
self.employment_related := l.employment_related;
self.charge_status := l.charge_status;
self.charge_status_date := l.charge_status_date;
self.record_changed_date_chg := l.record_changed_date;
self.record_changed_time_chg := l.record_changed_time;
self.Charge_Id_snt := r.Charge_Id;
self.Sentence_Id := r.Sentence_Id;
self.Decision_Type := r.Decision_Type;
self.Decision_Date := r.Decision_Date;
self.Finacinal_System_Flag := r.Finacinal_System_Flag;
self.Due_Date := r.Due_Date;
self.Decision_Status := r.Decision_Status;
self.Decision_Status_Date := r.Decision_Status_Date;
self.Record_Changed_Date_snt := r.Record_Changed_Date;
self.Record_Changed_Time_snt := r.Record_Changed_Time;
self := l;
end;

first_join_comp := join(first_join_compb, first_join_compa, 
						left.court_type= right.court_type and 
						left.court_location = right.court_location and
						left.case_number = right.case_number and
						left.charge_id = right.Charge_Id_snt,
						secondjoin(left, right), left outer, local);

////////////////////////////////////////////////////////////////////////////////

output(choosen(first_join_compa, 50), named('after_joina'));
output(choosen(first_join_compb, 50), named('after_joinb'));

output(choosen(first_join_comp, 50), named('after_join'));

Layout_Combined second_join(first_join_comp l, CRIM.File_OR_Raw_Laws r) := transform
	self.Court_Location_law := r.Court_Location;
	self.Record_Change_Date_law := r.Record_Change_Date;
	self.Record_Change_Time_law := r.Record_Change_Time;
	self.description := r.Description;
	self.penalty_code := r.penalty_code;
	self.penalty_class := r.penalty_class;
	self.law_agency := l.law_agency;
	self.law_code := l.law_code;
	self.law_number := l.law_number;
	self.charge_modifier_agency := l.charge_modifier_agency;
	self.decision_date := l.decision_date;
	self.sentence_id := l.sentence_id;
	self := l;
	self := r;	
	// self := [];
end;

second_join_comp := join(first_join_comp, CRIM.File_OR_Raw_Laws, 
						left.law_number = right.law_number and
						left.law_agency = right.law_agency,
						second_join(left, right), left outer, lookup);

// Layout_Combined third_join(second_join_comp l, CRIM.File_OR_Raw_amounts r) := transform
	// self.record_type_amt := r.record_type;
	// self.Amount_Id := r.Amount_Id;
	// self.Related_Record_Type := r.Related_Record_Type;
	// self.Related_Record_Id := r.Related_Record_Id;
	// self.Amount_Type := r.Amount_Type;
	// self.Amount_Modifier := r.Amount_Modifier;
	// self.Amount_Unit := r.Amount_Unit;
	// self.Dollars := r.Dollars;
	// self.Non_Dollars := r.Non_Dollars;
	// self.Related_Jgm_Amount_Id := r.Related_Jgm_Amount_Id;
	// self.Related_Receivable_Number := r.Related_Receivable_Number;
	// self.Related_Receivable_Sequence := r.Related_Receivable_Sequence;
	// self.Judgment_Flag := r.Judgment_Flag;
	// self.Record_Changed_Date := r.Record_Changed_Date;
	// self.Record_Changed_Time := r.Record_Changed_Time;
	// self.User_Id := r.User_Id;
	// self.Command_Name := r.Command_Name;
	// self.law_agency := l.law_agency;
	// self.law_code := l.law_code;
	// self.law_number := l.law_number;
	// self.charge_modifier_agency := l.charge_modifier_agency;
	// self.decision_date := l.decision_date;
	// self.sentence_id := l.sentence_id;
	// self := l;
	// self := r;
// end;

// third_join_comp := join(second_join_comp, distribute(CRIM.File_OR_Raw_amounts, hash(case_number)), 
						// left.court_type= right.court_type and 
						// left.court_location = right.court_location and
						// left.case_number = right.case_number and
						// right.Related_Record_Id = left.sentence_id,
						// third_join(left, right), left outer, local);

Layout_Combined fourth_join(second_join_comp l, CRIM.File_OR_Raw_party r) := transform
	self.Judgment_Flag_pty := r.Judgment_Flag;
	self.Record_Changed_Date_pty := r.Record_Changed_date;
	self.Record_Changed_Time_pty := r.Record_Changed_time;
	self.law_agency := l.law_agency;
	self.law_code := l.law_code;
	self.law_number := l.law_number;
	self.charge_modifier_agency := l.charge_modifier_agency;
	self.decision_date := l.decision_date;
	self.sentence_id := l.sentence_id;
	self := l;
	self := r;
	// self := [];
end;

fourth_join_comp := join(second_join_comp, distribute(CRIM.File_OR_Raw_party, hash(case_number)), 
						left.court_type= right.court_type and 
						left.court_location = right.court_location and
						left.case_number = right.case_number,
						fourth_join(left, right), left outer, local);

Layout_Combined fifth_join(fourth_join_comp l, CRIM.File_OR_Raw_party_id r) := transform
self.Drivers_License_Number := r.Drivers_License_Number;
self.Drivers_License_State := r.Drivers_License_State;
self.Arrest_Date := r.Arrest_Date;
self.Booking_Number := r.Booking_Number;
	self.law_agency := l.law_agency;
	self.law_code := l.law_code;
	self.law_number := l.law_number;
	self.charge_modifier_agency := l.charge_modifier_agency;
	self.decision_date := l.decision_date;
	self.sentence_id := l.sentence_id;
	self := l;
	self := r;	
	// self := [];
end;

fifth_join_comp := join(fourth_join_comp, distribute(CRIM.File_OR_Raw_party_id(party_side = 'DEF'), hash(case_number)), 
						left.court_type= right.court_type and 
						left.court_location = right.court_location and
						left.case_number = right.case_number,
						fifth_join(left, right), left outer, local): PERSIST('~thor_dell400::persist::Crim_OR_Offensesjn')
;

///////////JOINS COMPLETE - NEXT DO LOOKUPS

ds_Case_Court_Agency    := dedup(CRIM.File_OR_Lookup_Codes(Table_Type = 'TB11')
                                ,Table_Key);
ds_Charge_Status        := dedup(CRIM.File_OR_Lookup_Codes(Table_Type = 'TB13')
                                ,Table_Key);
ds_snt_jgmt_amount_type := dedup(CRIM.File_OR_Lookup_Codes(Table_Type = 'TB24')
                                ,Table_Key);
ds_Decision_Type        := dedup(CRIM.File_OR_Lookup_Codes(Table_Type = 'TB26')
                                ,Table_Key);
ds_Decision_Status      := dedup(CRIM.File_OR_Lookup_Codes(Table_Type = 'TB27')
                                ,Table_Key);
ds_sentence_modifier    := dedup(CRIM.File_OR_Lookup_Codes(Table_Type = 'TB46')
                                ,Table_Key);

Layout_Combined tb11_join(fifth_join_comp l, ds_Case_Court_Agency r) := transform
	self.law_agency_desc := r.full_description;
	self := l;
end;

lkup_first_join := join(fifth_join_comp, ds_Case_Court_Agency, trim(left.court_location, all) = trim(right.table_key, all), tb11_join(left, right), lookup);

fourth_join_comp tb13_join(lkup_first_join l, ds_Charge_Status r) := transform
	self.charge_status_desc := r.full_description;
	self := l;
end;

lkup_second_join := join(lkup_first_join, ds_Charge_Status, trim(left.Charge_Status, all) = trim(right.table_key, all), tb13_join(left, right), lookup);

fourth_join_comp tb26_join(lkup_second_join l, ds_Decision_Type r) := transform
	self.decision_type_desc := r.full_description;
	self := l;
end;

lkup_third_join := join(lkup_second_join, ds_Decision_Type, trim(left.decision_type, all) = trim(right.table_key, all), tb26_join(left, right), lookup);

fourth_join_comp tb27_join(lkup_third_join l, ds_Decision_Status r) := transform
	self.decision_status_desc := r.full_description;
	self := l;
end;

lkup_fourth_join := sort(join(lkup_third_join, ds_Decision_Status, trim(left.decision_status, all) = trim(right.table_key, all), tb27_join(left, right), lookup)
						,court_type,court_location,case_number): PERSIST('~thor_dell400::persist::Crim_OR_Offenseslkp')
						;

output(choosen(lkup_fourth_join, 50), named('after_lkup_join'));

///////////////// OFFENSE LAYOUT MAPPING

Crim_Common.Layout_In_Court_Offenses tOHCrim(Layout_Combined l) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

string amount_type_simp(string l, string r) := function
vSuspended	:= if (regexfind('DH|RC|RK|RV|SE|SI|SP|TR|VC|WV',
				r[1..2]), true, false);
vFine		:= if (regexfind('ATFE|BLFR|CJAS|CLLC|COMP|DICO|DMVC|FEES|FINE|IDAA|IDCC|IDCP|IDPR|IDRC|INDF|INTR|JGAF|JGFE|JGIN|JGPF|LRFE|LSAS|MBF |OPTS|SEFT|SEJG|STMH|STMM|STMP|UNAS|VCPT|WSFE|WTFE',
				l), true, false);
vJail		:= if (regexfind('CMCF|CMCS|CMYA|CUST|JAIL|JVDT|OCDO|ODCJ|ODOC|OWCD|PRPT|RPCC|TCSD',
				l), true, false);
vProbation	:= if (regexfind('PPSU|PRCU|PREX|PROB|PROC|PROR|PROS|PROY|PRRI|SVIN|SVMX',
				l), true, false);
vCosts		:= if (regexfind('CORC|COST|JGCC',
				l), true, false);
vDeath		:= if (regexfind('DETH',
				l), true, false);
vLife		:= if (regexfind('LIFE|LFWO|LFWP',
				l), true, false);
TERM := if(vLife, 'LIFE', if(vDeath, 'DEATH', if(vJail and ~vSuspended, 'JAIL' ,
			if(vProbation and ~vSuspended, 'PROB', 
				if(vJail and vSuspended, 'SUSP', 
					if(vCosts and ~vSuspended, 'COURT_COST', 
						if(vFine and ~vSuspended, 'COURT_FINE', 
							if(vFine and vSuspended, 'SUSPCOURT_FINE', ''))))))));
retval := Term;
return retval;
end;

self.process_date 				:= Crim_Common.Version_Development;
self.offender_key		:= '31'+l.court_type+l.court_location+l.case_number;
self.vendor 					:= '31';
self.state_origin 				:= 'OR';
self.source_file 				:= 'OR_CRIM_COURT';
self.off_comp 					:= l.charge_id[3..5];
self.off_delete_flag 			:= '';
self.off_date 					:= if(if(l.incident_date[1..1] = '1', '20', '19') + l.incident_date[2..7] between '19010101' and Crim_Common.Version_Production, if(l.incident_date[1..1] = '1', '20', '19') + l.incident_date[2..7], '');
								// if(regexreplace('1', regexreplace('0', l.incident_date[1..1], '19'), '20')[1..1]+l.incident_date[2..7] between '19010101' and Crim_Common.Version_Development, regexreplace('1', regexreplace('0', l.incident_date[1..1], '19'), '20')[1..1]+l.incident_date[2..7], '');
self.arr_date 					:= if(if(l.arrest_date[1..1] = '1', '20', '19') + l.arrest_date[2..7] between '19010101' and Crim_Common.Version_Production, if(l.arrest_date[1..1] = '1', '20', '19') + l.arrest_date[2..7], '');
// self.num_of_counts 				:= '';
self.le_agency_cd 				:= trim(l.law_agency, all);
// self.le_agency_desc 			:= '';
// self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= trim(l.citation_number, left, right);
self.traffic_dl_no 				:= trim(l.Drivers_License_Number, left, right);
self.traffic_dl_st 				:= trim(l.Drivers_License_state, left, right);
// self.arr_off_code 				:= '';
// self.arr_off_desc_1 			:= '';
// self.arr_off_desc_2 			:= '';
// self.arr_off_type_cd 			:= '';
// self.arr_off_type_desc 			:= '';
// self.arr_off_lev 				:= '';
// self.arr_statute 				:= '';
// self.arr_statute_desc 			:= '';
// self.arr_disp_date 				:= '';
// self.arr_disp_code 				:= '';
// self.arr_disp_desc_1 			:= '';
// self.arr_disp_desc_2 			:= '';
// self.pros_refer_cd 				:= '';
// self.pros_refer 				:= '';
// self.pros_assgn_cd 				:= '';
// self.pros_assgn 				:= '';
// self.pros_chg_rej 				:= '';
// self.pros_off_code 				:= '';
// self.pros_off_desc_1 			:= '';
// self.pros_off_desc_2 			:= '';
// self.pros_off_type_cd 			:= '';
// self.pros_off_type_desc 		:= '';
// self.pros_off_lev 				:= '';
// self.pros_act_filed 			:= '';
self.court_case_number 			:= trim(l.case_number, left, right);
self.court_cd 					:= trim(l.court_location, left, right);
self.court_desc 				:= trim(l.law_agency_desc[1..stringlib.stringfind(l.law_agency_desc, '  ', 1)], left, right);
// self.court_appeal_flag 			:= '';
// self.court_final_plea 			:= '';
self.court_off_code 			:= trim(l.law_number, left, right);
self.court_off_desc_1 			:= trim(l.description, left, right);
// self.court_off_desc_2			:= '';
// self.court_off_type_cd 			:= '';
// self.court_off_type_desc 		:= '';
self.court_off_lev 				:= trim(l.penalty_class + l.penalty_code, left, right);
// self.court_statute 				:= stringlib.stringfilterout(if(l.charge_offensedescription = l.dispositionactioncode, l.charge_actioncode, ''), '*');
// self.court_additional_statutes 	:= '';
// self.court_statute_desc 		:= '';
self.court_disp_date 			:= trim(if(if(l.charge_status_date[1..1] = '1', '20', '19') + l.charge_status_date[2..7] between '19010101' and Crim_Common.Version_Production, if(l.charge_status_date[1..1] = '1', '20', '19') + l.charge_status_date[2..7], ''), left, right);
self.court_disp_code 			:= trim(l.charge_status, left, right);
self.court_disp_desc_1	 		:= trim(if(~regexfind('(Filing)|(FILING)|(filing)', l.charge_status_desc), l.charge_status_desc, ''), left, right);
// self.court_disp_desc_2 			:= '';
self.sent_date 					:= trim(if(if(l.decision_date[1..1] = '1', '20', '19') + l.decision_date[2..7] between '19010101' and Crim_Common.Version_Production, if(l.decision_date[1..1] = '1', '20', '19') + l.decision_date[2..7], ''), left, right);
self.sent_jail 					:= trim(if(amount_type_simp(l.amount_type, l.amount_modifier) = 'JAIL', regexreplace('^0+', l.non_dollars[1..7], '')+ ' ' + regexreplace('W',regexreplace('D',regexreplace('M',regexreplace('Y',l.amount_unit, 'YEAR(S)'), 'MONTH(S)'), 'DAY(S)'), 'WEEK(S)'), if(amount_type_simp(l.amount_type, l.amount_modifier) in ['LIFE','DEATH'], amount_type_simp(l.amount_type, l.amount_modifier), '')), left, right);
self.sent_susp_time 			:= trim(if(amount_type_simp(l.amount_type, l.amount_modifier) = 'SUSP', regexreplace('^0+', l.non_dollars[1..7], '')+ ' ' + regexreplace('W',regexreplace('D',regexreplace('M',regexreplace('Y',l.amount_unit, 'YEAR(S)'), 'MONTH(S)'), 'DAY(S)'), 'WEEK(S)'), ''), left, right);
self.sent_court_cost 			:= trim(if(amount_type_simp(l.amount_type, l.amount_modifier) = 'COURT_COST', regexreplace('^0+', l.dollars, ''), ''), left, right);
self.sent_court_fine 			:= trim(if(amount_type_simp(l.amount_type, l.amount_modifier) = 'COURT_FINE', regexreplace('^0+', l.dollars, ''), ''), left, right);
self.sent_susp_court_fine 		:= trim(if(amount_type_simp(l.amount_type, l.amount_modifier) = 'SUSPCOURT_FINE', regexreplace('^0+', l.dollars, ''), ''), left, right);
self.sent_probation 			:= trim(if(amount_type_simp(l.amount_type, l.amount_modifier) = 'PROB', regexreplace('^0+', l.non_dollars[1..7], '')+ ' ' + regexreplace('W',regexreplace('D',regexreplace('M',regexreplace('Y',l.amount_unit, 'YEAR(S)'), 'MONTH(S)'), 'DAY(S)'), 'WEEK(S)'), ''), left, right);
// self.sent_addl_prov_code 		:= '';
// self.sent_addl_prov_desc_1 		:= '';
// self.sent_addl_prov_desc_2 		:= '';
// self.sent_consec 				:= '';
// self.sent_agency_rec_cust_ori 	:= '';
// self.sent_agency_rec_cust 		:= '';
// self.appeal_date 				:= '';
// self.appeal_off_disp 			:= '';
// self.appeal_final_decision 		:= '';
self := [];
end;

pOHCrim := project(lkup_fourth_join, tOHCrim(left));

fOHOffens:= dedup(sort(pOHCrim(off_comp <> 'Char'),record),record);
output(choosen(fOHOffens, 50));

Crim_Common.Layout_In_Court_Offenses T(Crim_Common.Layout_In_Court_Offenses L, Crim_Common.Layout_In_Court_Offenses R) := TRANSFORM
SELF.sent_court_cost := (string)((integer)L.sent_court_cost + (integer)R.sent_court_cost);
SELF.sent_court_fine := (string)((integer)L.sent_court_fine + (integer)R.sent_court_fine);
SELF.sent_susp_court_fine := (string)((integer)L.sent_susp_court_fine + (integer)R.sent_susp_court_fine);
SELF := R;
END;

iOhOffens := ungroup(ITERATE(group(fOHOffens, offender_key, off_comp),T(LEFT,RIGHT)));

Crim_Common.Layout_In_Court_Offenses dorollup(Crim_Common.Layout_In_Court_Offenses l, Crim_Common.Layout_In_Court_Offenses r) := transform
	self.sent_date := if(l.sent_date > r.sent_date, l.sent_date, r.sent_date);
	self.sent_jail := if(l.sent_jail > r.sent_jail, l.sent_jail, r.sent_jail);
	self.sent_susp_time := if(l.sent_susp_time > r.sent_susp_time, l.sent_susp_time, r.sent_susp_time);
	self.sent_court_cost := if(l.sent_court_cost > r.sent_court_cost, l.sent_court_cost, r.sent_court_cost);
	self.sent_court_fine := if(l.sent_court_fine > r.sent_court_fine, l.sent_court_fine, r.sent_court_fine);
	self.sent_susp_court_fine := if(l.sent_susp_court_fine > r.sent_susp_court_fine, l.sent_susp_court_fine, r.sent_susp_court_fine);
	self.sent_probation := if(l.sent_probation > r.sent_probation, l.sent_probation, r.sent_probation);
	self := l;
	self := r;
end;
	
rOhOffens := sort(rollup(iOHOffens, left.offender_key = right.offender_key and left.off_comp = right.off_comp and left.court_off_desc_1 = right.court_off_desc_1, dorollup(left, right)), record);

Crim_Common.Layout_In_Court_Offenses reformat(Crim_Common.Layout_In_Court_Offenses l) := transform
	self.sent_court_cost := if(l.sent_court_cost = '0', '', (string)intformat((integer)l.sent_court_cost, 8, 0));
	self.sent_court_fine := if(l.sent_court_fine = '0', '', (string)intformat((integer)l.sent_court_fine, 8, 0));
	self.sent_susp_court_fine := if(l.sent_susp_court_fine = '0', '', (string)intformat((integer)l.sent_susp_court_fine, 8, 0));
	self := l;
end;

refOffens := project(rOhOffens, reformat(left))
: PERSIST('~thor_dell400::persist::Crim_OR_Offenses')
;

export Map_OR_Offenses2 := refOffens;

