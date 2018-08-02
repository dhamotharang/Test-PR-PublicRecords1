import _Control, risk_indicators, suppress, ut, doxie, address, riskwise, NID, FCRA, Death_Master, MDR, Relationship;
import STD;
onThor := _Control.Environment.OnThor;

export iid_getSSNFlags(grouped DATASET(risk_indicators.Layout_output) inrec, unsigned1 dppa, unsigned1 glb, 
							boolean isFCRA=false, boolean runSSNCodes=false,
							string10 ExactMatchLevel=iid_constants.default_ExactMatchLevel,
							string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
							UNSIGNED1 BSversion = 3, 
							unsigned8 BSOptions=0,
							string50 DataPermission=risk_indicators.iid_constants.default_DataPermission) := function

glb_ok := iid_constants.glb_ok(glb, isFCRA);

todays_date := (string) risk_indicators.iid_constants.todaydate;

ExactFirstNameRequired := ExactMatchLevel[iid_constants.posExactFirstNameMatch]=iid_constants.sTrue;
ExactLastNameRequired := ExactMatchLevel[iid_constants.posExactLastNameMatch]=iid_constants.sTrue;
ExactFirstNameRequiredAllowNickname := ExactMatchLevel[iid_constants.posExactFirstNameMatchNicknameAllowed]=iid_constants.sTrue;

layout_output_DE_src := RECORD
	risk_indicators.layout_output;
	string2	deathSource;
END;

layout_output_DE_src tfInrec(inrec le) := transform
	self.deathSource	:= '';
	self							:= le;
end;

inrec_DE_src := project(inrec, tfInrec(left)); 

