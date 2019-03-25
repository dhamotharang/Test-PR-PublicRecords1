IMPORT Gateway,Phones,STD;

EXPORT GetATTPhones_Deltabase(DATASET(Phones.Layouts.PhoneAttributes.gatewayQuery)  dPhones,
													UNSIGNED1 SQLSelectLimit = Phones.Constants.GatewayValues.SQLSelectLimit, // Total number of records the Deltabase will return for a MAX
													DATASET(Gateway.Layouts.Config) Gateways = Gateway.Constants.void_gateway, 
													UNSIGNED1 gatewayTimeout = Phones.Constants.GatewayValues.requestTimeout, 
													UNSIGNED1 gatewayRetries = Phones.Constants.GatewayValues.requestRetries):= FUNCTION

	responseRec := Phones.Layouts.Deltabase.ATTResponse;	
	today 	 		:= STD.Date.Today();
	
	Gateway.Layouts.DeltabaseSQL.input_rec generateSelects(Phones.Layouts.PhoneAttributes.gatewayQuery l) := TRANSFORM						
		SELF.Select := 'SELECT ' +
									 'transaction_id,date_added, source,submitted_phonenumber, carrier_name,carrier_category,carrier_ocn,lata,reply_code,point_code ' +
									 'FROM delta_phonefinder.delta_phones_gateway ' +
									 // Choose appropriate phone and ATT DQ_IRS recs
									 'WHERE submitted_phonenumber = ? AND source =\'' + Phones.Constants.GatewayValues.DELTA_ATT_DQ_IRS + '\' ' +
									 'ORDER BY Date_Added DESC ' + 									
									 'LIMIT ' + SQLSelectLimit;					
		
		SELF.Parameters := DATASET([{l.phone}], Gateway.Layouts.DeltabaseSQL.value_rec);
	END;
	SelectStatements := PROJECT(dPhones(phone != ''), generateSelects(LEFT));
	
	DeltabaseURL := TRIM(Gateways (Gateway.Configuration.IsPhoneMetadata(ServiceName))[1].URL, LEFT, RIGHT);

	dsSOAPResults := Gateway.SoapCall_DeltabaseSQL(SelectStatements, DeltabaseURL, gatewayTimeout, gatewayRetries, responseRec);
		
	DeltabaseResults := PROJECT(dsSOAPResults.Records,TRANSFORM(Phones.Layouts.PhoneAttributes.Raw,
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
	 //OUTPUT(SelectStatements,NAMED('SelectStatements_att'), EXTEND);
	 //OUTPUT(dsSOAPResults,NAMED('SOAPResults_att'), EXTEND);
	 //OUTPUT(DeltabaseResults,NAMED('DeltabaseResults_att'), EXTEND);
	RETURN DeltabaseResults;
END;
	
				
													