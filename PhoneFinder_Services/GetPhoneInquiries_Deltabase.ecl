IMPORT Inquiry_Deltabase, Gateway, PhoneFinder_Services, STD;

EXPORT GetPhoneInquiries_Deltabase(DATASET(PhoneFinder_Services.Layouts.DeltaInquiryDataRecord)  dPhones,
													UNSIGNED1 SQLSelectLimit = PhoneFinder_Services.Constants.SQLSelectLimit, // Total number of records the Deltabase will return for a MAX
													DATASET(Gateway.Layouts.Config) Gateways = Gateway.Constants.void_gateway, 
													UNSIGNED1 gatewayTimeout = PhoneFinder_Services.Constants.gatewayTimeout, 
													UNSIGNED1 gatewayRetries = PhoneFinder_Services.Constants.gatewayRetries):= FUNCTION
													
													
	currentDate := (STRING)STD.Date.Today();	
	date := STD.date.ConvertDateFormat(currentDate, '%Y%m%d','%Y-%m-%d');
	PhoneFinder_Services.Layouts.DeltabaseInput generateSelects(dPhones l) := TRANSFORM
									
		SELF.Select := 	 'SELECT \'' + l.seq + '\' AS Seq, ' + // Force Seq into the response for each SELECT statement, this allows for us to use this in batch
									// Generate the Response Layout.  NOTE: If you alter anything in this section you MUST update PhoneFinder_Services.Layouts.DeltaInquiryDataRecord
									'i.Phone AS Phone10 ' + 
									// Select the Deltabase Table
									'FROM delta_shell.inquiry_nonfcra i ' +
									// Done Generating the Response Layout, now pick out the right address
									'WHERE i.Phone = \'' + l.Phone + '\' and i.date_added >= \'' + date + '\'' + 
									// And make sure to LIMIT the response so the SQL server isn't overloaded
									'LIMIT ' + SQLSelectLimit;				
		
		SELF.Parameters := [];
	END;
	SelectStatements := PROJECT(dPhones(phone != ''), generateSelects(LEFT));
	
	// Call the Deltabase!
	DeltabaseResponse := Inquiry_Deltabase.SoapCall_Deltabase(SelectStatements, Gateways, gatewayTimeout, gatewayRetries);
	
	PhoneFinder_Services.Layouts.DeltaInquiry_recout intolayout(Inquiry_Deltabase.Layouts.Deltabase_Response le,Inquiry_Deltabase.Layouts.Deltabase_Record ri) := TRANSFORM
	
	 self.seq := (UNSIGNED8) ri.seq;
	 self.Phone := ri.Phone10;
	 self.RecordsReturned := (UNSIGNED)le.RecordsReturned;
	
	END;
	
	recs_pre := NORMALIZE(DeltabaseResponse, LEFT.Response, intolayout(LEFT, RIGHT));
	
	recs_out:= DEDUP(SORT(recs_pre, seq, phone), seq, phone);

	RETURN recs_out;
																								
END;