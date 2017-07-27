IMPORT AutoStandardI, iesp;
export RealTimePhones_Params := module
	export params := INTERFACE(AutoStandardI.LIBIN.PenaltyI_Indv.base,
	 	                         AutoStandardI.InterfaceTranslator.glb_purpose.params,
		                         AutoStandardI.InterfaceTranslator.dppa_purpose.params,
												     AutoStandardI.InterfaceTranslator.company_name_value.params,
		                         AutoStandardI.InterfaceTranslator.penalt_threshold_value.params,
														 AutoStandardI.DataRestrictionI.params)
     export string15  phone      := '';
		 export string30  firstname  := '';
		 export string30  lastname   := '';
		 export string200 addr       := '';
		 export string25  city       := '';
		 export string2  state      := '';
		 export string6  zip        := '';
		 export boolean  failOnError := FALSE;
	   export string5  serviceType := '';  
		 export unsigned8 maxResults := batchServices.constants.RealTime.REALTIME_PHONE_LIMIT; //for each row in the batch service
		 export unsigned1 RecordCount := batchServices.constants.RealTime.REALTIME_Record_default; // responses from gateway

		 export string12	searchType := '';
		 export boolean	strictSSN := FALSE;
		 export string UID := '';
		 export string20 acctno := '';
		 export string  EspTransactionId := '';
     export boolean TUGatewayPhoneticMatch := false;
     export boolean UseQSENTV2 := false;
		 
		 export string11 ssn := '';
		 export dataset(iesp.share.t_StringArrayItem) ExcludedPhones := DATASET([], iesp.share.t_StringArrayItem);
	end;
end;												 