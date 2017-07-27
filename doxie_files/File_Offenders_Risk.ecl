import address,  ut, lib_stringlib, doxie_build,hygenics_crim,hygenics_search;

//offender := doxie_files.File_Offenders;

	old_layout_offender := record
		string8		process_date;
		string8		file_date:='';
		string60	offender_key;
		string5		vendor;
		string20	source_file;
		string2		record_type := '';
		string25	orig_state;
		string15	id_num:='';
		string56	pty_nm:='';
		string1		pty_nm_fmt:='';
		string20  orig_lname:= '';				
		string20  orig_fname:= '';				
		string20  orig_mname:= '';				
		string10  orig_name_suffix:= '';			
		string20	lname:='';		
		string20	fname:='';	
		string20	mname:='';
		string6		name_suffix:='';
		string1		pty_typ:='';
		string1		nitro_flag:='';
		string9		ssn:='';
		string35	case_num := '';
		string40  case_court	:= '';    			
		string8		case_date := '';
		string5   case_type := '';
		string25	case_type_desc;
		string30	county_of_origin := '';
		string10	dle_num:='';
		string9		fbi_num:='';
		string10	doc_num:='';
		string10	ins_num:='';
		string25  dl_num := '';					
		string2   dl_state := '';					
		string2		citizenship:='';
		string8		dob:='';
		string8		dob_alias:='';
		string13	county_of_birth;
		string25	place_of_birth:='';
		string25	street_address_1:='';
		string25	street_address_2:='';
		string25	street_address_3:='';
		string10	street_address_4:='';
		string10	street_address_5:='';
		string13	current_residence_county;
		string13	legal_residence_county;
		string3		race:='';
		string30	race_desc:='';
		string7		sex:='';
		string3		hair_color:='';
		string15	hair_color_desc:='';
		string3		eye_color:='';
		string15	eye_color_desc:='';
		string3		skin_color:='';
		string15	skin_color_desc:='';
		string10	scars_marks_tattoos_1:='';
		string10	scars_marks_tattoos_2:='';
		string10	scars_marks_tattoos_3:='';
		string10	scars_marks_tattoos_4:='';
		string10	scars_marks_tattoos_5:='';
		string3		height:='';
		string3		weight:='';
		string5		party_status:='';
		string60	party_status_desc:='';
		string10	_3g_offender:='';
		string10	violent_offender:='';
		string10	sex_offender:='';
		string10	vop_offender:='';
		string1		data_type;
		string26	record_setup_date;
		string45	datasource;
		address.Layout_Address_Clean_Return;
		string18	county_name;
		string12	did;
		string3		score;
		string9		ssn_appended;
		string1		curr_incar_flag := '';
		string1		curr_parole_flag := '';
		string1		curr_probation_flag := '';
		string8  	src_upload_date := '';			
		string3   Age := '';						
		string150 image_link := '';				
	end;

	offder := doxie_build.file_offenders_keybuilding;

	old_layout_offender reformatOld(offder l):= transform
		self := l;
	end;

offender := project(offder, reformatOld(left));

//offense := doxie_files.file_offenses;
//offense := doxie_build.file_offenses_keybuilding;
offense 	:= dataset('~thor_data400::base::corrections_offenses_' + doxie_build.buildstate,hygenics_crim.Layout_Base_Offenses_with_OffenseCategory,flat);
//court_offense := doxie_files.file_court_offenses;
//court_offense := doxie_build.file_courtoffenses_keybuilding;
court_offense := dataset('~thor_Data400::base::corrections_court_offenses_' + doxie_build.buildstate, hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory,flat);

offense_fields := record
	court_offense.process_date;
	court_offense.offender_key;
	court_offense.off_date;
	court_offense.arr_date;
	court_offense.arr_disp_date;
	court_offense.court_disp_date;
	court_offense.sent_date;
	court_offense.appeal_date;
	court_offense.court_off_lev;
	court_offense.Court_Off_Code;
	court_offense.court_statute;
	court_offense.Court_Statute_Desc;
	court_offense.Court_Off_Desc_1;
	court_offense.Court_Disp_Desc_1;
	court_offense.Court_Disp_Desc_2;
	offense.off_typ;
	offense.off_lev;
end;
	
offenses_merged := project(offense, transform(offense_fields, self.sent_date := left.stc_dt, self := left, self := [])) +
			    project(court_offense, transform(offense_fields, self := left, self := []));

offense_distr := distribute(offenses_merged, hash(offender_key));
offender_distr := distribute(offender, hash(offender_key));

