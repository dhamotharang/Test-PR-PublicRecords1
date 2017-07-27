IMPORT Gateway,Phones,STD;

EXPORT GetATTPhones_Deltabase(DATASET({STRING10 phone})  dPhones,
													UNSIGNED1 SQLSelectLimit = Phones.Constants.GatewayValues.SQLSelectLimit, // Total number of records the Deltabase will return for a MAX
													DATASET(Gateway.Layouts.Config) Gateways = Gateway.Constants.void_gateway, 
													UNSIGNED1 gatewayTimeout = Phones.Constants.GatewayValues.requestTimeout, 
													UNSIGNED1 gatewayRetries = Phones.Constants.GatewayValues.requestRetries):= FUNCTION
	layout 			:= Phones.Layouts;
	responseRec := layout.Deltabase.ATTResponse;	
	today 	 		:= STD.Date.Today();
	
	layout.Deltabase.dInput generateSelects(dPhones l) := TRANSFORM						
		SELF.Select := 'SELECT ' +
									 'transaction_id,date_added, source,submitted_phonenumber, carrier_name,carrier_category,carrier_ocn,lata,reply_code,point_code ' +
									 'FROM delta_phonefinder.delta_phones_gateway ' +
									 // Choose appropriate phone and ATT DQ_IRS recs
									 'WHERE submitted_phonenumber = \'' + l.phone + '\' AND source =\'' + Phones.Constants.GatewayValues.DELTA_ATT_DQ_IRS + '\' ' +
									 'ORDER BY Date_Added DESC ' + 									
									 'LIMIT ' + SQLSelectLimit;					
		
		SELF.Parameters := [];
	END;
	SelectStatements := PROJECT(dPhones(phone != ''), generateSelects(LEFT));
	
	DeltabaseURL := TRIM(Gateways (Gateway.Configuration.IsPhoneMetadata(ServiceName))[1].URL, LEFT, RIGHT);

	dsSOAPResults :=Phones.DeltaBaseSoapCall(SelectStatements, DeltabaseURL, gatewayTimeout, gatewayRetries, responseRec);
		
	DeltabaseResults := PROJECT(dsSOAPResults.Records,TRANSFORM(layout.PhoneAttributes.Raw,
																															eventDate := STD.Str.Filter(LEFT.date_added,'0123456789');
																															SELF.phone := LEFT.submitted_phonenumber,
																															SELF.reference_id := LEFT.transaction_id,
																															SELF.source := Phones.Constants.PhoneAttributes.ATT_LIDB_Delta,
																															SELF.local_area_transport_area := LEFT.lata,
																															SELF.account_owner := LEFT.carrier_ocn,
																															SELF.dt_first_reported := today,
																															SELF.dt_last_reported := today,
																															SELF.vendor_first_reported_dt := (UNSIGNED)eventDate[1..8],
																															SELF.vendor_first_reported_time := eventDate[9..],
																															SELF.vendor_last_reported_dt := (UNSIGNED)eventDate[1..8],
																															SELF.vendor_last_reported_time := eventDate[9..],
																															SELF:=LEFT,
																															SELF:=[]));
	RETURN DeltabaseResults;
END;
	
				
													