MAC_ssnTable_transform (trans_name, key_ssntable, FCRA_macro) := MACRO
layout_output_DE_src trans_name (layout_output_DE_src le, key_ssntable ri, INTEGER i) := transform

	ssnCorrectionHit := i=3 and trim(ri.ssn)<>'';

	// determine which section of the table is permitted for use based on the data restriction mask
	header_version := map(DataRestriction[iid_constants.posEquifaxRestriction]=iid_constants.sFalse and
												DataRestriction[iid_constants.posTransUnionRestriction]=iid_constants.sFalse and
												((~isFCRA and DataRestriction[iid_constants.posExperianRestriction]=iid_constants.sFalse) or (isFCRA and DataRestriction[iid_constants.posExperianFCRARestriction]=iid_constants.sFalse)) => ri.combo,
												((~isFCRA and DataRestriction[iid_constants.posExperianRestriction]=iid_constants.sFalse) or (isFCRA and DataRestriction[iid_constants.posExperianFCRARestriction]=iid_constants.sFalse)) => ri.en,
												~isFCRA and DataRestriction[iid_constants.posTransUnionRestriction]=iid_constants.sFalse => ri.tn,
												ri.eq);  // default to the EQ version														

	pre_history := header_version.header_first_seen < le.historydate;

	self.ssnexists := IF(i = 1 or ssnCorrectionHit,header_version.header_first_seen<>0 and pre_history,le.ssnexists);
	
	vssn := Risk_Indicators.Validate_SSN(le.ssn,'');
	
	socsvalflag_temp := IF(i = 1 or ssnCorrectionHit,MAP(
																				trim(le.ssn)='' => '3',
																				 vssn.invalid => '2',
																				 (ri.ssn<>'' and pre_history and ~ri.isValidFormat) or 
																						vssn.begin_invalid or vssn.middle_invalid or vssn.last_invalid or 
																						vssn.invalid_666s or vssn.pocketbook_ssn => '1',
																				 '0'),
																		le.socsvalflag);
	
	self.socsvalflag := socsvalflag_temp;
	
	PWsocsvalflag_temp := IF(i = 1 or ssnCorrectionHit,MAP(
																					trim(le.ssn)='' => '6',
																				 (trim(ri.ssn)<>'' and pre_history and ~ri.isValidFormat) or 
																						vssn.begin_invalid or vssn.middle_invalid or vssn.last_invalid or 
																						vssn.invalid_666s or vssn.pocketbook_ssn => '1',
																				 le.dob<> '' and (UNSIGNED3)ri.official_last_seen - (UNSIGNED3)(le.dob[1..6]) > 1800 => '5',
																				 ((UNSIGNED3)ri.official_last_seen <> 0 and (INTEGER)(todays_date[1..6]) - (UNSIGNED3)ri.official_last_seen < 700 AND ri.official_first_seen <> 201106) OR 
																				 ((UNSIGNED)(todays_date[1..6]) < 201806 AND ri.official_first_seen = 201106) => '4',
																				 // not sure what to do for 3 or 2
																				 '0'),
																		le.pwsocsvalflag);
						
	self.PWsocsvalflag := PWsocsvalflag_temp;
	
	#IF(onThor)
		socsRCISflag_temp := le.socsRCISflag;
	#ELSE
		socsRCISflag_temp := IF(Risk_Indicators.searchLegacySSN(le.ssn, le.did, isFCRA), '1', '0');
	#END
  
	SELF.socsRCISflag := socsRCISflag_temp;
	
	SELF.soclstate := IF(i = 1 or ssnCorrectionHit,ri.issue_state,le.soclstate);

	// Only EQ records go into last names.  So just remove these if you don't have GLB
	chooser1 := MAP(~glb_ok	or ~pre_history=> 0,
				 header_version.lname1.lname=le.lname AND header_version.lname2.first_seen < le.historydate => 2,
				 header_version.lname1.lname<>le.lname AND header_version.lname1.first_seen < le.historydate => 1,
				 0);
	
	self.altfirst := IF(i=1,CASE(chooser1,
									1		=> 	(STRING20)header_version.lname1.fname,
									2		=> 	(STRING20)header_version.lname2.fname,
									''),
					le.altfirst);
	altlast_temp := IF(i=1,CASE(chooser1,
									1		=> 	(STRING20)header_version.lname1.lname,
									2		=> 	(STRING20)header_version.lname2.lname,
									''),
				    le.altlast);
	self.altlast := altlast_temp;
	self.altlast_date := IF(i=1,CASE(chooser1,
									1		=> 	IF(header_version.lname1.last_seen=0,'',(STRING8)header_version.lname1.last_seen),
									2		=> 	IF(header_version.lname2.last_seen=0,'',(STRING8)header_version.lname2.last_seen),
									''),
					    le.altlast_date);
	self.altearly_date := IF(i=1,CASE(chooser1,
									1		=> 	IF(header_version.lname1.first_seen=0,'',(STRING8)header_version.lname1.first_seen),
									2		=> 	IF(header_version.lname2.first_seen=0,'',(STRING8)header_version.lname2.first_seen),
									''),
						le.altearly_date);
	
	chooser2 := MAP(~glb_ok	or ~pre_history=> 0,
				 chooser1=1 AND header_version.lname2.lname<>le.lname AND header_version.lname2.first_seen < le.historydate => 2,
				 chooser1=2 AND header_version.lname3.first_seen < le.historydate => 3,
				 0);
	
	self.altfirst2 := IF(i=1,CASE(chooser2,
									2		=> 	(STRING20)header_version.lname2.fname,
									3		=> 	(STRING20)header_version.lname3.fname,
									''),
					 le.altfirst2);
	altlast2_temp := IF(i=1,CASE(chooser2,
									2		=> 	(STRING20)header_version.lname2.lname,
									3		=> 	(STRING20)header_version.lname3.lname,
									''),
					le.altlast2);				 
	self.altlast2 := altlast2_temp;
	self.altlast_date2 := IF(i=1,CASE(chooser2,
									2		=> 	IF(header_version.lname2.last_seen=0,'',(STRING8)header_version.lname2.last_seen),
									3		=> 	IF(header_version.lname3.last_seen=0,'',(STRING8)header_version.lname3.last_seen),
									''),
						le.altlast_date2);
	self.altearly_date2 := IF(i=1,CASE(chooser2,
									2		=> 	IF(header_version.lname2.first_seen=0,'',(STRING8)header_version.lname2.first_seen),
									3		=> 	IF(header_version.lname3.first_seen=0,'',(STRING8)header_version.lname3.first_seen),
									''),
						 le.altearly_date2);
	
	chooser3 := MAP(~glb_ok	or ~pre_history=> 0,
				 chooser2=2 AND header_version.lname3.lname<>le.lname AND header_version.lname3.first_seen < le.historydate => 3,
				 chooser2=3 AND header_version.lname4.first_seen < le.historydate => 4,
				 0);
	
	self.altfirst3 := IF(i=1,CASE(chooser3,
												3		=> 	(STRING20)header_version.lname3.fname,
												4		=> 	(STRING20)header_version.lname4.fname,
												''),
					 le.altfirst3);
	altlast3_temp := IF(i=1,CASE(chooser3,
												3		=> 	(STRING20)header_version.lname3.lname,
												4		=> 	(STRING20)header_version.lname4.lname,
												''),
					le.altlast3);				 
	self.altlast3 := altlast3_temp;
	self.altlast_date3 := IF(i=1,CASE(chooser3,
												3		=> 	IF(header_version.lname3.last_seen=0,'',(STRING8)header_version.lname3.last_seen),
												4		=> 	IF(header_version.lname4.last_seen=0,'',(STRING8)header_version.lname4.last_seen),
												''),
						le.altlast_date3);
	self.altearly_date3 := IF(i=1,CASE(chooser3,
												3		=> 	IF(header_version.lname3.first_seen=0,'',(STRING8)header_version.lname3.first_seen),
												4		=> 	IF(header_version.lname4.first_seen=0,'',(STRING8)header_version.lname4.first_seen),
												''),
						 le.altearly_date3);
									
	SELF.altlast_count := IF(i=1,(INTEGER)(altlast_temp<>'') + (INTEGER)(altlast2_temp<>'') + (INTEGER)(altlast3_temp<>''),
						le.altlast_count);

	self.lastssnmatch := IF(i=1,pre_history and (header_version.lname1.lname=le.lname AND header_version.lname1.first_seen < le.historydate or 
						   header_version.lname2.lname=le.lname AND header_version.lname2.first_seen < le.historydate or 
						   header_version.lname3.lname=le.lname AND header_version.lname3.first_seen < le.historydate or 
						   header_version.lname4.lname=le.lname AND header_version.lname4.first_seen < le.historydate),
					    le.lastssnmatch);
	
	self.lastssnmatch2 := IF(i=1,pre_history and (iid_constants.g(risk_indicators.LnameScore(header_version.lname1.lname, le.lname)) and if(ExactLastNameRequired, header_version.lname1.lname=le.lname, true) AND header_version.lname1.first_seen < le.historydate or
						    iid_constants.g(risk_indicators.LnameScore(header_version.lname2.lname, le.lname)) and if(ExactLastNameRequired, header_version.lname2.lname=le.lname, true) AND header_version.lname2.first_seen < le.historydate or
						    iid_constants.g(risk_indicators.LnameScore(header_version.lname3.lname, le.lname)) and if(ExactLastNameRequired, header_version.lname3.lname=le.lname, true) AND header_version.lname3.first_seen < le.historydate or
						    iid_constants.g(risk_indicators.LnameScore(header_version.lname4.lname, le.lname)) and if(ExactLastNameRequired, header_version.lname4.lname=le.lname, true) AND header_version.lname4.first_seen < le.historydate),
						le.lastssnmatch2);
						
	nleft := NID.PreferredFirstNew(le.fname);
	n1 := NID.PreferredFirstNew(header_version.lname1.fname);
	n2 := NID.PreferredFirstNew(header_version.lname2.fname);
	n3 := NID.PreferredFirstNew(header_version.lname3.fname);
	n4 := NID.PreferredFirstNew(header_version.lname4.fname);						
	self.firstssnmatch := IF(i=1, pre_history and (
								(iid_constants.g(risk_indicators.FnameScore(header_version.lname1.fname, le.fname)) and 
									if(ExactFirstNameRequired, header_version.lname1.fname=le.fname, true) AND 
									if(ExactFirstNameRequiredAllowNickname, header_version.lname1.fname=le.fname or nleft=n1, true) and 
									header_version.lname1.first_seen < le.historydate) 
								or								
						    (iid_constants.g(risk_indicators.FnameScore(header_version.lname2.fname, le.fname)) and 
									if(ExactFirstNameRequired, header_version.lname2.fname=le.fname, true) AND 
									if(ExactFirstNameRequiredAllowNickname, header_version.lname2.fname=le.fname or nleft=n2, true) and
									header_version.lname2.first_seen < le.historydate)
								or
						    (iid_constants.g(risk_indicators.FnameScore(header_version.lname3.fname, le.fname)) and 
									if(ExactFirstNameRequired, header_version.lname3.fname=le.fname, true) AND
									if(ExactFirstNameRequiredAllowNickname, header_version.lname3.fname=le.fname or nleft=n3, true) and
									header_version.lname3.first_seen < le.historydate) 
								or
						    (iid_constants.g(risk_indicators.FnameScore(header_version.lname4.fname, le.fname)) and 
									if(ExactFirstNameRequired, header_version.lname4.fname=le.fname, true) AND 
									if(ExactFirstNameRequiredAllowNickname, header_version.lname4.fname=le.fname or nleft=n4, true) and
									header_version.lname4.first_seen < le.historydate)),
						le.firstssnmatch);
	
	// Death and Bankrupt are both nonglb
	full_history_date := risk_indicators.iid_constants.full_history_date(le.historydate);
	bansflag_temp := IF(i=1,MAP(ri.isBankrupt AND ((string)ri.dt_first_bankrupt < full_history_date) => '1',
						   // a 2 would be for a full name and address match
						   trim(le.ssn)='' OR trim(le.lname)='' OR trim(le.prim_name)='' => '3',	// does not appear that st. cloud will return a 3 anymore
						   '0'),
					le.bansFlag);
	
	self.bansFlag := bansflag_temp;
	self.bansdatefiled := IF(i=1 and bansflag_temp='1', (string)ri.dt_first_bankrupt, le.bansdatefiled);


	#if(FCRA_macro)
		//In this transform, only populate deceased information if we hit on the corrections file.  As of March, 2014 deceased information
		//will be picked up in the join to the new Death Master search further down.

		decsflag_temp := MAP( (ssnCorrectionHit and ri.isDeceased) AND ((string)ri.dt_first_deceased < full_history_date)  => '1',  //only a corrections hit will flag as deceased
												(i = 1 or ssnCorrectionHit) and socsvalflag_temp IN ['2','3']							=> '2',
																																																		 '0');


		self.decsflag := if(i = 1 or ssnCorrectionHit,decsflag_temp, le.decsflag);
		self.deceasedDate := if((ssnCorrectionHit) and decsflag_temp='1',ri.dt_first_deceased, le.deceasedDate);  // check only on ssn search, and make sure date is before history date				
		self.deceasedDOB := if((ssnCorrectionHit) and decsflag_temp='1',ri.decs_dob, le.deceaseddob);
		self.deceasedfirst := if((ssnCorrectionHit) and decsflag_temp='1',ri.decs_first, le.deceasedfirst);
		self.deceasedlast := if((ssnCorrectionHit) and decsflag_temp='1',ri.decs_last, le.deceasedlast);
	#else
		//for non-FCRA, can only set decsflag to invalid ('2') in this transform since we no longer can set deceased info in this join
	
		decsflag_temp := if(i = 1 AND socsvalflag_temp IN ['2','3'], '2', '0');
	
		self.decsflag := if(i = 1,decsflag_temp, le.decsflag);
		self.deceasedDate := le.deceasedDate;  // check only on ssn search, and make sure date is before history date				
		self.deceasedDOB := le.deceaseddob;
		self.deceasedfirst := le.deceasedfirst;
		self.deceasedlast := le.deceasedlast;
		// these fields are only on the non-fcra key, they were added for fraudpoint
		self.lnames_per_ssn := iid_constants.capVelocity(IF(i=1, header_version.lname_ct, le.lnames_per_ssn));
		self.lnames_per_ssn_created_6months := iid_constants.capVelocity(IF(i=1, header_version.lname_ct_c6, le.lnames_per_ssn_created_6months));
		self.addrs_per_ssn_multiple_use := iid_constants.capVelocity(IF(i=1, header_version.addr_ct_multiple_use, le.addrs_per_ssn_multiple_use));
		self.adls_per_ssn_multiple_use := iid_constants.capVelocity(IF(i=1, header_version.didcount_multiple_use, le.adls_per_ssn_multiple_use));
		self.adls_per_ssn_multiple_use_non_relative := 0; // needs to be calculated at runtime to know what the input DID is to check relatives
	#end
	
	/* The following accounts for randomized socials:
				ssnLowIssue - If possibly randomized, set low issue to the first date of randomization - June 25th, 2011
				ssnHighIssue - If possibly randomized, set to the current date (Or archive date if running in archive mode)
	*/
	firstSeen := IF(TRIM((STRING)ri.official_first_seen) = '201106', '20110625', TRIM((STRING)ri.official_first_seen));
	randomizedSocial := Risk_Indicators.rcSet.isCodeRS(le.ssn, socsvalflag_temp, firstSeen, socsRCISflag_temp);
	ssnLowIssue := IF(randomizedSocial and le.historydate > 201106, '20110625', firstSeen);
	ssnHighIssue := IF(randomizedSocial and le.historydate > 201106, IF(le.historydate = 999999, todays_date, le.historydate + '01'), TRIM((STRING)ri.official_last_seen));
	socllowissue_temp := IF(i = 1 or ssnCorrectionHit, ssnLowIssue, le.socllowissue);	// do we have to check to see if ssn has been corrected and if so, do we just use that result?
	self.socllowissue := socllowissue_temp;
	self.soclhighissue := IF(i = 1 or ssnCorrectionHit, ssnHighIssue, le.soclhighissue);

	socsdobflag_temp :=	IF(i = 1 or ssnCorrectionHit,vssn.ssnDobFlag(ri.official_last_seen),le.socsdobflag);
	self.socsdobflag := socsdobflag_temp;
		
	self.PWsocsdobflag := IF(i = 1 or ssnCorrectionHit,
														MAP(socsdobflag_temp = '3' or PWsocsvalflag_temp = '6' OR socsdobflag_temp='2' 											=> '2',
																Risk_Indicators.rcSet.isCodeRS(le.ssn, socsvalflag_temp, socllowissue_temp, socsRCISflag_temp)	=> '2', // For randomized socials we want it to default to 2
																socsdobflag_temp = '1' 																																					=> '1',
																socsdobflag_temp = '0' 																																					=> '0',
																																																																	 '0'),
														le.pwsocsdobflag);
	self.socsdidCount := IF(i=1,header_version.DidCount,le.socsdidcount);
	self.adls_per_ssn_seen_18months := iid_constants.capVelocity(IF(i=1,header_version.RecentCount,le.adls_per_ssn_seen_18months));
	self.addrs_per_ssn := iid_constants.capVelocity(IF(i=1, header_version.addr_ct, le.addrs_per_ssn)); 
	self.adls_per_ssn_created_6months := iid_constants.capVelocity(IF(i=1, header_version.DidCount_c6, le.adls_per_ssn_created_6months));
	self.addrs_per_ssn_created_6months := iid_constants.capVelocity(IF(i=1, header_version.addr_ct_c6, le.addrs_per_ssn_created_6months));


	// added these for dl validation stuff
	self.dlMatch := IF(i=2,iid_constants.g(risk_indicators.LnameScore(header_version.lname1.lname,le.lname)) and if(ExactLastNameRequired, header_version.lname1.lname=le.lname, true) AND header_version.lname1.first_seen < le.historydate or 
						 iid_constants.g(risk_indicators.LnameScore(header_version.lname2.lname,le.lname)) and if(ExactLastNameRequired, header_version.lname2.lname=le.lname, true) AND header_version.lname2.first_seen < le.historydate or 
						 iid_constants.g(risk_indicators.LnameScore(header_version.lname3.lname,le.lname)) and if(ExactLastNameRequired, header_version.lname3.lname=le.lname, true) AND header_version.lname3.first_seen < le.historydate or 
						 iid_constants.g(risk_indicators.LnameScore(header_version.lname4.lname,le.lname)) and if(ExactLastNameRequired, header_version.lname4.lname=le.lname, true) AND header_version.lname4.first_seen < le.historydate,
							 le.dlMatch);
	vdl := risk_indicators.Validate_SSN(le.dl_number[1..9],le.dob);			    
	dlsocsvalflag_temp := IF(i=2,MAP(le.dl_number[1..9]='' => '6',
								 (ri.ssn<>'' and (~ri.isValidFormat OR ~ri.isSequenceValid)) or vdl.begin_invalid or vdl.middle_invalid or vdl.last_invalid => '1',
								 le.dob<> '' and (UNSIGNED3)ri.official_last_seen - (UNSIGNED3)(le.dob[1..6]) > 1800 => '5',
								 (UNSIGNED3)ri.official_last_seen <> 0 and (INTEGER)(todays_date[1..6]) - (UNSIGNED3)ri.official_last_seen < 700 => '4',
								 // not sure what to do for 3 or 2
								 '0'),
						le.dlsocsvalflag);
	self.dlsocsvalflag := dlsocsvalflag_temp;
	dlsocsdob := vdl.ssnDobFlag(ri.official_last_seen);
	self.dlsocsdobflag := IF(i=2,MAP(dlsocsdob = '3' or dlsocsvalflag_temp = '6' OR dlsocsdob='2' => '2',
								 dlsocsdob = '1' => '1',
								 dlsocsdob = '0' => '0',
								 '0'),
						le.dlsocsdobflag);
	
	self := le;
