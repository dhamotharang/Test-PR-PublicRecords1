IMPORT Gateway, PhoneFinder_Services, STD;

EXPORT GetPhoneInquiries_Deltabase(DATASET(PhoneFinder_Services.Layouts.DeltaInquiryDataRecord)  dPhones,
													UNSIGNED1 SQLSelectLimit = PhoneFinder_Services.Constants.SQLSelectLimit, // Total number of records the Deltabase will return for a MAX
													DATASET(Gateway.Layouts.Config) Gateways = Gateway.Constants.void_gateway, 
													UNSIGNED1 gatewayTimeout = PhoneFinder_Services.Constants.gatewayTimeout, 
													UNSIGNED1 gatewayRetries = PhoneFinder_Services.Constants.gatewayRetries):= FUNCTION
													
													
	currentDate := (STRING)STD.Date.Today();	
	date := STD.date.ConvertDateFormat(currentDate, '%Y%m%d','%Y-%m-%d');
  
	Gateway.Layouts.DeltabaseSQL.input_rec generateSelects(PhoneFinder_Services.Layouts.DeltaInquiryDataRecord l) := TRANSFORM
									
		SELF.Select := 	 'SELECT \'' + l.seq + '\' AS Seq, ' + // Force Seq into the response for each SELECT statement, this allows for us to use this in batch
									// Generate the Response Layout.  NOTE: If you alter anything in this section you MUST update PhoneFinder_Services.Layouts.DeltaInquiryDataRecord
									'i.Phone AS Phone ' + 
									// Select the Deltabase Table
									'FROM delta_shell.inquiry_nonfcra i ' +
									// Done Generating the Response Layout, now pick out the right address
									'WHERE i.Phone = ? and i.date_added >= \'' + date + '\'' + 
									// And make sure to LIMIT the response so the SQL server isn't overloaded
									'LIMIT ' + SQLSelectLimit;				
		
		SELF.Parameters := DATASET([{l.phone}], Gateway.Layouts.DeltabaseSQL.value_rec);
	END;
	SelectStatements := PROJECT(dPhones(phone != ''), generateSelects(LEFT));
	
	Deltabase_URL := TRIM(Gateways (StringLib.StringToLowerCase(ServiceName) = Gateway.Constants.ServiceName.DeltaInquiry)[1].URL, LEFT, RIGHT);
  
	// Call the Deltabase!
	DeltabaseResponse := Gateway.SoapCall_DeltabaseSQL(SelectStatements, Deltabase_URL, gatewayTimeout, gatewayRetries, PhoneFinder_Services.Layouts.DeltaInquiryDeltabaseResponse);
	
	PhoneFinder_Services.Layouts.DeltaInquiry_recout intolayout(PhoneFinder_Services.Layouts.DeltaInquiryDeltabaseResponse le,PhoneFinder_Services.Layouts.DeltaInquiryDataRecord ri) := TRANSFORM
	
	 self.seq := (UNSIGNED8) ri.seq;
	 self.Phone := ri.Phone;
	 self.RecordsReturned := (UNSIGNED)le.RecordsReturned;
	
	END;
	
	recs_pre := NORMALIZE(DeltabaseResponse, LEFT.Response, intolayout(LEFT, RIGHT));
	
	recs_out:= DEDUP(SORT(recs_pre, seq, phone), seq, phone);

	// OUTPUT(SelectStatements,NAMED('SelectStatements_Inquiry'), EXTEND);
	// OUTPUT(DeltabaseResponse,NAMED('SOAPResults_Inquiry'), EXTEND);
	RETURN recs_out;
																								
END;