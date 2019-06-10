import doxie, ut, mdr, header, drivers, census_data, address, FCRA, riskwise, doxie_files, Utilfile, risk_indicators;

export Boca_Shell_FCRA_Neutral_Function_ExperianFCRA(grouped DATASET(risk_indicators.Layout_output) iid,
								unsigned1 dppa, unsigned1 glb,
								boolean isUtility = false,
								boolean isLN=false,
								boolean includeRelativeInfo = false,
								boolean IsFCRA = FALSE,
								unsigned1 BSversion = 1, boolean nugen = false,
								string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
								unsigned8 BSOptions
								) := function

glb_ok := glb > 0 and glb < 8 or glb=11 or glb=12;
dppa_ok := dppa > 0 and dppa < 8;

ids := GROUP(SORT(risk_indicators.Boca_Shell_Ids(iid, includeRelativeInfo, DataRestriction, BSOptions),seq),seq);

relrec := risk_indicators.layout_bocashell_neutral;

// JRP 02/12/2008 - Dataset of actioncode and reasoncode settings which are passed to the getactioncodes and reasoncodes functions.
unsigned1 IIDVersion := 0;	// version 0 will not get the new v1 reason codes
reasoncode_settings := dataset([{nugen, IIDVersion}],riskwise.layouts.reasoncode_settings);

	