END;
ENDMACRO;

// FCRA	
MAC_ssnTable_transform (get_ssnTable_FCRA, risk_indicators.key_ssn_table_v4_filtered_fcra, true);
MAC_ssnTable_transform (get_ssnTable_corr, fcra.Key_Override_SSN_Table_FFID, true);

got_SSNTable_fcra_roxie := join (inrec_DE_src, risk_indicators.key_ssn_table_v4_filtered_fcra,
                   left.ssn!='' and keyed(left.ssn=right.ssn) and
									 trim((string12)right.ssn) not in left.ssn_correct_record_id, 
                   get_ssnTable_FCRA(left,right,1),left outer, ATMOST(keyed(left.ssn=right.ssn),500));

key_legacy_ssn := if(isFCRA, doxie.Key_FCRA_legacy_ssn, doxie.Key_legacy_ssn);

legacy_ssn_thor := join (distribute(inrec_DE_src(ssn<>'' and did<>0), hash64(ssn,did)), 
									 distribute(pull(key_legacy_ssn), hash64(ssn, did)),
                   (left.ssn=right.ssn) and (left.did=right.did),
                   // trim((string12)right.ssn) not in left.ssn_correct_record_id,
                   TRANSFORM(RECORDOF(left),
                   SELF.socsRCISflag := if(right.ssn<>'' and right.did<>0,'1','0'),
                   SELF := left)
                   ,left outer, ATMOST(riskwise.max_atmost), KEEP(1), LOCAL) +
                   PROJECT(inrec_DE_src(ssn='' or did=0), TRANSFORM(RECORDOF(LEFT),
                   SELF.socsRCISflag := '0', SELF := LEFT));
                   
