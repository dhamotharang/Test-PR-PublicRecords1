// import risk_indicators, suppress, ut, doxie, address, riskwise, tms;
import risk_indicators, suppress, ut, doxie, address, riskwise;

export iid_getSSNFlags(grouped DATASET(risk_indicators.Layout_output) inrec, unsigned1 dppa, unsigned1 glb, 
							unsigned3 history_date=risk_indicators.iid_constants.default_history_date, boolean isFCRA=false, boolean runSSNCodes=false,
							string10 ExactMatchLevel=risk_indicators.iid_constants.default_ExactMatchLevel,
							unsigned1 headversion) := function

glb_ok := risk_indicators.iid_constants.glb_ok(glb, isFCRA);
full_history_date := risk_indicators.iid_constants.full_history_date(history_date);

ExactFirstNameRequired := ExactMatchLevel[risk_indicators.iid_constants.posExactFirstNameMatch]=risk_indicators.iid_constants.sTrue;
ExactLastNameRequired := ExactMatchLevel[risk_indicators.iid_constants.posExactLastNameMatch]=risk_indicators.iid_constants.sTrue;

// this will produce two (same) transforms: for regular key and fcra-key
MAC_ssnTable_transform (trans_name, key_ssntable) := MACRO
risk_indicators.layout_output trans_name (risk_indicators.layout_output le, key_ssntable ri, INTEGER i) := transform

	counts := map(headversion=1 => ri.combo,	// all bureaus allowed
								headversion=3 => ri.en,			// experian header allowed
								ri.eq);											// equifax header allowed, current way, so lets default that


	self.ssnexists := IF(i=1,ri.ssn<>'',le.ssnexists);

	//self.did := IF(i=1,IF(le.did=0 AND ri.bestCount=1,ri.bestDID,le.did),le.did);
	
	vssn := risk_indicators.Validate_SSN(le.ssn,'');
	
	socsvalflag_temp := IF(i=1,MAP(
							 le.ssn='' => '3',
							 vssn.invalid => '2',
							 (ri.ssn<>'' and (~ri.isValidFormat OR ~ri.isSequenceValid)) or 
							 vssn.begin_invalid or vssn.middle_invalid or vssn.last_invalid => '1',
							 '0'),
					   le.socsvalflag);
	
	self.socsvalflag := socsvalflag_temp;
	
	PWsocsvalflag_temp := 	IF(i=1,MAP(
							   le.ssn='' => '6',
							   (ri.ssn<>'' and (~ri.isValidFormat OR ~ri.isSequenceValid)) or vssn.begin_invalid or vssn.middle_invalid or vssn.last_invalid => '1',
							   le.dob<> '' and (UNSIGNED3)ri.official_last_seen - (UNSIGNED3)(le.dob[1..6]) > 1800 => '5',
							   (UNSIGNED3)ri.official_last_seen <> 0 and (INTEGER)(ut.GetDate[1..6]) - (UNSIGNED3)ri.official_last_seen < 700 => '4',
							   // not sure what to do for 3 or 2
							   '0'),
						le.pwsocsvalflag);
						
	self.PWsocsvalflag := PWsocsvalflag_temp;
	
	SELF.soclstate := IF(i=1,ri.issue_state,le.soclstate);

	// Only EQ records go into last names.  So just remove these if you don't have GLB
	chooser1 := MAP(~glb_ok	=> 0,
				 counts.lname1.lname=le.lname AND counts.lname2.first_seen < history_date => 2,
				 counts.lname1.lname<>le.lname AND counts.lname1.first_seen < history_date => 1,
				 0);
	
	self.altfirst := IF(i=1,CASE(chooser1,
									1		=> 	(STRING20)counts.lname1.fname,
									2		=> 	(STRING20)counts.lname2.fname,
									''),
					le.altfirst);
	altlast_temp := IF(i=1,CASE(chooser1,
									1		=> 	(STRING20)counts.lname1.lname,
									2		=> 	(STRING20)counts.lname2.lname,
									''),
				    le.altlast);
	self.altlast := altlast_temp;
	self.altlast_date := IF(i=1,CASE(chooser1,
									1		=> 	IF(counts.lname1.last_seen=0,'',(STRING8)counts.lname1.last_seen),
									2		=> 	IF(counts.lname2.last_seen=0,'',(STRING8)counts.lname2.last_seen),
									''),
					    le.altlast_date);
	self.altearly_date := IF(i=1,CASE(chooser1,
									1		=> 	IF(counts.lname1.first_seen=0,'',(STRING8)counts.lname1.first_seen),
									2		=> 	IF(counts.lname2.first_seen=0,'',(STRING8)counts.lname2.first_seen),
									''),
						le.altearly_date);
	
	chooser2 := MAP(~glb_ok	=> 0,
				 chooser1=1 AND counts.lname2.lname<>le.lname AND counts.lname2.first_seen < history_date => 2,
				 chooser1=2 AND counts.lname3.first_seen < history_date => 3,
				 0);
	
	self.altfirst2 := IF(i=1,CASE(chooser2,
									2		=> 	(STRING20)counts.lname2.fname,
									3		=> 	(STRING20)counts.lname3.fname,
									''),
					 le.altfirst2);
	altlast2_temp := IF(i=1,CASE(chooser2,
									2		=> 	(STRING20)counts.lname2.lname,
									3		=> 	(STRING20)counts.lname3.lname,
									''),
					le.altlast2);				 
	self.altlast2 := altlast2_temp;
	self.altlast_date2 := IF(i=1,CASE(chooser2,
									2		=> 	IF(counts.lname2.last_seen=0,'',(STRING8)counts.lname2.last_seen),
									3		=> 	IF(counts.lname3.last_seen=0,'',(STRING8)counts.lname3.last_seen),
									''),
						le.altlast_date2);
	self.altearly_date2 := IF(i=1,CASE(chooser2,
									2		=> 	IF(counts.lname2.first_seen=0,'',(STRING8)counts.lname2.first_seen),
									3		=> 	IF(counts.lname3.first_seen=0,'',(STRING8)counts.lname3.first_seen),
									''),
						 le.altearly_date2);
	
	chooser3 := MAP(~glb_ok	=> 0,
				 chooser2=2 AND counts.lname3.lname<>le.lname AND counts.lname3.first_seen < history_date => 3,
				 chooser2=3 AND counts.lname4.first_seen < history_date => 4,
				 0);
	
	self.altfirst3 := IF(i=1,CASE(chooser3,
												3		=> 	(STRING20)counts.lname3.fname,
												4		=> 	(STRING20)counts.lname4.fname,
												''),
					 le.altfirst3);
	altlast3_temp := IF(i=1,CASE(chooser3,
												3		=> 	(STRING20)counts.lname3.lname,
												4		=> 	(STRING20)counts.lname4.lname,
												''),
					le.altlast3);				 
	self.altlast3 := altlast3_temp;
	self.altlast_date3 := IF(i=1,CASE(chooser3,
												3		=> 	IF(counts.lname3.last_seen=0,'',(STRING8)counts.lname3.last_seen),
												4		=> 	IF(counts.lname4.last_seen=0,'',(STRING8)counts.lname4.last_seen),
												''),
						le.altlast_date3);
	self.altearly_date3 := IF(i=1,CASE(chooser3,
												3		=> 	IF(counts.lname3.first_seen=0,'',(STRING8)counts.lname3.first_seen),
												4		=> 	IF(counts.lname4.first_seen=0,'',(STRING8)counts.lname4.first_seen),
												''),
						 le.altearly_date3);
									
	SELF.altlast_count := IF(i=1,(INTEGER)(altlast_temp<>'') + (INTEGER)(altlast2_temp<>'') + (INTEGER)(altlast3_temp<>''),
						le.altlast_count);

	self.lastssnmatch := IF(i=1,counts.lname1.lname=le.lname AND counts.lname1.first_seen < history_date or 
						   counts.lname2.lname=le.lname AND counts.lname2.first_seen < history_date or 
						   counts.lname3.lname=le.lname AND counts.lname3.first_seen < history_date or 
						   counts.lname4.lname=le.lname AND counts.lname4.first_seen < history_date,
					    le.lastssnmatch);
	
	self.lastssnmatch2 := IF(i=1,risk_indicators.iid_constants.g(risk_indicators.LnameScore(counts.lname1.lname, le.lname)) and if(ExactLastNameRequired, counts.lname1.lname=le.lname, true) AND counts.lname1.first_seen < history_date or
						    risk_indicators.iid_constants.g(risk_indicators.LnameScore(counts.lname2.lname, le.lname)) and if(ExactLastNameRequired, counts.lname2.lname=le.lname, true) AND counts.lname2.first_seen < history_date or
						    risk_indicators.iid_constants.g(risk_indicators.LnameScore(counts.lname3.lname, le.lname)) and if(ExactLastNameRequired, counts.lname3.lname=le.lname, true) AND counts.lname3.first_seen < history_date or
						    risk_indicators.iid_constants.g(risk_indicators.LnameScore(counts.lname4.lname, le.lname)) and if(ExactLastNameRequired, counts.lname4.lname=le.lname, true) AND counts.lname4.first_seen < history_date,
						le.lastssnmatch2);
	self.firstssnmatch := IF(i=1,risk_indicators.iid_constants.g(risk_indicators.FnameScore(counts.lname1.fname, le.fname)) and if(ExactFirstNameRequired, counts.lname1.fname=le.fname, true) AND counts.lname1.first_seen < history_date or
						    risk_indicators.iid_constants.g(risk_indicators.FnameScore(counts.lname2.fname, le.fname)) and if(ExactFirstNameRequired, counts.lname2.fname=le.fname, true) AND counts.lname2.first_seen < history_date or
						    risk_indicators.iid_constants.g(risk_indicators.FnameScore(counts.lname3.fname, le.fname)) and if(ExactFirstNameRequired, counts.lname3.fname=le.fname, true) AND counts.lname3.first_seen < history_date or
						    risk_indicators.iid_constants.g(risk_indicators.FnameScore(counts.lname4.fname, le.fname)) and if(ExactFirstNameRequired, counts.lname4.fname=le.fname, true) AND counts.lname4.first_seen < history_date,
						le.firstssnmatch);
	
	// Death and Bankrupt are both nonglb
	
	bansflag_temp := IF(i=1,MAP(counts.isBankrupt AND ((string)counts.dt_first_bankrupt < full_history_date) => '1',
						   // a 2 would be for a full name and address match
						   le.ssn='' OR le.lname='' OR le.prim_name='' => '3',	// does not appear that st. cloud will return a 3 anymore
						   '0'),
					le.bansFlag);
	
	self.bansFlag := bansflag_temp;
	self.bansdatefiled := IF(i=1 and bansflag_temp='1', (string)counts.dt_first_bankrupt, le.bansdatefiled);
	
	decsflag_temp := IF(i=1,MAP(counts.isDeceased AND ((string)counts.dt_first_deceased < full_history_date)  => '1',
						   socsvalflag_temp IN ['2','3']/* OR length(le.dob) < 6 OR le.dob='' OR (INTEGER)le.dob=0*/ => '2',
						   '0'),
					le.decsflag);
	self.decsflag := decsflag_temp;
	self.deceasedDate := if(i=1 and decsflag_temp='1',counts.dt_first_deceased, le.deceasedDate);  // check only on ssn search, and make sure date is before history date				
	self.socllowissue := IF(i=1,TRIM((STRING)ri.official_first_seen,LEFT),le.socllowissue);
	self.soclhighissue := IF(i=1,TRIM((STRING)ri.official_last_seen,LEFT),le.soclhighissue);

	socsdobflag_temp :=	IF(i=1,vssn.ssnDobFlag(ri.official_last_seen),le.socsdobflag);
	self.socsdobflag := socsdobflag_temp;
		
	self.PWsocsdobflag := IF(i=1,MAP(socsdobflag_temp = '3' or PWsocsvalflag_temp = '6' OR socsdobflag_temp='2' => '2',
							   socsdobflag_temp = '1' => '1',
							   socsdobflag_temp = '0' => '0',
							   '0'),
						le.pwsocsdobflag);
	self.socsdidCount := IF(i=1,counts.DidCount,le.socsdidcount);
	self.addrs_per_ssn := IF(i=1, counts.addr_ct, le.addrs_per_ssn); 
	self.adls_per_ssn_created_6months := IF(i=1, counts.DidCount_c6, le.adls_per_ssn_created_6months);
	self.addrs_per_ssn_created_6months := IF(i=1, counts.addr_ct_c6, le.addrs_per_ssn_created_6months);

	
	// added these for dl validation stuff
	self.dlMatch := IF(i=2,risk_indicators.iid_constants.g(risk_indicators.LnameScore(counts.lname1.lname,le.lname)) and if(ExactLastNameRequired, counts.lname1.lname=le.lname, true) AND counts.lname1.first_seen < history_date or 
					   risk_indicators.iid_constants.g(risk_indicators.LnameScore(counts.lname2.lname,le.lname)) and if(ExactLastNameRequired, counts.lname2.lname=le.lname, true) AND counts.lname2.first_seen < history_date or 
					   risk_indicators.iid_constants.g(risk_indicators.LnameScore(counts.lname3.lname,le.lname)) and if(ExactLastNameRequired, counts.lname3.lname=le.lname, true) AND counts.lname3.first_seen < history_date or 
					   risk_indicators.iid_constants.g(risk_indicators.LnameScore(counts.lname4.lname,le.lname)) and if(ExactLastNameRequired, counts.lname4.lname=le.lname, true) AND counts.lname4.first_seen < history_date,
			         le.dlMatch);
	vdl := risk_indicators.Validate_SSN(le.dl_number[1..9],le.dob);			    
	self.dlsocsvalflag := IF(i=2,MAP(le.dl_number[1..9]='' => '6',
							   (ri.ssn<>'' and (~ri.isValidFormat OR ~ri.isSequenceValid)) or vdl.begin_invalid or vdl.middle_invalid or vdl.last_invalid => '1',
							   le.dob<> '' and (UNSIGNED3)ri.official_last_seen - (UNSIGNED3)(le.dob[1..6]) > 1800 => '5',
							   (UNSIGNED3)ri.official_last_seen <> 0 and (INTEGER)(ut.GetDate[1..6]) - (UNSIGNED3)ri.official_last_seen < 700 => '4',
							   // not sure what to do for 3 or 2
							   '0'),
						le.dlsocsvalflag);
	dlsocsdob := vdl.ssnDobFlag(ri.official_last_seen);
	self.dlsocsdobflag := IF(i=2,MAP(dlsocsdob = '3' or self.dlsocsvalflag = '6' OR dlsocsdob='2' => '2',
							   dlsocsdob = '1' => '1',
							   dlsocsdob = '0' => '0',
							   '0'),
						le.dlsocsdobflag);

	self := le;
