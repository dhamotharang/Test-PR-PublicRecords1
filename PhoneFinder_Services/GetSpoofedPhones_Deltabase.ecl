IMPORT Gateway,PhoneFinder_Services;

EXPORT GetSpoofedPhones_Deltabase(DATASET(PhoneFinder_Services.Layouts.SubjectPhone)  dPhones,
													UNSIGNED1 SQLSelectLimit = PhoneFinder_Services.Constants.SQLSelectLimit, // Total number of records the Deltabase will return for a MAX
													DATASET(Gateway.Layouts.Config) Gateways = Gateway.Constants.void_gateway, 
													UNSIGNED1 gatewayTimeout = PhoneFinder_Services.Constants.gatewayTimeout, // The Deltabase has a 2 second timeout
													UNSIGNED1 gatewayRetries = PhoneFinder_Services.Constants.gatewayRetries):= FUNCTION
	layout := PhoneFinder_Services.Layouts;
	responseRec := recordof(PhoneFinder_Services.Layouts.SpoofDeltabaseResponse);	
	layout.DeltabaseInput generateSelects(dPhones l) := TRANSFORM						
		SELF.Select := 'SELECT ' +
									// Generate the Response Layout.  NOTE: If you alter anything in this section you MUST update PhoneFinder_Services.Layouts.DeltaPortedDataRecord
									 'i.id, i.Date_Added, i.reference_id,i.mode_type,i.event_time, i.spoofed_phone_number, i.destination_number, i.source_phone_number ' +
									// Select the Deltabase Table
									 'FROM delta_phonefinder.delta_phones_spoofing i ' +
									// Choose appropriate phones
									'WHERE i.spoofed_phone_number = \'' + l.phone + '\' OR i.destination_number = \'' + l.phone +
									'\' OR i.source_phone_number = \'' + l.phone + '\' ' + 
									// Choose most current records
									'ORDER BY i.Date_Added DESC' + 									
									// LIMIT the response so the SQL server isn't overloaded
									' LIMIT ' + SQLSelectLimit;					
		
		SELF.Parameters := [];
	END;
	SelectStatements := PROJECT(dedup(sort(dPhones(phone != ''),phone),phone), generateSelects(LEFT));
	
	DeltabaseURL := TRIM(Gateways (Gateway.Configuration.IsPhoneMetadata(ServiceName))[1].URL, LEFT, RIGHT);

	dsSOAPResults :=PhoneFinder_Services.DeltaBaseSoapCall(SelectStatements, DeltabaseURL, gatewayTimeout, gatewayRetries, responseRec);
		
	DeltabaseResults := PROJECT(dsSOAPResults.Records,TRANSFORM(layout.DeltaSpoofedRec,SELF:=LEFT,SELF:=[]));
	
	layout.SpoofedRec normPhones (layout.DeltaSpoofedRec l, INTEGER C) := TRANSFORM
		SELF.id := l.id;
		SELF.event_date := Stringlib.StringFilter(l.event_time[1..10], '1234567890');
		SELF.event_time := Stringlib.StringFilter(l.event_time[11..], '1234567890');
		SELF.phone := CHOOSE(C, l.spoofed_phone_number, l.destination_number, l.source_phone_number);
		SELF.phone_origin := MAP(C=1 and l.spoofed_phone_number<>'' => PhoneFinder_Services.Constants.SpoofPhoneOrigin.SPOOFED,
														 C=2 and l.destination_number<>''		=> PhoneFinder_Services.Constants.SpoofPhoneOrigin.DESTINATION,
														 C=3 and l.source_phone_number<>''	=> PhoneFinder_Services.Constants.SpoofPhoneOrigin.SOURCE,
														 '');
		SELF := l;
		SELF := [];
	END;

	normSpoofed := NORMALIZE(DeltabaseResults,3, normPhones(LEFT,COUNTER));
	// OUTPUT(normSpoofed,NAMED('normSpoofed'));
	RETURN normSpoofed(phone<>'');
END;
	
				
													