EXPORT CRUAccidentReportSearch_Macro(Thread, Timeout, Retry, Output_file_name, Records_ToRun):= FUNCTIONMACRO

import iesp;

		//*********** SOAP SETTINGS ********************************
		
		String RoxieIP := 'http://10.194.5.11:5014/WsECrash?ver_=1.72'; 
		Integer threads := Thread;
		Integer timeout := timeout;
		Integer retry := retry;				
		String outfile_name :=  Output_file_name;
		Unsigned8 no_of_records := records_ToRun;
		servicename := 'CRUAccidentReportSearchRequest';  
	
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

 		//*********** CRUAccidentReportSearch SETUP AND SOAPCALL ******************
   	Layout_InsRequest:=record
			RoxieServices_ProcessAutomation.cruaccidentreportsearch.t_CRUAccidentReportSearchRequest;
	  end;
	
		InsRequest := '<Row><User>	<ReferenceCode>CERT_Test1</ReferenceCode>	<BillingCode></BillingCode>	<QueryId></QueryId>	<GLBPurpose></GLBPurpose>	<DLPurpose></DLPurpose>	<EndUser>	<CompanyName></CompanyName>	<StreetAddress1></StreetAddress1>	<City></City>	<State></State>	<Zip5></Zip5>	</EndUser>	<MaxWaitSeconds>0</MaxWaitSeconds>	<AccountNumber></AccountNumber>	</User>	<Options>	<SearchForReportsOnly>1</SearchForReportsOnly>	</Options>	<SearchBy>	<CruInqOrderid></CruInqOrderid>	<CruInqSeqNumber></CruInqSeqNumber>	<CruInqClaimNumber></CruInqClaimNumber>	<CruInqAdjusterId></CruInqAdjusterId>	<CruInqLossDate>	<Year>2014</Year>	<Month>11</Month>	<Day>24</Day>	</CruInqLossDate>	<CruInqLossTime></CruInqLossTime>	<CruInqLossStreet>1310 S FORT HOOD ST</CruInqLossStreet>	<CruInqLossCrossStreet></CruInqLossCrossStreet>	<CruInqLossCity>KILLEEN</CruInqLossCity>	<CruInqLossState>TX</CruInqLossState>	<CruInqLossZip4></CruInqLossZip4>	<CruInqLossZip5></CruInqLossZip5>	<CruInqLossCounty></CruInqLossCounty>	<Subjects>	<Subject>	<SubjectType></SubjectType>	<Name>	<Full></Full>	<First></First>	<Middle></Middle>	<Last>SIMPSON</Last>	<Suffix></Suffix>	<Prefix></Prefix>	</Name>	<DOB>	<Year></Year>	<Month></Month>	<Day></Day>	</DOB>	<SSN></SSN>	<DriversLicense>	<DriversLicenseNumber></DriversLicenseNumber>	<DriversLicenseState></DriversLicenseState>	</DriversLicense>	</Subject>	</Subjects>	<Vehicle>	<VIN></VIN>	<Tag>CTM0337</Tag>	<TagState>TX</TagState>	<MakeYear></MakeYear>	<MakeModel></MakeModel>	<Make>TOYOTA</Make>	</Vehicle>	<CruInqAgencyName></CruInqAgencyName>	<CruInqReportNumber></CruInqReportNumber>	<CruInqPolicy>	<PolicyNumber></PolicyNumber>	<PolicyState></PolicyState>	<PolicyExpirationDate></PolicyExpirationDate>	</CruInqPolicy>	<CruInqPrecinct></CruInqPrecinct>	<CruInqAdditionallnfo></CruInqAdditionallnfo>	<CruInqCarrierName></CruInqCarrierName>	<CruInqCarrierTypeId></CruInqCarrierTypeId>	<ServiceId>A</ServiceId>	<StateNumber>0</StateNumber>	<AgencyId></AgencyId>	</SearchBy>	</Row>'; 

		recInsRequest	:= FROMXML(Layout_InsRequest, InsRequest); 

	 layout_soap_input := RECORD
			string Acctno;
				DATASET(Layout_InsRequest) CRUAccidentReportSearchRequest {XPATH('Row')};
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
			RoxieServices_ProcessAutomation.cruaccidentreportsearch.t_CRUAccidentReportSearchResponseEx;
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
												NAMESPACE('http://webservices.seisint.com/WsECrash'), 
												HTTPHEADER('Authorization','Basic YWxhcWNsYWJfMjA6MDAxMDMyNTIyNzE='),
												HTTPHEADER('Content-Length', '7470'),
												HTTPHEADER('Content-Type', 'text/xml;charset=UTF-8'),
												XPATH('CRUAccidentReportSearchResponseEx'),
												SOAPACTION('WsECrash/CRUAccidentReportSearch?ver_=1.72'),
												TIMEOUT(timeout),
												RETRY(retry),
												onFail(ifFail(LEFT)));
		 
		final_output := output(Soap_output, , outfile_name, thor, compressed, overwrite);
		
		soap_in_output :=	output(choosen(soap_in,5), named('soap_in'));
		
		seq:=sequential(soap_in_output,final_output);
		
		RETURN seq;
		
ENDMACRO;