import _Control, doxie, ut, mdr, header, drivers, census_data, riskwise, VotersV2, 
	models, AID_Build;
onThor := _Control.Environment.OnThor;

export Boca_Shell_FCRA_Neutral_Function(grouped DATASET(Layout_output) iid,
								unsigned1 dppa, unsigned1 glb,
								boolean isUtility = false,
								boolean isLN=false,
								boolean includeRelativeInfo = true,
								boolean IsFCRA = FALSE,
								unsigned1 BSversion = 1, boolean nugen = false,
								string50 DataRestriction=iid_constants.default_DataRestriction,
								unsigned8 BSOptions
								) := function

glb_ok := glb > 0 and glb < 8 or glb=11 or glb=12;
dppa_ok := dppa > 0 and dppa < 8;

ids := GROUP(SORT(Risk_Indicators.Boca_Shell_Ids(iid, includeRelativeInfo, DataRestriction, BSOptions),seq),seq);

relrec := layout_bocashell_neutral;
relrecWRawAid := record
	layout_bocashell_neutral;
	unsigned8 rawaid_1 := 0;
	unsigned8 rawaid_2 := 0;
	unsigned8 rawaid_3 := 0;	
end;
// JRP 02/12/2008 - Dataset of actioncode and reasoncode settings which are passed to the getactioncodes and reasoncodes functions.
unsigned1 IIDVersion := 0;	// version 0 will not get the new v1 reason codes
reasoncode_settings := dataset([{nugen, IIDVersion}],riskwise.layouts.reasoncode_settings);

	

// Note: bool flag is set, if corrections exists (not necessarily used) for given record
// looks like it is safe doing here: this transform is used in all exec. paths
relrecWRawAid getBocaShell(Risk_Indicators.Layout_Output le) :=
TRANSFORM
	SELF.seq := le.seq;
	SELF.did := le.did;
	SELF.HistoryDate := le.historydate;
	SELF.ADLCategory := le.ADLCategory;
	SELF.trueDID := le.trueDID;

	SELF.Shell_Input := ROW(le,TRANSFORM(Layout_Input,SELF := LEFT));
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

	SELF.Available_Sources.DL := Risk_Indicators.Source_Available.DL(IF(le.dl_state<>'',le.dl_state,le.st)); 
  
  #IF(onThor)
     //if running on thor for bsversion >= 50, calculate in separate join to improve performance. Earlier versions are okay since they're checking set instead of key.
    SELF.Available_Sources.Voter := if(BSversion>=50, false,Risk_Indicators.Source_Available.VoterSrcSt(le.st, bsversion, isFCRA, le.historydate));
  #ELSE
    SELF.Available_Sources.Voter := Risk_Indicators.Source_Available.VoterSrcSt(le.st, bsversion, isFCRA, le.historydate); 
  #END

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
	en_eq_last_seen := MAX(le.adl_en_last_seen, le.adl_eqfs_last_seen);
	SELF.SSN_Verification.credit_first_seen := en_eq_first_seen;
	SELF.SSN_Verification.credit_last_seen := en_eq_last_seen;
	SELF.SSN_Verification.header_count := le.socscount;
	SELF.SSN_Verification.header_first_seen := ut.Min2(le.adl_other_first_seen, en_eq_first_seen);
	SELF.SSN_Verification.header_last_seen := MAX(le.adl_other_last_seen, en_eq_last_seen);
	
	
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
															(INTEGER)((string)SELF.SSN_Verification.Validation.high_issue_date)[1..4]);
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
	SELF.Velocity_Counters.adls_per_phone := if(isFCRA and bsversion>=50, 0, le.adls_per_phone); 
	SELF.Velocity_Counters.adls_per_phone_current := le.adls_per_phone_current; 
	SELF.Velocity_Counters.adls_per_phone_created_6months := le.adls_per_phone_created_6months;
	SELF.Velocity_Counters.ssns_per_adl := le.ssns_per_adl;
	SELF.Velocity_Counters.addrs_per_adl := le.addrs_per_adl;
	SELF.Velocity_Counters.phones_per_adl := le.phones_per_adl;
	SELF.Velocity_Counters.adls_per_addr := if(isFCRA and bsversion>=50, 0, le.adls_per_addr);
	SELF.Velocity_Counters.adls_per_addr_current := le.adls_per_addr_current;
	SELF.Velocity_Counters.ssns_per_addr := if(isFCRA and bsversion>=50, 0, le.ssns_per_addr);
	SELF.Velocity_Counters.ssns_per_addr_current := le.ssns_per_addr_current;
	SELF.Velocity_Counters.phones_per_addr := le.phones_per_addr;
	SELF.Velocity_Counters.phones_per_addr_current := le.phones_per_addr_current;
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
	// SELF.DL_Validation.valid := le.drlcvalflag='0';

	// Name Verification
	SELF.Name_Verification.adl_score := le.score;
	SELF.Name_Verification.fname_score := le.firstscore;
	SELF.Name_Verification.lname_score := le.lastscore;
	// multiple lnames according to lnames associated with ssn
	SELF.Name_Verification.lname_change_date := (unsigned3)le.altearly_date;
	SELF.Name_Verification.lname_prev_change_date := (unsigned3)le.altearly_date2;
	SELF.Name_Verification.source_count := MIN(le.firstcount,le.lastcount);
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
	SELF.Name_Verification.age := ut.Age((unsigned)le.verdob, (unsigned)risk_indicators.iid_constants.myGetDate(le.historydate));
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
	SELF.rawaid_1 := le.rawAid1;

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
	SELF.Address_Verification.Input_Address_Information.eda_sourced := inputbpicker(le.chronophone_namematch, le.chronophone2_namematch,le.chronophone3_namematch) BETWEEN 80 AND 100;
	SELF.Address_Verification.Input_Address_Information.utility_sourced := le.utiliaddr_addrcount>0;
	SELF.Address_Verification.Input_Address_Information.sources := '';	// blank because this is the same as iid.sources, addr hist 1 and 2 are populated

