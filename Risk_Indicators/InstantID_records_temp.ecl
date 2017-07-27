import address,models,riskwise,ut,codes,Suppress,AutoStandardI, seed_files;

Risk_indicators.MAC_unparsedfullname(title_val,fname_val,mname_val,lname_val,suffix_val,'FirstName','MiddleName','LastName','NameSuffix')

string30 account_value := '' : stored('AccountNumber');
string120 addr1_val := ''    : stored('StreetAddress');
string25 city_val := ''      : stored('City');
string2 state_val := ''      : stored('State');
// string5 zip_value := ''      : stored('Zip');
string5 zip_value := AutoStandardI.GlobalModule().zip;
string25 country_value := '' : stored('Country');

// string9 ssn_value := ''      : stored('ssn');
string9 ssn_value := AutoStandardI.GlobalModule().ssn;

string8 dob_value := ''      : stored('DateOfBirth');
unsigned1 age_value := 0     : stored('Age');

STRING20 dl_number_value := ''     : stored('DLNumber');
STRING2 dl_state_value := ''       : stored('DLState');

string100 email_value := ''  : stored('Email');
STRING20 ip_value := ''      : stored('IPAddress');

string10 phone_value := ''   : stored('HomePhone');
STRING10 wphone_value := ''  : stored('WorkPhone');

STRING100 employe_name_value := ''   	: stored('EmployerName');
STRING30 prev_lname_value := ''      	: stored('FormerName');

boolean Test_Data_Enabled := FALSE   	: stored('TestDataEnabled');
string20 Test_Data_Table_Name := ''  	: stored('TestDataTableName');

unsigned1 DPPA_Purpose := 0 					: stored('DPPAPurpose');
unsigned1 GLB_Purpose := 8 						: stored('GLBPurpose');
STRING5 industry_class_val := '' 			: stored('IndustryClass');
	isUtility := StringLib.StringToUpperCase(industry_class_val) = 'UTILI';
unsigned3 history_date := 999999 			: stored('HistoryDateYYYYMM');
boolean IsPOBoxCompliant := false 		: stored('PoBoxCompliance');
boolean ofac_only := true 						: stored('OfacOnly');
boolean ExcludeWatchLists := false 		: stored('ExcludeWatchLists');
unsigned1 OFAC_version :=1 						: stored('OFACversion');
boolean Include_Additional_watchlists := FALSE	: stored('IncludeAdditionalWatchlists');
boolean Include_Ofac := FALSE										: stored('IncludeOfac');
real global_watchlist_threshold := .84 					: stored('GlobalWatchlistThreshold');
boolean use_dob_filter := FALSE 								: stored('UseDobFilter');
integer2 dob_radius := 2 												: stored('DobRadius');
boolean FromIIDModel := false 									: stored('FromIIDModel');
unsigned1 RedFlag_version := 0 	: stored('RedFlag_version');
string6 ssnmask := 'NONE' 			: stored('SSNMask');
boolean IncludeTargus3220 := false		: stored('IncludeTargusE3220');

boolean ExactFirstNameMatch := false : stored('ExactFirstNameMatch');
boolean ExactLastNameMatch := false : stored('ExactLastNameMatch');
boolean ExactAddrMatch := false : stored('ExactAddrMatch');
boolean ExactPhoneMatch := false : stored('ExactPhoneMatch');
boolean ExactSSNMatch := false : stored('ExactSSNMatch');
boolean ExactDOBMatch := false : stored('ExactDOBMatch');
boolean ExactFirstNameMatchAllowNicknames := false : stored('ExactFirstNameMatchAllowNicknames');
string10 CustomDataFilter := '' : stored('CustomDataFilter');

string6 DataRestriction := AutoStandardI.GlobalModule().DataRestrictionMask; 