got_SSNTable_fcra_thor_pre := join (distribute(legacy_ssn_thor(ssn<>''), hash64(ssn)), 
									 distribute(pull(risk_indicators.key_ssn_table_v4_filtered_fcra), hash64(ssn)),
                   (left.ssn=right.ssn) and
									 trim((string12)right.ssn) not in left.ssn_correct_record_id, 
                   get_ssnTable_FCRA(left,right,1),left outer, ATMOST(left.ssn=right.ssn,500), LOCAL);
									 
got_SSNTable_fcra_thor := got_SSNTable_fcra_thor_pre + 
										// Put in correct default values without doing a join if no SSN is input
										project(inrec_DE_src(ssn=''), transform(layout_output_DE_src,
										self.decsflag := '2',
										self.socsdobflag := '3',
										self.pwsocsdobflag := '2',
										self.socsvalflag := '3',
										self.pwsocsvalflag := '6',
										self.socsrcisflag := '0',
										self.bansflag := '3',
										self := left));
									 
got_SSNTableDL_fcra_roxie := join (got_SSNTable_fcra_roxie, risk_indicators.key_ssn_table_v4_filtered_fcra,
                   left.dl_number!='' and keyed(left.dl_number[1..9]=right.ssn) and
									 trim((string12)right.ssn) not in left.ssn_correct_record_id,
                   get_ssnTable_FCRA(left,right,2),left outer, ATMOST( keyed(left.dl_number[1..9]=right.ssn),500));


legacy_ssn_thor_dl := join (distribute(got_SSNTable_fcra_thor(ssn<>'' and did<>0/* and dl_number <> ''*/), hash64(ssn,did)), 
									 distribute(pull(key_legacy_ssn), hash64(ssn, did)),
                   (left.ssn=right.ssn) and (left.did=right.did),
                   // trim((string12)right.ssn) not in left.ssn_correct_record_id,
                   TRANSFORM(RECORDOF(left),
                   SELF.socsRCISflag := if(right.ssn<>'' and right.did<>0,'1','0'),
                   SELF := left)
                   ,left outer, ATMOST(riskwise.max_atmost), KEEP(1), LOCAL) +
                   PROJECT(got_SSNTable_fcra_thor(ssn='' or did=0), TRANSFORM(RECORDOF(LEFT),
                   SELF.socsRCISflag := '0', SELF := LEFT));
                   