// for shell version 5.0, if the input address isn't 1 of the 3 addresses in the chronology, 
// populate the following fields from the new address sources summary section	
	input_address_sources := models.common.zip2(le.address_sources_summary.input_addr_sources, le.address_sources_summary.input_addr_sources_first_seen_date);

	// earliest_date := (unsigned)min(input_address_sources(str2<>'0'), (unsigned)str2);
	earliest_date := le.address_history_summary.input_addr_first_seen; // this field is only populated on version 4.0 and higher
	latest_date := le.address_history_summary.input_addr_last_seen;  // this field is only populated on version 4.0 and higher
	
	SELF.Address_Verification.Input_Address_Information.credit_sourced := if(whatsinput=0 and bsversion>=50,
		stringlib.stringfind(le.address_sources_summary.input_addr_sources, MDR.sourceTools.src_Equifax, 1) > 0,
		inputbpicker(le.chrono_eqfsaddrcount, le.chrono_eqfsaddrcount2,le.chrono_eqfsaddrcount3));
	SELF.Address_Verification.Input_Address_Information.dl_sourced := if(whatsinput=0 and bsversion>=50,
		models.common.findw_cpp(le.address_sources_summary.input_addr_sources, 'D' , ' ,', 'ie') > 0,
		inputbpicker(le.chrono_dladdrcount, le.chrono_dladdrcount2,le.chrono_dladdrcount3));
	SELF.Address_Verification.Input_Address_Information.voter_sourced := if(whatsinput=0 and bsversion>=50,
		stringlib.stringfind(le.address_sources_summary.input_addr_sources, 'EM', 1) > 0 or
		stringlib.stringfind(le.address_sources_summary.input_addr_sources, 'VO', 1) > 0,
		inputbpicker(le.chrono_emaddrcount,le.chrono_emaddrcount2,le.chrono_emaddrcount3));
	SELF.Address_Verification.Input_Address_Information.source_count := if(bsversion>=50, 
		count(input_address_sources),
		inputipicker(le.chrono_addrcount,le.chrono_addrcount2,le.chrono_addrcount3)+(INTEGER)SELF.Address_Verification.Input_Address_Information.eda_sourced );
	SELF.Address_Verification.Input_Address_Information.date_first_seen := if(whatsinput=0 and bsversion>=40,
		earliest_date,
		inputipicker(le.chronodate_first,le.chronodate_first2,le.chronodate_first3));
	SELF.Address_Verification.Input_Address_Information.date_last_seen := if(whatsinput=0 and bsversion>=40,
		latest_date,
		inputipicker(le.chronodate_last,le.chronodate_last2,le.chronodate_last3));
		
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

	VarisBestMatch1 := picker(le.chronoaddr_isBest,le.chronoaddr_isBest2 );
	SELF.Address_Verification.Address_History_1.isBestMatch := VarisBestMatch1;
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
	SELF.rawaid_2 := picker(le.rawAid1, le.rawAid2);	
	
	SELF.addrPop2 := picker(chrono_address1, chrono_address2) <>'';
	
	// get the addr_flags for the first address
	SELF.Address_Verification.addr_flags_1 := picker(le.chrono_addr_flags, le.chrono_addr_flags2);