temp := record
	offender;
	offense_fields offense;
	string8 earliest_offense_date;
end;

today := ut.getdate;

// some dates on the files are only ccyymm and some are ccyymmdd.  account for both.  blank out anything that looks like garbage date
clean_date(string date) := function
	tdate := trim(date);
	datelen := length(tdate);
	valid_centuries := ['19', '20'];
	valid_months := ['01','02','03','04','05','06','07','08','09','10','11','12'];
	// valid_days := ['01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31'];
	rdate := if(ut.isNumeric(tdate) and datelen in [6,8] and tdate[1..2] in valid_centuries and tdate[5..6] in valid_months, 
							if(datelen=8, tdate, tdate[1..6] + '01'),
							'');
	return rdate;
end;

earliest_date(string8 date1, string8 date2) := function
	cdate1 := clean_date(date1);
	cdate2 := clean_date(date2);
	early_date := if( ((integer)cdate1 < (integer)cdate2 and cdate1<>'') or cdate2='', cdate1, cdate2);
	return early_date;
end;

offender_with_offenses_data1 := join(offender_distr, offense_distr, left.offender_key=right.offender_key,
	transform(temp, self := left, self.offense := right;
		date1 := earliest_date(right.off_date, right.arr_disp_date);
		date2 := earliest_date(date1, right.court_disp_date);
		date3 := earliest_date(date2, right.sent_date);
		date4 := earliest_date(date3, right.arr_date);
		date5 := earliest_date(date4, right.appeal_date);
		date6 := earliest_date(date5, left.case_date);
		self.earliest_offense_date := date6;
		
		), left outer, local);
										
offender_with_offenses_data := offender_with_offenses_data1((integer)did != 0 and data_type in ['1','2','5']);

layout_offenders_risk := record
	string1 traffic_flag;
	string1 conviction_flag;
	string1 offense_score;
	string1 criminal_offender_level;  // 1 = traffic, not-convicted
									  // 2 = traffic, convicted
									  // 3 = non-traffic, not-convicted
									  // 4 = non-traffic, convicted
	temp;
end;

default_rules := project(offender_with_offenses_data, 
						transform(layout_offenders_risk, 
							self.traffic_flag := map(left.data_type='1' => 'N',
										left.vendor in hygenics_search.sCourt_Vendors_With_No_Traffic => 'N',		
										left.vendor in hygenics_search.sCourt_Vendors_With_Only_Traffic => 'Y',
										hygenics_search.fTraffic_Flag_From_Vendor_and_Offense_Level(left.Vendor,left.offense.court_off_lev) = 'Y' => 'Y',
										hygenics_search.fTraffic_Flag_From_Vendor_and_Offender_Key(left.vendor,left.offender_key) = 'Y' => 'Y',
										left.Vendor in hygenics_search.sCourt_Vendors_With_Traffic_Based_Upon_Off_Lev or 
											left.Vendor in hygenics_search.sCourt_Vendors_With_Traffic_Based_Upon_Offender_Key => 'N',  // if the vendor is one these 2 cases and hasn't been set to a Y already, 
																																 // set to N so the lookup isn't done on those records
										'U'),
										
							self.conviction_flag := map(left.data_type='1' and left.vendor in hygenics_search.sDOC_Vendors_Conviction_Unknown => 'U',
														left.data_type='1' and left.vendor not in hygenics_search.sDOC_Vendors_Conviction_Unknown 	and
																									 left.vendor not in hygenics_search.sDOC_Vendors_NoOffense_NoConviction => 'Y',
														left.data_type='1' and trim(left.offense.offender_key)<>'' and left.vendor in hygenics_search.sDOC_Vendors_NoOffense_NoConviction => 'Y',  // if there is an offense record and source is DOC, there is a conviction in FL
											 
														left.data_type='2' and (integer4)left.offense.Sent_Date<>0 and left.Vendor in hygenics_search.sCourt_Vendors_With_Conviction_Based_Upon_Sent_Date => 'Y',
														left.data_type='2' and (integer4)left.offense.Sent_Date=0 and left.Vendor in hygenics_search.sCourt_Vendors_With_Conviction_Based_Upon_Sent_Date => 'N',
														'U');									
							self := left,
							self := []) );


layout_offenders_risk tJoinForTrafficFlag(layout_offenders_risk le, hygenics_search.Layout_Traffic_Lookup rt) := transform
	self.traffic_flag := map(  le.traffic_flag='Y' => 'Y',
						  rt.vendor<>'' => 'Y',
						  le.traffic_flag='N' => 'N',
						  'N');
	self := le;
