IMPORT Gateway,PhoneFinder_Services,PhoneFraud;

EXPORT GetOTPPhones_Deltabase(DATASET(PhoneFinder_Services.Layouts.SubjectPhone)  dPhones,
													UNSIGNED1 SQLSelectLimit = PhoneFinder_Services.Constants.SQLSelectLimit, // Total number of records the Deltabase will return for a MAX
													DATASET(Gateway.Layouts.Config) Gateways = Gateway.Constants.void_gateway, 
													UNSIGNED1 gatewayTimeout = PhoneFinder_Services.Constants.gatewayTimeout, // The Deltabase has a 2 second timeout
													UNSIGNED1 gatewayRetries = PhoneFinder_Services.Constants.gatewayRetries):= FUNCTION

	responseRec := PhoneFinder_Services.Layouts.OTPDeltabaseResponse;	
  
	Gateway.Layouts.DeltabaseSQL.input_rec generateSelects(PhoneFinder_Services.Layouts.SubjectPhone l) := TRANSFORM
									
		SELF.Select := 'SELECT ' +
									// Generate the Response Layout.  NOTE: If you alter anything in this section you MUST update PhoneFinder_Services.Layouts.DeltaOTPRec
									 'i.transaction_id, i.date_added, i.event_time, i.otp_phone, i.function_name, i.otp_id, i.verify_passed ' +
                   ', i.otp_delivery_method ' +  // TODO: was it excluded on purpose?
									// Select the Deltabase Table
									 'FROM delta_otp.delta_otp i ' +
									// Choose appropriate phones
									'WHERE i.otp_phone = ? ' + 
									// Choose most current records
									'ORDER BY i.Date_Added DESC' + 								
									// LIMIT the response so the SQL server isn't overloaded
									' LIMIT ' + SQLSelectLimit;					
		
		SELF.Parameters := DATASET([{l.phone}], Gateway.Layouts.DeltabaseSQL.value_rec);
	END;
	SelectStatements := PROJECT(dedup(sort(dPhones(phone != ''),phone),phone), generateSelects(LEFT));
	
	DeltabaseURL := TRIM(Gateways (Gateway.Configuration.IsPhoneMetadata(ServiceName))[1].URL, LEFT, RIGHT);

	dsSOAPResults := Gateway.SoapCall_DeltabaseSQL(SelectStatements, DeltabaseURL, gatewayTimeout, gatewayRetries, responseRec);

	DeltabaseResults := PROJECT(dsSOAPResults.Records,TRANSFORM(PhoneFinder_Services.Layouts.OTPRec,
																											SELF.otp_phone 	:= PhoneFraud._Functions.clNum(LEFT.otp_phone),
																											SELF.event_date := PhoneFraud._Functions.clNum(LEFT.event_time)[1..8],
																											SELF.event_time := PhoneFraud._Functions.clNum(LEFT.event_time)[9..],
																											SELF:=LEFT,
																											SELF:=[]));
	// OUTPUT(SelectStatements,NAMED('SelectStatements_otp'), EXTEND);
	// OUTPUT(DeltabaseURL,NAMED('DeltabaseURL'));
	// OUTPUT(dsSOAPResults,NAMED('SOAPResults_OTP'), EXTEND);																								
	RETURN DeltabaseResults;
END;
	
				
													