// Note: bool flag is set, if corrections exists (not necessarily used) for given record
// looks like it is safe doing here: this transform is used in all exec. paths
relrec getBocaShell(Risk_Indicators.Layout_Output le) :=
TRANSFORM
	SELF.seq := le.seq;
	SELF.did := le.did;
	SELF.HistoryDate := le.historydate;
	SELF.ADLCategory := le.ADLCategory;
	SELF.trueDID := le.trueDID;

	SELF.Shell_Input := ROW(le,TRANSFORM(risk_indicators.Layout_Input,SELF := LEFT));
	SELF.iid.NAS_summary := le.socsverlevel;
	SELF.iid.NAP_summary := le.phoneverlevel;
	
	SELF.iid.NAP_Type   := le.nap_type;
	SELF.iid.NAP_Status := le.nap_status;

	verlast := IF(le.socsverlevel in [2,5,7,8,9,11,12] OR le.phoneverlevel in [2,5,7,8,9,11,12], le.combo_last, '');
	veraddr := IF(le.socsverlevel in [3,5,6,8,10,11,12] OR le.phoneverlevel in [3,5,6,8,10,11,12], Risk_Indicators.MOD_AddressClean.street_address('',le.combo_prim_range,
										le.combo_predir,le.combo_prim_name,le.combo_suffix,le.combo_postdir,le.combo_unit_desig,le.combo_sec_range),'');			
	SELF.iid.CVI := (INTEGER)risk_indicators.cviScore(SELF.iid.NAP_Summary,SELF.iid.NAS_summary,le,le.correctssn,le.correctaddr,le.correcthphone,'',veraddr,verlast);
	ri := Risk_indicators.reasonCodes(le, 6, reasoncode_settings); 	
	self.iid.reason1 := ri[1].hri;
  self.iid.reason2 := ri[2].hri;
  self.iid.reason3 := ri[3].hri;
  self.iid.reason4 := ri[4].hri;
	self.iid.reason5 := ri[5].hri;
  self.iid.reason6 := ri[6].hri;
	self.iid.altlastpop := le.altlast<>'';
	self.iid.altlast2pop := le.altlast2<>'';
	self.iid.watchlisthit := le.watchlist_table<>'';
	self.iid.iid_flags := le.iid_flags;
	self.iid.swappedNames := map(le.fname = '' or le.lname = ''	=> -1,
															 le.swappedNames 								=> 1,
																																 0);
	self.iid := le;

	SELF.Available_Sources.DL := risk_indicators.Source_Available.DL(IF(le.dl_state<>'',le.dl_state,le.st));
	SELF.Available_Sources.Voter := risk_indicators.Source_Available.VoterSrcSt(le.st, bsversion, isFCRA, le.historydate);

	// Input Check
	SELF.Input_Validation.FirstName := le.fname<>'';
	SELF.Input_Validation.LastName := le.lname<>'';
	SELF.Input_Validation.Address := le.in_streetAddress<>'';
	SELF.Input_Validation.SSN := le.ssn<>'';
	SELF.Input_Validation.SSN_Length := (string)(length(trim(le.ssn)));// currently this will say 9 if input socs=4 and found with did (iid_common fills in full 9 byte)
	self.Input_Validation.ssnLookupFlag := le.ssnLookupFlag;		
	SELF.Input_Validation.DateOfBirth := le.dob<>'';
	SELF.Input_Validation.Email := le.email_address<>'';
	SELF.Input_Validation.IPAddress := le.ip_address<>'';
	SELF.Input_Validation.HomePhone := le.phone10<>'';
	SELF.Input_Validation.WorkPhone := le.wphone10<>'';

	// Address Validation
	SELF.Address_Validation.USPS_Deliverable := le.addrvalflag='V';
	SELF.Address_Validation.Dwelling_type := le.dwelltype;
	SELF.Address_Validation.Zip_type := le.ziptypeflag;
	SELF.Address_Validation.HR_Address := le.hriskaddrflag='4';
	SELF.Address_Validation.HR_Company := '';									// null
	SELF.Address_Validation.Error_Codes := le.addr_status;	
	SELF.Address_Validation.Corrections := le.hrisksic = '2225';

	// SSN Verification
	// dates here are over-all adl dates
	SELF.SSN_Verification.ssn_score := le.socsscore;
	SELF.SSN_Verification.adlPerSSN_count := le.socsdidCount;
	SELF.SSN_Verification.namePerSSN_count := le.altlast_count;// this should probably count lnames from the key, not altlasts
	SELF.SSN_Verification.credit_sourced := le.eqfssocscount;
	SELF.SSN_Verification.tu_sourced := le.tusocscount;	
	en_eq_first_seen := ut.min2(le.adl_en_first_seen, le.adl_eqfs_first_seen);
	en_eq_last_seen := ut.max2(le.adl_en_last_seen, le.adl_eqfs_last_seen);
	SELF.SSN_Verification.credit_first_seen := en_eq_first_seen;
	SELF.SSN_Verification.credit_last_seen := en_eq_last_seen;
	SELF.SSN_Verification.header_count := le.socscount;
	SELF.SSN_Verification.header_first_seen := ut.Min2(le.adl_other_first_seen, en_eq_first_seen);
	SELF.SSN_Verification.header_last_seen := ut.max2(le.adl_other_last_seen, en_eq_last_seen);
	
	
	SELF.SSN_Verification.voter_sourced := le.emsocscount;
	SELF.SSN_Verification.bk_sourced := le.bksocscount;
	SELF.SSN_Verification.utility_sourced := le.utiliaddr_socscount;
	SELF.SSN_Verification.other_sourced := le.socscount - 
						((INTEGER)le.eqfssocscount+(INTEGER)le.dlsocscount+
						 (INTEGER)le.emsocscount+(INTEGER)le.bksocscount)+(INTEGER)le.utiliaddr_socscount;

	SELF.SSN_Verification.Validation.deceased := le.decsflag='1';
	SELF.SSN_Verification.Validation.deceasedDate := le.deceasedDate;
	SELF.SSN_Verification.Validation.valid := le.socsvalflag in ['0','3'] or (le.socsvalflag = '2' and length(trim(le.ssn))=4);
	SELF.SSN_Verification.Validation.issued := self.ssn_verification.validation.valid;	// setting this to be the same as valid for now as per Brent S.
	SELF.SSN_Verification.Validation.high_issue_date := (UNSIGNED4)le.soclhighissue;
	SELF.SSN_Verification.Validation.low_issue_date := (UNSIGNED4)le.socllowissue;
	SELF.SSN_Verification.Validation.issue_state := le.soclstate;
	
	SELF.SSN_Verification.Validation.dob_mismatch := IF(le.socsdobflag<>'1',0,
													(INTEGER)(le.dob[1..4]) - 
															(INTEGER)(SELF.SSN_Verification.Validation.high_issue_date[1..4]));
	SELF.SSN_Verification.Validation.inputsocscharflag := le.inputsocscharflag;
	SELF.SSN_Verification.Validation.inputsocscode := le.inputsocscode;
															
	SELF.Source_Verification.EQ_count := le.EQ_count;
	SELF.Source_Verification.EN_count := le.EN_count;
	SELF.Source_Verification.TU_count := le.TU_count;
	SELF.Source_Verification.DL_count := le.DL_count;
	SELF.Source_Verification.PR_count := le.PR_count;
	SELF.Source_Verification.V_count := le.V_count;
	SELF.Source_Verification.EM_count := le.EM_count;
	SELF.Source_Verification.VO_count := le.VO_count;
	SELF.Source_Verification.W_count := le.W_count;
	SELF.Source_Verification.EM_only_count := le.EM_only_count;
	SELF.Source_Verification.adl_EQfs_first_seen := le.adl_EQfs_first_seen;
	SELF.Source_Verification.adl_EN_first_seen := le.adl_EN_first_seen;
	SELF.Source_Verification.adl_TU_first_seen := le.adl_TU_first_seen;
	SELF.Source_Verification.adl_DL_first_seen := le.adl_DL_first_seen;
	SELF.Source_Verification.adl_PR_first_seen := le.adl_PR_first_seen;
	SELF.Source_Verification.adl_V_first_seen := le.adl_V_first_seen;
	SELF.Source_Verification.adl_EM_first_seen := le.adl_EM_first_seen;
	SELF.Source_Verification.adl_VO_first_seen := le.adl_VO_first_seen;
	SELF.Source_Verification.adl_EM_only_first_seen := le.adl_EM_only_first_seen;
	SELF.Source_Verification.adl_W_first_seen := le.adl_W_first_seen;
	SELF.Source_Verification.adl_EQfs_last_seen := le.adl_EQfs_last_seen;
	SELF.Source_Verification.adl_EN_last_seen := le.adl_EN_last_seen;
	SELF.Source_Verification.adl_TU_last_seen := le.adl_TU_last_seen;
	SELF.Source_Verification.adl_DL_last_seen := le.adl_DL_last_seen;
	SELF.Source_Verification.adl_PR_last_seen := le.adl_PR_last_seen;
	SELF.Source_Verification.adl_V_last_seen := le.adl_V_last_seen;
	SELF.Source_Verification.adl_EM_last_seen := le.adl_EM_last_seen;
	SELF.Source_Verification.adl_VO_last_seen := le.adl_VO_last_seen;
	SELF.Source_Verification.adl_EM_only_last_seen := le.adl_EM_only_last_seen;
	SELF.Source_Verification.adl_W_last_seen := le.adl_W_last_seen;
	SELF.Source_Verification.firstnamesources := le.firstnamesources;
	SELF.Source_Verification.lastnamesources := le.lastnamesources;
	SELF.Source_Verification.addrsources := le.addrsources;
	SELF.Source_Verification.socssources := le.socssources;		
	SELF.Source_Verification.EM_only_sources := le.EM_only_sources;
	SELF.Source_Verification.num_nonderogs := le.num_nonderogs;
	SELF.Source_Verification.num_nonderogs30 := le.num_nonderogs30;
	SELF.Source_Verification.num_nonderogs90 := le.num_nonderogs90;
	SELF.Source_Verification.num_nonderogs180 := le.num_nonderogs180;
	SELF.Source_Verification.num_nonderogs12 := le.num_nonderogs12;
	SELF.Source_Verification.num_nonderogs24 := le.num_nonderogs24;
	SELF.Source_Verification.num_nonderogs36 := le.num_nonderogs36;
	SELF.Source_Verification.num_nonderogs60 := le.num_nonderogs60;
			
			
	self.Velocity_Counters.addrs_per_ssn := le.addrs_per_ssn; 
	self.Velocity_Counters.adls_per_ssn_created_6months := le.adls_per_ssn_created_6months;
	self.Velocity_Counters.addrs_per_ssn_created_6months := le.addrs_per_ssn_created_6months;
	SELF.Velocity_Counters.adls_per_phone := le.adls_per_phone; 
	SELF.Velocity_Counters.adls_per_phone_created_6months := le.adls_per_phone_created_6months;
	SELF.Velocity_Counters.ssns_per_adl := le.ssns_per_adl;
	SELF.Velocity_Counters.addrs_per_adl := le.addrs_per_adl;
	SELF.Velocity_Counters.phones_per_adl := le.phones_per_adl;
	SELF.Velocity_Counters.adls_per_addr := le.adls_per_addr;
	SELF.Velocity_Counters.ssns_per_addr := le.ssns_per_addr;
	SELF.Velocity_Counters.phones_per_addr := le.phones_per_addr;
	SELF.Velocity_Counters.ssns_per_adl_created_6months := le.ssns_per_adl_created_6months;
	SELF.Velocity_Counters.addrs_per_adl_created_6months := le.addrs_per_adl_created_6months;
	SELF.Velocity_Counters.phones_per_adl_created_6months := le.phones_per_adl_created_6months;
	SELF.Velocity_Counters.adls_per_addr_created_6months := le.adls_per_addr_created_6months;
	SELF.Velocity_Counters.ssns_per_addr_created_6months := le.ssns_per_addr_created_6months;
	SELF.Velocity_Counters.phones_per_addr_created_6months := le.phones_per_addr_created_6months;
	SELF.Velocity_Counters.dl_addrs_per_adl := le.dl_addrs_per_adl;
	SELF.Velocity_Counters.vo_addrs_per_adl := le.vo_addrs_per_adl;
	SELF.Velocity_Counters.pl_addrs_per_adl := le.pl_addrs_per_adl;
	SELF.Velocity_Counters.lnames_per_adl := le.lnames_per_adl;
	SELF.Velocity_Counters.lnames_per_adl30 := le.lnames_per_adl30;	// within the last 30 days
	SELF.Velocity_Counters.lnames_per_adl90 := le.lnames_per_adl90;	// within the last 90 days
	SELF.Velocity_Counters.lnames_per_adl180 := le.lnames_per_adl180;
	SELF.Velocity_Counters.lnames_per_adl12 := le.lnames_per_adl12;	// within the last 1 year
	SELF.Velocity_Counters.lnames_per_adl24 := le.lnames_per_adl24;	// within the last 2 years
	SELF.Velocity_Counters.lnames_per_adl36 := le.lnames_per_adl36;	// within the last 3 years	
	SELF.Velocity_Counters.lnames_per_adl60 := le.lnames_per_adl60;
	SELF.Velocity_Counters.invalid_ssns_per_adl := le.invalid_ssns_per_adl;
	SELF.Velocity_Counters.invalid_addrs_per_adl := le.invalid_addrs_per_adl;
	SELF.Velocity_Counters.invalid_ssns_per_adl_created_6months := le.invalid_ssns_per_adl_created_6months;
	SELF.Velocity_Counters.invalid_addrs_per_adl_created_6months := le.invalid_addrs_per_adl_created_6months;
	
	SELF.Velocity_Counters.adls_per_ssn_seen_18months := le.adls_per_ssn_seen_18months;
	SELF.Velocity_Counters.ssns_per_adl_seen_18months := le.ssns_per_adl_seen_18months;
	
	SELF.Velocity_Counters.ssns_per_adl_multiple_use := le.ssns_per_adl_multiple_use;
	SELF.Velocity_Counters.ssns_per_adl_multiple_use_non_relative := le.ssns_per_adl_multiple_use_non_relative;
	SELF.Velocity_Counters.dobs_per_adl := le.dobs_per_adl;
	SELF.Velocity_Counters.dobs_per_adl_created_6months := le.dobs_per_adl_created_6months;		
	SELF.Velocity_Counters.lnames_per_ssn := le.lnames_per_ssn;
	SELF.Velocity_Counters.lnames_per_ssn_created_6months := le.lnames_per_ssn_created_6months;
	SELF.Velocity_Counters.addrs_per_ssn_multiple_use := le.addrs_per_ssn_multiple_use;
	SELF.Velocity_Counters.adls_per_ssn_multiple_use := le.adls_per_ssn_multiple_use;
	SELF.Velocity_Counters.adls_per_ssn_multiple_use_non_relative := le.adls_per_ssn_multiple_use_non_relative;
	SELF.Velocity_Counters.adls_per_addr_multiple_use := le.adls_per_addr_multiple_use;
	SELF.Velocity_Counters.suspicious_adls_per_addr_created_6months := le.suspicious_adls_per_addr_created_6months ;
	SELF.Velocity_Counters.ssns_per_addr_multiple_use := le.ssns_per_addr_multiple_use;
	SELF.Velocity_Counters.phones_per_addr_multiple_use := le.phones_per_addr_multiple_use;
	SELF.Velocity_Counters.adls_per_phone_multiple_use := le.adls_per_phone_multiple_use;
	SELF.Velocity_Counters.addrs_per_phone := le.addrs_per_phone;
	SELF.Velocity_Counters.addrs_per_phone_created_6months:= le.addrs_per_phone_created_6months;
	
	// DL Verification	
	//SELF.DL_Validation.valid := le.drlcvalflag='0';

	// Name Verification
	SELF.Name_Verification.adl_score := le.score;
	SELF.Name_Verification.fname_score := le.firstscore;
	SELF.Name_Verification.lname_score := le.lastscore;
	// multiple lnames according to lnames associated with ssn
	SELF.Name_Verification.lname_change_date := (unsigned3)le.altearly_date;
	SELF.Name_Verification.lname_prev_change_date := (unsigned3)le.altearly_date2;
	SELF.Name_Verification.source_count := ut.imin2(le.firstcount,le.lastcount);
	SELF.Name_Verification.fname_credit_sourced := le.eqfsfirstcount;
	SELF.Name_Verification.lname_credit_sourced := le.eqfslastcount;
	SELF.Name_Verification.fname_tu_sourced := le.tufirstcount;
	SELF.Name_Verification.lname_tu_sourced := le.tulastcount;
	SELF.Name_Verification.fname_eda_sourced := le.phoneaddr_firstcount>0 OR le.phonefirstcount>0;
	SELF.Name_Verification.fname_eda_sourced_type := map( le.phoneaddr_firstcount>0 AND le.phonefirstcount>0 => 'AP',	
																												le.phoneaddr_firstcount>0 => 'A',
																												le.phonefirstcount>0 => 'P',
																												'');
	SELF.Name_Verification.lname_eda_sourced := le.phoneaddr_lastcount>0 OR le.phonelastcount>0;
	SELF.Name_Verification.lname_eda_sourced_type := map( le.phoneaddr_lastcount>0 AND le.phonelastcount>0 => 'AP',
																												le.phoneaddr_lastcount>0 => 'A',
																												le.phonelastcount>0 => 'P',
																												'');
	SELF.Name_Verification.fname_dl_sourced := le.dlfirstcount;
	SELF.Name_Verification.lname_dl_sourced := le.dllastcount;
	SELF.Name_Verification.fname_voter_sourced := le.emfirstcount;
	SELF.Name_Verification.lname_voter_sourced := le.emlastcount;
	SELF.Name_Verification.fname_utility_sourced := le.utiliaddr_firstcount>0;
	SELF.Name_Verification.lname_utility_sourced := le.utiliaddr_lastcount>0;
	SELF.Name_Verification.age := ut.GetAgeI_asOf((unsigned)le.verdob, (unsigned)risk_indicators.iid_constants.myGetDate(le.historydate));
	SELF.Name_Verification.dob_score := le.dobscore;
	SELF.Name_Verification.newest_lname := le.last_from_did;
	SELF.Name_Verification.newest_lname_dt_first_seen := le.newest_lname_dt_first_seen;

	// Verified Address
	SELF.Address_Verification.Input_Address_Information.prim_range := le.prim_range;
	SELF.Address_Verification.Input_Address_Information.predir := le.predir;
	SELF.Address_Verification.Input_Address_Information.prim_name := le.prim_name;
	SELF.Address_Verification.Input_Address_Information.addr_suffix := le.addr_suffix;
	SELF.Address_Verification.Input_Address_Information.postdir := le.postdir;
	SELF.Address_Verification.Input_Address_Information.unit_desig := le.unit_desig;
	SELF.Address_Verification.Input_Address_Information.sec_range := le.sec_range;
	SELF.Address_Verification.Input_Address_Information.city_name := le.p_city_name;
	SELF.Address_Verification.Input_Address_Information.st := le.st;
	SELF.Address_Verification.Input_Address_Information.zip5 := le.z5;
	SELF.Address_Verification.Input_Address_Information.county := le.county;
	SELF.Address_Verification.Input_Address_Information.geo_blk := le.geo_blk;
	SELF.Address_Verification.Input_Address_Information.address_score := le.addrscore;
	SELF.Address_Verification.Input_Address_Information.House_Number_match := le.prim_range=le.verprim_range;
	

	whatsInput := MAP(	le.prim_name=le.chronoprim_name AND le.prim_range=le.chronoprim_range => 1,
					le.prim_name=le.chronoprim_name2 AND le.prim_range=le.chronoprim_range2 => 2,
					le.prim_name=le.chronoprim_name3 AND le.prim_range=le.chronoprim_range3 => 3,0);

	inputbpicker(field1,field2,field3) := MACRO
		CHOOSE(whatsInput,field1,field2,field3,false)
	ENDMACRO;
	inputipicker(field1,field2,field3) := MACRO
		CHOOSE(whatsInput,field1,field2,field3,0)
	ENDMACRO;


	SELF.Address_Verification.Input_Address_Information.isBestMatch := inputbpicker(le.chronoaddr_isBest,le.chronoaddr_isBest2,le.chronoaddr_isBest3);
	SELF.Address_Verification.Input_Address_Information.credit_sourced := inputbpicker(le.chrono_eqfsaddrcount, le.chrono_eqfsaddrcount2,le.chrono_eqfsaddrcount3);
	SELF.Address_Verification.Input_Address_Information.dl_sourced := inputbpicker(le.chrono_dladdrcount, le.chrono_dladdrcount2,le.chrono_dladdrcount3);
	SELF.Address_Verification.Input_Address_Information.eda_sourced := inputbpicker(le.chronophone_namematch, le.chronophone2_namematch,le.chronophone3_namematch) BETWEEN 80 AND 100;
	SELF.Address_Verification.Input_Address_Information.voter_sourced := inputbpicker(le.chrono_emaddrcount,le.chrono_emaddrcount2,le.chrono_emaddrcount3);
	SELF.Address_Verification.Input_Address_Information.utility_sourced := le.utiliaddr_addrcount>0;
	SELF.Address_Verification.Input_Address_Information.source_count := inputipicker(le.chrono_addrcount,le.chrono_addrcount2,le.chrono_addrcount3)+
																			(INTEGER)SELF.Address_Verification.Input_Address_Information.eda_sourced;
	SELF.Address_Verification.Input_Address_Information.date_first_seen := inputipicker(le.chronodate_first,le.chronodate_first2,le.chronodate_first3);
	SELF.Address_Verification.Input_Address_Information.date_last_seen := inputipicker(le.chronodate_last,le.chronodate_last2,le.chronodate_last3);
	SELF.Address_Verification.Input_Address_Information.sources := '';	// blank because this is the same as iid.sources, addr hist 1 and 2 are populated
	SELF.Address_Verification.edaMatchLevel := le.inputaddrmatchlevel;
	SELF.Address_Verification.activePhone := le.inputaddractivephone;
	
	SELF.addrPop := Risk_Indicators.MOD_AddressClean.street_address('',le.prim_range,le.predir,le.prim_name,le.addr_suffix,le.postdir,le.unit_desig,le.sec_range)<>'';
	
	// not populating the address_verification.addr_flags section at this time - doesnt seem to be needed
	
	// First Address
	TakeSecond_original := le.prim_name=le.chronoprim_name AND le.prim_range=le.chronoprim_range;
	TakeSecond_50 := false;  // always have address_history_1 = current address for 50 and newer
	TakeSecond := if(bsversion<50, TakeSecond_original, TakeSecond_50);
	
	picker(field1,field2) := MACRO
		IF(TakeSecond,field2,field1)
	ENDMACRO;

	SELF.Address_Verification.Address_History_1.isBestMatch := picker(le.chronoaddr_isBest,le.chronoaddr_isBest2 );
	SELF.Address_Verification.Address_History_1.prim_range := picker(le.chronoprim_range,le.chronoprim_range2);
	SELF.Address_Verification.Address_History_1.predir := picker(le.chronopredir,le.chronopredir2);
	SELF.Address_Verification.Address_History_1.prim_name := picker(le.chronoprim_name,le.chronoprim_name2);
	SELF.Address_Verification.Address_History_1.addr_suffix := picker(le.chronosuffix,le.chronosuffix2);
	SELF.Address_Verification.Address_History_1.postdir := picker(le.chronopostdir,le.chronopostdir2);
	SELF.Address_Verification.Address_History_1.unit_desig := picker(le.chronounit_desig,le.chronounit_desig2);
	SELF.Address_Verification.Address_History_1.sec_range := picker(le.chronosec_range,le.chronosec_range2);
	SELF.Address_Verification.Address_History_1.city_name := picker(le.chronocity,le.chronocity2);
	chrono_address1 := Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range,le.chronopredir,le.chronoprim_name,le.chronosuffix,le.chronopostdir,le.chronounit_desig,le.chronosec_range);
	chrono_address2 := Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range2,le.chronopredir2,le.chronoprim_name2,le.chronosuffix2,le.chronopostdir2,le.chronounit_desig2,le.chronosec_range2);
	SELF.Address_Verification.Address_History_1.st := picker(le.chronostate,le.chronostate2);
	SELF.Address_Verification.Address_History_1.zip5 := picker(le.chronozip,le.chronozip2);
	SELF.addrhist1zip4 := picker(le.chronozip4,le.chronozip4_2);	// for output in fraudpoint attributes
	SELF.Address_Verification.Address_History_1.county := picker(le.chronocounty,le.chronocounty2);
	SELF.Address_Verification.Address_History_1.geo_blk := picker(le.chronogeo_blk,le.chronogeo_blk2);
	SELF.Address_Verification.Address_History_1.address_score := picker(le.chronoaddrscore,le.chronoaddrscore2);
	SELF.Address_Verification.Address_History_1.House_Number_match := le.prim_range=picker(le.chronoprim_range,le.chronoprim_range2);
	SELF.Address_Verification.Address_History_1.credit_sourced := picker(le.chrono_eqfsaddrcount,le.chrono_eqfsaddrcount2);
	SELF.Address_Verification.Address_History_1.eda_sourced := picker(le.chronophone_namematch,le.chronophone2_namematch) BETWEEN 80 AND 100;
	SELF.Address_Verification.Address_History_1.dl_sourced := picker(le.chrono_dladdrcount,le.chrono_dladdrcount2);
	SELF.Address_Verification.Address_History_1.voter_sourced := picker(le.chrono_emaddrcount,le.chrono_emaddrcount2);
	SELF.Address_Verification.Address_History_1.utility_sourced := 0;	// null
	SELF.Address_Verification.Address_History_1.source_count := picker(le.chrono_addrcount,le.chrono_addrcount2)+
																	(INTEGER)SELF.Address_Verification.Address_History_1.eda_sourced;
	SELF.Address_Verification.Address_History_1.date_first_seen := picker(le.chronodate_first,le.chronodate_first2);
	SELF.Address_Verification.Address_History_1.date_last_seen := picker(le.chronodate_last,le.chronodate_last2);
	SELF.Address_Verification.edaMatchLevel2 := picker(le.inputaddrMatchLevel,le.chronoMatchLevel2);
	SELF.Address_Verification.activePhone2 := picker(le.inputaddrActivePhone,le.chronoActivePhone2);
	SELF.Address_Verification.Address_History_1.sources := picker(le.chrono_sources, le.chrono_sources2);	// sources with this address on it on the header results
	
	SELF.addrPop2 := picker(chrono_address1, chrono_address2) <>'';
	
	// get the addr_flags for the first address
	SELF.Address_Verification.addr_flags_1 := picker(le.chrono_addr_flags, le.chrono_addr_flags2);


	TakeThird := TakeSecond OR (le.prim_name=le.chronoprim_name2 AND le.prim_range=le.chronoprim_range2);
	picker2(field1,field2) := MACRO
		IF(TakeThird, field2, field1)
	ENDMACRO;

	// Next Next Recent Address
	SELF.Address_Verification.Address_History_2.isBestMatch := picker2(le.chronoaddr_isBest2,
																																						le.chronoaddr_isBest3);

	SELF.Address_Verification.Address_History_2.prim_range := picker2(le.chronoprim_range2,le.chronoprim_range3);
	SELF.Address_Verification.Address_History_2.predir := picker2(le.chronopredir2,le.chronopredir3);
	SELF.Address_Verification.Address_History_2.prim_name := picker2(le.chronoprim_name2,le.chronoprim_name3);
	SELF.Address_Verification.Address_History_2.addr_suffix := picker2(le.chronosuffix2,le.chronosuffix3);
	SELF.Address_Verification.Address_History_2.postdir := picker2(le.chronopostdir2,le.chronopostdir3);
	SELF.Address_Verification.Address_History_2.unit_desig := picker2(le.chronounit_desig2,le.chronounit_desig3);
	SELF.Address_Verification.Address_History_2.sec_range := picker2(le.chronosec_range2,le.chronosec_range3);
	SELF.Address_Verification.Address_History_2.city_name := picker2(le.chronocity2,le.chronocity3);
	chrono_address3 := Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range3,le.chronopredir3,le.chronoprim_name3,le.chronosuffix3,le.chronopostdir3,le.chronounit_desig3,le.chronosec_range3);
	SELF.Address_Verification.Address_History_2.st := picker2(le.chronostate2,le.chronostate3);
	SELF.Address_Verification.Address_History_2.zip5 := picker2(le.chronozip2,le.chronozip3);
	SELF.addrhist2zip4 := picker2(le.chronozip4_2,le.chronozip4_3);	// for output in fraudpoint attributes
	SELF.Address_Verification.Address_History_2.county := picker2(le.chronocounty2,le.chronocounty3);
	SELF.Address_Verification.Address_History_2.geo_blk := picker2(le.chronogeo_blk2,le.chronogeo_blk3);
	SELF.Address_Verification.Address_History_2.address_score := picker2(le.chronoaddrscore2,le.chronoaddrscore3);
	SELF.Address_Verification.Address_History_2.House_Number_match := le.prim_range=picker2(le.chronoprim_range2,le.chronoprim_range3);
	SELF.Address_Verification.Address_History_2.credit_sourced := picker2(le.chrono_eqfsaddrcount2,le.chrono_eqfsaddrcount3);
	SELF.Address_Verification.Address_History_2.eda_sourced := picker2(le.chronophone2_namematch,le.chronophone3_namematch) BETWEEN 80 AND 100;
	SELF.Address_Verification.Address_History_2.dl_sourced := picker2(le.chrono_dladdrcount2,le.chrono_dladdrcount3);
	SELF.Address_Verification.Address_History_2.voter_sourced := picker2(le.chrono_emaddrcount2,le.chrono_emaddrcount3);
	SELF.Address_Verification.Address_History_2.utility_sourced := 0;	// null
	SELF.Address_Verification.Address_History_2.source_count := picker2(le.chrono_addrcount2,le.chrono_addrcount3)+
																	(INTEGER)SELF.Address_Verification.Address_History_2.eda_sourced;
	SELF.Address_Verification.Address_History_2.date_first_seen := picker2(le.chronodate_first2,le.chronodate_first3);
	SELF.Address_Verification.Address_History_2.date_last_seen := picker2(le.chronodate_last2,le.chronodate_last3);
	SELF.Address_Verification.edaMatchLevel3 := picker2(le.chronoMatchLevel2,le.chronoMatchLevel3);
	SELF.Address_Verification.activePhone3 := picker2(le.chronoActivePhone2,le.chronoActivePhone3);
	
	SELF.Address_Verification.Address_History_2.sources := picker2(le.chrono_sources2, le.chrono_sources3);	// sources with this address on it on the header results
	
	SELF.addrPop3 := picker2(chrono_address2, chrono_address3) <> '';
	
	// get the addr_flags for the first address
	SELF.Address_Verification.addr_flags_2 := picker2(le.chrono_addr_flags2, le.chrono_addr_flags3);
	

	// replacing existing calcs with new ones	
	// try length of residence just taking the difference between first and last seen dates
	self.lres := if(self.address_verification.input_address_information.date_first_seen <> 0 and self.address_verification.input_address_information.date_last_seen <> 0,
																		round((ut.DaysApart((string)self.address_verification.input_address_information.date_first_seen, 
																												(string)self.address_verification.input_address_information.date_last_seen)) / 30), 
																 0);
														 
	self.lres2 := if(self.address_verification.address_history_1.date_first_seen <> 0 and self.address_verification.address_history_1.date_last_seen <> 0,
																		round((ut.DaysApart((string)self.address_verification.address_history_1.date_first_seen, 
																												(string)self.address_verification.address_history_1.date_last_seen)) / 30), 
																 0);
	
	self.lres3 := if(self.address_verification.address_history_2.date_first_seen <> 0 and self.address_verification.address_history_2.date_last_seen <> 0,
																		round((ut.DaysApart((string)self.address_verification.address_history_2.date_first_seen, 
																												(string)self.address_verification.address_history_2.date_last_seen)) / 30), 
																 0);
	
	
	
	SELF.Other_Address_Info.max_lres := ut.max2(ut.max2(self.lres, self.lres2), self.lres3);
	SELF.Other_Address_Info.avg_lres := (self.lres + self.lres2 + self.lres3) / ((integer)(boolean)self.lres + (integer)(boolean)self.lres2 + (integer)(boolean)self.lres3);// this does not take into account real 0's
	SELF.Other_Address_Info.addrs_last_5years := le.addrs_last_5years;
	SELF.Other_Address_Info.addrs_last_10years := le.addrs_last_10years;
	SELF.Other_Address_Info.addrs_last_15years := le.addrs_last_15years;
	SELF.Other_Address_Info.isPrison := le.isPrison;  // this flag tells if any of your addresses is a prison
	chrono1_isprison	:= risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.Chrono1_isPrison, le.iid_flags );
	chrono2_isprison	:= risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.Chrono2_isPrison, le.iid_flags );
	chrono3_isprison	:= risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.Chrono3_isPrison, le.iid_flags );
	SELF.Other_Address_Info.hist1_isPrison := picker(chrono1_isprison, chrono2_isprison);
	SELF.Other_Address_Info.hist2_isPrison := picker2(chrono2_isprison, chrono3_isprison);
	
	SELF.Other_Address_Info.addrs_last30 := le.addrs_last30;
	SELF.Other_Address_Info.addrs_last90 := le.addrs_last90;
	SELF.Other_Address_Info.addrs_last12 := le.addrs_last12;
	SELF.Other_Address_Info.addrs_last24 := le.addrs_last24;
	SELF.Other_Address_Info.addrs_last36 := le.addrs_last36;

	SELF.Phone_Verification.phone_score := le.combo_hphonescore;
	SELF.Phone_Verification.telcordia_type := le.nxx_type;
	SELF.Phone_Verification.phone_zip_mismatch := le.phonezipflag='1';
	SELF.Phone_Verification.distance := le.disthphoneaddr;
	SELF.Phone_Verification.disconnected := le.phone_disconnected;
	SELF.Phone_Verification.recent_disconnects := le.phone_disconnectcount;
	SELF.Phone_Verification.HR_Phone := le.hriskphoneflag='6';
	SELF.Phone_Verification.Corrections := le.hrisksicphone = '2225';	
	SELF.Phone_Verification.phone_sources := le.phone_sources;
	
	SELF.reported_dob := le.reported_dob;
	SELF.inferred_age := le.inferred_age;
	
	
	SELF.dobmatchlevel := le.dobmatchlevel;	// now calculated in iid portion for use in iid
														
	SELF.gong_ADL_dt_first_seen := le.gong_ADL_dt_first_seen;  
	SELF.gong_ADL_dt_last_seen := le.gong_ADL_dt_last_seen;  
	
	SELF.mobility_indicator := le.mobility_indicator;
	
	// calculate inter-address scores - Hardcode the zips to match, because we don't want to receive the 12 for zips not matching
	self.Address_Verification.addr1addr2score := Risk_Indicators.AddrScore.AddressScore(SELF.address_verification.input_address_information.prim_range,SELF.address_verification.input_address_information.prim_name,SELF.address_verification.input_address_information.sec_range,
																												 SELF.address_verification.address_history_1.prim_range,SELF.address_verification.address_history_1.prim_name,SELF.address_verification.address_history_1.sec_range);
	self.Address_Verification.addr1addr3score := Risk_Indicators.AddrScore.AddressScore(SELF.address_verification.input_address_information.prim_range,SELF.address_verification.input_address_information.prim_name,SELF.address_verification.input_address_information.sec_range,
																												 SELF.address_verification.address_history_2.prim_range,SELF.address_verification.address_history_2.prim_name,SELF.address_verification.address_history_2.sec_range);
	self.Address_Verification.addr2addr3score := Risk_Indicators.AddrScore.AddressScore(SELF.address_verification.address_history_1.prim_range,SELF.address_verification.address_history_1.prim_name,SELF.address_verification.address_history_1.sec_range,
																												 SELF.address_verification.address_history_2.prim_range,SELF.address_verification.address_history_2.prim_name,SELF.address_verification.address_history_2.sec_range);

	
	// Calculate inter-address distances, capping at 9998 for real distances, 9999 means we can't calculate
	SELF.Address_Verification.distance_in_2_h1:= 
				IF(SELF.Address_Verification.Input_Address_Information.zip5='' 
						OR SELF.Address_Verification.Address_History_1.zip5='', 9999,
								ut.imin2((INTEGER) ut.zip_Dist(SELF.Address_Verification.Input_Address_Information.zip5,
													SELF.Address_Verification.Address_History_1.zip5), 9998));
	SELF.Address_Verification.distance_in_2_h2 := 
				IF(SELF.Address_Verification.Input_Address_Information.zip5='' 
						OR SELF.Address_Verification.Address_History_2.zip5='', 9999,
								ut.imin2((INTEGER) ut.zip_Dist(SELF.Address_Verification.Input_Address_Information.zip5,
													SELF.Address_Verification.Address_History_2.zip5), 9998));
	SELF.Address_Verification.distance_h1_2_h2 := 
				IF(SELF.Address_Verification.Address_History_1.zip5=''
						OR SELF.Address_Verification.Address_History_2.zip5='', 9999, 
								ut.imin2((INTEGER) ut.zip_Dist(SELF.Address_Verification.Address_History_1.zip5,
													SELF.Address_Verification.Address_History_2.zip5), 9998));

  SELF.ConsumerFlags.corrected_flag := (StringLib.StringFind (le.src, 'CO', 1) != 0) OR
                                       (StringLib.StringFind (le.sources, 'CO', 1) != 0);
																			 		