//	in bsversion 5.0 and higher, don't ever take chrono3
	TakeThird := bsversion < 50 and (TakeSecond OR (le.prim_name=le.chronoprim_name2 AND le.prim_range=le.chronoprim_range2));
	picker2(field1,field2) := MACRO
		IF(TakeThird, field2, field1)
	ENDMACRO;

	// Next Next Recent Address
	SELF.Address_Verification.Address_History_2.isBestMatch := picker2(le.chronoaddr_isBest2,le.chronoaddr_isBest3);
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
	SELF.rawaid_3 := picker2(le.rawAid2, le.rawAid3);	

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
																		if(VarisBestMatch1=false and bsversion>=50,0, round((ut.DaysApart((string)self.address_verification.address_history_1.date_first_seen, 
																												(string)self.address_verification.address_history_1.date_last_seen)) / 30)), 
																 0);
	
	self.lres3 := if(self.address_verification.address_history_2.date_first_seen <> 0 and self.address_verification.address_history_2.date_last_seen <> 0,
																		round((ut.DaysApart((string)self.address_verification.address_history_2.date_first_seen, 
																												(string)self.address_verification.address_history_2.date_last_seen)) / 30), 
																 0);
	
	
	// in shell 5.0 and higher, this max_lres and avg_lres are set inside of boca_shell_address_occupancy function instead and overwrites what is done here
	SELF.Other_Address_Info.max_lres := MAX(MAX(self.lres, self.lres2), self.lres3);
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
								MIN((INTEGER) ut.zip_Dist(SELF.Address_Verification.Input_Address_Information.zip5,
													SELF.Address_Verification.Address_History_1.zip5), 9998));
	SELF.Address_Verification.distance_in_2_h2 := 
				IF(SELF.Address_Verification.Input_Address_Information.zip5='' 
						OR SELF.Address_Verification.Address_History_2.zip5='', 9999,
								MIN((INTEGER) ut.zip_Dist(SELF.Address_Verification.Input_Address_Information.zip5,
													SELF.Address_Verification.Address_History_2.zip5), 9998));
	SELF.Address_Verification.distance_h1_2_h2 := 
				IF(SELF.Address_Verification.Address_History_1.zip5=''
						OR SELF.Address_Verification.Address_History_2.zip5='', 9999, 
								MIN((INTEGER) ut.zip_Dist(SELF.Address_Verification.Address_History_1.zip5,
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

p_tmp_noThorDL := PROJECT(iid, getBocaShell(LEFT));

p_tmp_thor_50 := JOIN(p_tmp_noThorDL, VotersV2.Key_Voters_States(isFCRA), 
									 LEFT.Address_Verification.Input_Address_Information.st = RIGHT.state and
									 RIGHT.date_first_seen[1..6] < Risk_Indicators.iid_constants.myGetDate(LEFT.historydate)[1..6],
									 TRANSFORM(relrecWRawAid,
									 SELF.Available_Sources.Voter := RIGHT.state <> '';
									 SELF := LEFT), LEFT OUTER, LOOKUP);
									 
#IF(onThor)
	p_tmp := group(sort(if(BSversion>=50,p_tmp_thor_50, p_tmp_noThorDL) , seq), seq);
#ELSE
	p_tmp := group(sort(p_tmp_noThorDL , seq), seq);
#END

p:=project(p_tmp, transform(relrec, self := left));

aid_key := AID_Build.Key_AID_Base;
aid_layout := record
	recordOf(relrecWRawAid);
	typeOf(AID_Build.Key_AID_Base.rec_type) AH1_rec_type;
	typeOf(AID_Build.Key_AID_Base.err_stat) AH1_err_stat;
	typeOf(AID_Build.Key_AID_Base.rec_type) AH2_rec_type;
	typeOf(AID_Build.Key_AID_Base.err_stat) AH2_err_stat;
end;

aid_layout getRawAid1(p_tmp le, aid_key ri) := transform
	self.AH1_rec_type := ri.rec_type;//Address_History_1
	self.AH1_err_stat := ri.err_stat;//Address_History_1
	self.AH2_rec_type := '';//Address_History_2
	self.AH2_err_stat := '';//Address_History_2
	self := le;
END;

RawAid_addrHist1_roxie := join(p_tmp, aid_key,
										left.rawAid_2 != 0 and keyed(left.rawAid_2 = right.rawaid),
										getRawAid1(LEFT, RIGHT), left outer, 
										atmost(riskwise.max_atmost), keep(1));
		
RawAid_addrHist1_thor_pre := join(distribute(p_tmp(rawAid_2 != 0), hash64(rawAid_2)), 
										distribute(pull(aid_key), hash64(rawaid)),
										(left.rawAid_2 = right.rawaid),
										getRawAid1(LEFT, RIGHT), left outer, 
										atmost(riskwise.max_atmost), keep(1), local); 

RawAid_addrHist1_thor := group(sort(RawAid_addrHist1_thor_pre + project(p_tmp(rawAid_2 = 0), transform(aid_layout, self := left, self := [])), seq), seq);

#IF(onThor)
	RawAid_addrHist1 := RawAid_addrHist1_thor;
#ELSE
	RawAid_addrHist1 := RawAid_addrHist1_roxie;
#END

aid_layout getRawAid(RawAid_addrHist1 le, aid_key ri) := transform
	self.AH1_rec_type := le.AH1_rec_type;//Address_History_1
	self.AH1_err_stat := le.AH1_err_stat;//Address_History_1
	self.AH2_rec_type := ri.rec_type;//Address_History_2
	self.AH2_err_stat := ri.err_stat;//Address_History_2
	self := le;
END;

RawAid_addrHist_roxie := join(RawAid_addrHist1, aid_key,
										left.rawaid_3 != 0 and keyed(left.rawaid_3 = right.rawaid),
										getRawAid(LEFT, RIGHT), left outer, 
										atmost(riskwise.max_atmost), keep(1));

RawAid_addrHist_thor_pre := join(distribute(RawAid_addrHist1(rawaid_3 != 0), hash64(rawaid_3)), 
										distribute(pull(aid_key), hash64(rawaid)),
										(left.rawaid_3 = right.rawaid),
										getRawAid(LEFT, RIGHT), left outer, 
										atmost(riskwise.max_atmost), keep(1), local);

RawAid_addrHist_thor := group(sort(RawAid_addrHist_thor_pre + RawAid_addrHist1(rawaid_3 = 0), seq), seq);

#IF(onThor)
	RawAid_addrHist := RawAid_addrHist_thor;
#ELSE
	RawAid_addrHist := RawAid_addrHist_roxie;
#END

relrec getDwell(RawAid_addrHist le) := transform
	// get dwelltype for address history 1
	a1_val := Risk_Indicators.MOD_AddressClean.street_address('',le.address_verification.address_history_1.prim_range,le.address_verification.address_history_1.predir,
																				le.address_verification.address_history_1.prim_name,le.address_verification.address_history_1.addr_suffix,
																				le.address_verification.address_history_1.postdir,le.address_verification.address_history_1.unit_desig,
																				le.address_verification.address_history_1.sec_range);
	
	invalidSet := ['E101','E212','E213','E214','E216','E302','E412','E413','E420','E421','E423','E500','E501','E502','E503','E600'];	// added E600 6/6/2005 per Jim C.

	a1Override := trim(le.address_verification.addr_flags_1.dwelltype)<>'';	// means there was a correction to this address
	
	SELF.Address_Verification.addr_type2 := map(a1Override => le.address_verification.addr_flags_1.dwelltype,
																							le.AH1_rec_type = 'S' and le.AH1_err_stat in invalidSet => '', 
																							le.AH1_rec_type);
	
	// get dwelltype for address history 2
	a1_val2 := Risk_Indicators.MOD_AddressClean.street_address('',le.address_verification.address_history_2.prim_range,le.address_verification.address_history_2.predir,
																				le.address_verification.address_history_2.prim_name,le.address_verification.address_history_2.addr_suffix,
																				le.address_verification.address_history_2.postdir,le.address_verification.address_history_2.unit_desig,
																				le.address_verification.address_history_2.sec_range);
	
																				
	a2Override := trim(le.address_verification.addr_flags_2.dwelltype)<>'';	// means there was a correction to this address
	
	SELF.Address_Verification.addr_type3 := map(a2Override => le.address_verification.addr_flags_2.dwelltype,
																							le.AH2_rec_type = 'S' and le.AH2_err_stat in invalidSet => '', 
																							le.AH2_rec_type);
	SELF := le;
end;
wDwell_rawaid := project(RawAid_addrHist, getDwell(left));						

wDwell := if(BSversion>1, wDwell_rawaid, p);										
										
// Get apartment count for boca shell 3
relrec addAptCount(wDwell le, header.Key_AptBuildings ri) := transform
	SELF.Address_Verification.Input_Address_Information.unit_count := ri.apt_cnt;
	SELF := le;
end;
useExperianFCRA := DataRestriction[Risk_Indicators.iid_constants.posExperianFCRARestriction]=Risk_Indicators.iid_constants.sFalse;	// if not restricted then use EN

AptBuilding_Key := if(isFCRA, If(useExperianFCRA, doxie.Key_FCRA_EN_AptBuildings, doxie.Key_FCRA_AptBuildings), header.Key_AptBuildings);

wAptCount_roxie := group(sort(join(wDwell, AptBuilding_Key,	
								trim(left.shell_input.prim_name)<>'' and
								keyed(left.shell_input.prim_range=right.prim_range) and 
								keyed(left.shell_input.prim_name=right.prim_name) and
								keyed(left.shell_input.z5=right.zip) and 
								keyed(left.shell_input.addr_suffix=right.suffix) and 
								keyed(left.shell_input.predir=right.predir),
								addAptCount(left,right), left outer, atmost(riskwise.max_atmost), keep(1)),seq),seq);

wAptCount_thor_addr := join(distribute(wDwell(trim(shell_input.prim_name)<>''), hash64(shell_input.prim_range, shell_input.prim_name, shell_input.z5)), 
								distribute(pull(AptBuilding_Key), hash64(prim_range, prim_name,zip)),	
								(left.shell_input.prim_range=right.prim_range) and 
								(left.shell_input.prim_name=right.prim_name) and
								(left.shell_input.z5=right.zip) and 
								(left.shell_input.addr_suffix=right.suffix) and 
								(left.shell_input.predir=right.predir),
								addAptCount(left,right), left outer, atmost(riskwise.max_atmost), keep(1), LOCAL);
wAptCount_thor := group(sort(wAptCount_thor_addr + wDwell(trim(shell_input.prim_name)=''),seq),seq);

#IF(onThor)
	wAptCount := if(BSversion>2, wAptCount_thor, wDwell);
#ELSE
	wAptCount := if(BSversion>2, wAptCount_roxie, wDwell);
#END


// get infutor by phone for bocashell 3
infutor_phone := if(BSversion>2, Risk_Indicators.Boca_Shell_Infutor_phone(wAptCount, isFCRA, BSVersion), wAptCount);	

												
// get accident data for boca shell 3 - not for FCRA
acc := Risk_Indicators.Boca_Shell_Accident(infutor_phone, BSversion);

															
// try getting foreclosure index - not for FCRA
relrec getFI12(relrec le, Risk_Indicators.Key_FI_Module.key_fi_geo12 ri, unsigned c) := transform
	self.Address_Verification.Input_Address_Information.geo12_fc_index := if(c=1, ri.geo12_index, le.Address_Verification.Input_Address_Information.geo12_fc_index);
	self.Address_Verification.Address_History_1.geo12_fc_index := if(c=4, ri.geo12_index, le.Address_Verification.Address_History_1.geo12_fc_index);
	self.Address_Verification.Address_History_2.geo12_fc_index := if(c=7, ri.geo12_index, le.Address_Verification.Address_History_2.geo12_fc_index);
	self := le;
end;
relrec getFI11(relrec le, Risk_Indicators.Key_FI_Module.key_fi_geo11 ri, unsigned c) := transform
	self.Address_Verification.Input_Address_Information.geo11_fc_index := if(c=2, ri.geo11_index, le.Address_Verification.Input_Address_Information.geo11_fc_index);
	self.Address_Verification.Address_History_1.geo11_fc_index := if(c=5, ri.geo11_index, le.Address_Verification.Address_History_1.geo11_fc_index);
	self.Address_Verification.Address_History_2.geo11_fc_index := if(c=8, ri.geo11_index, le.Address_Verification.Address_History_2.geo11_fc_index);
	self := le;
end;
relrec getFIfips(relrec le, Risk_Indicators.Key_FI_Module.key_fi_fips ri, unsigned c) := transform
	self.Address_Verification.Input_Address_Information.fips_fc_index := if(c=3, ri.fips_index, le.Address_Verification.Input_Address_Information.fips_fc_index); 
	self.Address_Verification.Address_History_1.fips_fc_index := if(c=6, ri.fips_index, le.Address_Verification.Address_History_1.fips_fc_index); 
	self.Address_Verification.Address_History_2.fips_fc_index := if(c=9, ri.fips_index, le.Address_Verification.Address_History_2.fips_fc_index); 
	self := le;
end;
// get input address foreclosure indices
wPropGeo12 := join(acc, Risk_Indicators.Key_FI_Module.key_fi_geo12, 	
											left.address_verification.input_address_information.st<>'' and left.address_verification.input_address_information.county<>'' and left.address_verification.input_address_information.geo_blk<>'' and
											keyed(left.address_verification.input_address_information.st+left.address_verification.input_address_information.county+left.address_verification.input_address_information.geo_blk=right.geo12),
											getFI12(left,right,1), left outer, atmost(riskwise.max_atmost), keep(1));

wPropGeo11 := join(wPropGeo12, Risk_Indicators.Key_FI_Module.key_fi_geo11, 
											left.address_verification.input_address_information.st<>'' and left.address_verification.input_address_information.county<>'' and left.address_verification.input_address_information.geo_blk<>'' and
											keyed(left.address_verification.input_address_information.st+left.address_verification.input_address_information.county+left.address_verification.input_address_information.geo_blk[1..6]=right.geo11),
											getFI11(left,right,2), left outer, atmost(riskwise.max_atmost), keep(1));

wPropfips := join(wPropGeo11, Risk_Indicators.Key_FI_Module.key_fi_fips, 
											left.address_verification.input_address_information.st<>'' and left.address_verification.input_address_information.county<>'' and
											keyed(left.address_verification.input_address_information.st+left.address_verification.input_address_information.county=right.fips),
											getFIfips(left,right,3), left outer, atmost(riskwise.max_atmost), keep(1));
											
// get address history 1 foreclosure indices										
wPropGeo12_2 := join(wPropfips, Risk_Indicators.Key_FI_Module.key_fi_geo12, 
											left.address_verification.address_history_1.st<>'' and left.address_verification.address_history_1.county<>'' and left.address_verification.address_history_1.geo_blk<>'' and
											keyed(left.address_verification.address_history_1.st+left.address_verification.address_history_1.county+left.address_verification.address_history_1.geo_blk=right.geo12),
											getFI12(left,right,4), left outer, atmost(riskwise.max_atmost), keep(1));
wPropGeo11_2 := join(wPropGeo12_2, Risk_Indicators.Key_FI_Module.key_fi_geo11, 
											left.address_verification.address_history_1.st<>'' and left.address_verification.address_history_1.county<>'' and left.address_verification.address_history_1.geo_blk<>'' and
											keyed(left.address_verification.address_history_1.st+left.address_verification.address_history_1.county+left.address_verification.address_history_1.geo_blk[1..6]=right.geo11),
											getFI11(left,right,5), left outer, atmost(riskwise.max_atmost), keep(1));
wPropfips_2 := join(wPropGeo11_2, Risk_Indicators.Key_FI_Module.key_fi_fips, 
											left.address_verification.address_history_1.st<>'' and left.address_verification.address_history_1.county<>'' and
											keyed(left.address_verification.address_history_1.st+left.address_verification.address_history_1.county=right.fips),
											getFIfips(left,right,6), left outer, atmost(riskwise.max_atmost), keep(1));

// get address history 2 foreclosure indices
wPropGeo12_3 := join(wPropfips_2, Risk_Indicators.Key_FI_Module.key_fi_geo12, 
											left.address_verification.address_history_2.st<>'' and left.address_verification.address_history_2.county<>'' and left.address_verification.address_history_2.geo_blk<>'' and
											keyed(left.address_verification.address_history_2.st+left.address_verification.address_history_2.county+left.address_verification.address_history_2.geo_blk=right.geo12),
											getFI12(left,right,7), left outer, atmost(riskwise.max_atmost), keep(1));
wPropGeo11_3 := join(wPropGeo12_3, Risk_Indicators.Key_FI_Module.key_fi_geo11, 
											left.address_verification.address_history_2.st<>'' and left.address_verification.address_history_2.county<>'' and left.address_verification.address_history_2.geo_blk<>'' and
											keyed(left.address_verification.address_history_2.st+left.address_verification.address_history_2.county+left.address_verification.address_history_2.geo_blk[1..6]=right.geo11),
											getFI11(left,right,8), left outer, atmost(riskwise.max_atmost), keep(1));
wPropfips_3 := join(wPropGeo11_3, Risk_Indicators.Key_FI_Module.key_fi_fips, 
											left.address_verification.address_history_2.st<>'' and left.address_verification.address_history_2.county<>'' and
											keyed(left.address_verification.address_history_2.st+left.address_verification.address_history_2.county=right.fips),
											getFIfips(left,right,9), left outer, atmost(riskwise.max_atmost), keep(1));
											

wPropFip := if(isFCRA or BSversion<=2, infutor_phone, wPropfips_3);	// dont use foreclosure index or acc for FCRA	or bocashell versions <= 2													



// add utility logic here for boca shell 3
wUtil := if(IsFCRA or BSversion<=2, wPropFip, Risk_Indicators.Boca_Shell_Utility(wPropFip, glb, isFCRA, bsversion));		// don't get utility for FCRA		// don't get utility for FCRA

relrec combo_p_and_id(relrec L, ids R) := transform
	// we want layout_overrides from the left, so dont do a self := R anymore because the overrides are empty on the right side
	// these are the only fields on the right that are not override fields
	self.seq := r.seq;
	self.historydate := r.historydate;
	self.did := r.did;
	self.isrelat := r.isrelat;
	self.fname := r.fname;
	self.lname := r.lname;
	self.relation := r.relation;
	self := L;
end;

pre_relatives_roxie := join(wUtil, ids, left.seq = right.seq, combo_p_and_id(LEFT,RIGHT), many lookup, left outer);
pre_relatives_thor := group(sort(join(distribute(wUtil, hash64(seq)), 
													 distribute(ids, hash64(seq)), 
													 left.seq = right.seq, combo_p_and_id(LEFT,RIGHT), left outer, local), seq, local), seq, local);

#IF(onThor)
	pre_relatives := pre_relatives_thor;
#ELSE
	pre_relatives := pre_relatives_roxie;
#END

// slimmed down the layout to reduce the memory usage in this bit of code, don't need full bocashell layout to calculate the relatives flags
relatives_slim := record
	relrec.seq;
	relrec.historydate;
	relrec.did;
	relrec.isrelat;
	relrec.relation;
	relrec.fname;
	relrec.lname;
	relrec.shell_input shell_input;
	relrec.relatives_at_input_address;
	relrec.zip5;
	relrec.state;
	relrec.county;
	relrec.geo_blk;
	relrec.age;
	relrec.dt_first_seen;
	relrec.dt_last_seen;
	unsigned1 relative_suspicious_identities_count;
	unsigned1 relative_bureau_only_count;
	unsigned1 relative_bureau_only_count_created_1month;
	unsigned1 relative_bureau_only_count_created_6months;
end;
																									
ds_max := choosen(doxie.key_max_dt_last_seen, 1);
hdr_max_dt_last_seen := if(isFCRA, '0', ((string)ds_max[1].max_date_last_seen)[1..6]+'01' );
// this is the same as iid_constants.myGetDate with the exception of using hdr_max_dt_last_seen instead of ut.GetDate
relative_myGetDate(unsigned3 history_date) := IF(history_date=999999,
																									hdr_max_dt_last_seen,
																									min(hdr_max_dt_last_seen, risk_indicators.iid_constants.full_history_date(history_date) )
																									);																							
relativeDaysApart(string8 full_history_date, string8 d2) := ut.DaysApart(full_history_date,d2) <= 62 OR (unsigned)d2 >= (unsigned)full_history_date;	
relatives_slim get_relat_info(pre_relatives le, doxie.Key_Header ri) :=
TRANSFORM
	dt := MAP(ri.dt_last_seen<>0 => ri.dt_last_seen, 
						ri.dt_vendor_last_reported<>0 => ri.dt_vendor_last_reported,
						ri.dt_first_seen<>0 => ri.dt_first_seen,
						ri.dt_vendor_first_reported);
					
	SELF.relatives_at_input_address := if(le.shell_input.prim_range=ri.prim_range and 
																						ut.NNEQ(le.shell_input.sec_range,ri.sec_range) and 
																						relativeDaysApart(relative_myGetDate(le.historydate),((STRING6)dt+'31')), 1, 0);
																						
	SELF.zip5 := ri.zip;
	SELF.state := ri.st;
	SELF.county := ri.county;
	SELF.geo_blk := ri.geo_blk;
	SELF.age := ut.Age(ri.dob);
	SELF.dt_first_seen := ri.dt_first_seen;
	SELF.dt_last_seen := ri.dt_last_seen;
	SELF := le;
END;

			
idheader1_roxie :=  JOIN(pre_relatives(isrelat), doxie.Key_Header, 
														keyed(LEFT.did=RIGHT.s_did) AND
														right.src not in iid_constants.masked_header_sources(DataRestriction, isFCRA) AND 
														RIGHT.dt_first_seen < left.historydate AND
														// check permissions	
														(~mdr.Source_is_Utility(RIGHT.src) OR ~isUtility)	AND
														(header.isPreGLB_LIB(RIGHT.dt_nonglb_last_seen, 
																								 RIGHT.dt_first_seen, 
																								 RIGHT.src, 
																								 DataRestriction) OR glb_ok) AND
														(~mdr.Source_is_DPPA(RIGHT.src) OR
															(dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src),dppa,RIGHT.src))) AND
														~risk_indicators.iid_constants.filtered_source(right.src, right.st) AND
														(ut.DaysApart(((STRING6)RIGHT.dt_last_seen)+'01',iid_constants.myGetDate(left.historydate))<=365 OR RIGHT.dt_last_seen >= left.historydate), 
														get_relat_info(LEFT,RIGHT), LEFT OUTER, KEEP(30),atmost(ut.limits.HEADER_PER_DID));

idheader1_thor :=  group(sort(JOIN(distribute(pre_relatives(isrelat), hash64(did)), 
														distribute(pull(doxie.Key_Header), hash64(s_did)), 
														LEFT.did=RIGHT.s_did AND
														right.src not in iid_constants.masked_header_sources(DataRestriction, isFCRA) AND 
														RIGHT.dt_first_seen < left.historydate AND
														// check permissions	
														(~mdr.Source_is_Utility(RIGHT.src) OR ~isUtility)	AND
														(header.isPreGLB_LIB(RIGHT.dt_nonglb_last_seen, 
																								 RIGHT.dt_first_seen, 
																								 RIGHT.src, 
																								 DataRestriction) OR glb_ok) AND
														(~mdr.Source_is_DPPA(RIGHT.src) OR
															(dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src),dppa,RIGHT.src))) AND
														~risk_indicators.iid_constants.filtered_source(right.src, right.st) AND
														(ut.DaysApart(((STRING6)RIGHT.dt_last_seen)+'01',iid_constants.myGetDate(left.historydate))<=365 OR RIGHT.dt_last_seen >= left.historydate), 
														get_relat_info(LEFT,RIGHT), LEFT OUTER, KEEP(30),atmost(ut.limits.HEADER_PER_DID), LOCAL),seq),seq);

