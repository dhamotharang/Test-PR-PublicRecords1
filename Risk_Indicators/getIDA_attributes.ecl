IMPORT iesp, Gateway, Risk_Indicators, STD;

EXPORT getIDA_attributes(DATASET(Risk_Indicators.layouts.layout_IDA_in) indata, 
                   DATASET(Gateway.Layouts.Config) gateways,
                   UNSIGNED1 Gateway_mode = 0,
                   UNSIGNED1 Timeout_sec = 3,
                   UNSIGNED1 Retries = 1
                   ) := FUNCTION
	
  
  //Grab the IDA gateway row
  gateway_cfg	:= gateways(Gateway.Configuration.IsIDAFraud(servicename))[1];
  
  to_IDA_date(STRING8 InDate, STRING6 InTime = '', BOOLEAN isdob=FALSE) := FUNCTION
    
    //convert ECL date YYYYMMDD to IDA date format
    //YYYY-MM-DD for DOBs
    //YYYY-MM-DDT00:00:00 for DateTimestamp
    temp_formatted_date := TRIM(InDate[1..4] + '-' + InDate[5..6] + '-' + InDate[7..8]);
    temp_formatted_time := TRIM(InTime[1..2] + ':' + InTime[3..4] + ':' + InTime[5..6]);
    
    formatted_date := IF(isdob,temp_formatted_date, TRIM(temp_formatted_date + 'T' + temp_formatted_time));
    
    RETURN formatted_date; 
  END;
  
  iesp.ida_report_request.t_IDAReportRequest prep(indata le) := TRANSFORM
    // Client and product values
    SELF.ReportBy.Client := TRIM(le.Client);
    SELF.ReportBy.Affiliate := '';
    SELF.ReportBy.Solution := TRIM(le.Solution);
    SELF.ReportBy.ProductName := TRIM(le.ProductName);
    SELF.ReportBy.ProductID := TRIM(le.ProductID);
    									 
    //Options section
    SELF.Options.UseUATService := IF(Gateway_mode = 1, TRUE, FALSE); //IF gateway_mode = 1 then use the IDA UAT environment (use gateway service_name = 'idareport_uat')
    
    //Origination section
    SELF.ReportBy.Origination.RequestType := 'N'; 
    
    //going to use HistoryDateTimeStamp to pass to IDA
    cleanedDate := MAP(TRIM(le.historyDateTimeStamp) IN ['','999999'] => (STRING)STD.Date.Today() + ' ' + INTFORMAT(STD.Date.CurrentTime(TRUE),6,1),
                       LENGTH(TRIM(le.historyDateTimeStamp)) = 6      => TRIM(le.historyDateTimeStamp) + '01 12010100', //use default time
                       LENGTH(TRIM(le.historyDateTimeStamp)) = 8      => TRIM(le.historyDateTimeStamp) + ' 12010100',   // use default time
                       LENGTH(TRIM(le.historyDateTimeStamp)) > 8      => TRIM(le.historyDateTimeStamp),                 //if it seems properly populated then use it
                                                                         (STRING)STD.Date.Today() + ' ' + INTFORMAT(STD.Date.CurrentTime(TRUE),6,1) //fallthrough condition, use Current date/time
                      );
    
    // If date is not today then it is a retro run. In that case -1 day so IDA's logic works correctly
    tempAppDate := IF(cleanedDate[1..8] = (STRING)STD.Date.Today(), cleanedDate, (STRING)Std.Date.AdjustDate((UNSIGNED)(cleanedDate[1..8]), 0,0,-1) + cleanedDate[9..17]);
    
    formattedAppDate := to_IDA_date(tempAppDate[1..8], tempAppDate[10..17]);
    
    SELF.ReportBy.Origination.ApplicationDate := formattedAppDate; //Format is YYYY-MM-DDTHH:MM:SS
    SELF.ReportBy.Origination.AppID := TRIM(le.App_ID); 
    SELF.ReportBy.Origination.Designation := 'A1';
    SELF.ReportBy.Origination.EventType := '';
    SELF.ReportBy.Origination.IndustryType := '';
    
    //Identity section
    SELF.ReportBy.Identity.FirstName := TRIM(le.fname); 
    SELF.ReportBy.Identity.MiddleName := TRIM(le.mname);
    SELF.ReportBy.Identity.LastName := TRIM(le.lname);
    SELF.ReportBy.Identity.SSN := IF(TRIM(le.SSN) = '' OR LENGTH(TRIM(le.SSN)) < 9, '', TRIM(le.SSN)); //IDA can't accept partial SSN, blank it out if it is
    SELF.ReportBy.Identity.DOB := IF(TRIM(le.DOB) = '' OR LENGTH(TRIM(le.DOB)) < 8, '', to_IDA_date(TRIM(le.DOB), '', TRUE)); //Format is YYYY-MM-DD; IDA can't accept partial DOB, blank it out if it is
    SELF.ReportBy.Identity.Address.Line1 := TRIM(le.in_streetAddress);
    SELF.ReportBy.Identity.City := TRIM(le.in_city);
    SELF.ReportBy.Identity.State := TRIM(le.in_state);
    SELF.ReportBy.Identity.Zip := TRIM(le.in_zipCode);
    SELF.ReportBy.Identity.HomePhone := IF(TRIM(le.phone10) = '' OR LENGTH(TRIM(le.phone10)) < 10, '', TRIM(le.phone10)); //IDA can't accept partial phone, blank it out if it is
    SELF.ReportBy.Identity.MobilePhone := IF(TRIM(le.wphone10) = '' OR LENGTH(TRIM(le.wphone10)) < 10, '', TRIM(le.wphone10)); //map workphone to mobile phone for IDA can't be a partial phone number
    SELF.ReportBy.Identity.Email := TRIM(le.email_address);
    SELF.ReportBy.Identity.IDType := IF(TRIM(le.dl_state) != '' AND TRIM(le.dl_number) != '', 'STATE_DL', ''); 
    SELF.ReportBy.Identity.IDOrigin := TRIM(le.dl_state);
    SELF.ReportBy.Identity.IDNumber := TRIM(le.dl_number);

    //Application section
    SELF.ReportBy.Application.Channel := CASE(TRIM(STD.STR.ToLowerCase(le.Channel)),
                                              ''            => TRIM(''),
                                              'mail'        => TRIM('1'),
                                              'pointofsale' => TRIM('2'),
                                              'kiosk'       => TRIM('3'),
                                              'internet'    => TRIM('4'),
                                              'branch'      => TRIM('5'),
                                              'telephonic'  => TRIM('6'),
                                              'other'       => TRIM('99'),
                                                               TRIM('99')
                                              );
		SELF.ReportBy.Application.CARetailFlag := TRIM(le.CARetailFlag),
    SELF.ReportBy.Application.SourceIP := TRIM(le.ip_address);
    SELF.ReportBy.Application.LexID := (STRING)le.Did;
    SELF.ReportBy.Application.LNTransactionID := le.ESPTransactionId;
		
		// self.ExternalData.lnrs_ssn := trim(le.best_ssn);
		// self.ExternalData.lnrs_dob := IF(le.best_dob != '', to_IDA_date(le.best_dob, '', TRUE), ''); //Format is YYYY-MM-DD
		// self.ExternalData.lnrs_address := trim(le.best_address);
		// self.ExternalData.lnrs_zip := trim(le.best_zip);
		// self.ExternalData.lnrs_phone := trim(le.best_phone);
		
    SELF := [];
  END;
  
  IDA_in := PROJECT(indata, prep(LEFT));

  makeGatewayCall := gateway_cfg.url!='' AND COUNT(IDA_in)>0 AND Gateway_mode != 3;
  IDA_results := IF(makeGatewayCall, Gateway.SoapCall_IDA_Attributes(IDA_in, gateway_cfg, makeGatewayCall, Timeout_sec, Retries), DATASET([],iesp.ida_report_response.t_IDAReportResponseEx));

  //Debug statments
  // output(gateway_cfg,named('getIDA_attributes_gateways'));
  // output(IDA_in,named('IDA_in'));
  // output(IDA_results,named('IDA_results'));
  
  RETURN IDA_results;
  
END;