end;


dCourtOffensesMixedTrafficByOffense1	:= join(default_rules,hygenics_search.File_Traffic_lookup(Court_Statute<>''),
												left.Vendor = right.Vendor
											and left.offense.court_statute = right.Court_Statute,
												tJoinForTrafficFlag(left,right),
												left outer,
												lookup
											   );
dCourtOffensesMixedTrafficByOffense2	:= join(dCourtOffensesMixedTrafficByOffense1,hygenics_search.File_Traffic_lookup(Court_Statute_Desc<>''),
												left.Vendor = right.Vendor
											and left.offense.Court_Statute_Desc = right.Court_Statute_Desc,
												tJoinForTrafficFlag(left,right),
												left outer,
												lookup
											   );
traffic_lookup	:= join(dCourtOffensesMixedTrafficByOffense2,hygenics_search.File_Traffic_lookup(Court_Off_Desc_1<>''),
												left.Vendor = right.Vendor
											and left.offense.Court_Off_Desc_1[1..70] = right.Court_Off_Desc_1,
												tJoinForTrafficFlag(left,right),
												left outer,
												lookup
											   );

layout_offenders_risk tJoinForConvictionFlag(layout_offenders_risk le, hygenics_search.Layout_Conviction_Lookup rt) :=   transform
	self.conviction_flag	:= map(le.conviction_flag='Y' => 'Y',  // if already convicted, leave it convicted
							  rt.conviction_flag<>''=> rt.conviction_flag,  // if hit on lookup table, use that flag
							  le.conviction_flag='N' => 'N',  // if not convicted, leave not convicted
							  'U');  // otherwise leave as unknown
	self						:=	le;
end;


dCourtOffensesConvictionByDisp1	:= join(traffic_lookup,hygenics_search.File_Conviction_Lookup(Court_Disp_Desc<>''),
										//left.Vendor = right.Vendor and 
										left.offense.process_date<>'' // adding this line to make sure we don't do conviction lookup on records without a matching offense record
									and trim(lib_stringlib.stringlib.stringtouppercase(left.offense.Court_Disp_Desc_1)) = trim(lib_stringlib.stringlib.stringtouppercase(right.Court_Disp_Desc)),
										tJoinForConvictionFlag(left,right),
										left outer,
										lookup
									   );
										 