// they want this customizable, so instead of doing an incremental ranking, use 1 or 0 for each element
// everything defaulted to off would be '0000000'  
// making this a string10 in case they decide to make it even more granular
string10 ExactMatchLevel := if(ExactFirstNameMatch, iid_constants.sTrue, iid_constants.sFalse) + 
														if(ExactLastNameMatch, iid_constants.sTrue, iid_constants.sFalse) + 
														if(ExactAddrMatch, iid_constants.sTrue, iid_constants.sFalse) + 
														if(ExactPhoneMatch, iid_constants.sTrue, iid_constants.sFalse) + 
														if(ExactSSNMatch, iid_constants.sTrue, iid_constants.sFalse) + 
														if(ExactDOBMatch, iid_constants.sTrue, iid_constants.sFalse) +
														if(ExactFirstNameMatchAllowNicknames, iid_constants.sTrue, iid_constants.sFalse);

dob_radius_use := if(use_dob_filter,dob_radius,-1);
boolean suppressNearDups := false;
boolean require2ele := false;
boolean fromBiid := false;
boolean isFCRA := false;
boolean ln_branded := false;
boolean fromIT1O := false;

model_url := dataset([],Models.Layout_Score_Chooser) : STORED('scores',few);
gateways_in := dataset([],risk_indicators.Layout_Gateways_In) : STORED('gateways',few);

risk_indicators.Layout_Gateways_In gw_switch(gateways_in le) := transform
	self.servicename := map(IncludeTargus3220 and le.servicename = 'targus' => 'targuse3220',	// if E3220 requested, change servicename for later use
													le.servicename);
	self.url := map(IncludeTargus3220 and le.servicename = 'targus' => le.url + '?ver_=1.39',	// need version 1.39 for E3220,
									le.url); 
end;
gateways := project(gateways_in, gw_switch(left));

rec := record
  unsigned4 seq;
  end;
d := dataset([{(unsigned)account_value}],rec);


// JRP 02/12/2008 - Dataset of actioncode and reasoncode settings which are passed to the getactioncodes and reasoncodes functions.
boolean IsInstantID := true;
reasoncode_settings := dataset([{IsInstantID}],riskwise.layouts.reasoncode_settings);
actioncode_settings := dataset([{IsPOBoxCompliant, IsInstantID}],riskwise.layouts.actioncode_settings);

// Check to see if Red Flags or Fraud Advisor Requested
RedFlagsReq := redflag_version > 0;
FraudDefenderReq := EXISTS(model_url(name='Models.FraudAdvisor_Service'));

risk_indicators.Layout_Input into(rec l) := transform
	
	street_address := risk_indicators.MOD_AddressClean.street_address(addr1_val);
	clean_a2 := risk_indicators.MOD_AddressClean.clean_addr( street_address, city_val, state_val, zip_value ) ;		
	
	dob_val := riskwise.cleandob(dob_value);
	dl_num_clean := riskwise.cleanDL_num(dl_number_value);
	
	self.seq := l.seq;
		
	self.ssn := IF(ssn_value='000000000','',ssn_value);	// blank out social if it is all 0's
	self.dob := dob_val;
	self.age := if (age_value = 0 and (integer)dob_val != 0, (STRING3)ut.GetAgeI((integer)dob_val), (string3)age_value);
	
	self.phone10 := phone_value;
	self.wphone10 := wphone_value;
	
	self.title := stringlib.stringtouppercase(title_val);
	self.fname := stringlib.stringtouppercase(fname_val);
	self.mname := stringlib.stringtouppercase(mname_val);
	self.lname := stringlib.stringtouppercase(lname_val);
	self.suffix := stringlib.stringtouppercase(suffix_val);
	
	SELF.in_streetAddress := addr1_val;
	SELF.in_city := city_val;
	SELF.in_state := state_val;
	SELF.in_zipCode := zip_value;
	SELF.in_country := country_value;
	
	self.prim_range := clean_a2[1..10];
	self.predir := clean_a2[11..12];
	self.prim_name := clean_a2[13..40];
	self.addr_suffix := clean_a2[41..44];
	self.postdir := clean_a2[45..46];
	self.unit_desig := clean_a2[47..56];
	self.sec_range := clean_a2[57..64];
	self.p_city_name := clean_a2[90..114];
	self.st := clean_a2[115..116];
	self.z5 := clean_a2[117..121];
	self.zip4 := clean_a2[122..125];
	self.lat := clean_a2[146..155];
	self.long := clean_a2[156..166];
	self.addr_type := clean_a2[139];
	self.addr_status := clean_a2[179..182];
	self.county := clean_a2[143..145];
	self.geo_blk := clean_a2[171..177];
		
	self.country := country_value;
	
	SELF.dl_number := stringlib.stringtouppercase(dl_num_clean);
	SELF.dl_state := stringlib.stringtouppercase(dl_state_value);
	
	SELF.email_address := email_value;
	SELF.ip_address := ip_value;
	
	SELF.employer_name := stringlib.stringtouppercase(employe_name_value);
	SELF.lname_prev := stringlib.stringtouppercase(prev_lname_value);
