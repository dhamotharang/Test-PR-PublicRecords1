﻿/*--SOAP--
<message name="Phone_NoReconn_Service">
   <part name="IncludeRealTimePhones" type="xsd:boolean"/>
   <part name="Acctno" type="xsd:string"/>
   <part name="DID" type="xsd:string"/>
   <part name="UnParsedFullName" type="xsd:string"/>
   <part name="SSN" type="xsd:string"/>
   <part name="FirstName" type="xsd:string"/>
   <part name="LastName" type="xsd:string"/>
   <part name="MiddleName" type="xsd:string"/>
   <part name="NameSuffix" type="xsd:string"/>
   <part name="AllowNickNames" type="xsd:boolean"/>
   <part name="PhoneticMatch" type="xsd:boolean"/>
   <part name="TUGatewayPhoneticMatch" type="xsd:boolean"/>
   <part name="CompanyName" type="xsd:string"/>
   <part name="IncludeHRI" type="xsd:boolean"/>
   <part name="Addr" type="xsd:string"/>
   <part name="PrimRange" type="xsd:string"/>
   <part name="PrimName" type="xsd:string"/>
   <part name="SecRange" type="xsd:string"/>
   <part name="City" type="xsd:string"/>
   <part name="State" type="xsd:string"/>
   <part name="Zip" type="xsd:string"/>
   <part name="Phone" type="xsd:string"/>
   <part name="ExcludeCurrentGong" type="xsd:boolean"/>
   <part name="IncludePhonesFeedback" type="xsd:boolean"/>
   <part name="IncludeAddressFeedback" type="xsd:boolean"/>
   <part name="MaxResults" type="xsd:unsignedInt"/>
   <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
   <part name="SkipRecords" type="xsd:unsignedInt"/>
   <part name="DPPAPurpose" type="xsd:byte"/>
   <part name="GLBPurpose" type="xsd:byte"/> 
   <part name="DataRestrictionMask" type="xsd:string"/>
   <part name="SSNMask" type="xsd:string"/>
   <part name="IndustryClass" type="xsd:string"/>
	 <part name="ApplicationType" type="xsd:string"/>
   <part name="DataPermissionMask" type="xsd:string"/>
   <part name="UseQSENTV2" type="xsd:boolean"/>
   <part name="Gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
   <part name="BatchFriendly" type="xsd:boolean"/>
	 <part name="StrictMatch" type="xsd:boolean"/>
 	 <part name="IncludeFullPhonesPlus" type="xsd:boolean"/>
 	 <part name="IncludeLastResort" type="xsd:boolean"/>
 	 <part name="UseDateSort" type="xsd:boolean"/>
	 <part name="IncludeDeadContacts" type="xsd:boolean"/>
   <part name="UseMetronet" type="xsd:boolean"/>
	 <part name="ScoreThreshold" 		type="xsd:unsignedInt"/>
	 <part name="IncludeMinors" type="xsd:boolean"/>
	 <part name="ExcludeResidence" type="xsd:boolean"/>
	 <part name="ExcludeBusiness" type="xsd:boolean"/>
	 <part name="SuppressNewPorting" type="xsd:boolean"/>
   <part name="SuppressPortedTestDate" type="xsd:string"/>
   <part name="excludeLandlines" type="xsd:boolean"/>
   <part name="SuppressBlankNameAddress" type="xsd:boolean"/>
</message>
*/

/*--INFO-- 
This service searches for cell phone users, or who likely to be transferred their number 
from a land line, or current landline if included in the search. Also try Targus gateway 
if the permission is set. Try Qsent data if nothing found above.
*/

/*
<message name="phone_noreconn_search" wuTimeout="300000">
*/

IMPORT AutoStandardI, BatchServices, DeathV2_Services, DidVille, Doxie_Raw, iesp, MDR, PhonesFeedback_Services, PhonesInfo, Royalty, STD, Suppress, ut, WSInput;