END;
ENDMACRO;

MAC_ssnTable_transform (get_ssnTable, tms.key_ssn_table_v3);
MAC_ssnTable_transform (get_ssnTable_FCRA, tms.key_ssn_table_FCRA_v3);

got_SSNTable :=
 if (isFCRA, join (inrec, tms.key_ssn_table_FCRA_v3,
                   left.ssn!='' and keyed(left.ssn=right.ssn) AND (if(headversion=1, RIGHT.combo.header_first_seen,
																																			if(headversion=2, RIGHT.eq.header_first_seen, RIGHT.en.header_first_seen)) < history_date),  // check date
                   get_ssnTable_FCRA(left,right,1),left outer, ATMOST(keyed(left.ssn=right.ssn),500)),
					   join (inrec, tms.key_ssn_table_v3,
							left.ssn!='' and keyed(left.ssn=right.ssn) AND (if(headversion=1, RIGHT.combo.header_first_seen,
																																			if(headversion=2, RIGHT.eq.header_first_seen, RIGHT.en.header_first_seen)) < history_date),
							get_ssnTable(left,right,1),left outer, ATMOST(keyed(left.ssn=right.ssn),500)));
got_SSNTableDL :=
 if (isFCRA, join (got_SSNTable, tms.key_ssn_table_FCRA_v3,
                   left.dl_number!='' and keyed(left.dl_number[1..9]=right.ssn) AND (if(headversion=1, RIGHT.combo.header_first_seen,
																															if(headversion=2, RIGHT.eq.header_first_seen, RIGHT.en.header_first_seen)) < history_date),
                   get_ssnTable_FCRA(left,right,2),left outer, ATMOST( keyed(left.dl_number[1..9]=right.ssn),500)),
             join (got_SSNTable, tms.key_ssn_table_v3,
                   left.dl_number!='' and keyed(left.dl_number[1..9]=right.ssn) AND (if(headversion=1, RIGHT.combo.header_first_seen,
																																			if(headversion=2, RIGHT.eq.header_first_seen, RIGHT.en.header_first_seen)) < history_date),
                   get_ssnTable(left,right,2),left outer, ATMOST(keyed(left.dl_number[1..9]=right.ssn),500)));	
			    
					