end;
prep := PROJECT(d,into(LEFT));


// Changed to default to version 2 in order to get back ADL info used in Red Flags.
unsigned1 BSversion := 2;
boolean runSSNCodes := true;
boolean runBestAddr := true;
boolean runChronoPhone := true;
boolean runAreaCodeSplit := true;
// boolean allowCellPhones := gateways(servicename='targuse3220').url <> '';	// if targuse3220 gateway is available then allow cell phone searching, NOTE: idp1/idp3 mean something a little different
boolean allowCellPhones := false;

// after the code freeze in January, point this back at risk_indicators.InstantID_Function, and add CustomDataFilter to the library interface
ret := risk_indicators.InstantID_Function_temp(prep, gateways, DPPA_Purpose, GLB_Purpose, isUtility, ln_branded, history_date, 
																					ofac_only, suppressNearDups, require2ele, fromBiid, isFCRA, ExcludeWatchLists,
																					fromIT1O,ofac_version,include_ofac,include_additional_watchlists,
																					global_watchlist_threshold,dob_radius_use,BSversion,runSSNCodes,runBestAddr,
																					runChronoPhone,runAreaCodeSplit,allowCellPhones,
																					ExactMatchLevel, DataRestriction, CustomDataFilter);

ret_test_seed_un := risk_indicators.InstantID_Test_Function(Test_Data_Table_Name,fname_val,lname_val,ssn_value,zip_value,
                       					 phone_value,Account_value);
																												 
ret_test_seed := project(ret_test_seed_un,risk_indicators.Layout_InstantID_NuGenPlus);

risk_indicators.layout_input into_test_prep(risk_indicators.Layout_InstantID_NuGenPlus l) := transform
	self.seq := l.seq;	// take seq from the ret_test_seed data as we will need it for joining to scores later.
	self.ssn := ssn_value;
	self.phone10 := phone_value;
	self.fname := stringlib.stringtouppercase(fname_val);
	self.lname := stringlib.stringtouppercase(lname_val);
	SELF.in_zipCode := zip_value;
	self := [];
end;

test_prep := PROJECT(ret_test_seed,into_test_prep(LEFT));																												 

tscore(UNSIGNED1 i) := IF(i=255,0,i);


