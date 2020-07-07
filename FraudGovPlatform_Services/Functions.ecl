IMPORT Address, BatchShare, didville, FraudGovPlatform, FraudGovPlatform_Services, 
				FraudShared_Services, FraudShared, iesp, STD, ut;

EXPORT Functions := MODULE
	
	EXPORT getExternalServicesRecs(	DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in, 
																	FraudGovPlatform_Services.IParam.BatchParams batch_params) := FUNCTION

		raw_ := FraudGovPlatform_Services.Raw(ds_batch_in, batch_params);
		recs_Death := raw_.GetDeath();
		recs_Criminal := raw_.GetCriminal();
		recs_Patriot := raw_.GetGlobalWatchlist();
		recs_FDN := raw_.GetFDN();
		
		ds_instantIDRaw := raw_.getInstantIDRaw();
		
		recs_RedFlag := raw_.GetRedFlags(ds_instantIDRaw); 
		recs_CIID := raw_.GetCIID(ds_instantIDRaw);
		
		FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw xfm_Compilation(FraudShared_Services.Layouts.BatchIn_rec L) := TRANSFORM
			SELF.batchin_rec := L;
			SELF.childRecs_Death := recs_Death(acctno = L.acctno);
			SELF.childRecs_Criminal := recs_Criminal(acctno = L.acctno);
			SELF.childRecs_RedFlag := recs_RedFlag(seq = (INTEGER)L.acctno);
			SELF.childRecs_Patriot := UNGROUP(recs_Patriot(acctno = L.acctno));
			SELF.childRecs_FDN := recs_FDN(acctno = L.acctno);
			SELF.childRecs_CIID := UNGROUP(recs_CIID(seq = (INTEGER)L.acctno));
			SELF := L;
			SELF := [];
		END;

		final_recs := PROJECT(ds_batch_in, xfm_Compilation(LEFT));
		
		// Added for QA to display raw records coming out of external services, so its easy for them to test knownfrauds.
		#IF(FraudGovPlatform_Services.Constants.IS_DEBUG)
			output(recs_Death, named('recs_Death'));
			output(recs_Criminal, named('recs_Criminal'));
			output(recs_RedFlag, named('recs_RedFlag'));
			output(recs_Patriot, named('recs_Patriot'));
			output(recs_FDN, named('recs_FDN'));
			output(recs_CIID, named('recs_CIID'));
		#END

		return final_recs;
	END;
	
		EXPORT GetIndicatorAttributes(DATASET(FraudGovPlatform_Services.Layouts.elementNidentity_uid_recs) ds_in, FraudGovPlatform_Services.IParam.BatchParams batch_params) := FUNCTION
			
		indicator_out := RECORD
		  STRING20 acctno;
			iesp.fraudgovreport.t_FraudGovIndicatorAttribute;
		END;

		FraudGovPlatform_Services.Layouts.kel_filter_rec xform_getFilter(FraudGovPlatform_Services.Layouts.elementNidentity_uid_recs L) := TRANSFORM
			SELF.gc_id := batch_params.GlobalCompanyId;
			SELF.ind_type := batch_params.IndustryType;
			SELF.element := L;
		END;

		ds_kel_filter := PROJECT(ds_in,xform_getFilter(LEFT));

		indicator_out xform_getIndicatorAttribute(FraudGovPlatform_Services.Layouts.kel_filter_rec L, FraudGovPlatform.Key_ElementPivot R):= TRANSFORM
		  SELF.acctno := L.element.acctno;
			SELF.IndicatorTypeCode := R.indicatortype;
			SELF.IndicatorTypeDescription := R.indicatordescription;
			SELF.DataType := R.fieldtype;
			SELF.RiskLevel := (STRING)R.risklevel;
			SELF.DescriptionCode := R.field;
			SELF.Description := R.label; 
			SELF.DescriptionValue := R.value;
			SELF := [];
		END;

		ds_indicator_attributes := JOIN(ds_kel_filter, FraudGovPlatform.Key_ElementPivot(),
										KEYED(LEFT.gc_id = RIGHT.customer_id_ AND
											LEFT.ind_type = RIGHT.industry_type_ AND
											LEFT.element.entity_context_uid = RIGHT.entity_context_uid_),
										xform_getIndicatorAttribute(LEFT,RIGHT), LIMIT(FraudGovPlatform_Services.Constants.Limits.MAX_JOIN_LIMIT,SKIP));

		ds_indicator_attributes_dedup := DEDUP(SORT(ds_indicator_attributes,acctno, DescriptionCode,-DescriptionValue),acctno,DescriptionCode);	

		return ds_indicator_attributes_dedup;
	END;
		
	EXPORT getVelocityRecs(	DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
													FraudGovPlatform_Services.IParam.BatchParams batch_params,
													DATASET(FraudShared_Services.Layouts.Raw_Payload_rec) ds_payload) := FUNCTION

		//Following project is necessary to transform "ds_batch_in" to "BatchInExtended_rec" , which is actually used by Search service and is new input 
		//layout sent to FraudGovPlatform_Services.Raw_Records
		ds_batch_in_extended := PROJECT(ds_batch_in, FraudShared_Services.Layouts.BatchInExtended_rec);

		contributionType_recs_norm := FraudShared_Services.Functions.getFragmentMatchTypes(ds_batch_in_extended, ds_payload, batch_params);

		rules := FraudShared_Services.Functions.GetVelocityRules(batch_params);

		velocity_recs := FraudShared_Services.Functions.GetVelocityExceeded(contributionType_recs_norm, rules);

		velocity_top_recs:= FraudShared_Services.Functions.GetTopVelocityExceeded(velocity_recs, batch_params.maxvelocities);

		ds_rec_velocity_recs_denorm_w_payload:= FraudShared_Services.Functions.AddPayload(velocity_top_recs,ds_payload);

		FraudGovPlatform_Services.Layouts.velocities xform_out(ds_rec_velocity_recs_denorm_w_payload l) := TRANSFORM
			SELF.acctno := (STRING)l.acctno,	
			SELF.ds_payload := l.ds_payload,
			SELF :=  l;
		END;

		ds_velocities :=  PROJECT(SORT(ds_rec_velocity_recs_denorm_w_payload,  acctno),  xform_out(LEFT));

		RETURN ds_velocities;
	END;	
	
	EXPORT getKnownFrauds(DATASET(FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw) ds_records, 
												FraudGovPlatform_Services.IParam.BatchParams batch_params) := FUNCTION

		slim_knownrisk_rec := RECORD
			STRING20 acctno;
			STRING100 known_risk_reason;
			STRING8 event_date;
			STRING30 event_type;
		END;
		
		//Creating the tree_uid and entity_context_uid for fetching scores from kel keys. 
		ds_entityNameUID := PROJECT(ds_records, 
													TRANSFORM(FraudGovPlatform_Services.Layouts.elementNidentity_uid_recs,
														SELF.acctno := LEFT.acctno,
														SELF.entity_name := FraudGovPlatform_Services.Constants.Fragment_Types.PERSON_FRAGMENT, 
														SELF.entity_value := (string) LEFT.LexID,
														SELF.tree_uid := FraudGovPlatform_Services.Constants.KelEntityIdentifier._LEXID + (string) LEFT.LexID;
														SELF.entity_context_uid := FraudGovPlatform_Services.Constants.KelEntityIdentifier._LEXID + (string) LEFT.LexID;
														SELF := []));
														
		
		ds_indicator_attribute :=	GetIndicatorAttributes(ds_entityNameUID, batch_params);
		
		ds_indicator_attribute_sorted := SORT(ds_indicator_attribute(IndicatorTypeCode IN [FraudGovPlatform_Services.Constants.KelIndicatorType.KNOWN_RISK,FraudGovPlatform_Services.Constants.KelIndicatorType.IDENTITY]),
																				-IndicatorTypeCode,-RiskLevel,DescriptionCode,-DescriptionValue, RECORD);
		
		ds_known_risk_contrib := JOIN(ds_records(identity_resolved <> 'R'), ds_indicator_attribute_sorted,
																	LEFT.acctno = RIGHT.acctno,
																				TRANSFORM(slim_knownrisk_rec,
																					   SELF.acctno := RIGHT.acctno,
																						 SELF.known_risk_reason := RIGHT.Description,
																						 SELF.event_date := '',
																						 SELF.event_type := ''));
																											 
		ds_indicator_attribute_realtime_raw := FraudGovPlatform_Services.mod_RealTimeScoring(ds_records(identity_resolved = 'R'), batch_params).WeightedResult;
		
		ds_known_risk_realtime := JOIN(ds_records(identity_resolved = 'R'), ds_indicator_attribute_realtime_raw,
																	LEFT.acctno = RIGHT.acctno,
																				TRANSFORM(slim_knownrisk_rec,
																					   SELF.acctno := RIGHT.acctno,
																						 SELF.known_risk_reason := RIGHT.label,
																						 SELF.event_date := '',
																						 SELF.event_type := ''));
		
		known_risk_ds := ds_known_risk_contrib + ds_known_risk_realtime;
		
		RETURN known_risk_ds;
	END;

	EXPORT getFlatBatchOut(	DATASET(FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw) ds_records, 
												FraudGovPlatform_Services.IParam.BatchParams batch_params) := FUNCTION

		ds_knownFraud := getKnownFrauds(ds_records, batch_params);
		
		FraudGovPlatform_Services.Layouts.BatchOut_rec xfm_pre_batchout(FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw L) := TRANSFORM
			SELF.Seq := L.batchin_rec.Seq;
			unsigned4 VEL_CNT := COUNT(L.childRecs_Velocities);
			SELF.velocity_exceeded_cnt := VEL_CNT;
			SELF.velocity_exceeded_reason1 := IF(VEL_CNT >= 1, STD.Str.CleanSpaces(L.childRecs_Velocities[1].description), '');
			SELF.velocity_exceeded_reason2 := IF(VEL_CNT >= 2, STD.Str.CleanSpaces(L.childRecs_Velocities[2].description), '');
			SELF.velocity_exceeded_reason3 := IF(VEL_CNT >= 3, STD.Str.CleanSpaces(L.childRecs_Velocities[3].description), '');
			
			SELF := L;
			SELF := [];
		END;

		pre_ds_results := PROJECT(ds_records, xfm_pre_batchout(LEFT));
		
		FraudGovPlatform_Services.Layouts.BatchOut_rec xfm_batchout(FraudGovPlatform_Services.Layouts.BatchOut_rec L, DATASET(RECORDOF(ds_knownFraud)) R) := TRANSFORM
			
			SELF.known_risks_cnt 		:= COUNT(R);
			SELF.known_risk_reason1 := R[1].known_risk_reason;
			SELF.known_risk_reason2 := R[2].known_risk_reason;
			SELF.known_risk_reason3 := R[3].known_risk_reason;
			SELF.known_risk_reason4 := R[4].known_risk_reason;
			SELF.known_risk_reason5 := R[5].known_risk_reason;
			SELF := L;
		END;
		
		//ds_knownFraud_sorted := SORT(ds_knownFraud, acctno, -event_date,RECORD);
		
		ds_results := DENORMALIZE(pre_ds_results, ds_knownFraud,
															LEFT.acctno = RIGHT.acctno,
															GROUP,
															xfm_batchout(LEFT, ROWS(RIGHT)));

		RETURN ds_results;
	END;
	
	EXPORT getGovernmentBest(	DATASET(didville.Layout_Did_OutBatch) ds_best_in,
														FraudGovPlatform_Services.IParam.BatchParams batch_params) := FUNCTION

		
		ds_best := DidVille.did_service_common_function(ds_best_in,
																										appends_value			:= FraudGovPlatform_Services.Constants.append_l,
																										verify_value			:= FraudGovPlatform_Services.Constants.verify_l,
																										glb_flag					:= batch_params.isValidGLB(),
																										glb_purpose_value	:= batch_params.glb,
																										appType						:= batch_params.application_type,
																										include_minors		:= TRUE,
																										IndustryClass_val	:= batch_params.industry_class,
																										DRM_val						:= batch_params.DataRestrictionMask,
																										GetSSNBest				:= TRUE);
		
		iesp.fraudgovplatform.t_FraudGovBestInfo best_trans(RECORDOF(ds_best) L) := TRANSFORM	
			dob_ := iesp.ECL2ESP.toDate((integer) L.best_dob);
			masked_dob := iesp.ECL2ESP.ApplyDateMask(dob_, batch_params.dob_mask);
			
			SELF.UniqueId := (string) L.did;  
			SELF.Name.Prefix := L.best_title; 
			SELF.Name.First := L.best_fname; 
			SELF.Name.Middle := L.best_mname; 
			SELF.Name.Last := L.best_lname; 
			SELF.Name.Suffix := L.best_name_suffix;
			SELF.SSN := (string) L.best_ssn;
			SELF.DOB := masked_dob;
			SELF.Address := iesp.ECL2ESP.SetAddress('',
																							'', 
																							'', 
																							'', 
																							'', 
																							'', 
																							'',
																							L.best_city,
																							L.best_state, 
																							L.best_zip, 
																							L.best_zip4, 
																							'',
																							'',
																							L.best_addr1);
			SELF.Phone10 := L.best_phone;
			SELF := [];
		END;
		
		ds_best_proj := PROJECT(ds_best, best_trans(LEFT));
		
		RETURN ds_best_proj; 
	END;
	
	EXPORT getContributedBest(DATASET(didville.Layout_Did_OutBatch) ds_best_in,
														STRING fraud_platform,
														FraudGovPlatform_Services.IParam.BatchParams batch_params) := FUNCTION

		ds_rids:=	JOIN(ds_best_in, FraudShared.Key_Did(fraud_platform),
										KEYED(LEFT.did = RIGHT.did),
										TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
											SELF := LEFT,
											SELF := RIGHT,
											SELF := []),
									LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));

		ds_payload_recs := FraudGovPlatform_Services.fn_GetPayloadRecords(ds_rids, batch_params, fraud_platform:= fraud_platform);

		ds_payload_recs_sorted := SORT(ds_payload_recs, did, -event_date, record);

		FraudShared_Services.Layouts.Raw_Payload_rec xformRollup(FraudShared_Services.Layouts.Raw_Payload_rec L, FraudShared_Services.Layouts.Raw_Payload_rec R) := transform
				//We wanted to keep the record which has good address, instead of first non blank address...
				//We wanted to keep the name from record which has atleast last name given, instead of first non blank names...
				BOOLEAN isPhysicalAddress	:=  l.clean_address.prim_name != '' AND ((l.clean_address.p_city_name != '' AND l.clean_address.st != '') OR l.clean_address.zip != '');
				BOOLEAN isName := L.cleaned_name.lname <> '';

				SELF.AcctNo := L.Acctno;
				SELF.DID := L.DID;
				SELF.cleaned_name.title :=  IF(isName , L.cleaned_name.title , R.cleaned_name.title);
				SELF.cleaned_name.fname :=  IF(isName , L.cleaned_name.fname , R.cleaned_name.fname);
				SELF.cleaned_name.lname :=  IF(isName , L.cleaned_name.lname , R.cleaned_name.lname);
				SELF.cleaned_name.mname :=  IF(isName , L.cleaned_name.mname , R.cleaned_name.mname);
				SELF.cleaned_name.name_suffix :=  IF(L.cleaned_name.name_suffix <> '' , L.cleaned_name.name_suffix , R.cleaned_name.name_suffix);
				SELF.ssn :=  IF(L.ssn <> '' , L.ssn , R.ssn);
				SELF.dob :=  IF(L.dob <> '' , L.dob , R.dob);
				SELF.phone_number :=  IF(L.clean_phones.phone_number <> '' , L.clean_phones.phone_number , R.clean_phones.phone_number);
				SELF.email_address :=  IF(L.email_address <> '' , L.email_address , R.email_address);
				SELF.clean_address.prim_range := IF(isPhysicalAddress, L.clean_address.prim_range, R.clean_address.prim_range);
				SELF.clean_address.predir := IF(isPhysicalAddress, L.clean_address.predir, R.clean_address.predir);
				SELF.clean_address.prim_name := IF(isPhysicalAddress, L.clean_address.prim_name, R.clean_address.prim_name);
				SELF.clean_address.addr_suffix := IF(isPhysicalAddress, L.clean_address.addr_suffix, R.clean_address.addr_suffix);
				SELF.clean_address.postdir := IF(isPhysicalAddress, L.clean_address.postdir, R.clean_address.postdir);
				SELF.clean_address.unit_desig := IF(isPhysicalAddress, L.clean_address.unit_desig, R.clean_address.unit_desig);
				SELF.clean_address.sec_range := IF(isPhysicalAddress, L.clean_address.sec_range, R.clean_address.sec_range);
				SELF.clean_address.p_city_name := IF(isPhysicalAddress, L.clean_address.p_city_name, R.clean_address.p_city_name);
				SELF.clean_address.v_city_name := IF(isPhysicalAddress, L.clean_address.v_city_name, R.clean_address.v_city_name);
				SELF.clean_address.st := IF(isPhysicalAddress, L.clean_address.st, R.clean_address.st);
				SELF.clean_address.zip := IF(isPhysicalAddress, L.clean_address.zip, R.clean_address.zip);
				SELF.clean_address.zip4 := IF(isPhysicalAddress, L.clean_address.zip4, R.clean_address.zip4);
				SELF := [];
		END;

		ds_payload_recs_rolled := ROLLUP(	ds_payload_recs_sorted, left.did = right.did, xformRollup(left, right));

		iesp.fraudgovreport.t_FraudGovIdentityCardDetails best_trans(FraudShared_Services.Layouts.Raw_Payload_rec L) := TRANSFORM
			SELF.ContributedBest.UniqueId := (string) L.DID;
			SELF.ContributedBest.Name.Prefix := L.cleaned_name.title;
			SELF.ContributedBest.Name.First := L.cleaned_name.fname;
			SELF.ContributedBest.Name.Middle := L.cleaned_name.mname;
			SELF.ContributedBest.Name.Last := L.cleaned_name.lname;
			SELF.ContributedBest.Name.Suffix := L.cleaned_name.name_suffix;
			SELF.ContributedBest.SSN := L.ssn;
			SELF.ContributedBest.DOB := iesp.ECL2ESP.toDatestring8(L.dob);
			SELF.ContributedBest.Address := iesp.ECL2ESP.SetAddress(L.clean_address.prim_name,
																															L.clean_address.prim_range,
																															L.clean_address.predir,
																															L.clean_address.postdir,
																															L.clean_address.addr_suffix,
																															L.clean_address.unit_desig,
																															L.clean_address.sec_range,
																															L.clean_address.p_city_name,
																															L.clean_address.st,
																															L.clean_address.zip,
																															L.clean_address.zip4,
																															'');
			SELF.ContributedBest.Phone10 :=  L.clean_phones.phone_number;
			SELF.EmailAddress := L.email_address;
			SELF := [];
		END;

		ds_Contrib_Best := PROJECT(ds_payload_recs_rolled, best_trans(LEFT));
		
		// output(ds_payload_recs_sorted, named('ds_payload_recs_sorted'));
		// output(ds_Contrib_Best, named('ds_Contrib_Best'));
		
		RETURN ds_Contrib_Best;
	END;
	
	EXPORT GetDeltabaseLogDataSet(ds_in,InquiryReason) := FUNCTIONMACRO
		
		commonRecord := RECORD
			RECORDOF(ds_in.FraudGovUser) fraudGovUser;
			#IF(InquiryReason=FraudGovPlatform_Services.Constants.ServiceType.REPORT)
					RECORDOF(ds_in.reportBy) reportBy;
			#ELSE
					RECORDOF(ds_in.searchBy) reportBy;
			#END
		
			RECORDOF(ds_in.Options) options;
		END;
		
		commonRecord createCommonDs(RECORDOF(ds_in) L) := TRANSFORM	
			SELF.fraudGovUser := L.FraudGovUser;
			
			//Storing either reportBy or searchBy, depending on calling service
			//The input layouts have almost completely the same fields, however
			//FraudGovPlatform_Services.SearchService input layout named part of them in the SearchBy
			//sublayout
			//whereas the same set of fields for FraudGovPlatform_Services.ReportService are stored
			//in the ReportBy sublayout
			#IF(InquiryReason=FraudGovPlatform_Services.Constants.ServiceType.REPORT)
				SELF.reportBy := L.reportBy;
			#ELSE
				SELF.reportBy := L.searchBy;
			#END
			
			SELF.options := L.options;
		END;
		
		common_ds := PROJECT(ds_in, createCommonDs(LEFT));
		
		today := STD.Date.CurrentDate(True);
		time := STD.Date.CurrentTime(True);
		today_str :=  intformat(STD.Date.Year(today),4,1)  + '-' + intformat(STD.Date.Month(today),2,1) + '-' + 
									intformat(STD.Date.Day(today),2,1)   + ' ' + intformat(STD.Date.Hour(time),2,1)   + ':' + 
									intformat(STD.Date.Minute(time),2,1) + ':' + intformat(STD.Date.Second(time),2,1);
		
		FraudGovPlatform_Services.Layouts.LOG_Deltabase_Layout_Record xform_deltabase_log(commonRecord L):= TRANSFORM
			SELF.gc_id := (STRING)L.FraudGovUser.GlobalCompanyId;
			SELF.program_name := L.FraudGovUser.IndustryTypeName;
			SELF.inquiry_reason := InquiryReason;
			SELF.reason_description := InquiryReason;
			SELF.inquiry_source := FraudGovPlatform_Services.Constants.INQUIRY_SOURCE;
			SELF.file_type := FraudGovPlatform_Services.Constants.PayloadFileTypeEnum.IdentityActivity;
			
			#IF(InquiryReason=FraudGovPlatform_Services.Constants.ServiceType.REPORT)
				//SELF.customer_county_code := L.options.AgencyCounty;
				SELF.customer_county_code :=  Address.County_Names(state_alpha=L.options.AgencyState,
																														county_name=L.options.AgencyCounty)[1].county_code;
				SELF.customer_state := L.options.AgencyState;
				SELF.customer_vertical_code := L.options.AgencyVerticalType;
				SELF.client_uid := '';
				SELF.case_id := '';
			#ELSEIF(InquiryReason=FraudGovPlatform_Services.Constants.ServiceType.SEARCH)
				SELF.customer_county_code := '';
				SELF.customer_state := '';
				SELF.customer_vertical_code := '';
				SELF.client_uid := L.reportBy.CustomerPersonId;
				SELF.case_id := L.reportBy.HouseholdId;
			#END
			
			SELF.ssn := L.reportBy.ssn;
			SELF.dob := iesp.ECL2ESP.t_DateToString8(L.reportBy.DOB);
			SELF.lex_id := (INTEGER)L.reportBy.UniqueId;
			SELF.name_full := L.reportBy.Name.Full;
			SELF.name_prefix := L.reportBy.Name.Prefix;
			SELF.name_first := L.reportBy.Name.first;
			SELF.name_middle := L.reportBy.Name.middle;
			SELF.name_last := L.reportBy.Name.last;
			SELF.name_suffix := L.reportBy.Name.suffix;
			// If StreetAddress is empty, then use the parsed address fields
			Physical_address:= 	IF(L.reportBy.Address.StreetAddress1 = '',
															Address.Addr1FromComponents(L.reportBy.Address.StreetNumber, 
																													L.reportBy.Address.StreetPreDirection,
																													L.reportBy.Address.StreetName, L.reportBy.Address.StreetSuffix,
																													L.reportBy.Address.StreetPostDirection,L.reportBy.Address.UnitDesignation,
																													L.reportBy.Address.UnitNumber),
															STD.Str.CleanSpaces(L.reportBy.Address.StreetAddress1) + ' ' + STD.Str.CleanSpaces(L.reportBy.Address.StreetAddress2));			
			SELF.full_address := Physical_address;
			SELF.physical_address := Physical_address;
			SELF.physical_city := L.reportBy.Address.City;
			SELF.physical_state := L.reportBy.Address.State;
			SELF.physical_zip := L.reportBy.Address.Zip5;
			SELF.physical_county := L.reportBy.Address.County;
			SELF.mailing_address := IF(L.reportBy.MailingAddress.StreetAddress1 = '',
																	Address.Addr1FromComponents(L.reportBy.MailingAddress.StreetNumber, 
																															L.reportBy.MailingAddress.StreetPreDirection,
																															L.reportBy.MailingAddress.StreetName, L.reportBy.MailingAddress.StreetSuffix,
																															L.reportBy.MailingAddress.StreetPostDirection,L.reportBy.MailingAddress.UnitDesignation,
																															L.reportBy.MailingAddress.UnitNumber),
																	STD.Str.CleanSpaces(L.reportBy.MailingAddress.StreetAddress1) + ' ' + STD.Str.CleanSpaces(L.reportBy.MailingAddress.StreetAddress2));
			SELF.mailing_city := L.reportBy.MailingAddress.City;
			SELF.mailing_state := L.reportBy.MailingAddress.State;
			SELF.mailing_zip := L.reportBy.MailingAddress.Zip5;
			SELF.mailing_county := L.reportBy.MailingAddress.County;
			SELF.phone := L.reportBy.Phone10;
			SELF.ultid := L.reportBy.BusinessLinkIds[1].ultid;
			SELF.orgid := L.reportBy.BusinessLinkIds[1].orgid;
			SELF.seleid := L.reportBy.BusinessLinkIds[1].seleid;
			SELF.tin := L.reportBy.tin;
			SELF.email_address := L.reportBy.EmailAddress;
			SELF.appendedproviderid := L.reportBy.appendedproviderid;
			SELF.lnpid := L.reportBy.lnpid;
			SELF.npi := L.reportBy.npi;
			SELF.ip_address := L.reportBy.IpAddress;
			SELF.device_id := L.reportBy.DeviceId;
			SELF.professional_id := L.reportBy.ProfessionalId;
			SELF.bank_routing_number := L.reportBy.BankInformation.BankRoutingNumber;
			SELF.bank_account_number := L.reportBy.BankInformation.BankAccountNumber;
			SELF.dl_state := L.reportBy.DriversLicense.DriversLicenseState;
			SELF.dl_number := L.reportBy.DriversLicense.DriversLicenseNumber;
			SELF.geo_lat := L.reportBy.GeoLocation.Latitude;
			SELF.geo_long := L.reportBy.GeoLocation.Longitude;
			SELF.date_added := today_str;
			SELF := L;
			SELF := [];
		END;
	
		deltabase_inquiry_log_records := PROJECT(common_ds,xform_deltabase_log(LEFT));

		//Transform to create final XPATH layout that ESP requires
		FraudGovPlatform_Services.Layouts.LOG_Deltabase_Layout xForm_get_records(FraudGovPlatform_Services.Layouts.LOG_Deltabase_Layout_Record L) := TRANSFORM
			SELF.records := deltabase_inquiry_log_records; 
		END;

		deltabase_inquiry_log := PROJECT(deltabase_inquiry_log_records,xForm_get_records(LEFT));

		return deltabase_inquiry_log;
		
	ENDMACRO;
	
	EXPORT GetFragmentRecs (DATASET(FraudShared_Services.Layouts.BatchInExtended_rec) ds_freg_recs_in,
													DATASET(FraudShared_Services.Layouts.Raw_payload_rec) ds_payload,
													FraudGovPlatform_Services.IParam.BatchParams batch_params,
													Boolean skip_autokey_ds_matching = FALSE) := FUNCTION

		_Constant := FraudGovPlatform_Services.Constants;
		Fragment_Types_const := _Constant.Fragment_Types;
		File_Type_Const := _Constant.PayloadFileTypeEnum;													
	
		ds_fragment_recs := FraudShared_Services.Functions.getMatchedEntityTypes(ds_freg_recs_in, ds_payload, skip_autokey_ds_matching, 
												_Constant.FRAUD_PLATFORM);

		FraudGovPlatform_Services.Layouts.fragment_w_value_recs  ds_fragment_recs_w_trans(FraudShared_Services.layouts.layout_velocity_in L, 
																																											FraudShared_Services.Layouts.Raw_Payload_rec R)  := TRANSFORM
			
			BOOLEAN isBankAccountNumber1 := EXISTS(ds_freg_recs_in(bank_account_number <> '' AND bank_account_number = R.bank_account_number_1));
			BOOLEAN isBankAccountNumber2 := EXISTS(ds_freg_recs_in(bank_account_number <> '' AND bank_account_number = R.bank_account_number_2));
			
			bankRountingNumber1 := IF(isBankAccountNumber1 AND R.bank_routing_number_1 <> '', TRIM(R.bank_routing_number_1, LEFT, RIGHT), ' '); 
			bankRountingNumber2 := IF(isBankAccountNumber2 AND R.bank_routing_number_2 <> '', TRIM(R.bank_routing_number_2, LEFT, RIGHT), ' ');
			
			bank_info_to_use := MAP(isBankAccountNumber1 => bankRountingNumber1 + _Constant.FRAGMENT_SEPARATOR + R.bank_account_number_1,
															isBankAccountNumber2 => bankRountingNumber2 + _Constant.FRAGMENT_SEPARATOR + R.bank_account_number_2,
															'');
			
			SELF.fragment_value := CASE(L.fragment, 
																	Fragment_Types_const.BANK_ACCOUNT_NUMBER_FRAGMENT => bank_info_to_use,
																	Fragment_Types_const.DEVICE_ID_FRAGMENT => R.device_id,
																	Fragment_Types_const.DRIVERS_LICENSE_NUMBER_FRAGMENT => STD.Str.CleanSpaces(R.drivers_license) + _Constant.FRAGMENT_SEPARATOR + STD.Str.CleanSpaces(R.Drivers_License_State),
																	// Fragment_Types_const.GEOLOCATION_FRAGMENT => R.clean_address.geo_lat + ' ' + R.clean_address.R.geo_long,
																	Fragment_Types_const.IP_ADDRESS_FRAGMENT => R.ip_address	,
																	Fragment_Types_const.MAILING_ADDRESS_FRAGMENT => (STD.Str.CleanSpaces(R.additional_address.address_1) + ' ' + STD.Str.CleanSpaces(R.additional_address.address_2)),
																	Fragment_Types_const.NAME_FRAGMENT => (R.cleaned_name.fname + ' ' + R.cleaned_name.lname),
																	Fragment_Types_const.PERSON_FRAGMENT => (string) R.did,
																	Fragment_Types_const.PHONE_FRAGMENT => R.clean_phones.phone_number,
																	Fragment_Types_const.PHYSICAL_ADDRESS_FRAGMENT => STD.Str.CleanSpaces(R.address_1) + _Constant.FRAGMENT_SEPARATOR + STD.Str.CleanSpaces(R.address_2),
																	Fragment_Types_const.SSN_FRAGMENT => R.ssn,
																	Fragment_Types_const.EMAIL_FRAGMENT => R.email_address,
																	'');
			SELF.file_type := R.classification_Permissible_use_access.file_type;
			SELF := L;
		END;

		ds_fragment_recs_w_value := JOIN(ds_fragment_recs, ds_payload,
																	LEFT.record_id = RIGHT.record_id,
																	ds_fragment_recs_w_trans(LEFT, RIGHT),
																	LIMIT(FraudGovPlatform_Services.Constants.Limits.MAX_JOIN_LIMIT, SKIP));
		
		RETURN ds_fragment_recs_w_value;
	END;
	
	EXPORT getClusterDetails (ds_entityNameUID, batch_params, useRelatedCluster) := FUNCTIONMACRO
		
		IMPORT FraudGovPlatform;

		unsigned6 GC_ID := batch_params.GlobalCompanyId;
		unsigned2 IndustryType := batch_params.IndustryType;
		
		temp_rec := RECORD
			STRING20 acctno;
			STRING60 entity_name;
			STRING100 entity_value;
			RECORDOF(FraudGovPlatform.Key_ClusterDetails);
		END;											 		
		
		
		// In the Following join, when useRelatedCluster = TRUE, Joining with same tree_uid to entity_context_uid_ & tree_uid_ from Key. 
		// This is done so I can find the center cluster record for the related entity cluster. 
		// By definition, center cluster record for an entity has entity_context_uid_ = tree_uid_. (only 1 such row per entity in key).
		ds_clusterdetails:= JOIN(ds_entityNameUID , FraudGovPlatform.Key_ClusterDetails(),
													KEYED(RIGHT.customer_id_ = GC_ID AND
																RIGHT.industry_type_ = IndustryType AND
																#IF(useRelatedCluster)
																	LEFT.tree_uid = RIGHT.entity_context_uid_ AND
																	LEFT.tree_uid = RIGHT.tree_uid_),
																#ELSE
																	LEFT.entity_context_uid = RIGHT.entity_context_uid_),
																#END
													TRANSFORM(temp_rec,
														SELF.acctno := LEFT.acctno,
														SELF.entity_name := LEFT.entity_name,
														SELF.entity_value := LEFT.entity_value,
														SELF := RIGHT),
													LIMIT(FraudGovPlatform_Services.Constants.Limits.MAX_JOIN_LIMIT, SKIP));

		// output(ds_entityNameUID, named('ds_entityNameUID____getClusterDetails')); 
		// output(ds_clusterdetails, named('ds_clusterdetails____getClusterDetails'));
		// output(ds_clusterdetails_dedup, named('ds_clusterdetails_dedup____getClusterDetails'));
		RETURN ds_clusterdetails;											 
	ENDMACRO;	
	
	EXPORT getAssociatedAddresses (DATASET(FraudShared_Services.Layouts.Raw_Payload_rec) ds_payload) := FUNCTION
		
		ds_physicaladdress := PROJECT(ds_payload,TRANSFORM(iesp.fraudgovreport.t_FraudGovAssociatedAddress,
																								SELF.AddressType := LEFT.address_type,
																								SELF.Address := iesp.ECL2ESP.SetAddress(LEFT.clean_address.prim_name, 
																																												LEFT.clean_address.prim_range, 
																																												LEFT.clean_address.predir, 
																																												LEFT.clean_address.postdir, 
																																												LEFT.clean_address.addr_suffix, 
																																												LEFT.clean_address.unit_desig, 
																																												LEFT.clean_address.sec_range, 
																																												LEFT.clean_address.p_city_name, 
																																												LEFT.clean_address.st, 
																																												LEFT.clean_address.zip, 
																																												LEFT.clean_address.zip4, 
																																												'', 
																																												'', 
																																												LEFT.address_1, 
																																												LEFT.address_2,
																																												''),
																								SELF.RoofTopLatLong.Latitude := LEFT.clean_address.geo_lat,
																								SELF.RoofTopLatLong.Longitude := LEFT.clean_address.geo_long));
		
		ds_Mailingaddress := PROJECT(ds_payload,TRANSFORM(iesp.fraudgovreport.t_FraudGovAssociatedAddress,
																							SELF.AddressType := LEFT.additional_address.address_type,
																							SELF.Address := iesp.ECL2ESP.SetAddress(LEFT.additional_address.clean_address.prim_name, 
																																											LEFT.additional_address.clean_address.prim_range, 
																																											LEFT.additional_address.clean_address.predir, 
																																											LEFT.additional_address.clean_address.postdir, 
																																											LEFT.additional_address.clean_address.addr_suffix, 
																																											LEFT.additional_address.clean_address.unit_desig, 
																																											LEFT.additional_address.clean_address.sec_range, 
																																											LEFT.additional_address.clean_address.p_city_name, 
																																											LEFT.additional_address.clean_address.st, 
																																											LEFT.additional_address.clean_address.zip, 
																																											LEFT.additional_address.clean_address.zip4, 
																																											'', 
																																											'', 
																																											LEFT.additional_address.street_1, 
																																											LEFT.additional_address.street_2,
																																											''),
																							SELF.RoofTopLatLong.Latitude := LEFT.additional_address.clean_address.geo_lat,
																							SELF.RoofTopLatLong.Longitude := LEFT.additional_address.clean_address.geo_long));
		
		//Discarding the addresses which doesn't have RoofTopLatLong information in the data.
		ds_address_w_geoloc := (ds_physicaladdress + ds_Mailingaddress)(RoofTopLatLong.Latitude <> '' OR RoofTopLatLong.Longitude <> '');
		
		ds_address := DEDUP(SORT(ds_address_w_geoloc, 
															RoofTopLatLong.Latitude, RoofTopLatLong.Longitude), 
												RoofTopLatLong.Latitude, RoofTopLatLong.Longitude);

		RETURN ds_address;											 
	END;	

	EXPORT GetScoreBreakDown(DATASET(FraudGovPlatform_Services.Layouts.elementNidentity_uid_recs) ds_in, FraudGovPlatform_Services.IParam.BatchParams batch_params) := FUNCTION

		gc_id := batch_params.GlobalCompanyId;
		ind_type := batch_params.IndustryType;

		FraudGovPlatform_Services.Layouts.kel_filter_rec xform_getFilter(FraudGovPlatform_Services.Layouts.elementNidentity_uid_recs L) := TRANSFORM
			SELF.gc_id := gc_id;
			SELF.ind_type := ind_type;
			SELF.element := L;
		END;

		ds_kel_filter := PROJECT(ds_in,xform_getFilter(LEFT));

	
		iesp.fraudgovreport.t_FraudGovScoreBreakdown generateScoreBreakdown(FraudGovPlatform_Services.Layouts.kel_filter_rec L,
																			FraudGovPlatform.Key_ScoreBreakdown R):= TRANSFORM
			SELF.IndicatorTypeCode := R.indicatortype;
			SELF.IndicatorTypeDescription := R.IndicatorDescription;
			SELF.RiskLevel := (STRING)R.risklevel;
			SELF.PopulationType := R.populationtype;
			SELF.Value := R.value;
		END;

		ds_scoreBreakdowns := JOIN(ds_kel_filter,FraudGovPlatform.Key_ScoreBreakdown(), 
									KEYED(LEFT.gc_id = RIGHT.customer_id_ AND
												LEFT.ind_type = RIGHT.industry_type_ AND
												LEFT.element.entity_context_uid = RIGHT.entity_context_uid_),
									generateScoreBreakdown(LEFT,RIGHT), LIMIT(FraudGovPlatform_Services.Constants.Limits.MAX_JOIN_LIMIT, SKIP));

		ds_scoreBreakdowns_dedup := DEDUP(SORT(ds_scoreBreakdowns,IndicatorTypeCode,PopulationType,-Value),IndicatorTypeCode,PopulationType);

		return ds_scoreBreakdowns_dedup;
	END;
	
	EXPORT IsValidInputDate(iesp.share.t_Date date) := FUNCTION
		date_int := iesp.ECL2ESP.DateToInteger(date);
		
		return STD.Date.IsValidDate(date_int) OR date_int = 0;
	END;
	
	EXPORT GetCleanAddressFragmentValue(string address) := FUNCTION
		return REGEXREPLACE(FraudGovPlatform_Services.Constants.FRAGMENT_SEPARATOR ,address,', ');
	END;	
	
	EXPORT GetCleanFragmentValue(string FragmentValue, integer pos) := FUNCTION
		return REGEXFIND('(.*)' + FraudGovPlatform_Services.Constants.FRAGMENT_SEPARATOR + '(.*)$',FragmentValue, pos);
	END;
	
	EXPORT GetLastRecentActivityDate() := FUNCTION
		return STD.Date.AdjustDate(STD.Date.Today(),day_delta:=FraudGovPlatform_Services.Constants.RECENT_ACTIVITY_DAYS*-1);
	END;

END;