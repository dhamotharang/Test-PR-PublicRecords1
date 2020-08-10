//copied the code from "Risk_Indicators.test_BocaShell_SoapCall" to customize the data distribution
// this will reduce the number of calls to roxie when running on a 400 cluster
Import risk_indicators;
EXPORT BocaShell_SoapCall (dataset (risk_indicators.Layout_InstID_SoapCall) indataset, 
                                string service_name, string service_url,
                                const unsigned1 call_number = 1,unsigned1 nodes)  := FUNCTION
dist_dataset := DISTRIBUTE (indataset, RANDOM() % nodes);

xlayout := RECORD
	unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	risk_indicators.Layout_Boca_Shell;
	STRING200 errorcode;
END;

xlayout myFail(dist_dataset le) :=
TRANSFORM
	SELF.errorcode := FAILCODE + ' ' + FAILMESSAGE;
	SELF.seq := (unsigned)le.AccountNumber;
	// keep input
	SELF.shell_input.fname := le.FirstName;
	SELF.shell_input.mname := le.MiddleName;
	SELF.shell_input.lname := le.LastName;
	SELF.shell_input.suffix := le.NameSuffix;
	SELF.shell_input.in_streetaddress := le.StreetAddress;
	SELF.shell_input.in_city := le.City;
	SELF.shell_input.in_state := le.State;
	SELF.shell_input.in_zipcode := le.Zip;
	SELF.shell_input.in_country := le.Country;
	SELF.shell_input.ssn := le.SSN;
	SELF.shell_input.dob := le.DateOfBirth;
	SELF.shell_input.age := le.Age;
	SELF.shell_input.dl_number := le.DLNumber;
	SELF.shell_input.dl_state := le.DLState;
	SELF.shell_input.email_address := le.Email;
	SELF.shell_input.ip_address := le.IPAddress;
	SELF.shell_input.phone10 := le.HomePhone;
	SELF.shell_input.wphone10 := le.WorkPhone;
	SELF.shell_input.employer_name := le.EmployerName;
	SELF.shell_input.lname_prev := le.FormerName;
	SELF := [];
END;

// par_calls not used here, as PARALLEL expects const expr. see bug #19389
result := SOAPCALL (dist_dataset, service_url, 
                    service_name, {dist_dataset}, 
                    DATASET (xlayout),
										XPATH('*/Results/Result/Dataset[@name=\'Results\']/Row'),
										RETRY(5), TIMEOUT(500),
                    PARALLEL (call_number), onFail(myFail (Left)));


return result;
	
END;