#IF(onThor)
	idheader1 := idheader1_thor;
#ELSE
	idheader1 := idheader1_roxie;
#END

// idheader := if(isFCRA, pre_relatives(isrelat), idheader1);	// dont call the header for fcra because there will never be a relative
idheader := idheader1;	// dont call the header for fcra because there will never be a relative
	
relatives_slim rollme(relatives_slim le, relatives_slim ri) :=
TRANSFORM
	SELF.dt_first_seen := ut.Min2(le.dt_first_seen,ri.dt_first_seen);
	SELF.dt_last_seen := ut.Min2(le.dt_last_seen,ri.dt_last_seen);
	SELF.age := MAX(le.age, ri.age);
	SELF.relatives_at_input_address := le.relatives_at_input_address+
																					if(le.did<>ri.did,ri.relatives_at_input_address,0);
	SELF := le;
END;
						 
idroll_slim := ROLLUP(SORT(idheader,did, state, zip5, county, geo_blk, -relatives_at_input_address),rollme(LEFT,RIGHT),
						 did, state, zip5, county, geo_blk);


// send all relatives through the suspicious_identities_function to see if any of them are suspicious
relative_adls := project(pre_relatives(isrelat), 
	transform(risk_indicators.Boca_Shell_Fraud.layout_identities_input, self.did := left.did;
							 self.historydate := left.historydate;));