got_SSNTableDL_fcra_thor_pre := join (distribute(legacy_ssn_thor_dl(dl_number <> ''), hash64(dl_number[1..9])), 
									 distribute(pull(risk_indicators.key_ssn_table_v4_filtered_fcra), hash64(ssn)),
                   (left.dl_number[1..9]=right.ssn) and
									 trim((string12)right.ssn) not in left.ssn_correct_record_id,
                   get_ssnTable_FCRA(left,right,2),left outer, ATMOST(left.dl_number[1..9]=right.ssn,500), local);

got_SSNTableDL_fcra_thor := group(sort(distribute(got_SSNTableDL_fcra_thor_pre + 
								project(got_SSNTable_fcra_thor(dl_number=''), transform(recordof(left),
																				self.dlsocsvalflag := '6',
																				self.dlsocsdobflag := '2',
																				self := left)), hash64(seq)), seq, LOCAL), seq, LOCAL);

#IF(onThor)
	got_SSNTableDL_fcra := got_SSNTableDL_fcra_thor;
#ELSE
	got_SSNTableDL_fcra := got_SSNTableDL_fcra_roxie;
#END
	
deathSSNKey := Death_Master.key_ssn_ssa(isFCRA);

layout_output_DE_src getDeathSSN (layout_output_DE_src le, deathSSNKey ri) := transform

	ssnDeathHit := trim(ri.ssn)<>'';
	full_history_date := risk_indicators.iid_constants.full_history_date(le.historydate);
	pre_history := (string)ri.dod8 < full_history_date;
	vssn := Risk_Indicators.Validate_SSN(le.ssn,'');
	socsvalflag_temp := MAP(trim(le.ssn)='' 														=> '3',
													vssn.invalid 																=> '2',
													(ri.ssn<>'' and pre_history) or 
													 vssn.begin_invalid or vssn.middle_invalid or vssn.last_invalid or 
													 vssn.invalid_666s or vssn.pocketbook_ssn 	=> '1',
																																				 '0');

	decsflag_temp := MAP((pre_history) 										=> '1',
												socsvalflag_temp IN ['2','3']		=> '2',
																													 '0');

	self.decsflag := if(ssnDeathHit,decsflag_temp, le.decsflag);
	self.deceasedDate := if((ssnDeathHit) and decsflag_temp='1',(integer)ri.dod8, le.deceasedDate);  // check only on ssn search, and make sure date is before history date				
	self.deceasedDOB := if((ssnDeathHit) and decsflag_temp='1',(integer)ri.dob8, le.deceaseddob);
	self.deceasedfirst := if((ssnDeathHit) and decsflag_temp='1',ri.fname, le.deceasedfirst);
	self.deceasedlast := if((ssnDeathHit) and decsflag_temp='1',ri.lname, le.deceasedlast);
	self.deathsource := if((ssnDeathHit) and decsflag_temp='1',ri.src, le.deathsource);
	self := le;
	self := [];
END;

got_death_fcra_roxie := join (got_SSNTableDL_fcra, deathSSNKey,
                   left.ssn!='' and keyed(left.ssn=right.ssn) and
									 (((integer)right.DOD8 <> 0 and (string)right.DOD8[1..6] <= (string)left.historydate) or
									  ((integer)right.filedate <> 0 and (string)right.filedate[1..6] <= (string)left.historydate)) and
									 trim((string12)right.ssn) not in left.ssn_correct_record_id and
									 right.src not in risk_indicators.iid_constants.masked_header_sources(DataRestriction, isFCRA) and
									 (right.src <> MDR.sourceTools.src_Death_Restricted or Risk_Indicators.iid_constants.deathSSA_ok(DataPermission)), 
                   getDeathSSN(left,right),left outer, KEEP(10), ATMOST(keyed(left.ssn=right.ssn),500));
 
got_death_fcra_thor_pre := join (distribute(got_SSNTableDL_fcra(ssn <> ''), hash64(ssn)), 
									 distribute(pull(deathSSNKey), hash64(ssn)),
                   (left.ssn=right.ssn) and
									 (((integer)right.DOD8 <> 0 and (string)right.DOD8[1..6] <= (string)left.historydate) or
									  ((integer)right.filedate <> 0 and (string)right.filedate[1..6] <= (string)left.historydate)) and
									 trim((string12)right.ssn) not in left.ssn_correct_record_id and
									 right.src not in risk_indicators.iid_constants.masked_header_sources(DataRestriction, isFCRA) and
									 (right.src <> MDR.sourceTools.src_Death_Restricted or Risk_Indicators.iid_constants.deathSSA_ok(DataPermission)), 
                   getDeathSSN(left,right),left outer, KEEP(10), ATMOST(left.ssn=right.ssn,500), LOCAL);

got_death_fcra_thor := got_death_fcra_thor_pre + got_SSNTableDL_fcra(ssn='');
									 
got_SSNTable_corr_roxie := join(got_death_fcra_roxie, FCRA.Key_Override_SSN_Table_FFID,
																			keyed(right.flag_file_id in left.ssn_correct_ffid),
																			get_ssnTable_corr(left,right,3), left outer, atmost(right.flag_file_id in left.ssn_correct_ffid, 100));

got_SSNTable_corr_thor_pre := join(got_death_fcra_thor(count(ssn_correct_ffid)>0), pull(FCRA.Key_Override_SSN_Table_FFID),
																			(right.flag_file_id in left.ssn_correct_ffid),
																			get_ssnTable_corr(left,right,3), left outer, all);

got_SSNTable_corr_thor := group(sort(distribute(got_SSNTable_corr_thor_pre + got_death_fcra_thor(count(ssn_correct_ffid)=0), hash64(seq)), seq, LOCAL), seq, LOCAL);
																			
#IF(onThor)
	got_SSNTable_corr := got_SSNTable_corr_thor;
#ELSE
	got_SSNTable_corr := got_SSNTable_corr_roxie;
#END

got_SSNTable_corr_dedup := dedup(sort(got_SSNTable_corr, seq, ssn, deathSource, -deceasedfirst, -deceasedDate, -deceasedDOB), seq, ssn);

risk_indicators.layout_output tfSSNTable_corr_proj(got_SSNTable_corr_dedup le) := transform
	self	:= le;
end;

got_SSNTable_corr_proj := project(got_SSNTable_corr_dedup, tfSSNTable_corr_proj(left)); 