risk_indicators.Layout_InstantID_NuGenPlus format_out(risk_indicators.Layout_Output le) :=
TRANSFORM
	SELF.acctNo := account_value;
	SELF.transaction_id := 0;

	self.verfirst := IF(le.combo_firstcount>0, le.combo_first, '');
	self.verlast := IF(le.combo_lastcount>0, le.combo_last, '');
	SELF.veraddr := IF(le.combo_addrcount>0, Risk_Indicators.MOD_AddressClean.street_address('',le.combo_prim_range,
										le.combo_predir,le.combo_prim_name,le.combo_suffix,le.combo_postdir,le.combo_unit_desig,le.combo_sec_range),'');			
	SELF.vercity := IF(le.combo_addrcount>0, le.combo_city, '');
	SELF.verstate := IF(le.combo_addrcount>0, le.combo_state, '');
	SELF.verzip := IF(le.combo_addrcount>0, le.combo_zip[1..5], '');
	SELF.verzip4 := IF(le.combo_addrcount>0, le.combo_zip[6..9], '');
	SELF.vercounty := if(le.combo_addrcount>0, le.combo_county, '');
	SELF.verdob := IF(le.combo_dobcount>0, le.combo_dob, '');
	SELF.verssn := IF(le.combo_ssncount>0 and le.combo_ssnscore between 90 and 100, le.combo_ssn, '');// i don't think we want to output the input social for level =1
	SELF.verhphone := IF(le.combo_hphonecount>0, le.combo_hphone, '');
	
	SELF.verify_addr := IF(le.addrmultiple,'O','');
	SELF.verify_dob := IF(le.combo_dobcount>0,'Y','N');
	SELF.NAS_summary := le.socsverlevel;
	SELF.NAP_summary := le.phoneverlevel;
	SELF.NAP_Type    := le.nap_type;
	SELF.NAP_Status  := le.nap_status;

	SELF.valid_ssn := IF(le.socllowissue != '', 'G', '');
		
	SELF.corrected_lname := le.correctlast;
	SELF.corrected_dob := le.correctdob;
	SELF.corrected_phone := le.correcthphone;
	SELF.corrected_ssn := le.correctssn;
	SELF.corrected_address := le.correctaddr;
	
	SELF.area_code_split := if(le.areacodesplitflag='Y', le.altareacode, '');
	SELF.area_code_split_date := if(le.areacodesplitflag='Y', le.areacodesplitdate, '');
	
	SELF.additional_score1 := 0;
	SELF.additional_score2 := 0;
	
	SELF.phone_fname := le.dirsfirst;
	SELF.phone_lname := le.dirslast;
	SELF.phone_address := Risk_Indicators.MOD_AddressClean.street_address('',le.dirs_prim_range,le.dirs_predir,le.dirs_prim_name,
											le.dirs_suffix,le.dirs_postdir,le.dirs_unit_desig,le.dirs_sec_range);
	SELF.phone_city := le.dirscity;
	SELF.phone_st := le.dirsstate;
	SELF.phone_zip := le.dirszip;
	
	SELF.name_addr_phone := le.name_addr_phone;
	
	SELF.ssa_date_first := le.socllowissue;
	SELF.ssa_date_last := le.soclhighissue;
	SELF.ssa_state := le.soclstate;
	SELF.ssa_state_name := Codes.GENERAL.STATE_LONG(le.soclstate);
	
	SELF.current_fname := le.verfirst;
	SELF.current_lname := le.verlast;
	
	addr1 := Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range, le.chronopredir, 
										   le.chronoprim_name, le.chronosuffix,
										   le.chronopostdir, le.chronounit_desig, le.chronosec_range);
	addr2 := Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range2, le.chronopredir2, 
										   le.chronoprim_name2, le.chronosuffix2,
										   le.chronopostdir2, le.chronounit_desig2, le.chronosec_range2);
	addr3 := Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range3, le.chronopredir3, 
										   le.chronoprim_name3, le.chronosuffix3,
										   le.chronopostdir3, le.chronounit_desig3, le.chronosec_range3);
						
	SELF.Chronology := DATASET([{1, addr1, le.chronocity, le.chronostate, le.chronozip, le.chronozip4, le.chronophone, le.chronodate_first, le.chronodate_last},
						    {2, addr2, le.chronocity2, le.chronostate2, le.chronozip2, le.chronozip4_2, le.chronophone2, le.chronodate_first2, le.chronodate_last2},
						    {3, addr3, le.chronocity3, le.chronostate3, le.chronozip3, le.chronozip4_3, le.chronophone3, le.chronodate_first3, le.chronodate_last3}], 
						  Risk_Indicators.Layout_AddressHistory);

	
	SELF.Additional_Lname := if(le.socsverlevel IN [4,7,9,10,11,12], DATASET([{le.altfirst,le.altlast,le.altlast_date},
							    {le.altfirst2,le.altlast2,le.altlast_date2},
							    {le.altfirst3,le.altlast3,le.altlast_date3}], Risk_Indicators.Layout_LastNames), 
								dataset([], Risk_Indicators.Layout_LastNames));

	SELF.Watchlist_Table := le.watchlist_table;
	SELF.Watchlist_Program :=le.watchlist_program;
	SELF.Watchlist_Record_Number := le.Watchlist_Record_Number;
	SELF.Watchlist_fname := le.Watchlist_fname;
	SELF.Watchlist_lname := le.Watchlist_lname;
	SELF.Watchlist_address := le.Watchlist_address;
	SELF.Watchlist_city := le.Watchlist_city;
	SELF.Watchlist_state := le.Watchlist_state;
	SELF.Watchlist_zip := le.Watchlist_zip;
	SELF.Watchlist_contry := le.Watchlist_contry;
	SELF.Watchlist_Entity_Name := le.Watchlist_Entity_Name;

	SELF.ri := risk_indicators.reasonCodes(le, 6, reasoncode_settings);
	SELF.fua := risk_indicators.getActionCodes(le, 4, SELF.NAS_summary, SELF.NAP_summary, ac_settings := actioncode_settings);
	

	SELF.CVI := if(IsPOBoxCompliant AND le.addr_type = 'P', '10', 
					risk_indicators.cviScore(SELF.NAP_Summary,SELF.NAS_summary,le,SELF.corrected_ssn,
										self.corrected_address,self.corrected_phone,'',self.veraddr,self.verlast));

	self.age := if (le.age = '***','',le.age);
    
	SELF := le;
	SELF := [];  // default models and red flags datasets to empty