suspicious_identities_hist := risk_indicators.Boca_Shell_Fraud.suspicious_identities_function_hist(ungroup(relative_adls));

// if realtime production mode, search just the suspicious Identities key instead
risk_indicators.Boca_Shell_Fraud.layout_identities_output getSuspiciousIds(relative_adls le, Risk_Indicators.Key_Suspicious_Identities ri) := TRANSFORM
	self.did := le.did;
	self.historydate := le.historydate;
	self := ri;
END;

suspicious_identities_realtime_roxie := join(relative_adls, Risk_Indicators.Key_Suspicious_Identities,
	keyed(left.did=right.did),
		getSuspiciousIds(LEFT,RIGHT), atmost(riskwise.max_atmost), keep(1));

suspicious_identities_realtime_thor := group(sort(join(distribute(relative_adls, hash64(did)), 
	distribute(pull(Risk_Indicators.Key_Suspicious_Identities), hash64(did)),
	(left.did=right.did),
	getSuspiciousIds(LEFT,RIGHT), atmost(riskwise.max_atmost), keep(1), LOCAL),did),did);
			
#IF(onThor)
	suspicious_identities_realtime := suspicious_identities_realtime_thor;
#ELSE
	suspicious_identities_realtime := suspicious_identities_realtime_roxie;