// NON FCRA branch				 
MAC_ssnTable_transform (get_ssnTable, risk_indicators.key_ssn_table_v4_2, false);

got_SSNTable_nonfcra_roxie := join (inrec_DE_src,risk_indicators.key_ssn_table_v4_2,
									left.ssn!='' and keyed(left.ssn=right.ssn),
									get_ssnTable(left,right,1),left outer, ATMOST(keyed(left.ssn=right.ssn),500));							 
			    		    
got_SSNTable_nonfcra_thor := join (distribute(inrec_DE_src, hash64(ssn)),
									distribute(pull(risk_indicators.key_ssn_table_v4_2), hash64(ssn)),
									left.ssn!='' and (left.ssn=right.ssn),
									get_ssnTable(left,right,1),left outer, ATMOST(left.ssn=right.ssn,500), LOCAL);		
								
								
got_SSNTableDL_nonfcra_roxie := join (got_SSNTable_nonfcra_roxie, risk_indicators.key_ssn_table_v4_2,
                   left.dl_number!='' and keyed(left.dl_number[1..9]=right.ssn),
                   get_ssnTable(left,right,2),left outer, ATMOST(keyed(left.dl_number[1..9]=right.ssn),500));
									 
got_SSNTableDL_nonfcra_thor_pre := join (distribute(got_SSNTable_nonfcra_thor(dl_number <> ''), hash64(dl_number[1..9])), 
									 distribute(pull(risk_indicators.key_ssn_table_v4_2), hash64(ssn)),
                   (left.dl_number[1..9]=right.ssn),
                   get_ssnTable(left,right,2),left outer, ATMOST(left.dl_number[1..9]=right.ssn,500), LOCAL);									 

got_SSNTableDL_nonfcra_thor := got_SSNTableDL_nonfcra_thor_pre + 
															 project(got_SSNTable_nonfcra_thor(dl_number=''), transform(recordof(left),
																				self.dlsocsvalflag := '6',
																				self.dlsocsdobflag := '2',
																				self := left));

got_death_nonfcra_roxie := join (got_SSNTableDL_nonfcra_roxie, deathSSNKey,
                   left.ssn!='' and keyed(left.ssn=right.ssn) and
									 (((integer)right.DOD8 <> 0 and (string)right.DOD8[1..6] <= (string)left.historydate) or
									  ((integer)right.filedate <> 0 and (string)right.filedate[1..6] <= (string)left.historydate)) and									 
									 trim((string12)right.ssn) not in left.ssn_correct_record_id and
									 right.src not in risk_indicators.iid_constants.masked_header_sources(DataRestriction, isFCRA) AND
									 (right.src <> MDR.sourceTools.src_Death_Restricted or Risk_Indicators.iid_constants.deathSSA_ok(DataPermission)), 
                   getDeathSSN(left,right),left outer, KEEP(10), ATMOST(keyed(left.ssn=right.ssn),500));
									 
got_death_nonfcra_thor := join (distribute(got_SSNTableDL_nonfcra_thor, hash64(ssn)), 
									 distribute(pull(deathSSNKey), hash64(ssn)),
                   left.ssn!='' and (left.ssn=right.ssn) and
									 (((integer)right.DOD8 <> 0 and (string)right.DOD8[1..6] <= (string)left.historydate) or
									  ((integer)right.filedate <> 0 and (string)right.filedate[1..6] <= (string)left.historydate)) and									 
									 trim((string12)right.ssn) not in left.ssn_correct_record_id and
									 right.src not in risk_indicators.iid_constants.masked_header_sources(DataRestriction, isFCRA) AND
									 (right.src <> MDR.sourceTools.src_Death_Restricted or Risk_Indicators.iid_constants.deathSSA_ok(DataPermission)), 
                   getDeathSSN(left,right),left outer, KEEP(10), ATMOST(left.ssn=right.ssn,500), LOCAL);
									 
#IF(onThor)
	got_death_nonfcra := group(sort(got_death_nonfcra_thor, seq),seq);
#ELSE
	got_death_nonfcra := got_death_nonfcra_roxie;
#END

got_death_nonfcra_dedup := dedup(sort(got_death_nonfcra, seq, ssn, deathSource, -deceasedfirst, -deceasedDate, -deceasedDOB), seq, ssn);

risk_indicators.layout_output tfdeath_nonfcra_proj(got_death_nonfcra_dedup le) := transform
	self	:= le;
end;

got_death_nonfcra_proj := project(got_death_nonfcra_dedup, tfdeath_nonfcra_proj(left)); 

ssn_table_results1 := if(isFCRA, got_SSNTable_corr_proj, got_death_nonfcra_proj	);

