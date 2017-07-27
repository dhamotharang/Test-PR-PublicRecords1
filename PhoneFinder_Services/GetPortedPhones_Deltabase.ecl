IMPORT Gateway,PhoneFinder_Services;

EXPORT GetPortedPhones_Deltabase(DATASET(PhoneFinder_Services.Layouts.SubjectPhone)  dPhones,
													UNSIGNED1 SQLSelectLimit = PhoneFinder_Services.Constants.SQLSelectLimit, // Total number of records the Deltabase will return for a MAX
													DATASET(Gateway.Layouts.Config) Gateways = Gateway.Constants.void_gateway, 
													UNSIGNED1 gatewayTimeout = PhoneFinder_Services.Constants.gatewayTimeout, // The Deltabase has a 2 second timeout
													UNSIGNED1 gatewayRetries = PhoneFinder_Services.Constants.gatewayRetries):= FUNCTION
													
	PhoneFinder_Services.Layouts.DeltabaseInput generateSelects(dPhones l) := TRANSFORM
									
		SELF.Select := 	'SELECT ' +
									// Generate the Response Layout.  NOTE: If you alter anything in this section you MUST update PhoneFinder_Services.Layouts.DeltaPortedDataRecord
									'i.ID, i.Date_Added, i.phone, i.source, i.spid, i.port_start_dt, i.port_end_dt, is_ported ' +
									// Select the Deltabase Table
									'FROM delta_phonefinder.delta_phones_metadata i ' +
									// Choose appropriate phones
									'WHERE i.phone = \'' + l.phone + '\' ' + 
									// Choose most current records
									'ORDER BY i.Date_Added DESC' + 									
									// LIMIT the response so the SQL server isn't overloaded
									' LIMIT ' + SQLSelectLimit;					
		
		SELF.Parameters := [];
	END;
	SelectStatements := PROJECT(dPhones(phone != ''), generateSelects(LEFT));
	
	// Prepare SOAP call
	DeltabaseURL := TRIM(Gateways (Gateway.Configuration.IsPhoneMetadata(ServiceName))[1].URL, LEFT, RIGHT);

	PhoneFinder_Services.Layouts.DeltabaseResponse soapFailure(PhoneFinder_Services.Layouts.DeltabaseInput le) := TRANSFORM
		SELF.ExceptionMessage := FAILMESSAGE + ' ' + FAILCODE;
		SELF := le;
		SELF := [];
	END;

	SOAPResults := IF(DeltabaseURL != '', 
											SOAPCALL(SelectStatements,
															 DeltabaseURL,
															 'DeltaBasePreparedSql',
															 {SelectStatements},                         
															 DATASET(PhoneFinder_Services.Layouts.DeltabaseResponse),
															 XPATH('DeltaBaseSelectResponse'),
															 onFail(soapFailure(LEFT)),
															 RETRY(gatewayRetries), TIMEOUT(gatewayTimeout)),
											DATASET([], PhoneFinder_Services.Layouts.DeltabaseResponse));
		
	DeltabaseResults := PROJECT(SOAPResults.Records,TRANSFORM(PhoneFinder_Services.Layouts.PortedMetadata,SELF:=LEFT,SELF:=[]));
	// OUTPUT(SelectStatements,NAMED('SelectStatements'));
	// OUTPUT(DeltabaseURL,NAMED('DeltabaseURL'));
	// OUTPUT(SOAPResults,NAMED('SOAPResults'));
	RETURN DeltabaseResults;
END;
	
				
													