#END

// check the first record in the batch to determine if this a realtime transaction or an archive test
// if the record is default_history_date or same month as today, run production_realtime_mode
production_realtime_mode := relative_adls[1].historydate=risk_indicators.iid_constants.default_history_date or
	relative_adls[1].historydate = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..6]);	suspicious_identities := if(production_realtime_mode, ungroup(suspicious_identities_realtime), suspicious_identities_hist);

relatives_with_suspcious_ids := join(idroll_slim, suspicious_identities, 
															left.did=right.did, 
															transform(relatives_slim,
															self.relative_suspicious_identities_count := if(right.did<>0, 1, 0);
															self.relative_bureau_only_count := if(right.bureau_only, 1, 0);
															self.relative_bureau_only_count_created_1month := if(right.bureau_only_last_1month, 1, 0);
															self.relative_bureau_only_count_created_6months := if(right.bureau_only_last_6months, 1, 0);	
															self := left), left outer, atmost(riskwise.max_atmost), keep(1));

isFraudpoint :=  (BSOptions & iid_constants.BSOptions.IncludeFraudVelocity) > 0;

// idroll := if(isFCRA, group(idroll_slim,seq), if(isFraudPoint, group(relatives_with_suspcious_ids, seq), group(idroll_slim,seq)));

idroll := if(isFCRA, group(idroll_slim, seq), if(isFraudpoint or bsversion>=41, group(relatives_with_suspcious_ids, seq), group(idroll_slim,seq)));

relrec get_census(relatives_slim le, Census_Data.Key_Smart_Jury ri) :=
TRANSFORM
	SELF.census_age := ri.age;
	SELF.census_income := ri.income;
	SELF.census_home_value := ri.home_value;
	SELF.census_education := ri.education;
	
	income := (INTEGER)ri.income;
	self.AMLIncome := (INTEGER)ri.income;
	SELF.relative_incomeUnder25_count := (INTEGER)(income < 25000);
	SELF.relative_incomeUnder50_count := (INTEGER)(income BETWEEN 25000 AND 50000 AND income<>50000);
	SELF.relative_incomeUnder75_count := (INTEGER)(income BETWEEN 50000 AND 75000 AND income<>75000);
	SELF.relative_incomeUnder100_count := (INTEGER)(income BETWEEN 75000 AND 100000 AND income<>100000);
	SELF.relative_incomeOver100_count := (INTEGER)(income >= 100000);
	
	home_value := (INTEGER)ri.home_value;
	
	SELF.relative_homeUnder50_count := (INTEGER)(home_value < 50000);
	SELF.relative_homeUnder100_count := (INTEGER)(home_value BETWEEN 50000 AND 100000 AND home_value<>100000);
	SELF.relative_homeUnder150_count := (INTEGER)(home_value BETWEEN 100000 AND 150000 AND home_value<>150000);
	SELF.relative_homeUnder200_count := (INTEGER)(home_value BETWEEN 150000 AND 200000 AND home_value<>200000);
	SELF.relative_homeUnder300_count := (INTEGER)(home_value BETWEEN 200000 AND 300000 AND home_value<>300000);
	SELF.relative_homeUnder500_count := (INTEGER)(home_value BETWEEN 300000 AND 500000 AND home_value<>500000);
	SELF.relative_homeOver500_count := (INTEGER)(home_value >= 500000);
	
	education := (INTEGER)ri.education;
	
	SELF.relative_educationUnder8_count := (INTEGER)(education < 8);
	SELF.relative_educationUnder12_count := (INTEGER)(education BETWEEN 8 AND 12 AND education<>12);
	SELF.relative_educationOver12_count := (INTEGER)(education >= 12);
	
	age := (INTEGER)ri.age;
	
	SELF.relative_ageUnder20_count := (INTEGER)(age < 20);
	SELF.relative_ageUnder30_count := (INTEGER)(age BETWEEN 20 AND 30 AND age<>30);
	SELF.relative_ageUnder40_count := (INTEGER)(age BETWEEN 30 AND 40 AND age<>40);
	SELF.relative_ageUnder50_count := (INTEGER)(age BETWEEN 40 AND 50 AND age<>50);
	SELF.relative_ageUnder60_count := (INTEGER)(age BETWEEN 50 AND 60 AND age<>60);
	SELF.relative_ageUnder70_count := (INTEGER)(age BETWEEN 60 AND 70 AND age<>70);
	SELF.relative_ageOver70_count := (INTEGER)(age >= 70);
	
	self.census_loose1 := true;
	self.census_loose2 := true;
	self.census_loose3 := true;
	self.relation := le.relation;
	SELF := le;
	self := [];
END;

idcensus := JOIN(idroll, 
			  Census_Data.Key_Smart_Jury, 	
				keyed(LEFT.state = RIGHT.stusab) and 
				keyed(left.county = right.county) and
				keyed(left.geo_blk[1..6] = right.tract) and 
				keyed(left.geo_blk[7] = right.blkgrp),
			   get_census(LEFT,RIGHT), KEEP(1), LEFT OUTER) + pre_relatives(~isrelat);
											

JustIds :=  group(project(idcensus,  transform(doxie.layout_references,
																				 self.did := left.did)));

PossIncarceration :=  Risk_Indicators.Collection_Shell_MOD.getIncarceration(JustIds);

idsPosIncar :=  group(join(idcensus, PossIncarceration,
                     left.did=right.did,
										 transform(relrec,
										          self.AMLPossIncarceration := if((string)right.incarceration_flag='', '0', right.incarceration_flag) ,
															self := left),
										left outer), seq);
																		