//VC : commented as Court_Disp_Desc_2 does not have disposition
/*dCourtOffensesConvictionByDisp2	:= join(dCourtOffensesConvictionByDisp1,CrimSrch.File_Conviction_Lookup(Court_Disp_Desc<>''),
										//left.Vendor = right.Vendor and 
										left.offense.process_date<>'' // adding this line to make sure we don't do conviction lookup on records without a matching offense record
									and trim(lib_stringlib.stringlib.stringtouppercase(left.offense.Court_Disp_Desc_2)) = trim(lib_stringlib.stringlib.stringtouppercase(right.Court_Disp_Desc)),
										tJoinForConvictionFlag(left,right),
										left outer,
										lookup
									   );
dCourtOffensesConvictionsMaybe	:= join(dCourtOffensesConvictionByDisp2,CrimSrch.File_Conviction_Lookup(Court_Disp_Desc=''),
										//left.Vendor = right.Vendor and 
										left.offense.process_date<>'' // adding this line to make sure we don't do conviction lookup on records without a matching offense record
									and trim(lib_stringlib.stringlib.stringtouppercase(left.offense.Court_Disp_Desc_1)) = trim(lib_stringlib.stringlib.stringtouppercase(right.Court_Disp_Desc))
									and trim(lib_stringlib.stringlib.stringtouppercase(left.offense.Court_Disp_Desc_2)) = trim(lib_stringlib.stringlib.stringtouppercase(right.Court_Disp_Desc)),
										tJoinForConvictionFlag(left,right),
										left outer,
										lookup
									   );
*/
string1 fMapOffenseLevelToScore(string2 pVendor, string2 pOffenseLevel) := 
	map(pVendor = 'AR' and pOffenseLevel = '  ' => 'F',
		pVendor = 'AZ' and pOffenseLevel = '5 ' => 'F',
		pVendor = 'AZ' and pOffenseLevel = '6 ' => 'F',
		pVendor = 'AZ' and pOffenseLevel = '4 ' => 'F',
		pVendor = 'AZ' and pOffenseLevel = '1 ' => 'F',
		pVendor = 'AZ' and pOffenseLevel = '3 ' => 'F',
		pVendor = 'AZ' and pOffenseLevel = '2 ' => 'F',
		pVendor = 'AZ' and pOffenseLevel = '  ' => 'F',
		pVendor = 'CT' and pOffenseLevel = '  ' => 'F',
		pVendor = 'DC' and pOffenseLevel = '  ' => 'F',
		pVendor = 'FL' and pOffenseLevel = 'P ' => 'M',
		pVendor = 'FL' and pOffenseLevel = '5 ' => 'F',
		pVendor = 'FL' and pOffenseLevel = 'C ' => 'U',
		pVendor = 'FL' and pOffenseLevel = '1 ' => 'F',
		pVendor = 'FL' and pOffenseLevel = '2 ' => 'F',
		pVendor = 'FL' and pOffenseLevel = 'L ' => 'U',
		pVendor = 'FL' and pOffenseLevel = '3 ' => 'F',
		pVendor = 'FL' and pOffenseLevel = '  ' => 'F',
		pVendor = 'GA' and pOffenseLevel = '  ' => 'F',
		pVendor = 'IA' and pOffenseLevel = '  ' => 'F',
		pVendor = 'ID' and pOffenseLevel = '  ' => 'F',
		pVendor = 'IL' and pOffenseLevel = 'A ' => 'F',
		pVendor = 'IL' and pOffenseLevel = 'U ' => 'F',
		pVendor = 'IL' and pOffenseLevel = '2 ' => 'F',
		pVendor = 'IL' and pOffenseLevel = '  ' => 'F',
		pVendor = 'IL' and pOffenseLevel = 'B ' => 'F',
		pVendor = 'IL' and pOffenseLevel = 'X ' => 'F',
		pVendor = 'IL' and pOffenseLevel = '1 ' => 'F',
		pVendor = 'IL' and pOffenseLevel = 'C ' => 'F',
		pVendor = 'IL' and pOffenseLevel = '4 ' => 'F',
		pVendor = 'IL' and pOffenseLevel = 'M ' => 'M',
		pVendor = 'IL' and pOffenseLevel = '3 ' => 'F',
		pVendor = 'IN' and pOffenseLevel = 'FD' => 'F',
		pVendor = 'IN' and pOffenseLevel = 'MC' => 'M',
		pVendor = 'IN' and pOffenseLevel = 'CC' => 'U',
		pVendor = 'IN' and pOffenseLevel = 'FB' => 'F',
		pVendor = 'IN' and pOffenseLevel = 'M ' => 'M',
		pVendor = 'IN' and pOffenseLevel = 'MA' => 'M',
		pVendor = 'IN' and pOffenseLevel = 'XX' => 'U',
		pVendor = 'IN' and pOffenseLevel = 'MB' => 'M',
		pVendor = 'IN' and pOffenseLevel = 'HO' => 'U',
		pVendor = 'IN' and pOffenseLevel = 'FA' => 'F',
		pVendor = 'IN' and pOffenseLevel = 'FC' => 'F',
		pVendor = 'KS' and pOffenseLevel = '  ' => 'F',
		pVendor = 'KS' and pOffenseLevel = 'C ' => 'F',
		pVendor = 'KS' and pOffenseLevel = 'D ' => 'F',
		pVendor = 'KS' and pOffenseLevel = 'B ' => 'F',
		pVendor = 'KS' and pOffenseLevel = 'E ' => 'F',
		pVendor = 'KS' and pOffenseLevel = 'A ' => 'F',
		pVendor = 'KS' and pOffenseLevel = 'U ' => 'U',
		pVendor = 'KY' and pOffenseLevel = '3 ' => 'F',
		pVendor = 'KY' and pOffenseLevel = '2 ' => 'F',
		pVendor = 'KY' and pOffenseLevel = 'A ' => 'F',
		pVendor = 'KY' and pOffenseLevel = 'O ' => 'F',
		pVendor = 'KY' and pOffenseLevel = 'M ' => 'F',
		pVendor = 'KY' and pOffenseLevel = 'D ' => 'F',
		pVendor = 'KY' and pOffenseLevel = '. ' => 'F',
		pVendor = 'KY' and pOffenseLevel = 'C ' => 'F',
		pVendor = 'KY' and pOffenseLevel = '8 ' => 'F',
		pVendor = 'KY' and pOffenseLevel = '\\ ' => 'F',
		pVendor = 'KY' and pOffenseLevel = 'B ' => 'F',
		pVendor = 'KY' and pOffenseLevel = '` ' => 'F',
		pVendor = 'KY' and pOffenseLevel = 'X ' => 'F',
		pVendor = 'KY' and pOffenseLevel = '0 ' => 'F',
		pVendor = 'KY' and pOffenseLevel = '{ ' => 'F',
		pVendor = 'KY' and pOffenseLevel = ', ' => 'F',
		pVendor = 'KY' and pOffenseLevel = '  ' => 'F',
		pVendor = 'KY' and pOffenseLevel = '1 ' => 'F',
		pVendor = 'ME' and pOffenseLevel = '  ' => 'F',
		pVendor = 'MI' and pOffenseLevel = '  ' => 'F',
		pVendor = 'MN' and pOffenseLevel = '  ' => 'F',
		pVendor = 'MO' and pOffenseLevel = '  ' => 'F',
		pVendor = 'MS' and pOffenseLevel = '  ' => 'F',
		pVendor = 'MT' and pOffenseLevel = '  ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'B ' => 'F',
		pVendor = 'NC' and pOffenseLevel = '2 ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'A1' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'A ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'B2' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'F ' => 'F',
		pVendor = 'NC' and pOffenseLevel = '  ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'B1' => 'F',
		pVendor = 'NC' and pOffenseLevel = '1 ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'C ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'D ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'I ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'G ' => 'F',
		pVendor = 'NC' and pOffenseLevel = '3 ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'H ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'J ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'E ' => 'F',
		pVendor = 'NE' and pOffenseLevel = '  ' => 'F',
		pVendor = 'NE' and pOffenseLevel = 'I ' => 'F',
		pVendor = 'NE' and pOffenseLevel = 'A ' => 'F',
		pVendor = 'NE' and pOffenseLevel = 'E ' => 'F',
		pVendor = 'NE' and pOffenseLevel = 'F ' => 'F',
		pVendor = 'NE' and pOffenseLevel = 'B ' => 'F',
		pVendor = 'NE' and pOffenseLevel = 'D ' => 'F',
		pVendor = 'NE' and pOffenseLevel = 'H ' => 'F',
		pVendor = 'NE' and pOffenseLevel = 'C ' => 'F',
		pVendor = 'NE' and pOffenseLevel = 'G ' => 'F',
		pVendor = 'NH' and pOffenseLevel = '  ' => 'F',
		pVendor = 'NJ' and pOffenseLevel = 'd ' => 'F',
		pVendor = 'NJ' and pOffenseLevel = '  ' => 'F',
		pVendor = 'NJ' and pOffenseLevel = '1 ' => 'F',
		pVendor = 'NJ' and pOffenseLevel = 'D ' => 'F',
		pVendor = 'NJ' and pOffenseLevel = 'P ' => 'F',
		pVendor = 'NJ' and pOffenseLevel = '3 ' => 'F',
		pVendor = 'NJ' and pOffenseLevel = '2 ' => 'F',
		pVendor = 'NJ' and pOffenseLevel = 'M ' => 'F',
		pVendor = 'NJ' and pOffenseLevel = '4 ' => 'F',
		pVendor = 'NJ' and pOffenseLevel = 'p ' => 'F',
		pVendor = 'NM' and pOffenseLevel = 'F ' => 'F',
		pVendor = 'NM' and pOffenseLevel = '  ' => 'F',
		pVendor = 'NM' and pOffenseLevel = 'M ' => 'M',
		pVendor = 'NV' and pOffenseLevel = '  ' => 'F',
		pVendor = 'NY' and pOffenseLevel = 'B ' => 'F',
		pVendor = 'NY' and pOffenseLevel = 'A ' => 'F',
		pVendor = 'NY' and pOffenseLevel = 'E ' => 'F',
		pVendor = 'NY' and pOffenseLevel = '1 ' => 'F',
		pVendor = 'NY' and pOffenseLevel = '3 ' => 'F',
		pVendor = 'NY' and pOffenseLevel = '2 ' => 'F',
		pVendor = 'NY' and pOffenseLevel = 'D ' => 'F',
		pVendor = 'NY' and pOffenseLevel = 'M ' => 'M',
		pVendor = 'NY' and pOffenseLevel = 'C ' => 'F',
		pVendor = 'NY' and pOffenseLevel = 'U ' => 'F',
		pVendor = 'OH' and pOffenseLevel = '  ' => 'F',
		pVendor = 'OK' and pOffenseLevel = '  ' => 'F',
		pVendor = 'OR' and pOffenseLevel = 'B ' => 'F',
		pVendor = 'OR' and pOffenseLevel = '  ' => 'F',
		pVendor = 'OR' and pOffenseLevel = 'A ' => 'F',
		pVendor = 'OR' and pOffenseLevel = 'U ' => 'F',
		pVendor = 'OR' and pOffenseLevel = 'C ' => 'F',
		pVendor = 'OR' and pOffenseLevel = 'O ' => 'F',
		pVendor = 'PA' and pOffenseLevel = '  ' => 'F',
		pVendor = 'SC' and pOffenseLevel = '  ' => 'F',
		pVendor = 'TN' and pOffenseLevel = 'C ' => 'F',
		pVendor = 'TN' and pOffenseLevel = 'E ' => 'F',
		pVendor = 'TN' and pOffenseLevel = 'D ' => 'F',
		pVendor = 'TN' and pOffenseLevel = '  ' => 'F',
		pVendor = 'TN' and pOffenseLevel = 'B ' => 'F',
		pVendor = 'TN' and pOffenseLevel = 'A ' => 'F',
		pVendor = 'TX' and pOffenseLevel = '  ' => 'F',
		pVendor = 'UT' and pOffenseLevel = 'N ' => 'F',
		pVendor = 'UT' and pOffenseLevel = '1 ' => 'F',
		pVendor = 'UT' and pOffenseLevel = '3 ' => 'F',
		pVendor = 'UT' and pOffenseLevel = 'A ' => 'F',
		pVendor = 'UT' and pOffenseLevel = 'M ' => 'M',
		pVendor = 'UT' and pOffenseLevel = '  ' => 'F',
		pVendor = 'UT' and pOffenseLevel = 'B ' => 'F',
		pVendor = 'UT' and pOffenseLevel = 'C ' => 'F',
		pVendor = 'UT' and pOffenseLevel = '2 ' => 'F',
		pVendor = 'VA' and pOffenseLevel = '  ' => 'F',
		pVendor = 'WA' and pOffenseLevel = '  ' => 'F',
		pVendor = 'WI' and pOffenseLevel = '  ' => 'F',
		'U'
	   )
 ;