EXPORT phone_noreconn_search := MACRO 
	
	//The following macro defines the field sequence on WsECL page of query. 
	WSInput.MAC_phone_noreconn_search();

	shared prog_phone := progressive_phone.layout_progressive_phones;
	boolean call_PVS := false : STORED('IncludeRealTimePhones');
	boolean use_Metronet := false : STORED('UseMetronet');
	boolean excludeResidence := false : stored('ExcludeResidence');
	boolean excludeBusiness := false : stored('ExcludeBusiness');
	boolean excludeLandlines := false : stored('ExcludeLandlines');	
	boolean SuppressNewPorting := excludeLandlines : stored('SuppressNewPorting');
 boolean SuppressBlankNameAddress := false : stored('SuppressBlankNameAddress');

	doxie.MAC_Header_Field_Declare();
	globalmod := AutoStandardI.GlobalModule();
	srchMod := MODULE(PROJECT(globalmod,doxie.phone_noreconn_param.searchParams,OPT))
			EXPORT UNSIGNED1 DPPAPurpose := DPPA_Purpose;
			EXPORT UNSIGNED1 GLBPurpose := GLB_Purpose;
			EXPORT STRING32  ApplicationType := application_type_value;
			EXPORT STRING5   IndustryClass := industry_class_value;
			EXPORT UNSIGNED1 ScoreThreshold := score_threshold_value;
			EXPORT STRING30  Acctno := '' : STORED('Acctno');
			EXPORT STRING14  DID := did_value;
			EXPORT STRING11  SSN := ssn_value;
			EXPORT STRING120 UnParsedFullName := unparsed_fullname_value;
			EXPORT STRING30  FirstName := fname_value;
			EXPORT STRING30  MiddleName := mname_value;
			EXPORT STRING30  LastName := lname_value;
			EXPORT STRING120 CompanyName := company_name;
			EXPORT STRING10  PrimRange := prange_value;
			EXPORT STRING2   PreDir := predir_value;
			EXPORT STRING30  PrimName := pname_value;
			EXPORT STRING4   Suffix := addr_suffix_value;
			EXPORT STRING2   PostDir := postdir_value;
			EXPORT STRING10  SecRange := sec_range_value;
			EXPORT STRING25  City := city_value;
			EXPORT STRING2   State := state_value;
			EXPORT STRING6   Zip := zip_value_cleaned;
			EXPORT STRING15  Phone := phone_value;
			EXPORT BOOLEAN   ExcludeCurrentGong := FALSE : STORED('ExcludeCurrentGong');
			EXPORT BOOLEAN   IncludeFullPhonesPlus := FALSE : STORED('IncludeFullPhonesPlus');
			EXPORT BOOLEAN   IncludeLastResort := FALSE : STORED('IncludeLastResort');
			EXPORT BOOLEAN   IncludeRealTimePhones := call_PVS;
			EXPORT BOOLEAN   IncludeHRI := FALSE : STORED('IncludeHRI');
	END;
	gateways_in := Gateway.Configuration.Get();

	phoneOnlySearch := srchMod.Phone != '' and
										 srchMod.FirstName = '' and srchMod.LastName = '' and srchMod.MiddleName = '' and srchMod.NameSuffix = '' and
										 srchMod.Addr = '' and srchMod.PrimRange = '' and srchMod.PrimName = '' and srchMod.SecRange = '' and
										 srchMod.City = '' and srchMod.State = '' and srchMod.Zip = '' and srchMod.DID = '' and srchMod.UnParsedFullName = '';

	dids_deduped := dedup(sort(doxie.Get_Dids(true,true),did),did)(did<>0);		
			
	// eliminate minors as necessary
	ut.PermissionTools.GLB.mac_FilterOutMinors(dids_deduped, filteredDids)

	resultOut_w_tzone_no_suppress := doxie.phone_noreconn_records(srchMod).val(filteredDids, gateways_in);
  
	// Suppress records without full name and address 
	resultOut_w_tzone := if(~SuppressBlankNameAddress or (SuppressBlankNameAddress and exists(resultOut_w_tzone_no_suppress(listed_name != '' OR (fname != '' AND lname!= '') OR (prim_name != '' AND ((city_name != '' AND st != '' ) OR zip != ''))))),
                          resultOut_w_tzone_no_suppress);

	boolean  batch_friendly := false : stored('BatchFriendly');
	boolean  IncludePhonesFeedback := false : stored('IncludePhonesFeedback');
	boolean  IncludeAddressFeedback := false : stored('IncludeAddressFeedback');
	boolean  IncludeLastResort := false : stored('IncludeLastResort');
	boolean  IncludeDeadContacts := false : stored('IncludeDeadContacts');
	boolean  UseDateSort := false : stored('UseDateSort');
	 
	//adding targus and qsent options
	boolean use_tg := doxie.DataPermission.use_targus;
	boolean use_LR := doxie.DataPermission.Use_LastResort and IncludeLastResort;
	boolean use_qt := doxie.DataPermission.use_qsent and ~use_LR;

	string25	tcity_name   	:= '' : stored('City');
	string2		tst          	:= '' : stored('State');
	string30  tlname_val  	:= '' : stored('LastName');
	string200 taddr_value 	:= '' : stored('Addr');
	string120 tcompany_name := '' : stored('CompanyName');

	unsigned1 SSNSearchLength :=  if (lname_value <> '', length(trim(SSN_value)), 0);

	// boolean use_PVS := TRUE;
	boolean use_PVS := (NOT EXISTS(resultOut_w_tzone) 
						 OR 
						 EXISTS(resultOut_w_tzone(COCType ='EOC' and ssc in ['C','R'])) 
						 OR
						 EXISTS(resultOut_w_tzone(COCType in ['PMC','RCC','SP1','SP2'] and ssc in ['C','R','S']))) 
						 OR 
						 SSNSearchLength > 0  // always go to the gateway (if requested) if there is ssn and last name
						 OR 
						 (length(trim(phone_value,all)) = 10) 
						 OR 
						 (tlname_val !='' and  taddr_value != '' and (tcity_name !='' and tst !=''))  // gateway does not use zip
						 OR 
						 (tcompany_name !='' AND taddr_value != '' AND tst != '' AND(tcity_name !='' OR srchMod.Zip !=''));


	// do not call the gateway with all criteria
	in_mod1 := MODULE(PROJECT(globalmod, BatchServices.RealTimePhones_Params.params, OPT))
		export string15 phone     := phone_value;
		export string200 addr     := addr_value;
		export string25 city      := city_value;
		export string2 state      := state_value;
		export string6 zip        := zip_val;
		export string11 ssn        := if (ssn_value <> '',intformat((integer)ssn_value,9,1),'');
		export boolean failOnError := false;  
		export string5 serviceType := ''; 
		export unsigned1 RecordCount := batchServices.constants.REALTIME_Record_max;
		export boolean TUGatewayPhoneticMatch := globalmod.TUGatewayPhoneticMatch;
		export string	 EspTransactionId := gateways_in[1].TransactionId; //all rows of the gateway have the same incoming transaction id
		export boolean UseQSENTV2 := false : stored('UseQSENTV2');
	end;

	PVS_gw_rslt := if(use_PVS and Call_PVS,
											Doxie_Raw.RealTimePhones_Raw(gateways_in,3,,in_mod1, use_PVS and Call_PVS) 										
										)	;

	issueHint := (use_PVS and Call_PVS and SSNSearchLength = 9 and (~exists(PVS_gw_rslt) and (~exists(resultOut_w_tzone))));  // say they should try 4 digit ssn

	ut.getTimeZone(PVS_gw_rslt,phone,timezone,PVS_GW_w_tzone);

	PVS_sort := sort(project(PVS_GW_w_tzone,transform(Doxie_Raw.PhonesPlus_Layouts.t_PhoneplusSearchResponse,
																							self.dt_first_seen := iesp.ECL2ESP.t_DateToString8(left.RealTimePhone_Ext.listingCreationDate),
																							self.dt_last_seen := iesp.ECL2ESP.t_DateToString8(left.RealTimePhone_Ext.listingTransactionDate),
																							self := left)), -dt_last_seen,-dt_first_seen,record);
		
	cmp_res := if(use_PVS and Call_PVS, PVS_sort) & project(resultOut_w_tzone,transform(
																									Doxie_Raw.PhonesPlus_Layouts.t_PhoneplusSearchResponse,
																									self := left, self := []));

	seq_rec := record
		Doxie_Raw.PhonesPlus_Layouts.t_PhoneplusSearchResponse;
		integer seq;
	end;

	cmp_res_seq := project(cmp_res, transform(seq_rec, self.seq := counter, self := left));

	/*--- Find Additional DIDs for records that have enough information ---*/                                                        
	hasEnoughInfoAndNoDid(string did, string lname, string fname, string ssn, string prim_range, string prim_name, string zip, string city_name, string st) := 
																		(did = '' or did = '0') and (lname <> '' and fname <> '' and
																		(ssn <> '' or (prim_range <> '' and prim_name <> '' and
																									(zip <> '' or (city_name <> '' and st <> '')))));

	without_did := cmp_res_seq(hasEnoughInfoAndNoDid(did, lname, fname, ssn, prim_range, prim_name, zip, city_name, st));
	appendDid_ready := project(without_did, transform(DidVille.Layout_Did_OutBatch,
																										self.did := 0,
																										self.phone10 := left.phone,
																										self.addr_suffix := left.suffix,
																										self.p_city_name := left.city_name,
																										self.z5 := left.zip,
																										self.DOB := '';
																										self := left));
																										
	DidVille.MAC_DidAppend(appendDid_ready, wdid,true,'ZG');

	wdid_done := join(cmp_res_seq, wdid, 
										left.seq = right.seq,
										transform(seq_rec,
										self.did := if(left.did = '' or left.did = '0', (string)right.did, left.did),
										self := left),
										left outer, keep(1),limit(0));

	//Resort records
	res_wdid := sort(wdid_done, seq);
									 
	/*--- Back to code ---*/
	cmp_res2 := if(srchMod.IncludeRealTimePhones, res_wdid, cmp_res_seq);

	//Get Experian recs
	Experian_Phones.Layouts.base getExperianBase(Experian_Phones.Key_Did_Digits ri) := transform
		self.DID										:= ri.DID;
		self.Encrypted_Experian_PIN := ri.Encrypted_Experian_PIN;
		self.Phone_digits						:= ri.Phone_digits;
		self.score 									:= ri.score;
		self.pin_lname 							:= if(ri.PIN_lname <>'',ri.PIN_lname,
																			if(srchMod.LastName <> '',srchMod.LastName,''));
		self.pin_fname 							:= if(ri.PIN_fname <>'',ri.PIN_fname,
																			if(srchMod.FirstName <> '',srchMod.FirstName,''));
		self.pin_mname							:= if(ri.PIN_mname <>'',ri.PIN_mname,
																			if(srchMod.MiddleName <> '',srchMod.MiddleName,''));
		self												:= ri;
		self 												:= [];
	end;

	//Filter out experian records with phone numbers already contained in other in-house
	//records.  Go to the gateway only if there are in-house experian records with phone 
	//numbers not contained in any other files.		

	exp0 := join(filteredDids, Experian_Phones.Key_Did_Digits, 
							 keyed(left.did = right.did) AND right.rec_type <> 'SP', 
								getExperianBase(right), inner, limit(100));

	exp1 := join(exp0,cmp_res2, 
						left.Phone_digits = right.phone[LENGTH(TRIM(right.phone))-2..LENGTH(TRIM(right.phone))], 
						transform(left), left only);

	//We want only records matching the subject (not spouse)	
	exp2 := topn(exp1, 1, -score);

	// progressive_phone.layout_experian_phones getExperianPhones(Experian_Phones.Layouts.base le) := transform
	prog_phone.layout_exp_multiple_phones getExperianPhones(Experian_Phones.Layouts.base le) := transform
		self.DID 									:= le.DID;
		self.ExperianPIN 					:= le.Encrypted_Experian_PIN;
		self.Phones_Last3Digits   := CHOOSEN(DATASET([{(STRING3)le.Phone_digits}],
																	prog_phone.Phone_Last3Digits), iesp.Constants.MaxCountLast3Digits);
		self.phone_score 					:= (string3)le.score;
		self.subj_last 						:= le.pin_lname;
		self.subj_first 					:= le.pin_fname;
		self.subj_middle 					:= le.pin_mname;
		self.subj_phone_type_new	:= MDR.sourceTools.src_Metronet_Gateway;
		self 											:= [];
	end;																	

	//transform the experian in-house recs into the layout expected by the metronet gateway.
	exp3 := project(exp2, getExperianPhones(LEFT));
									
	metronetGateway_cfg := gateways_in(Gateway.Configuration.IsMetronet(servicename))[1];

	metronetGatewayURL := metronetGateway_cfg.url;

	ExperianFlatFileOK := ut.PermissionTools.glb.OK(srchMod.GLBPurpose) AND ~Doxie.DataRestriction.ExperianPhones;
	MetronetOK := use_Metronet and ExperianFlatFileOK;

	out_metronet_gateway := if(MetronetOK and count(filteredDids) = 1 and trim(metronetGatewayURL) <> '',
														Gateway.SoapCall_Metronet(exp3, metronetGateway_cfg),
														dataset([], prog_phone.layout_exp_multiple_phones ));
														
	// If more than one 10 digit phone number is returned from the gateway with the same last three digits,
	// use up to two of them.  	
					
	exp4 := CHOOSEN(out_metronet_gateway, 2);

	Doxie_Raw.PhonesPlus_Layouts.t_PhoneplusSearchResponse exp2PhonePlus(prog_phone.layout_exp_multiple_phones le) := transform
		self.did 					:= (string15)le.did;
		self.phone				:= le.subj_phone10;
		self.Carrier_Name := le.phpl_phone_carrier;  //Original Carrier Name?  e.g. Sprint	
		self.vendor_id    := le.subj_phone_type_new;
		self.fname				:= le.subj_first;
		self.mname 				:= le.subj_middle;
		self.lname 				:= le.subj_last;
		self.name_suffix	:= le.subj_suffix;	
		self.city_name 		:= le.p_city_name;
		self.zip 					:= le.zip5;	
		self.SSN					:= le.ssn;
		self 							:= le;
		self 							:= [];
	end;
			
	exp5 := project(exp4, exp2PhonePlus(left));

	n := count(cmp_res2);

	exp_seq := project(exp5, transform(seq_rec, self.seq := counter+n, self := left));

	cmp_res3 := cmp_res2 + exp_seq;

	dids_for_best_in	:= dedup(sort(project(cmp_res3(did<>''),transform(doxie.layout_references,self.did := (integer)left.did) ),did),did);

	doxie.mac_best_records(dids_for_best_in,did,outfile,dppa_ok,glb_ok,,doxie.DataRestriction.fixed_DRM);

	/*---Get TNT Value---*/
	//get HHID
	did_hhid_key := doxie.Key_Did_HDid;
			
	infile_rec_hhid := record
		seq_rec;
		unsigned6 hhid;
	end;

	cmp_res3_whhid := join(cmp_res3, did_hhid_key, 
										keyed((integer)left.did = right.did), 
										transform(infile_rec_hhid, self.hhid := right.hhid_relat, self := left), 
										left outer, atmost(ut.limits.HHID_PER_PERSON));
										
	doxie.MAC_getTNTValue(cmp_res3_whhid, outfile, cmp_res_wtnt);

	//Rollup records to keep best TNT value
	cmp_res_wtnt keepBestTNT(cmp_res_wtnt le, cmp_res_wtnt ri) := transform
		self.tnt := MAP(le.tnt = 'B' or ri.tnt = 'B' => 'B',
						 le.tnt = 'V' or ri.tnt = 'V' => 'V',
						 le.tnt = 'C' or ri.tnt = 'C' => 'C',
						 le.tnt = 'P' or ri.tnt = 'P' => 'P',
						 le.tnt = 'R' or ri.tnt = 'R' => 'R', 'H');
		SELF := le;
	END;

	cmp_res_wtnt_roll := ROLLUP(SORT(cmp_res_wtnt, seq), left.seq = right.seq, keepBestTNT(LEFT, RIGHT));

	cmp_res4 := if(srchMod.IncludeRealTimePhones, 
								project(cmp_res_wtnt_roll, seq_rec),
								cmp_res3);			

	/*--- Yellow Flag Codes ---*/
	yellow_codes := ['2265', '2325', '2310', '2210', '2230', '2290', '2215', '2220', '2320', '2345', '2225'];

	out_layout := record(Doxie_Raw.PhonesPlus_Layouts.t_PhoneplusSearchResponse)
		DATASET(AddressFeedback_Services.Layouts.feedback_report) Address_Feedback {MAXCOUNT(1)};
	end;
		
	out_layout trans_best(cmp_res4 l,outfile r) := transform
		tempssn := if (l.ssn = '',r.ssn,l.ssn);
		self.ssn := tempssn;
		self.penalt := l.penalt + doxie.FN_Tra_Penalty_ssn(tempssn);
		Self.yellow_flag := if(srchMod.IncludeHRI, exists(L.hri_address(hri in yellow_codes)), false);
		self := l;
		self.Address_Feedback := [];
	end;

	results_best:= join(cmp_res4,outfile,(integer)left.did = right.did,
											trans_best(left,right),left outer,keep(1),limit(0));
																			 
	/*--- Back to code ---*/                  
	deathparams := DeathV2_Services.IParam.GetDeathRestrictions(globalmod);

	filteredResults := join(results_best, Doxie.key_death_masterV2_ssa_DID,
														keyed((integer)left.did = right.l_did)
														and	not DeathV2_Services.functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
														transform(out_layout,
																			self.deceased := 'N',
																			self := left),left only);

	resultsPlusDeath := join(results_best, Doxie.key_death_masterV2_ssa_DID,
														keyed((integer)left.did = right.l_did)
														and	not DeathV2_Services.functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
														transform(out_layout,
																			self.deceased := if ( right.l_did > 0,'Y','N'),  
																			self.dod := (integer)right.dod8, 
																			self := left),
														left outer,limit(ut.limits.DEATH_PER_DID),keep(1));

	resultsToMask := if (IncludeDeadContacts,resultsPlusDeath,filteredResults);

	resultsFilterRes := if(excludeResidence,resultsToMask(listing_type_bus <> '' or listing_type_res = ''), resultsToMask);
	resultsFilterBus := if(excludeBusiness, resultsFilterRes(listing_type_res <> '' or listing_type_bus = ''), resultsFilterRes);

	Suppress.MAC_Mask(resultsFilterBus, cmp_res_out, ssn, blank, true, false,,,,SSN_mask_value);		

	// **************************************************************************************
	// Start of June 2016 corrections to the 04/19/16 "RTP Synchrony Port Update" changes.
	// NOTE: the checking for "ported phones" and setting of service_type ouput field coding
	//       is triggered by the "SuppressNewPorting" roxie input option.  
	//
	// First sort/dedup to only keep unique phone#s to reduce the ported phones key join matches
	ds_cmp_res_out_dd := dedup(sort(cmp_res_out,phone),phone);

	// Then do a a one-time join to the "phones_ported_metadata" key (NOTE:key name is miss-leading
	//    since it contains more than just "ported" phones) 
	// and keep the matching key records to be used for mutiple places below.
	ds_ppmd_key_recs := join(ds_cmp_res_out_dd, PhonesInfo.Key_Phones.Ported_Metadata,
															keyed(left.phone = right.phone),
													 transform(right),
													 inner, limit(doxie.phone_noreconn_constants.MaxPortedMatches,skip));

	// Join a second time, the orig cmp_res_out to the ds_ppmd_key_recs comparing the 
	// left date_first/last_seen (+/-5 days) vs right port_start/end dates to save the port dates.
	out_layout_plus_portinfo := record
		out_layout;
		PhonesInfo.Layout_common.portedMetadata_Main.port_start_dt;
		PhonesInfo.Layout_common.portedMetadata_Main.port_end_dt;
	end;

	ds_ported_dt_match := join(cmp_res_out, ds_ppmd_key_recs,
															 left.phone = right.phone and
															 // from key recs, only use the 2 sources (PJ & PK) that have ported info
															 right.source in MDR.sourceTools.set_PhonesPorted and
															 // check person/phone dates vs ported key port dates
															 (unsigned) ut.date_math(left.dt_first_seen, 
																						 -doxie.phone_noreconn_constants.PortingMarginOfError)
																					<= right.port_start_dt and
															 (unsigned) ut.date_math(left.dt_last_seen, 
																						 doxie.phone_noreconn_constants.PortingMarginOfError)
																					>= max(right.port_end_dt,right.port_start_dt),
															 transform(out_layout_plus_portinfo,
																 self.port_start_dt := right.port_start_dt,
																 self.port_end_dt	  := right.port_end_dt, 
																 self :=left),
															 left outer); // keep left ds recs even if don't match right

	// Sort/dedup to only keep the most recent port dates for each acctno/did/phone#
	ds_ported_most_recent := dedup(sort(ds_ported_dt_match,
																			acctno, did, phone,
																			-port_start_dt,
																			-(port_end_dt=0), // sort 0 port_end dates first
																			-port_end_dt),
																 acctno, did, phone);

	// Filter to only keep phones ported more than 7 days from the current date or
	// that were not ported at all (port start/end dates = 0).
	// v--- NOTE: SuppressPortedTestDate is for roxie internal testing ONLY !!!!!!!!!!!!!!!
	string8 SuppressPortedTestDate := (string8) STD.Date.Today() : STORED('SuppressPortedTestDate');
	string8 current_date           := SuppressPortedTestDate;

	ds_phones_kept  := ds_ported_most_recent(
												ut.DaysApart((string) max(port_end_dt, port_start_dt), current_date)
												> doxie.phone_noreconn_constants.PortingSuppressLimit); //limit is 7 days

	// Then join original cmp_res_out ds of all phones to see which ones should be kept.
	ds_ported_kept := join(cmp_res_out, ds_phones_kept,
														left.acctno = right.acctno and
														left.did    = right.did    and
														left.phone = right.phone,
												 transform(left),
												 inner); // only keep left ds recs that match to right

	// For all kept phones, set the service_type field.
	//
	// First sort/dedup ported key recs to only keep the one rec with most recent port date for each phone#
	ds_ppmd_kr_deduped := dedup(sort(ds_ppmd_key_recs,
																	 phone,
																	 -vendor_last_reported_dt,
																	 -port_start_dt,
																	 -(port_end_dt=0), // sort 0 port end dates first
																	 -port_end_dt, 
																	 -(serv !=''), serv), // sort ones with non blank serv first
															phone);

	// Final join to set service_type
	ds_ported_servtype := join(ds_ported_kept, ds_ppmd_kr_deduped,
																left.phone = right.phone,
														 transform(out_layout,
																self.service_type := 
																	case(right.serv,  
																			 (string)doxie.phone_noreconn_constants.servType.Landline
																									=> doxie.phone_noreconn_constants.servDesc[1],
																			 (string)doxie.phone_noreconn_constants.servType.Wireless
																									=> doxie.phone_noreconn_constants.servDesc[2],
																			 (string)doxie.phone_noreconn_constants.servType.VOIP
																									=> doxie.phone_noreconn_constants.servDesc[3],
																			 doxie.phone_noreconn_constants.servDesc[4]);
																self              := left),
														 left outer);

	// Only when "SuppressNewPorting" input option is "true", use the ported checked data 
	//Supressing 'Voip' records for synchrony
	port_results := ds_ported_servtype(service_type != doxie.phone_noreconn_constants.servDesc[3]);
	ds_results_ported_checked := MAP( excludeLandlines => port_results(service_type != doxie.phone_noreconn_constants.servDesc[1]),
																		SuppressNewPorting => port_results,
																		cmp_res_out);

	doxie.MAC_Marshall_Results_NoCount(ds_results_ported_checked,resultsPreFB,,disp_cnt);

	// End of June 2016 corrections 
	// ****************************

	PhonesFeedback_Services.Mac_Append_Feedback(resultsPreFB
																							,did
																							,Phone
																							,resultsPhnFB);			

	resultsWithPhnFB := if(IncludePhonesFeedback,resultsPhnFB,resultsPreFB);

	AddressFeedback_Services.MAC_Append_Feedback(resultsWithPhnFB, resultsAddrFB, address_feedback,,,,,,,,,,1);

	resultsWithAddrFB := if(IncludeAddressFeedback, resultsAddrFB, resultsWithPhnFB);


	results := if(UseDateSort,sort(resultsWithAddrFB,-dt_last_seen,penalt),resultsWithAddrFB);

	results_friendly := project(results, transform(recordof(results), 
											 self.COCDescription := [],
											 self.SSCDescription := [],
											 self.RealTimePhone_Ext := [],
											 self := left));
			 
	Royalty.MAC_RoyaltyLastResort(results,lastresort_royalties)
	targus_royalties := Royalty.RoyaltyTargus.GetOnlineRoyalties(results,,,trackPDE:=phoneOnlySearch,trackWCS:=doxie.DataPermission.use_confirm, trackVE:=~phoneOnlySearch);
	Royalty.MAC_RoyaltyQSENT(results, qsent_royalties, use_qt, call_PVS and use_PVS)						
	Royalty.MAC_RoyaltyMetronet(results, metronet_royalties, vendor_id, MDR.sourceTools.src_Metronet_Gateway);	

	royalties := dataset([], Royalty.Layouts.Royalty)  
								 + if(use_tg and ~call_PVS, targus_royalties)  
								 + qsent_royalties
								 + if (use_LR, lastresort_royalties)
								 + if(use_Metronet, metronet_royalties);

	out_royal := output(royalties,named('RoyaltySet'));

	if(issueHint,ut.outputMessage(ut.constants_MessageCodes.TRYSSN4));

	out_rslt := output(if(~batch_friendly,results,results_friendly), named('Results'));


	// OUTPUT(use_PVS,NAMED('use_PVS'));
	// OUTPUT(call_pvs,NAMED('call_pvs'));
	// OUTPUT(PVS_GW_w_tzone,NAMED('PVS_GW_w_tzone'))
	// OUTPUT(PVS_gw_rslt,NAMED('PVS_gw_rslt'));
	// OUTPUT(cmp_res_seq,NAMED('cmp_res_seq'));
	// output(h0_tf,named('PhonesPlus'));	 
	// output(h_targus,named('Targus'));
	// output(h_qsent,named('h_qsent'));	 
	// output(gong_dids,named('gong_dids'));	 
	// output(gong_recs,named('gong_recs'));	 
	// output(h1_raw ,named('h1raw'));	 
	// output(h3p,named('gongPlusTargus'));	 
	// output(g2,named('Telcordia'));	 
	// output(preFinal3,named('preFinal3'));	 
	// output(cmp_res_out,named('cmp_res_out'));	 
	// output(lengthSSN,named('lengthSSN'));
	// output(conductSSNSearch,named('conductSSNSearch'));
	// output(ds_cmp_res_out_dd,named('ds_cmp_res_out_dd'));
	// output(ds_ppmd_key_recs,named('ds_ppmd_key_recs'));
	// output(ds_ported_dt_match,named('ds_ported_dt_match'));
	// output(ds_ported_most_recent,named('ds_ported_most_recent'));
	// output(suppressportedtestdate,named('suppressportedtestdate'));
	// output(current_date,named('current_date'));
	// output(ds_phones_kept,named('ds_phones_kept'));
	// output(ds_ported_kept,named('ds_ported_kept'));
	// output(ds_ppmd_kr_deduped,named('ds_ppmd_kr_deduped'));
	// output(ds_ported_servtype,named('ds_ported_servtype'));
	// output(ds_results_ported_checked,named('ds_results_ported_checked'));
	// output(resultsPreFB,named('resultsPreFB'));

	if(~batch_friendly, 
		 if(use_tg or use_qt or call_PVS or use_LR or use_metronet, parallel(disp_cnt, out_royal, out_rslt), parallel(disp_cnt, out_rslt)),out_rslt);

ENDMACRO;
// doxie.phone_noreconn_search();