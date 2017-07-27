IMPORT iesp;

EXPORT experian_phone_soapcall(DATASET(progressive_phone.layout_experian_phones) phone_request, STRING gateway_URL, INTEGER timeout = 1, INTEGER retries = 1) := FUNCTION

	inputSeq := PROJECT(phone_request, TRANSFORM(progressive_phone.layout_experian_phones, SELF.seq := (STRING)COUNTER; SELF := LEFT));

	iesp.gateway_metronet.t_MetronetSearchRequest into_input(progressive_phone.layout_experian_phones le) := TRANSFORM
		SELF.User.QueryId := TRIM(le.seq);

		SELF.SearchBy.EPIN := TRIM(le.ExperianPIN);
		SELF.SearchBy.PhoneLastTwo := DATASET([{TRIM(le.Phone_Last3Digits[2..3])}], iesp.share.t_StringArrayItem);

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

	soapout := IF(TRIM(gateway_URL) <> '' AND COUNT(input) > 0, 
							SOAPCALL(
												input,
												gateway_URL,
												'MetronetSearch',
												{input},  
												DATASET(iesp.gateway_metronet.t_MetronetSearchResponseEx),
												XPATH('MetronetSearchResponseEx'),
												ONFAIL(errX(LEFT)), 
												TIMEOUT(timeout), 
												RETRY(retries)
											)
								);

	fprec := record(iesp.gateway_metronet.t_MetronetPhone)
		string50 queryid:='';
	end;

	progressive_phone.layout_experian_phones grabResult(progressive_phone.layout_experian_phones le, fprec ri) := TRANSFORM
		// Grab the phones matching on the last 3 digits		
		// We can potentially have multiple phones match on the last 3 digits - keep the most recently seen one
		SELF.subj_phone10 := ri.ACPhone;
		SELF.switch_type := IF(TRIM(StringLib.StringToUpperCase(ri._Type)) = 'C', 'C', 'P');  // looks like the values might be C and R
		SELF.phpl_phones_plus_type := ri._Type;
		
		// Keep date in YYYYMM format, blank out if we couldn't find a date
		year := IF(ri.LastReportedDate.Year = 0, '', TRIM((STRING)ri.LastReportedDate.Year));
		month := IF(ri.LastReportedDate.Month = 0, '', IF(ri.LastReportedDate.Month < 10, '0' + (STRING)ri.LastReportedDate.Month, (STRING)ri.LastReportedDate.Month));
		day := IF(ri.LastReportedDate.Day = 0, '', IF(ri.LastReportedDate.Day < 10, '0' + (STRING)ri.LastReportedDate.Day, (STRING)ri.LastReportedDate.Day));
		
		SELF.subj_date_first := TRIM(year + month);
		SELF.subj_date_last := TRIM(year + month);
		
		SELF.subj_phone_date_last := TRIM(year + month + day);
		
		SELF := le;
	END;
	fullPhones := project(soapout[1].response._Record.Phones,transform(fprec,self.queryid := soapout[1].Response._Header.QueryId,self:=left));

	result := JOIN(inputSeq, fullPhones, LEFT.seq = RIGHT.QueryId and  left.Phone_Last3Digits = right.ACPhone[8..10] , grabResult(LEFT, RIGHT), LEFT OUTER);
	RETURN result;
END;