END;

risk_indicators.Layout_InstantID_NuGenPlus intoEmpty(d le) := transform
	self.acctNo := account_value;
	self := [];
END;

formed := if(fromIIDModel and EXISTS(model_url), project(d, intoEmpty(LEFT)),
	ungroup(PROJECT(ret, format_out(LEFT))));	// don't do IID portion if from IID model and a model is requested
// for testing only   formed contains the hri desc  under ri and under fua it already contains the codes
// output(formed,named('formed'));

// this is not ideal to index into the datasets by position number, as the position can change,
// but I can't figure out how to reference the row in the parameters dataset that is named 'isstudent'
student_params := project(model_url(name='Models.StudentAdvisor_Service'), transform(models.layout_parameters, self := left.parameters[1]));
student_boolean := student_params[1].value='1';
ca_params := project(model_url(name[1..9]='Models.RV'), transform(models.layout_parameters, self := left.parameters[1]));
ca_boolean := ca_params[1].value='1';

customfraud_params := project(model_url(name='Models.CustomFA_Service'), transform(models.layout_parameters, self := left.parameters[1]));
customfraud_modelname := trim(StringLib.StringToUppercase(customfraud_params(name='Custom')[1].value));


fa_params := model_url(name='Models.FraudAdvisor_Service')[1].parameters;
model_version := trim(StringLib.StringToUppercase(fa_params(name='Version')[1].value));
custom_modelname := trim(StringLib.StringToUppercase(fa_params(name='Custom')[1].value));
modelname := if(model_version='', custom_modelname, model_version);

// TODO:  Terrence and Anant would like us to add a name lookup to validate the input model matches the tag name
//  if name='Custom' and model is actually a flagship model, throw an exception
//  if name='Version' and model is actually a custom model, throw an exception
// can't put this in immediately because ESP is currently using Version for all models, even custom models
// so add this after the ESP has been released to accurately pass in Custom or Version
/*
modelname := map( model_version='' and custom_modelname='' => '',
									model_version<>'' and model_version in ['FP3710_0'] => model_version,
									custom_modelname<>'' and custom_modelname in ['FP3904_1', 'FP3904_1', 'IDN6051'] => custom_modelname,
									error('Invalid fraud version/model input combination'));
*/