// adding self := le; so we don't need to manually map fields from layout output into the shell anymore if they're named the same	
	// self.header_summary := le.header_summary;
	// self.address_history_summary := le.address_history_summary;
	self.age := (integer)le.age;  // age is an integer field on the shell, string in layout_output, need to manually map that one
	self := le;
	SELF := [];
END;

p := group(sort(PROJECT(iid, getBocaShell(LEFT)), seq), seq);
				
relrec getDwell(p le) := transform
	// get dwelltype for address history 1
	a1_val := Risk_Indicators.MOD_AddressClean.street_address('',le.address_verification.address_history_1.prim_range,le.address_verification.address_history_1.predir,
																				le.address_verification.address_history_1.prim_name,le.address_verification.address_history_1.addr_suffix,
																				le.address_verification.address_history_1.postdir,le.address_verification.address_history_1.unit_desig,
																				le.address_verification.address_history_1.sec_range);
	
	clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(a1_val, le.address_verification.address_history_1.city_name, le.address_verification.address_history_1.st,
																				le.address_verification.address_history_1.zip5);
	
	invalidSet := ['E101','E212','E213','E214','E216','E302','E412','E413','E420','E421','E423','E500','E501','E502','E503','E600'];	// added E600 6/6/2005 per Jim C.

	a1Override := trim(le.address_verification.addr_flags_1.dwelltype)<>'';	// means there was a correction to this address
	
	SELF.Address_Verification.addr_type2 := map(a1Override => le.address_verification.addr_flags_1.dwelltype,
																							clean_a2[139] = 'S' and clean_a2[179..182] in invalidSet => '', 
																							clean_a2[139]);
	
	// get dwelltype for address history 2
	a1_val2 := Risk_Indicators.MOD_AddressClean.street_address('',le.address_verification.address_history_2.prim_range,le.address_verification.address_history_2.predir,
																				le.address_verification.address_history_2.prim_name,le.address_verification.address_history_2.addr_suffix,
																				le.address_verification.address_history_2.postdir,le.address_verification.address_history_2.unit_desig,
																				le.address_verification.address_history_2.sec_range);
	
	clean_a22 := Risk_Indicators.MOD_AddressClean.clean_addr(a1_val2, le.address_verification.address_history_2.city_name, le.address_verification.address_history_2.st,
																				le.address_verification.address_history_2.zip5);
																				
	a2Override := trim(le.address_verification.addr_flags_2.dwelltype)<>'';	// means there was a correction to this address
	
	SELF.Address_Verification.addr_type3 := map(a2Override => le.address_verification.addr_flags_2.dwelltype,
																							clean_a22[139] = 'S' and clean_a22[179..182] in invalidSet => '', 
																							clean_a22[139]);
	SELF := le;
end;
wDwell := project(p, getDwell(left));						

return wDwell;

end;