// do velocity stuff here, currently using current results for these fields
// gotSSNVelocity := getSSNVelocityHist(got_SSNTableDL, history_date);
// wSSNVelocity := if(history_date = iid_constants.default_history_date, got_SSNTableDL, gotSSNVelocity);			    
			    
			    									
risk_indicators.layout_output get_ssnMap (risk_indicators.layout_output le, doxie.Key_SSN_Map ri, INTEGER i) := transform

  // new ssn-issue data have '20990101' for the current date intervals
  r_end := (UNSIGNED3) (ri.end_date[1..6]);
  end_yyyymm := IF (r_end = 209901, 0, r_end); 

	self.socsvalflag := IF(i=1, IF(le.socsvalflag='0' and ri.ssn5='','1',le.socsvalflag),
					   le.socsvalflag);
						 
	self.PWsocsvalflag := IF(i=1,MAP(le.PWsocsvalflag='0' and ri.ssn5='' => '1',
							   le.PWsocsvalflag='0' and le.dob<> '' and end_yyyymm - (UNSIGNED3)(le.dob[1..6]) > 1800 => '5',
							   le.PWsocsvalflag='0' and end_yyyymm <> 0 and (INTEGER)(ut.GetDate[1..6]) - end_yyyymm < 700 => '4',
							   le.PWsocsvalflag),
						le.PWsocsvalflag);
						
	self.socllowissue  := IF(i=1, ri.start_date, le.socllowissue);
	self.soclhighissue := IF(i=1, IF ((unsigned)ri.end_date in [0, 20990101, 20991231], '', ri.end_date), le.soclhighissue);
	SELF.soclstate := IF(i=1,Address.Map_State_Name_To_Abbrev(Stringlib.StringToUpperCase(ri.state)),le.soclstate);
	
	socsdobflag_temp := IF(i=1,risk_indicators.validate_ssn(le.ssn,le.dob).ssnDobFlag (end_yyyymm),le.socsdobflag);
	self.socsdobflag := socsdobflag_temp;
	self.PWsocsdobflag := IF(i=1,MAP(socsdobflag_temp = '3' or self.PWsocsvalflag = '6' OR socsdobflag_temp='2' => '2',
							   socsdobflag_temp = '1' => '1',
							   socsdobflag_temp = '0' => '0',
							   '0'),
						le.pwsocsdobflag);
						
	// needed for dl validation stuff
	self.dlsocsvalflag := IF(i=2,IF(le.dlsocsvalflag='0' and ri.ssn5='','1',le.dlsocsvalflag),
						le.dlsocsvalflag);
	dlsocsdob := risk_indicators.validate_ssn(le.dl_number[1..9],le.dob).ssnDobFlag(end_yyyymm);
	self.dlsocsdobflag := IF(i=2,MAP(dlsocsdob='3' or self.dlsocsvalflag='6' or dlsocsdob='2' => '2',
							   dlsocsdob='1' => '1',
							   dlsocsdob='0' => '0',
							   '0'),
						le.dlsocsdobflag);
	
	SELF := le;