relrec get_property_census(relrec le, Census_Data.Key_Smart_Jury ri, integer select, boolean loose) :=
TRANSFORM
	census_age := choose(select,
						IF(le.Address_Verification.Input_Address_Information.census_age<>''	OR (loose AND le.Address_Verification.Input_Address_Information.geo_blk[1..6]<ri.tract),
							le.Address_Verification.Input_Address_Information.census_age,ri.age),
						IF(le.Address_Verification.Address_History_1.census_age<>''	OR (loose AND le.Address_Verification.Address_History_1.geo_blk[1..6]<ri.tract),
							le.Address_Verification.Address_History_1.census_age,ri.age),
						IF(le.Address_Verification.Address_History_2.census_age<>''	OR (loose AND le.Address_Verification.Address_History_2.geo_blk[1..6]<ri.tract),
							le.Address_Verification.Address_History_2.census_age,ri.age));
	census_income := choose(select,
						IF(le.Address_Verification.Input_Address_Information.census_income<>'' OR (loose AND le.Address_Verification.Input_Address_Information.geo_blk[1..6]<ri.tract),
							le.Address_Verification.Input_Address_Information.census_income,ri.income),
						IF(le.Address_Verification.Address_History_1.census_income<>'' OR (loose AND le.Address_Verification.Address_History_1.geo_blk[1..6]<ri.tract),
							le.Address_Verification.Address_History_1.census_income,ri.income),
						IF(le.Address_Verification.Address_History_2.census_income<>'' OR (loose AND le.Address_Verification.Address_History_2.geo_blk[1..6]<ri.tract),
							le.Address_Verification.Address_History_2.census_income,ri.income));
	census_home_value := choose(select,
						IF(le.Address_Verification.Input_Address_Information.census_home_value<>'' OR (loose AND le.Address_Verification.Input_Address_Information.geo_blk[1..6]<ri.tract),
							le.Address_Verification.Input_Address_Information.census_home_value,ri.home_value),
						IF(le.Address_Verification.Address_History_1.census_home_value<>'' OR (loose AND le.Address_Verification.Address_History_1.geo_blk[1..6]<ri.tract),
							le.Address_Verification.Address_History_1.census_home_value,ri.home_value),
						IF(le.Address_Verification.Address_History_2.census_home_value<>'' OR (loose AND le.Address_Verification.Address_History_2.geo_blk[1..6]<ri.tract),
							le.Address_Verification.Address_History_2.census_home_value,ri.home_value));
	census_education := choose(select,
						IF(le.Address_Verification.Input_Address_Information.census_education<>'' OR (loose AND le.Address_Verification.Input_Address_Information.geo_blk[1..6]<ri.tract),
							le.Address_Verification.Input_Address_Information.census_education,ri.education),
						IF(le.Address_Verification.Address_History_1.census_education<>'' OR (loose AND le.Address_Verification.Address_History_1.geo_blk[1..6]<ri.tract),
							le.Address_Verification.Address_History_1.census_education,ri.education),
						IF(le.Address_Verification.Address_History_2.census_education<>'' OR (loose AND le.Address_Verification.Address_History_2.geo_blk[1..6]<ri.tract),
							le.Address_Verification.Address_History_2.census_education,ri.education));
	self.census_loose1 := if (select = 1, 
						IF(le.census_loose1=TRUE AND le.Address_Verification.Input_Address_Information.st=ri.stusab, 
							loose, 
							le.census_loose1), le.census_loose1);
	self.census_loose2 := if (select = 2,
						IF(le.census_loose2=TRUE AND le.Address_Verification.Address_History_1.st=ri.stusab, 
							loose, 
							le.census_loose2), le.census_loose2);
	self.census_loose3 := if (select = 3,
						IF(le.census_loose3=TRUE AND le.Address_Verification.Address_History_2.st=ri.stusab, 
							loose, 
							le.census_loose3), le.census_loose3);
	
	SELF.Address_Verification.Input_Address_Information.census_age := if (select = 1, census_age, LE.Address_Verification.Input_Address_Information.census_age);
	SELF.Address_Verification.Input_Address_Information.census_income := if (select = 1, census_income, LE.Address_Verification.Input_Address_Information.census_income);
	SELF.Address_Verification.Input_Address_Information.census_home_value := if (select = 1, census_home_value, LE.Address_Verification.Input_Address_Information.census_home_value);	
	SELF.Address_Verification.Input_Address_Information.census_education := if (select = 1, census_education, LE.Address_Verification.Input_Address_Information.census_education);	
	SELF.Address_Verification.Input_Address_Information.full_match := if (select = 1, (~self.census_loose1) AND census_age<>'', LE.Address_Verification.Input_Address_Information.full_match);
	SELF.Address_Verification.Address_History_1.census_age := if (select = 2, census_age, LE.Address_Verification.Address_History_1.census_age);
	SELF.Address_Verification.Address_History_1.census_income := if (select = 2, census_income, LE.Address_Verification.Address_History_1.census_income);
	SELF.Address_Verification.Address_History_1.census_home_value := if (select = 2 , census_home_value, LE.Address_Verification.Address_History_1.census_home_value);
	SELF.Address_Verification.Address_History_1.census_education := if (select = 2, census_education, LE.Address_Verification.Address_History_1.census_education);
	SELF.Address_Verification.Address_History_1.full_match := if (select = 2, ~self.census_loose2, LE.Address_Verification.Address_History_1.full_match);
	SELF.Address_Verification.Address_History_2.census_age := if (select = 3, census_age, LE.Address_Verification.Address_History_2.census_age);
	SELF.Address_Verification.Address_History_2.census_income := if (select = 3, census_income, LE.Address_Verification.Address_History_2.census_income);
	SELF.Address_Verification.Address_History_2.census_home_value := if (select = 3, census_home_value, LE.Address_Verification.Address_History_2.census_home_value);
	SELF.Address_Verification.Address_History_2.census_education := if (select = 3, census_education, LE.Address_Verification.Address_History_2.census_education);
	SELF.Address_Verification.Address_History_2.full_match := if (select = 3, ~self.census_loose3, LE.Address_Verification.Address_History_2.full_match);
	SELF := le;
END;

Dist_Smart_Jury := distribute(pull(Census_Data.Key_Smart_Jury), hash64(stusab, county, tract[1..4]));

Property_with_census1a_roxie := JOIN(idsPosIncar, Census_Data.Key_Smart_Jury, 
							keyed(LEFT.Address_Verification.Input_Address_Information.st = RIGHT.stusab) and 
							keyed(left.Address_Verification.Input_Address_Information.county = right.county) and
							keyed(left.Address_Verification.Input_Address_Information.geo_blk[1..6] = right.tract) and 
							keyed(left.Address_Verification.Input_Address_Information.geo_blk[7] = right.blkgrp), 
					    get_property_census(LEFT,RIGHT,1,false), LEFT OUTER, keep(1));

Property_with_census1a_thor := JOIN(distribute(idsPosIncar, hash64(Address_Verification.Input_Address_Information.st, 
																																	 Address_Verification.Input_Address_Information.county,
																																	 Address_Verification.Input_Address_Information.geo_blk[1..4])), 
							Dist_Smart_Jury, 
							(LEFT.Address_Verification.Input_Address_Information.st = RIGHT.stusab) and 
							(left.Address_Verification.Input_Address_Information.county = right.county) and
							(left.Address_Verification.Input_Address_Information.geo_blk[1..6] = right.tract) and 
							(left.Address_Verification.Input_Address_Information.geo_blk[7] = right.blkgrp), 
					    get_property_census(LEFT,RIGHT,1,false), LEFT OUTER, keep(1), LOCAL);
							
