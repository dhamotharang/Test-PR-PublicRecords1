IMPORT Gateway,PhoneFinder_Services;

EXPORT GetPortedPhones_Deltabase(DATASET(PhoneFinder_Services.Layouts.SubjectPhone)  dPhones,
													UNSIGNED1 SQLSelectLimit = PhoneFinder_Services.Constants.SQLSelectLimit, // Total number of records the Deltabase will return for a MAX
													DATASET(Gateway.Layouts.Config) Gateways = Gateway.Constants.void_gateway, 
													UNSIGNED1 gatewayTimeout = PhoneFinder_Services.Constants.gatewayTimeout, // The Deltabase has a 2 second timeout
													UNSIGNED1 gatewayRetries = PhoneFinder_Services.Constants.gatewayRetries):= FUNCTION
													
	Gateway.Layouts.DeltabaseSQL.input_rec generateSelects(PhoneFinder_Services.Layouts.SubjectPhone l) := TRANSFORM
									
		SELF.Select := 	'SELECT ' +
									// Generate the Response Layout.  NOTE: If you alter anything in this section you MUST update PhoneFinder_Services.Layouts.DeltaPortedDataRecord
									'i.id, i.date_added, i.phone, i.source, i.spid, i.port_start_dt, i.port_end_dt, is_ported ' +
									// Select the Deltabase Table
									'FROM delta_phonefinder.delta_phones_metadata i ' +
									// Choose appropriate phones
									'WHERE i.phone = ? ' + 
									// Choose most current records
									'ORDER BY i.Date_Added DESC' + 									
									// LIMIT the response so the SQL server isn't overloaded
									' LIMIT ' + SQLSelectLimit;					
		
		SELF.Parameters := DATASET([{l.phone}], Gateway.Layouts.DeltabaseSQL.value_rec);
	END;
	SelectStatements := PROJECT(dPhones(phone != ''), generateSelects(LEFT));
	
	// Prepare SOAP call
	DeltabaseURL := TRIM(Gateways (Gateway.Configuration.IsPhoneMetadata(ServiceName))[1].URL, LEFT, RIGHT);

	SOAPResults := Gateway.SoapCall_DeltabaseSQL(SelectStatements, DeltabaseURL, gatewayTimeout, gatewayRetries, PhoneFinder_Services.Layouts.DeltabaseResponse);
		
	DeltabaseResults := PROJECT(SOAPResults.Records,TRANSFORM(PhoneFinder_Services.Layouts.PortedMetadata,SELF:=LEFT,SELF:=[]));
	// OUTPUT(SelectStatements,NAMED('SelectStatements_ported'), EXTEND);
	// OUTPUT(DeltabaseURL,NAMED('DeltabaseURL'));
	// OUTPUT(SOAPResults,NAMED('SOAPResults_Ported'), EXTEND);
	RETURN DeltabaseResults;
END;
	
				
													