END;

got_SSNMap := join(got_SSNTableDL, doxie.Key_SSN_Map,
					(left.ssn!='') and 
          keyed (left.ssn[1..5]=right.ssn5) AND
          keyed (left.ssn[6..9] between Right.start_serial AND Right.end_serial) AND
					// check date
					((unsigned3)(RIGHT.start_date[1..6]) < history_date),
					get_ssnMap(left,right, 1),
          LEFT OUTER, keep (1));
					

got_SSNMapDL := join(got_SSNMap, doxie.Key_SSN_Map,
					(left.dl_number!='') and
          keyed(left.dl_number[1..5]=right.ssn5) AND
          //TODO: not clear if check for start/end_serial for DL
					// check date
					((unsigned3)(RIGHT.start_date[1..6]) < history_date),
					get_ssnMap(left,right, 2),
          LEFT OUTER, keep (1));
					

// pluck the deceased value from ssn_table already done and send that through to ssnCodes function			
codes_in := ungroup( project(got_SSNTable, transform(RiskWise.layouts.layout_ssn_in,
									self.deceased := left.decsflag='1',  
									self := left)) );
									
socl := risk_indicators.getSSNCodes(codes_in, history_date);
			
risk_indicators.layout_output add_ssncodes(got_SSNMap le, socl rt) := transform
	self.inputsocscharflag := map(le.ssn='' => '6', // ssn empty
						     rt.socscode in ['0','110'] and rt.dobcode='60' => '5', // valid, but issued after 18th birthday
							rt.socscode in ['0','110'] and (integer)ut.getdate[1..4] - (integer)rt.highissue[1..4] <= 7 => '4',  // valid, but issued in the last 7 years
							rt.socscode in ['14','15','104','105','106','109','180','181','200','201'] => '1', // invalid
							rt.socscode in ['100','103','107','108'] => '2', // invalid, not issued
							rt.socscode = '12' => '3', // invalid; pocket book type
							'0');  // valid
	self.inputsocscode := rt.socscode; // save the raw socs code for use elsewhere
	self := le;
