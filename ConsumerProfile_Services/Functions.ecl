import Risk_Indicators, iesp, ut, Address, RiskWiseFCRA, RiskWise, FCRA, FFD, Models;

EXPORT Functions := MODULE
		
	//Project to Risk_Indicators layout for BocaShell
	export getBocaShellStandardInputLayout(iesp.fcraconsumerprofilereport.t_ConsumerProfileReportBy in_rec) := function
		unsigned3 history_date := 999999; //HistoryDateYYYYMM not included in the input
		unsigned1 age_value := 0; //Age not included in the input
		string10  wphone_value := '' ; //WorkPhone not included in the input
		string25  country_value := '';//Country not included in the input
		string20  drlc_value := '';  //DLNumber not included in the input
		string2   drlcstate_value := ''; //DLState not included in the input
		string100 email_value := ''; //Email not included in the input
		string45  ip_value := ''; //IPAddress not included in the input
		string100 cmpy_value := '';//EmployerName not included in the input
		string30  formerlast_value := ''; //FormerName not included in the input
		Risk_Indicators.Layout_Input xformBocashellInput(iesp.fcraconsumerprofilereport.t_ConsumerProfileReportBy L) := TRANSFORM
			self.DID 	:= (unsigned)L.UniqueId; 	
			self.score:= if(self.DID <> 0, 100, 0);
			self.seq 	:= 1; //only have one rec coming in
			self.ssn 	:= IF(L.SSN = '000000000', '', L.SSN);	// blank out social if it is all 0's
			self.dob 	:= iesp.ECL2ESP.DateToString(L.DOB);		
			// self is Layout_Input, which defines age as STRING3, so cast the appropriate values to that type.
			// make age archivable
			self.age := if (age_value = 0 and (integer)self.DOB != 0, 
											(STRING3)ut.GetAgeI_asOf((unsigned)self.DOB, (unsigned)risk_indicators.iid_constants.myGetDate(history_date)), 
											(STRING3)age_value);		
			self.phone10:= L.Phone10;
			useCleanName:= L.Name.Full <> '';
			cleanName		:= Address.CleanNameFields(Address.CleanPerson73(L.Name.Full)).CleanNameRecord;
			self.title 	:= if(useCleanName, cleanName.title, stringlib.stringtouppercase(L.Name.Prefix));
			self.fname 	:= if(useCleanName, cleanName.fname, stringlib.stringtouppercase(L.Name.First));
			self.mname 	:= if(useCleanName, cleanName.mname, stringlib.stringtouppercase(L.Name.Middle));
			self.lname 	:= if(useCleanName, cleanName.lname, stringlib.stringtouppercase(L.Name.Last));
			self.suffix := if(useCleanName, cleanName.name_suffix, stringlib.stringtouppercase(L.Name.Suffix));
			self.in_streetAddress := L.Address.StreetAddress1;
			self.in_city 			:= L.Address.City;
			self.in_state 		:= L.Address.State;
			self.in_zipCode 	:= L.Address.Zip5;
			self.in_country 	:= country_value;		
			addr1							:= L.Address.StreetAddress1 + ' ' + L.Address.StreetAddress2;
			addr2 						:= Address.Addr2FromComponents(L.Address.City, L.Address.State, L.Address.Zip5);
			clean_addr 				:= address.GetCleanAddress(addr1,addr2,address.Components.country.US);
			ca_res						:= clean_addr.results;			
			self.prim_range 	:= ca_res.prim_range;
			self.predir 			:= ca_res.predir;
			self.prim_name 		:= ca_res.prim_name;
			self.addr_suffix 	:= ca_res.suffix;
			self.postdir 			:= ca_res.postdir;
			self.unit_desig 	:= ca_res.unit_desig;
			self.sec_range 		:= ca_res.sec_range;
			self.p_city_name 	:= ca_res.v_city;//Models.RiskView_Records p_city_name uses [90..114] of clean address which corresponds to v_city
			self.st 					:= ca_res.state;
			self.z5 					:= ca_res.zip;
			self.zip4 				:= ca_res.zip4;
			self.lat 					:= ca_res.latitude;
			self.long 				:= ca_res.longitude;
			self.addr_type		:= ca_res.address_type;
			self.addr_status 	:= ca_res.error_msg;
			self.county 			:= ca_res.county;
			self.geo_blk 			:= ca_res.geo_blk;
			//the following fields are blank as their values are not included as part of the input for this service
			self.historydate:= history_date; 
			self.wphone10		:= wphone_value;		
			self.country		:= country_value;
			dl_num 					:= stringlib.stringFilterOut(drlc_value,'-');
			dl_num2 				:= stringlib.stringFilterOut(dl_num,' ');	
			self.dl_number 	:= stringlib.stringtouppercase(dl_num2);
			self.dl_state 	:= stringlib.stringtouppercase(drlcstate_value);		
			self.email_address := email_value;
			self.ip_address := ip_value;			
			self.employer_name := stringlib.stringtouppercase(cmpy_value);
			self.lname_prev := stringlib.stringtouppercase(formerlast_value);
		END;
		out_rec := PROJECT(in_rec, xformBocashellInput(left));
		return out_rec;
	end;
		
	//Rollup FCRA header data on DID to concatenate best record
	EXPORT getBestRecord(dataset(ConsumerProfile_Services.Layouts.working) ds_in) := function
		ConsumerProfile_Services.Layouts.working xformRoll2Best(ConsumerProfile_Services.Layouts.working L, ConsumerProfile_Services.Layouts.working R) := transform
			self.title 				:= if(L.title <> '', L.title, R.title);
			self.fname 				:= if(L.fname <> '', L.fname, R.fname);
			self.mname 				:= if(L.mname <> '', L.mname, R.mname);
			self.lname 				:= if(L.lname <> '', L.lname, R.lname);
			self.name_suffix 	:= if(L.name_suffix <> '', L.name_suffix, R.name_suffix); //TODO: DO I WANT TO CONCATENATE NAME LIKE THIS...
			self.ssn					:= if(L.ssn <> '', L.ssn, R.ssn);
			self.dob					:= if(L.dob <> 0, L.dob, R.dob);
			self.StatementIds := FFD.Constants.BlankStatements; // no record level statements for header data
			self 							:= L;
		end;
		//sort to ensure oldest record is at the top
		ds_sort := sort(ds_in, did, -dt_last_seen, dt_first_seen, -persistent_record_id);
		best_header_ds := rollup(ds_sort, left.did = right.did, xformRoll2Best(left, right));
		
	 RETURN best_header_ds;
	END;
	
	//Get address history from FCRA header data
	EXPORT getAddressHistory(dataset(ConsumerProfile_Services.Layouts.working) ds_in) := function
		ds_filt_sort := sort(ds_in, prim_range, prim_name, city_name, st, zip, sec_range);
		ds_in xformRollDup(ds_in L, ds_in R) := transform
			self.dt_last_seen := if(L.dt_last_seen > R.dt_last_seen, L.dt_last_seen, R.dt_last_seen);
			self.dt_first_seen := if(L.dt_first_seen < R.dt_first_seen and L.dt_first_seen <> 0, 
															 L.dt_first_seen, if(R.dt_first_seen <> 0, R.dt_first_seen, L.dt_first_seen)); //to get full dt_seen range on an address
			self.StatementIds := FFD.Constants.BlankStatements;  // no record level statements for header data		
			self := L;
		end;
		ds_filt_roll := rollup(ds_filt_sort, left.prim_range = right.prim_range and
															left.prim_name = right.prim_name and
															left.sec_range = right.sec_range,
															xformRollDup(left, right));
										 
	 ds_sort_out := sort(ds_filt_roll, -dt_last_seen, dt_first_seen, -persistent_record_id);
	 
	 RETURN ds_sort_out;
	END;
	
	//Get verification code and description based on NAS and NAP scores
	export calculateNASPDVerification(Risk_Indicators.Layout_Boca_Shell clam) := function
		//Name and SSN Verification
		attr := Models.Attributes_Master(clam, true); // isFCRA = true since it is being used only by an FCRA service.
		ssn_name_verif_code_pre := attr.ConfirmationInputSSN;
    //“-1” response to be displayed as a “0”		
		ssn_name_verif_code := if(ssn_name_verif_code_pre = '-1','0',ssn_name_verif_code_pre);
		string ssn_name_verif_desc := map(
																				//ssn_name_verif_code = '-1'  => '',
																				ssn_name_verif_code =  '0'  => 'No match as SSN not on file, input SSN is invalid, or SSN not provided as input',
																				ssn_name_verif_code =  '1'  => 'No match as input SSN linked to a different name and address on file',
																				ssn_name_verif_code =  '2'  => 'Input SSN matches SSN on file using close-matching miskey logic',
																				ssn_name_verif_code =  '3'  => 'Input SSN matches SSN on file as an exact match',
																				''
																				);
		
		//Address Verification
		unsigned1 addr_verif_code := map(clam.iid.nas_summary in ConsumerProfile_Services.Constants.ADDRESS_VERIFICATION.NO_MATCH => 0, //could also use nap_summary for this one...
																		 1); //clam.iid.nap_summary in ConsumerProfile_Services.Constants.ADDRESS_VERIFICATION.MATCH
		string addr_verif_desc := ConsumerProfile_Services.Constants.ADDRESS_VERIFICATION.DESCRIPTION(clam.iid.nas_summary);		
		
		//DOB Verification
		unsigned1 dob_verif_code := map(clam.dobmatchlevel in ConsumerProfile_Services.Constants.DOB_VERIFICATION.NO_MATCH 		  => 0,
																	  clam.dobmatchlevel in ConsumerProfile_Services.Constants.DOB_VERIFICATION.PARTIAL_MATCH => 1,
																	  2); //clam.dobmatchlevel in ConsumerProfile_Services.Constants.DOB_VERIFICATION.MATCH
		string dob_verif_desc := ConsumerProfile_Services.Constants.DOB_VERIFICATION.DESCRIPTION(clam.dobmatchlevel);
		
		//Phone Verification
		unsigned1 phone_verif_code := map(clam.iid.nap_summary in ConsumerProfile_Services.Constants.PHONE_VERIFICATION.NO_ADDR_MATCH 			=> 0,
																			1); //clam.iid.nap_summary in ConsumerProfile_Services.Constants.PHONE_VERIFICATION.ADDRESS_MATCH
																			// clam.iid.nap_summary in ConsumerProfile_Services.Constants.PHONE_VERIFICATION.ADDRESS_MATCH	=> 1,
																		 // 2); //anything else should be an empty string
		string phone_verif_desc := ConsumerProfile_Services.Constants.PHONE_VERIFICATION.DESCRIPTION(clam.iid.nap_summary);		

		iesp.fcraconsumerprofilereport.t_ConsumerProfileInputConfirmation xformInputVerificationOut() := transform
			self.SSNVerification.Code 						:= (string)ssn_name_verif_code;
			self.SSNVerification.Description 			:= ssn_name_verif_desc;
			self.AddressVerification.Code				 	:= (string)addr_verif_code;
			self.AddressVerification.Description 	:= addr_verif_desc;
			self.DOBVerification.Code 						:= (string) dob_verif_code;
			self.DOBVerification.Description 			:= dob_verif_desc;
			self.PhoneVerification.Code 					:= (string)phone_verif_code;//if(phone_verif_code <> 2, (string)phone_verif_code, '');
			self.PhoneVerification.Description 		:= phone_verif_desc;
		end;
		return row(xformInputVerificationOut());
	end;
	
	//Get High Risk Indicators
	export getHighRiskIndicators(Risk_Indicators.Layout_Boca_Shell clam) := function
		HRI_ds_codes(string code) := DATASET([{code,risk_indicators.getHRIDesc(code)}],risk_indicators.Layout_Desc);
		getHRI := RiskWise.Reasons(clam);
		
 		hri_ds 		:= 		IF(getHRI.rc02,HRI_ds_codes(ConsumerProfile_Services.Constants.Reason_Codes.S65)) &
      							IF(getHRI.rc03,HRI_ds_codes(ConsumerProfile_Services.Constants.Reason_Codes.S65)) &
      							IF(getHRI.rc06,HRI_ds_codes(ConsumerProfile_Services.Constants.Reason_Codes.S65)) &
      							IF(getHRI.rc25,HRI_ds_codes(ConsumerProfile_Services.Constants.Reason_Codes.F04)) &
      							IF(getHRI.rc39,HRI_ds_codes(ConsumerProfile_Services.Constants.Reason_Codes.S65)) &
      							IF(getHRI.rc79,HRI_ds_codes(ConsumerProfile_Services.Constants.Reason_Codes.F00)) &
      							IF(getHRI.rc99,HRI_ds_codes(ConsumerProfile_Services.Constants.Reason_Codes.F03));

		return hri_ds;
	end;
	
	//Alert Dataset
	export getAlertDataset(string alertCode) := function
		return dataset([{alertCode, FCRA.Constants.getAlertDescription(alertCode),
                    FCRA.Constants.getAlertMessage(alertCode)}], iesp.fcraconsumerprofilereport.t_ConsumerProfileAlert);
	end;
	
	//Extract Alerts from PersonContext
  export checkForAlertsFromPC(dataset(FFD.Layouts.PersonContextBatch) pc_recs, FFD.layouts.ConsumerFlagsBatch pc_consumer_flags,
                              integer8 inFFDOptionsMask = 0) := function
  
    pc_alerts := FFD.ConsumerFlag.prepareAlertMessages(pc_recs, pc_consumer_flags, inFFDOptionsMask);
    return project(pc_alerts, transform(iesp.fcraconsumerprofilereport.t_ConsumerProfileAlert, 
                    self.Code := left.Code,
                    self.Message := left.Message,
                    self.description := FCRA.Constants.getAlertDescription(left.Code)));
    
  end;
  
	//Extract Alerts from input
	export checkForAlertsFromInput(iesp.fcraconsumerprofilereport.t_ConsumerProfileReportBy in_rec,
																 ConsumerProfile_Services.IParam.options in_param) := function
		//Insufficient input, return alert code 50A
		boolean insufficientInput := in_param.intended_purpose = '' or 
																 ((unsigned)in_rec.UniqueId = 0 and
																  ((in_rec.Name.Full = '' and (in_rec.Name.First = '' or in_rec.Name.Last = '')) or in_rec.SSN = '') and
																	((in_rec.Name.Full = '' and (in_rec.Name.First = '' or in_rec.Name.Last = '')) or in_rec.Address.StreetAddress1 = '' or in_rec.Address.City = '' or in_rec.Address.State = '' or in_rec.Address.Zip5 = ''));
		return if(insufficientInput, getAlertDataset(FCRA.Constants.ALERT_CODE.INSUFFICIENT_INPUT_INFO));
	end;
	
	//Extract Alerts from clam output
	export checkForAlertsFromClam(Risk_Indicators.Layout_Boca_Shell clam,
																ConsumerProfile_Services.IParam.options in_param) := function
		//no lexID found, return alert code 222A
		boolean noDID := clam.did = 0;
		//security freeze, return alert code 100A
		boolean hasSecurityFreeze := clam.consumerFlags.security_freeze;
		//security fraud alert, return alert code 100B
		boolean hasSecurityFraudAlert := clam.consumerFlags.security_alert;
		//California or Rhodes Island state exceptions, return alert code 100D
		boolean isCaliforniaException := in_param.is_california and (
																		(integer)(boolean)clam.iid.combo_firstcount+(integer)(boolean)clam.iid.combo_lastcount
																		+(integer)(boolean)clam.iid.combo_addrcount+(integer)(boolean)clam.iid.combo_hphonecount
																		+(integer)(boolean)clam.iid.combo_ssncount+(integer)(boolean)clam.iid.combo_dobcount) < 3;
		boolean isRhodeIslandException := clam.rhode_island_insufficient_verification;
		boolean isStateException := isCaliforniaException or isRhodeIslandException;
		alert_ds := if(noDID, getAlertDataset(FCRA.Constants.ALERT_CODE.NO_DID_FOUND)) +
								if(hasSecurityFreeze, getAlertDataset(FCRA.Constants.ALERT_CODE.SECURITY_FREEZE)) + 
								if(hasSecurityFraudAlert, getAlertDataset(FCRA.Constants.ALERT_CODE.SECURITY_FRAUD_ALERT)) +
								if(isStateException, getAlertDataset(FCRA.Constants.ALERT_CODE.STATE_EXCEPTION));
		return alert_ds;
	end;
		
END;