Property_with_census1b_roxie := JOIN(Property_with_census1a_roxie, Census_Data.Key_Smart_Jury,
							LEFT.census_loose1 AND
							keyed(LEFT.Address_Verification.Input_Address_Information.st = RIGHT.stusab) and 
							keyed(left.Address_Verification.Input_Address_Information.county = right.county) and
							keyed(left.Address_Verification.Input_Address_Information.geo_blk[1..4] = right.tract[1..4]), 
						get_property_census(LEFT,RIGHT,1,true), LEFT OUTER, keep(1));

Property_with_census1b_thor := JOIN(Property_with_census1a_thor, Dist_Smart_Jury,
							LEFT.census_loose1 AND
							(LEFT.Address_Verification.Input_Address_Information.st = RIGHT.stusab) and 
							(left.Address_Verification.Input_Address_Information.county = right.county) and
							(left.Address_Verification.Input_Address_Information.geo_blk[1..4] = right.tract[1..4]), 
						get_property_census(LEFT,RIGHT,1,true), LEFT OUTER, keep(1), LOCAL);

Property_with_census2a_roxie := JOIN(property_with_census1b_roxie, Census_Data.Key_Smart_Jury, 
							keyed(LEFT.Address_Verification.Address_History_1.st = RIGHT.stusab) and 
							keyed(left.Address_Verification.Address_History_1.county = right.county) and
							keyed(left.Address_Verification.Address_History_1.geo_blk[1..6] = right.tract) and 
							keyed(left.Address_Verification.Address_History_1.geo_blk[7] = right.blkgrp), 
					    get_property_census(LEFT,RIGHT,2,false), LEFT OUTER, keep(1));

Property_with_census2a_thor := JOIN(distribute(property_with_census1b_thor, hash64(Address_Verification.Address_History_1.st,
																																						Address_Verification.Address_History_1.county,
																																						Address_Verification.Address_History_1.geo_blk[1..4])), 
							Dist_Smart_Jury, 
							(LEFT.Address_Verification.Address_History_1.st = RIGHT.stusab) and 
							(left.Address_Verification.Address_History_1.county = right.county) and
							(left.Address_Verification.Address_History_1.geo_blk[1..6] = right.tract) and 
							(left.Address_Verification.Address_History_1.geo_blk[7] = right.blkgrp), 
					    get_property_census(LEFT,RIGHT,2,false), LEFT OUTER, keep(1), LOCAL);
							
Property_with_census2b_roxie := JOIN(Property_with_census2a_roxie, Census_Data.Key_Smart_Jury,
							LEFT.census_loose2 AND
							keyed(LEFT.Address_Verification.Address_History_1.st = RIGHT.stusab) and 
							keyed(left.Address_Verification.Address_History_1.county = right.county) and
							keyed(left.Address_Verification.Address_History_1.geo_blk[1..4] = right.tract[1..4]), 
						get_property_census(LEFT,RIGHT,2,true), LEFT OUTER, keep(1));

Property_with_census2b_thor := JOIN(Property_with_census2a_thor, Dist_Smart_Jury,
							LEFT.census_loose2 AND
							(LEFT.Address_Verification.Address_History_1.st = RIGHT.stusab) and 
							(left.Address_Verification.Address_History_1.county = right.county) and
							(left.Address_Verification.Address_History_1.geo_blk[1..4] = right.tract[1..4]), 
						get_property_census(LEFT,RIGHT,2,true), LEFT OUTER, keep(1), LOCAL);
						
Property_with_census3a_roxie := JOIN(Property_with_census2b_roxie, Census_Data.Key_Smart_Jury, 
							keyed(LEFT.Address_Verification.Address_History_2.st = RIGHT.stusab) and 
							keyed(left.Address_Verification.Address_History_2.county = right.county) and
							keyed(left.Address_Verification.Address_History_2.geo_blk[1..6] = right.tract) and 
							keyed(left.Address_Verification.Address_History_2.geo_blk[7] = right.blkgrp), 
					    get_property_census(LEFT,RIGHT,3,false), LEFT OUTER, keep(1));

Property_with_census3a_thor := JOIN(distribute(Property_with_census2b_thor, hash64(Address_Verification.Address_History_2.st,
																																									 Address_Verification.Address_History_2.county,
																																									 Address_Verification.Address_History_2.geo_blk[1..4])), 
							Dist_Smart_Jury, 
							(LEFT.Address_Verification.Address_History_2.st = RIGHT.stusab) and 
							(left.Address_Verification.Address_History_2.county = right.county) and
							(left.Address_Verification.Address_History_2.geo_blk[1..6] = right.tract) and 
							(left.Address_Verification.Address_History_2.geo_blk[7] = right.blkgrp), 
					    get_property_census(LEFT,RIGHT,3,false), LEFT OUTER, keep(1), LOCAL);
							
Property_with_census3b_roxie := JOIN(Property_with_census3a_roxie, Census_Data.Key_Smart_Jury,
							LEFT.census_loose3 AND
							keyed(LEFT.Address_Verification.Address_History_2.st = RIGHT.stusab) and 
							keyed(left.Address_Verification.Address_History_2.county = right.county) and
							keyed(left.Address_Verification.Address_History_2.geo_blk[1..4] = right.tract[1..4]), 
						get_property_census(LEFT,RIGHT,3,true), LEFT OUTER, keep(1));

Property_with_census3b_thor := group(sort(JOIN(Property_with_census3a_thor, Dist_Smart_Jury,
							LEFT.census_loose3 AND
							(LEFT.Address_Verification.Address_History_2.st = RIGHT.stusab) and 
							(left.Address_Verification.Address_History_2.county = right.county) and
							(left.Address_Verification.Address_History_2.geo_blk[1..4] = right.tract[1..4]), 
						get_property_census(LEFT,RIGHT,3,true), LEFT OUTER, keep(1), LOCAL), seq), seq);

#IF(onThor)
	Property_with_census3b := Property_with_census3b_thor;
#ELSE
	Property_with_census3b := Property_with_census3b_roxie;
#END

With_or_without_census := IF(isFCRA, pre_relatives, Property_with_census3b);

Risk_Indicators.MAC_testHRIAddress (With_or_without_census, Input_Address_Information, Prop_HRI_InputAddress, IsFCRA);
Risk_Indicators.MAC_testHRIAddress (Prop_HRI_InputAddress, Address_History_1, Prop_HRI_AddressHistory_1, IsFCRA);
Risk_Indicators.MAC_testHRIAddress (Prop_HRI_AddressHistory_1, Address_History_2, Prop_HRI_AddressHistory_2, IsFCRA);

// output(iid, named('iid'));
// output(p, named('p'));
// output(p_tmp);
return Prop_HRI_AddressHistory_2;

end;