risk_indicators.Layout_Interactive_In scoredata(rec le) :=
TRANSFORM
	SELF.AccountNumber := account_value;
	SELF.SSN := ssn_value;
	SELF.FirstName := fname_val;
	SELF.MiddleName := mname_val;
	SELF.LastName := lname_val;
	SELF.NameSuffix := suffix_val;

	SELF.DateOfBirth := dob_value;
	
	SELF.StreetAddress := addr1_val;
	SELF.City := city_val;
	SELF.State := state_val;
	SELF.Zip := zip_value;
	
	SELF.Age := age_value;
	SELF.DLNumber := dl_number_value;
	SELF.DLState := dl_state_value;
	
	SELF.HomePhone := phone_value;
	SELF.WorkPhone := wphone_value;
	
	SELF.DPPAPurpose := DPPA_Purpose;
	SELF.GLBPurpose := GLB_Purpose;
	SELF.IndustryClass := industry_class_val;
	SELF.LnBranded := ln_branded;
	SELF.HistoryDateYYYYMM := history_date;
	SELF.OfacOnly := ofac_only;
	self.isStudent := student_boolean;
	self.isCalifornia := ca_boolean;
	self.gateways := gateways;
	
	self.IncludeAdditionalWatchlists := Include_Additional_Watchlists;

	// self.ExcludeWatchLists := ExcludeWatchLists_val;
	self.OFACVersion := OFAC_version;
	
	self.IncludeOFAC := Include_Ofac;
	self.GlobalWatchListThreshold := global_watchlist_threshold;
	self.UseDOBFilter := use_dob_filter;
	self.DOBRadius    := dob_Radius;
	self.customFraudModel := customfraud_modelname;
	
	self.ipaddress := ip_value;
	self.model := modelname;
	self.testdataenabled := Test_Data_Enabled;
	self.TestDataTableName := Test_Data_Table_Name;
	// self.ModelVersion := modelversion;

	self := [];
END;

scores_out := IF(EXISTS(model_url),riskwise.ScoreController(model_url,PROJECT(ungroup(d),scoredata(LEFT))));


// FraudPoint models return 6 reason codes, but we only want 4 for IID
models.layout_score limit_scores( models.layout_score le ) := TRANSFORM
	self.reason_codes := choosen( le.reason_codes, 4 );
	self := le;
END;
models.layout_model limit_model( models.layout_Model le ) := TRANSFORM
	self.scores := project( le.scores, limit_scores(LEFT) );
	self := le;
END;
{scores_out} limit_scores_out( scores_out le ) := transform
	self.models := project( le.models, limit_model(left) );
	self.AccountNumber := le.AccountNumber;
end;
//

scores := if( modelname in ['FP3710_0','FP3904_1','FP3905_1'], project( scores_out, limit_scores_out(left) ), scores_out );

iid := if(Test_Data_Enabled, ret_test_seed, formed);	// choose either test results or real results

risk_indicators.Layout_InstantID_NuGenPlus combo(risk_indicators.Layout_InstantID_NuGenPlus le, scores ri) :=
TRANSFORM
	SELF.models := ri.models;
	self.ssn := ssn_value;	// replace the entered social
	self.dob := dob_value;	// replace the input dob, it could have been blanked out for bad format
	self.recordcount := count(iid);	// add recordcount for logging by ESP
	SELF := le;
END;

scores_added := JOIN(iid, scores, 
										LEFT.AcctNo=RIGHT.AccountNumber, combo(LEFT,RIGHT), LEFT OUTER, PARALLEL);

red_flags := if(Test_Data_Enabled, seed_files.GetRedFlags(test_prep, Test_Data_Table_Name), risk_indicators.Red_Flags_Function(ret));

with_red_flags := join(scores_added, red_flags, left.seq=right.seq, 
											transform(risk_indicators.Layout_InstantID_NuGenPlus,
																self.Red_Flags := right, self := left), left outer);

// If red flags option is selected, then return result with red flags added. Otherwise, return data without red flags.
pick_transaction := if(RedFlagsReq, with_red_flags, scores_added);

Suppress.MAC_Mask(pick_transaction, final, verssn, '', true, false, false, false, '', ssnmask);
Suppress.MAC_Mask(final, final2, corrected_ssn, '', true, false, false, false, '', ssnmask);

// output(ExactMatchLevel, named('ExactMatchLevel'));
// output(data_restriction_value, named('data_restriction_value'));
// output(ret, named('ret'));

export InstantID_records_temp := final2;

