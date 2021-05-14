EXPORT PhoneHeaderScore_Macro(Thread, Timeout, Retry, Output_file_name, Records_ToRun):= FUNCTIONMACRO

import iesp;

		//*********** SOAP SETTINGS ********************************
		
		String RoxieIP := 'http://10.194.3.3:5010/WsInsuranceRisk?ver_=1.82'; 
		Integer threads := Thread;
		Integer timeout := timeout;
		Integer retry := retry;				
		String outfile_name :=  Output_file_name;
		Unsigned8 no_of_records := records_ToRun;
		servicename := 'PhoneHeaderScore';  
	
		//*********** USER SETTINGS ********************************
		
		// GLB := ;
		// DL_Purpose := ;
		// SSNMask := ;
		// DOBMask := ;
		// DLMask := ;
		// DRM :=;  
		// DPM := ;
		// ApplicationType := ;
		// SSNMaskingOn := ;
		// DLMaskingOn := ;
		// OutcomeTrackingOptOut := ;
		// PrimarySubjectId := ;
		// IntendedPurpose :=;
		// isFCRA := ;
		// Version := ;
		// HISTORYDATE := ;
	
	  //************** INPUT FILE GENERATION ****************
		
		// layout_input := RECORD

		// END;

    // ds_raw_input := IF(no_of_records > 0, CHOOSEN(DATASET( infile_name, layout_input,thor), no_of_records),
                            // DATASET( infile_name, layout_input, thor));

 		//*********** PhoneHeaderScore SETUP AND SOAPCALL ******************
   	Layout_InsRequest:=record
			RoxieServices_ProcessAutomation.phoneheaderscore.t_PhoneHeaderScoreRequest;
	  end;
		
		InsRequest := '<Row><User>	<ReferenceCode></ReferenceCode>	<BillingCode></BillingCode>	<QueryId></QueryId>	<GLBPurpose></GLBPurpose>	<DLPurpose></DLPurpose>	<EndUser>	<CompanyName></CompanyName>	<StreetAddress1></StreetAddress1>	<City></City>	<State></State>	<Zip5></Zip5>	</EndUser>	<MaxWaitSeconds>0</MaxWaitSeconds>	<AccountNumber></AccountNumber>	</User>	<Account>	<AccountNumber></AccountNumber>	<AccountSuffix></AccountSuffix>	<CustomerNumber></CustomerNumber>	<CustomerName></CustomerName>	</Account>	<Options>	<RequireExactMatch>	<LastName>0</LastName>	<FirstName>0</FirstName>	<FirstNameAllowNickname>0</FirstNameAllowNickname>	</RequireExactMatch>	<HistoryDateYYYYMM></HistoryDateYYYYMM>	<LastSeenThreshold>9999</LastSeenThreshold>	<TransactionID></TransactionID>	</Options>	<SearchBy>	<Name>	<Full></Full>	<First>Taulant</First>	<Middle></Middle>	<Last>Kostallari</Last>	<Suffix></Suffix>	<Prefix></Prefix>	</Name>	<Address>	<StreetNumber></StreetNumber>	<StreetPreDirection></StreetPreDirection>	<StreetName></StreetName>	<StreetSuffix></StreetSuffix>	<StreetPostDirection></StreetPostDirection>	<UnitDesignation></UnitDesignation>	<UnitNumber></UnitNumber>	<StreetAddress1>115 governor st fl 1</StreetAddress1>	<StreetAddress2></StreetAddress2>	<City></City>	<State>CT</State>	<Zip5>06108</Zip5>	<Zip4></Zip4>	<County></County>	<PostalCode></PostalCode>	<StateCityZip></StateCityZip>	</Address>	<HomePhone>3202248027</HomePhone>	</SearchBy>	</Row>';
		
		recInsRequest	:= FROMXML(Layout_InsRequest, InsRequest); 

    layout_soap_input := RECORD
		  string Acctno;
   	  DATASET(Layout_InsRequest) PhoneHeaderScore {XPATH('Row')};
   	END;
		
		//request
		Layout_InsRequest xInsRequest() := TRANSFORM
			SELF :=recInsRequest
			// SELF := [];
		END;							
				
		soap_in:= DATASET([xInsRequest()]);
		// output(soap_in, named('soap_in'));
		
		//Soap output layout
		layout_Soap_output := RECORD
			// STRING Acctno;
			RoxieServices_ProcessAutomation.phoneheaderscore.t_PhoneHeaderScoreResponseEx;
			STRING errorcode;
		END;
   
   	//*********** PERFORMING SOAPCALL TO ROXIE ************

		layout_soap_output ifFail(soap_in le) := TRANSFORM
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			// SELF.acctno := TransactionId;
			SELF := le;
			SELF := [];
		END;

		Soap_output := SOAPCALL(soap_in, 
												RoxieIP, 
												servicename, 
												{soap_in},
												dataset(layout_soap_output),
												PARALLEL(threads),
												literal,
												NAMESPACE('http://webservices.seisint.com/WsInsuranceRisk'), 
												HTTPHEADER('Authorization','Basic YWxhcWNsYWJfMjA6MDAxMDMyNTIyNzE='),
												HTTPHEADER('Content-Length', '7470'),
												HTTPHEADER('Content-Type', 'text/xml;charset=UTF-8'),
												XPATH('PhoneHeaderScoreResponseEx'),
												SOAPACTION('WsInsuranceRisk/PhoneHeaderScore?ver_=1.82'),
												TIMEOUT(timeout),
												RETRY(retry),
												onFail(ifFail(LEFT)));	

    
		final_output := output(Soap_output, , outfile_name, thor, compressed, overwrite);
		
		soap_in_output :=	output(choosen(soap_in,5), named('soap_in'));
		
		seq:=sequential(soap_in_output,final_output);
		
		RETURN seq;
		
ENDMACRO;