end;
with_socs_codes := join(got_SSNMapDL, socl, left.seq=right.seq, add_ssncodes(left,right), left outer, lookup);						
					
ssn_flags := if(runSSNCodes, with_socs_codes, got_SSNMapDL);  // to optimize query latency, only turn on runSSNCodes when needed	

risk_indicators.layout_output doOver(risk_indicators.layout_output L) := transform
	dcNeeded := Suppress.dateCorrect.do(L.ssn).needed;
	self.socllowissue		:= Suppress.dateCorrect.sdate_s8(frm.ssn_unmasked, L.socllowissue);
	self.soclhighissue	:= Suppress.dateCorrect.edate_s8(frm.ssn_unmasked, L.soclhighissue);
	self.soclstate			:= Suppress.dateCorrect.st(frm.ssn_unmasked, L.soclstate);
	self.socsvalflag		:= if(dcNeeded, '0', L.socsvalflag);
	self.PWsocsvalflag	:= if(dcNeeded, '0', L.PWsocsvalflag);
	self.decsflag				:= if(dcNeeded, '0', L.decsflag);
	self.dlsocsvalflag	:= if(dcNeeded, '0', L.dlsocsvalflag);
	self.socsdobflag		:= if(dcNeeded, '0', L.socsdobflag);
	self.PWsocsdobflag	:= if(dcNeeded, '0', L.PWsocsdobflag);
	self.dlsocsdobflag	:= if(dcNeeded, '0', L.dlsocsdobflag);
	self := L;
end;
ssn_over := project(ssn_flags, doOver(left));

return ssn_over;

end;