// this section of code used for fraudpoint nonfcra to identify if the ssns on file belong to any of your relatives
		temprec := record
			unsigned6 wildcard_did;
			boolean isRelative;
			ssn_table_results1;
		end;
		temprec getMultipleUseSSNs(ssn_table_results1 le, doxie.Key_Header_Wild_SSN ri) := transform
			self.wildcard_did := ri.did;
			self.isRelative := false;
			self := le;
		end;
		
		multiple_use_ssns_with_wildcard_did_roxie := join(ssn_table_results1(adls_per_ssn_multiple_use>0), doxie.Key_Header_Wild_SSN,
			left.ssn<>'' and
			keyed(right.s1=left.ssn[1]) and
			keyed(right.s2=left.ssn[2]) and
			keyed(right.s3=left.ssn[3]) and
			keyed(right.s4=left.ssn[4]) and
			keyed(right.s5=left.ssn[5]) and
			keyed(right.s6=left.ssn[6]) and
			keyed(right.s7=left.ssn[7]) and
			keyed(right.s8=left.ssn[8]) and
			keyed(right.s9=left.ssn[9]) and
			left.did<>right.did,
			getMultipleUseSSNs(LEFT,RIGHT),
						left outer,
						atmost(riskwise.max_atmost), keep(100));
						
			multiple_use_ssns_with_wildcard_did_thor := join(distribute(ssn_table_results1(adls_per_ssn_multiple_use>0), hash64(ssn)), 
			distribute(pull(doxie.Key_Header_Wild_SSN), hash64(s1+s2+s3+s4+s5+s6+s7+s8+s9)),
			left.ssn<>'' and
			(right.s1=left.ssn[1]) and
			(right.s2=left.ssn[2]) and
			(right.s3=left.ssn[3]) and
			(right.s4=left.ssn[4]) and
			(right.s5=left.ssn[5]) and
			(right.s6=left.ssn[6]) and
			(right.s7=left.ssn[7]) and
			(right.s8=left.ssn[8]) and
			(right.s9=left.ssn[9]) and
			left.did<>right.did,
			getMultipleUseSSNs(LEFT,RIGHT),
						left outer,
						atmost(riskwise.max_atmost), keep(100), LOCAL);
						
    #IF(onThor)
      multiple_use_ssns_with_wildcard_did := group(sort(multiple_use_ssns_with_wildcard_did_thor, seq), seq);
    #ELSE
      multiple_use_ssns_with_wildcard_did := multiple_use_ssns_with_wildcard_did_roxie;
    #END
  
		iids_dedp := dedup(sort(ungroup(multiple_use_ssns_with_wildcard_did)(did<>0),did), did);
		justDids := PROJECT(iids_dedp, 
			TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout, SELF.DID := LEFT.DID));
		rellyids := Relationship.proc_GetRelationship(justDids, topnCount:=500,
			RelativeFlag :=TRUE,AssociateFlag:=TRUE,doAtmost:=TRUE,MaxCount:=RiskWise.max_atmost).result;

		multiple_use_ssn_with_relative_flag := join(multiple_use_ssns_with_wildcard_did, rellyids, 
			left.did<>0 and
			left.did=right.did1,
				transform(temprec, 
					self.isRelative := left.wildcard_did<>0 and right.did2=left.wildcard_did, 
					self := left), 
						left outer);

		with_relative_flag := dedup(sort(multiple_use_ssn_with_relative_flag, seq, ssn, wildcard_did, -isRelative), seq, ssn, wildcard_did);

		non_relative_stats := table(with_relative_flag, {seq, ssn,  
																	non_relative_adls_per_ssn := count(group, not isRelative),
																	}, seq, ssn);
																	
		ssn_table_results2 := join(ssn_table_results1, non_relative_stats, left.seq=right.seq,
		// ssn_table_results2 := join(ssn_table_results1, non_relative_stats, left.seq=right.seq,
			transform(risk_indicators.Layout_Output, 
				// cap the count of non_relative_adls_per_ssn to the number of adls_per_ssn_multiple_use that came from the ssn_table
				self.adls_per_ssn_multiple_use_non_relative := min(left.adls_per_ssn_multiple_use, right.non_relative_adls_per_ssn);
				self := left), left outer);
//
isFraudpoint :=  not isFCRA and (BSOptions & iid_constants.BSOptions.IncludeFraudVelocity) > 0;
ssn_table_results := if(isFraudpoint or (bsversion>=41 and ~isFCRA), group(ssn_table_results2, seq), group(ssn_table_results1, seq));
// ssn_table_results := if(isFraudpoint or (bsversion>=41 and ~isFCRA), group(ssn_table_results2, seq), group(ssn_table_results1, seq));

    									
risk_indicators.layout_output get_ssnMap (risk_indicators.layout_output le, doxie.Key_SSN_Map ri, INTEGER i) := transform
	hasCorrection := le.ssn_correct_ffid <> [];
	
  // new ssn-issue data have '20990101' for the current date intervals
  r_end := if(hasCorrection, (UNSIGNED3)(le.soclhighissue[1..6]), (UNSIGNED3) (ri.end_date[1..6]));
  end_yyyymm := IF (r_end = 209901, 0, r_end); 

	self.PWsocsvalflag := IF(i=1,MAP(
							   le.PWsocsvalflag='0' and le.dob<> '' and end_yyyymm - (UNSIGNED3)(le.dob[1..6]) > 1800 => '5',
							   le.PWsocsvalflag='0' and end_yyyymm <> 0 and (INTEGER)(todays_date[1..6]) - end_yyyymm < 700 => '4',
							   le.PWsocsvalflag),
						le.PWsocsvalflag);
	/* The following accounts for randomized socials:
				ssnLowIssue - If possibly randomized, set low issue to the first date of randomization - June 25th, 2011
				ssnHighIssue - If possibly randomized, set to the current date (Or archive date if running in archive mode)
	*/
	randomizedSocial := Risk_Indicators.rcSet.isCodeRS(le.ssn, le.socsvalflag, if(hasCorrection, TRIM(le.socllowissue), TRIM((STRING)ri.start_date)), le.socsRCISflag);
	ssnLowIssue := IF(randomizedSocial and le.historydate > 201106, '20110625', if(hasCorrection, TRIM(le.socllowissue), TRIM((STRING)ri.start_date)));
	ssnHighIssue := IF(randomizedSocial and le.historydate > 201106, IF(le.historydate = 999999, todays_date, le.historydate + '01'), if(hasCorrection, TRIM(le.soclhighissue), TRIM((STRING)ri.end_date)));
					
	self.socllowissue  := IF(i=1, ssnLowIssue, le.socllowissue);	
	self.soclhighissue := IF(i=1, IF ((unsigned)ssnHighIssue in [0, 20990101, 20991231], '', ssnHighIssue), le.soclhighissue);
	SELF.soclstate := IF(i=1,IF(hasCorrection, le.soclstate, Address.Map_State_Name_To_Abbrev(Stringlib.StringToUpperCase(ri.state))),le.soclstate);
	
	socsdobflag_temp := IF(i=1,risk_indicators.validate_ssn(le.ssn,le.dob).ssnDobFlag (end_yyyymm),le.socsdobflag);
	self.socsdobflag := socsdobflag_temp;
	self.PWsocsdobflag := IF(i=1,MAP(socsdobflag_temp = '3' or self.PWsocsvalflag = '6' OR socsdobflag_temp='2' OR randomizedSocial => '2',
							   socsdobflag_temp = '1' => '1',
							   socsdobflag_temp = '0' => '0',
							   '0'),
						le.pwsocsdobflag);
						
	// needed for dl validation stuff
	self.dlsocsvalflag := le.dlsocsvalflag;
	dlsocsdob := risk_indicators.validate_ssn(le.dl_number[1..9],le.dob).ssnDobFlag(end_yyyymm);
	self.dlsocsdobflag := IF(i=2,MAP(dlsocsdob='3' or self.dlsocsvalflag='6' or dlsocsdob='2' => '2',
							   dlsocsdob='1' => '1',
							   dlsocsdob='0' => '0',
							   '0'),
						le.dlsocsdobflag);
	
	SELF := le;
END;

SSNMapKey := if(isFCRA, doxie.Key_SSN_FCRA_Map, doxie.Key_SSN_Map);

