// replacement for Progressive_Phone.experian_phone_soapcall.

IMPORT iesp, progressive_phone, Gateway, Royalty;
prog_layout := progressive_phone.layout_progressive_phones;

EXPORT SoapCall_Metronet(DATASET(prog_layout.layout_exp_multiple_phones) phone_request,  
												 Gateway.Layouts.Config gateway_cfg, 
												 INTEGER timeout = 1, 
												 INTEGER retries = 1,
												 INTEGER MaxCountLast3Digits = iesp.Constants.MaxCountLast3Digits) := FUNCTION
												 
	gateway_URL := [];
	inputSeq := PROJECT(phone_request, TRANSFORM(prog_layout.layout_exp_multiple_phones, SELF.seq := IF((INTEGER)LEFT.seq > 0, LEFT.seq, (STRING)COUNTER); SELF := LEFT));
 vMakeGWCall := False;
	
	
  iesp.share.t_StringArrayItem getDigits(prog_layout.Phone_Last3Digits le) := TRANSFORM
	   SELF.value := le.digits;
  END;

	iesp.gateway_metronet.t_MetronetSearchRequest into_input(prog_layout.layout_exp_multiple_phones le) := TRANSFORM
		SELF.User.QueryId := le.seq;
		SELF.USer.ReferenceCode := gateway_cfg.TransactionId;
		SELF.SearchBy.EPIN := le.ExperianPIN;
	  SELF.SearchBy.PhoneLastTwo := PROJECT(CHOOSEN(le.Phones_Last3Digits, MaxCountLast3Digits), getDigits(LEFT));
		
		// Royalty tracking
		SELF.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(gateway_cfg);
		SELF.GatewayParams.BatchJobId 			:= Gateway.Configuration.GetBatchJobId(gateway_cfg);
		SELF.GatewayParams.ProcessSpecId 		:= Gateway.Configuration.GetBatchSpecId(gateway_cfg);
		SELF.GatewayParams.QueryName 				:= Gateway.Configuration.GetRoxieQueryName(gateway_cfg);
		SELF.GatewayParams.RoyaltyCode 			:= Royalty.Constants.RoyaltyCode.METRONET;
		SELF.GatewayParams.RoyaltyType 			:= Royalty.Constants.RoyaltyType.METRONET;	
		
		// Enabling call to external gateway. Additional field CheckVendorGatewayCall to preserve backward 
		// compatibility on Gateway ESP side in case of non-roxie calls.
		SELF.GatewayParams.CheckVendorGatewayCall := true; 
		SELF.GatewayParams.MakeVendorGatewayCall 	:= vMakeGWCall;		
		SELF.Options.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
		SELF := [];
	END;
	
	input := PROJECT(inputSeq, into_input(LEFT));	
	
	iesp.gateway_metronet.t_MetronetSearchResponseEx errX(iesp.gateway_metronet.t_MetronetSearchRequest le) := TRANSFORM
		SELF.Response._Header.Message := FAILMESSAGE;
		SELF.Response._Header.Status := FAILCODE;
		SELF.Response._Header.QueryId := le.User.QueryId;
		SELF.Response._Record.Phones := [];
		SELF := [];
	END;

	soapout := IF(vMakeGWCall, 
							SOAPCALL(
												input,
												gateway_URL,
												'MetronetSearch',
												{input},  							
												DATASET(iesp.gateway_metronet.t_MetronetSearchResponseEx),
												XPATH('MetronetSearchResponseEx'),
												ONFAIL(errX(LEFT)), 
												TIMEOUT(timeout), 
												RETRY(retries),
												LOG
											)
								);
	
	norm_phone_rec := RECORD(iesp.gateway_metronet.t_MetronetPhone)	
		iesp.share.t_ResponseHeader.QueryId;
	END;
	
	norm_phone_rec norm_trans(soapout l,iesp.gateway_metronet.t_MetronetPhone r) := TRANSFORM
		SELF.queryid := l.response._header.queryid;
		SELF := r;
	END;
	 
	ds_soapout_Record := normalize(soapout,LEFT.response._record.phones, norm_TRANS(LEFT,RIGHT));
													
	prog_layout.layout_exp_multiple_phones grabResult(prog_layout.layout_exp_multiple_phones le,
																			      iesp.gateway_metronet.t_MetronetPhone ri) := TRANSFORM
		// Grab the phones matching on the last 3 digits		
		// We can potentially have multiple phones match on the last 3 digits - keep the most recently seen one
		SELF.subj_phone10 := ri.ACPhone;
		SELF.switch_type 	:= IF(TRIM(StringLib.StringToUpperCase(ri._Type)) = 'C', 'C', 'P');  // looks like the values might be C and R
		SELF.phpl_phones_plus_type := ri._Type;
		
		// Keep date in YYYYMM format, blank out if we couldn't find a date
		year 	:= IF(ri.LastReportedDate.Year = 0, '', TRIM((STRING)ri.LastReportedDate.Year));
		month := IF(ri.LastReportedDate.Month = 0, '', IF(ri.LastReportedDate.Month < 10, '0' + (STRING)ri.LastReportedDate.Month, (STRING)ri.LastReportedDate.Month));
		day 	:= IF(ri.LastReportedDate.Day = 0, '', IF(ri.LastReportedDate.Day < 10, '0' + (STRING)ri.LastReportedDate.Day, (STRING)ri.LastReportedDate.Day));
		
		SELF.subj_date_first	:= TRIM(year + month);
		SELF.subj_date_last 	:= TRIM(year + month);
		
		SELF.subj_phone_date_last := TRIM(year + month + day);
		SELF.phone_score := le.phone_score;
		SELF := le;
	END;

	result := join(inputseq,	ds_soapout_Record, left.seq = right.queryid, grabresult(left,right));						
	
	RETURN result;
	
END;
