IMPORT Gateway,PhoneFinder_Services,PhoneFraud;

EXPORT GetOTPPhones_Deltabase(DATASET(PhoneFinder_Services.Layouts.SubjectPhone)  dPhones,
													UNSIGNED1 SQLSelectLimit = PhoneFinder_Services.Constants.SQLSelectLimit, // Total number of records the Deltabase will return for a MAX
													DATASET(Gateway.Layouts.Config) Gateways = Gateway.Constants.void_gateway, 
													UNSIGNED1 gatewayTimeout = PhoneFinder_Services.Constants.gatewayTimeout, // The Deltabase has a 2 second timeout
													UNSIGNED1 gatewayRetries = PhoneFinder_Services.Constants.gatewayRetries):= FUNCTION
	responseRec := recordof(PhoneFinder_Services.Layouts.OTPDeltabaseResponse);	
	PhoneFinder_Services.Layouts.DeltabaseInput generateSelects(dPhones l) := TRANSFORM
									
		SELF.Select := 'SELECT ' +
									// Generate the Response Layout.  NOTE: If you alter anything in this section you MUST update PhoneFinder_Services.Layouts.DeltaPortedDataRecord
									 'i.transaction_id, i.Date_Added, i.event_time, i.otp_phone, i.function_name, i.otp_id, i.verify_passed ' +
									// Select the Deltabase Table
									 'FROM delta_otp.delta_otp i ' +
									// Choose appropriate phones
									'WHERE i.otp_phone = \'' + l.phone + '\' ' + 
									// Choose most current records
									'ORDER BY i.Date_Added DESC' + 								
									// LIMIT the response so the SQL server isn't overloaded
									' LIMIT ' + SQLSelectLimit;					
		
		SELF.Parameters := [];
	END;
	SelectStatements := PROJECT(dedup(sort(dPhones(phone != ''),phone),phone), generateSelects(LEFT));
	
	DeltabaseURL := TRIM(Gateways (Gateway.Configuration.IsPhoneMetadata(ServiceName))[1].URL, LEFT, RIGHT);

	dsSOAPResults :=PhoneFinder_Services.DeltaBaseSoapCall(SelectStatements, DeltabaseURL, gatewayTimeout, gatewayRetries, responseRec);

	DeltabaseResults := PROJECT(dsSOAPResults.Records,TRANSFORM(PhoneFinder_Services.Layouts.OTPRec,
																											SELF.otp_phone 	:= PhoneFraud._Functions.clNum(LEFT.otp_phone),
																											SELF.event_date := PhoneFraud._Functions.clNum(LEFT.event_time)[1..8],
																											SELF.event_time := PhoneFraud._Functions.clNum(LEFT.event_time)[9..],
																											SELF:=LEFT,
																											SELF:=[]));
	// OUTPUT(SelectStatements,NAMED('SelectStatements'));
	// OUTPUT(DeltabaseURL,NAMED('DeltabaseURL'));
	// OUTPUT(SOAPResults,NAMED('SOAPResults'));																								
	RETURN DeltabaseResults;
END;
	
				
													