got_SSNMap_roxie := join(ssn_table_results, SSNMapKey,
												(left.ssn!='' AND LENGTH(StringLib.StringFilter(LEFT.ssn, '0123456789')) = 9 AND LENGTH(TRIM(LEFT.ssn)) = 9) and 
												keyed (left.ssn[1..5]=right.ssn5) AND
												keyed (left.ssn[6..9] between Right.start_serial AND Right.end_serial) AND
												// check date
												((unsigned3)(RIGHT.start_date[1..6]) < left.historydate),
												get_ssnMap(left,right, 1),
												LEFT OUTER, atmost(riskwise.max_atmost), keep(1));
					
got_SSNMap_thor_pre := join(distribute(ssn_table_results(ssn<>'' or ssn_correct_ffid <> []), hash64(ssn[1..5])), 
												distribute(pull(SSNMapKey), hash64(ssn5)),
												LENGTH(StringLib.StringFilter(LEFT.ssn, '0123456789')) = 9 AND LENGTH(TRIM(LEFT.ssn)) = 9 and 
												 (left.ssn[1..5]=right.ssn5) AND
												 (left.ssn[6..9] between Right.start_serial AND Right.end_serial) AND
												// check date
												((unsigned3)(RIGHT.start_date[1..6]) < left.historydate),
												get_ssnMap(left,right, 1),
												LEFT OUTER, keep(1), local);
						
got_SSNMap_thor := got_SSNMap_thor_pre + 
										project(ssn_table_results(ssn= '' and ssn_correct_ffid=[]), transform(recordof(left), self.socllowissue := '', self.soclhighissue := '', self := left));
						
#IF(onThor)
	got_SSNMap := got_SSNMap_thor;
#ELSE
	got_SSNMap := got_SSNMap_roxie;
#END

got_SSNMapDL_roxie := join(got_SSNMap, SSNMapKey,
																(left.dl_number!='') and
																keyed(left.dl_number[1..5]=right.ssn5) AND
																//TODO: not clear if check for start/end_serial for DL
																// check date
																((unsigned3)(RIGHT.start_date[1..6]) < left.historydate),
																get_ssnMap(left,right, 2),
																LEFT OUTER, atmost(riskwise.max_atmost), keep(1));

got_SSNMapDL_thor_pre := join(distribute(got_SSNMap(dl_number<>''), hash64(dl_number[1..5])), 
																distribute(pull(SSNMapKey), hash64(ssn5)),
																(left.dl_number[1..5]=right.ssn5) AND
																//TODO: not clear if check for start/end_serial for DL
																// check date
																((unsigned3)(RIGHT.start_date[1..6]) < left.historydate),
																get_ssnMap(left,right, 2),
																LEFT OUTER, atmost(left.dl_number[1..5]=right.ssn5, riskwise.max_atmost), keep(1), LOCAL);				
																
got_SSNMapDL_thor := got_SSNMapDL_thor_pre + got_SSNMap(dl_number='');

#IF(onThor)
	got_SSNMapDL := got_SSNMapDL_thor;
#ELSE
	got_SSNMapDL := got_SSNMapDL_roxie;
#END

// pluck the deceased value from ssn_table already done and send that through to ssnCodes function			
codes_in := ungroup( project(ssn_table_results, transform(RiskWise.layouts.layout_ssn_in,
									self.deceased := left.decsflag='1',  
									self := left)) );
									
socl := risk_indicators.getSSNCodes(codes_in, isFCRA);
			
risk_indicators.layout_output add_ssncodes(got_SSNMapDL le, socl rt) := transform
	self.inputsocscharflag := map(le.ssn='' => '6', // ssn empty
						  rt.socscode in ['0','110'] and rt.dobcode='60' => '5', // valid, but issued after 18th birthday
							rt.socscode in ['0','110'] and (integer)(todays_date[1..4]) - (integer)rt.highissue[1..4] <= 7 => '4',  // valid, but issued in the last 7 years
							rt.socscode in ['14','15','103','104','105','106','109','180','181','200','201'] => '1', // invalid
							rt.socscode = '12' => '3', // invalid; pocket book type
							'0');  // valid
	self.inputsocscode := rt.socscode; // save the raw socs code for use elsewhere
	self := le;
end;
with_socs_codes_roxie := join(got_SSNMapDL, socl, left.seq=right.seq, add_ssncodes(left,right), left outer, lookup);						
with_socs_codes_thor := join(distribute(got_SSNMapDL, hash64(seq)), 
														 distribute(socl, hash64(seq)), 
														 left.seq=right.seq, 
														 add_ssncodes(left,right), left outer, LOCAL);						

#IF(onThor)
	with_socs_codes := with_socs_codes_thor;
#ELSE
	with_socs_codes := with_socs_codes_roxie;
#END

ssn_flags_roxie := group(sort(if(runSSNCodes, with_socs_codes, got_SSNMapDL), seq),seq);  // to optimize query latency, only turn on runSSNCodes when needed	
ssn_flags_thor := group(sort(if(runSSNCodes, with_socs_codes, got_SSNMapDL), seq, LOCAL), seq, LOCAL); 

#IF(onThor)
	ssn_flags := ssn_flags_thor;
#ELSE
	ssn_flags := ssn_flags_roxie;
#END

risk_indicators.layout_output checkDC(risk_indicators.layout_output L) := transform
	dcNeeded := Suppress.dateCorrect.do(L.ssn).needed;
	self.socsvalflag		:= if(dcNeeded, '0', L.socsvalflag);
	self.PWsocsvalflag	:= if(dcNeeded, '0', L.PWsocsvalflag);
	self.socsRCISflag		:= if(dcNeeded, '0', L.socsRCISflag);
	self.decsflag				:= if(dcNeeded, '0', L.decsflag);
	self.dlsocsvalflag	:= if(dcNeeded, '0', L.dlsocsvalflag);
	self.socsdobflag		:= if(dcNeeded, '0', L.socsdobflag);
	self.PWsocsdobflag	:= if(dcNeeded, '0', L.PWsocsdobflag);
	self.dlsocsdobflag	:= if(dcNeeded, '0', L.dlsocsdobflag);
	self.socllowissue		:= Suppress.dateCorrect.sdate_s8(L.ssn, L.socllowissue);
	self.soclhighissue	:= Suppress.dateCorrect.edate_s8(L.ssn, L.soclhighissue);
	self.soclstate			:= Suppress.dateCorrect.st(L.ssn, L.soclstate);
	self := L;
end;
ssn_flags2 := project(ssn_flags, checkDC(left));

return ssn_flags2;

end;