layout_offenders_risk final_calculations(layout_offenders_risk le) := transform		
	offscore1 := if(le.Conviction_Flag <> 'Y', '', le.offense_score);
	offscore2 := if(le.Traffic_Flag = 'Y' and le.Conviction_Flag = 'Y', 'T', offscore1);
	offscore3 := if(le.Traffic_Flag <> 'Y' and le.Conviction_Flag = 'Y',
				hygenics_search.fStandard_Offense_Level_From_Orig(le.vendor, le.offense.court_off_lev),
				offscore2);
	offscore4 := if(offscore3 <> 'U',
				 offscore3,
				hygenics_search.fOffense_Score_From_Offense_Code(le.Vendor,le.offense.Court_Off_Code) );		
	
	doc_offense_score := map(le.offense.off_typ = 'S' => 'S',
					 le.offense.off_typ = 'M' => 'M',
					 le.offense.off_typ = 'F' => 'F',
					 'U');
	
	doc_offense_score2 := if(doc_offense_score='U', fMapOffenseLevelToScore(le.vendor, le.offense.off_lev), doc_offense_score);
	
	offense_score_final := if(le.data_type='1', doc_offense_score2, offscore4);
	self.offense_score := offense_score_final;
	
	
	set_off := ['V','I','C','T'];
	traffic_flag := if(offense_score_final in set_Off,'Y',le.traffic_flag );
	conviction_flag	:= if(le.Conviction_Flag<>'',
									  if(le.Conviction_Flag='D'
									  or (le.Data_Type='1' and
										  le.Vendor not in hygenics_search.sDOC_Vendors_Conviction_Unknown 	and
										  le.Vendor not in hygenics_search.sDOC_Vendors_NoOffense_NoConviction
										 ),
										 'Y',
										 le.Conviction_Flag
										),
									  if(le.Data_Type='1' 												and
										  le.Vendor not in hygenics_search.sDOC_Vendors_Conviction_Unknown 	and
										  le.Vendor not in hygenics_search.sDOC_Vendors_NoOffense_NoConviction,
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
 
added_offense_score := project(dCourtOffensesConvictionByDisp1, final_calculations(left));

export File_Offenders_Risk := added_offense_score : persist('persist::criminal_offender_risk');