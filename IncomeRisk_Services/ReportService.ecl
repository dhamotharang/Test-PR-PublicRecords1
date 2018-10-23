/*--SOAP--
<message name="IncomeRiskAssessment_ReportService" wuTimeout="300000">

	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DPPAPurpose"           type="xsd:byte"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	
	<part name="MaxWaitSeconds"      type="xsd:integer"/>

  <part name="SSN"              type="xsd:string"/>
 	<part name="UnParsedFullName" type="xsd:string"/>
	<part name="FirstName"        type="xsd:string"/>
	<part name="MiddleName"       type="xsd:string"/>
	<part name="LastName"         type="xsd:string"/>
	<part name="NameSuffix"				type="xsd:string"/>
	
	<part name="prim_range" type="xsd:string"/>
	<part name="prim_name" type="xsd:string"/>
  <part name="predir" type="xsd:string"/>
  <part name="postdir" type="xsd:string"/>
	<part name="suffix"  type="xsd:string"/>
  <part name="sec_range" type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
	<part name="PhoneNumber" type="xsd:string"/>
	<part name="DOB" type="xsd:string"/>
	<part name="JobTitle" type="xsd:string"/>
	<part name="Employer" type="xsd:string"/>
	<part name="EmployerMatch" type="xsd:boolean"/>
	<part name="JobExperience"  type="xsd:string"/>
	<part name="ProfessionalExperience"  type="xsd:string"/>
	<part name="AnnualIncome" type="xsd:integer"/>
	<part name="BorrowerPostalCode" type="xsd:string"/>
	<part name="DBA" type="xsd:string"/>
	<part name="TIN" type="xsd:string"/>
	<part name="PoBoxCompliance"  type="xsd:boolean"/>
	<part name="IncludeMSOverride"  type="xsd:boolean"/>
	<part name="IncludeDLVerification"  type="xsd:boolean"/>
	<part name="DisallowTargusEID3220"  type="xsd:boolean"/>
	<part name="GlobalWatchListThreshold"  type="xsd:real"/>
	<part name="SIC" type="xsd:string"/>
	<part name="NAICS" type="xsd:string"/>
	<part name="SOC" type="xsd:string"/>
	<part name="gateways" type="tns:XmlDataSet" cols="80" rows="30" />
	<part name="IncomeRiskAssessmentReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />
	
	
	</message>
	*/
	/*
	notes:
	
	 <part name="ERISalaryReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />
	<part name="BusinessRisk" type="tns:XmlDataSet" cols="80" rows="30" />
	 
 
  The general idea of this service is that after obtaining all the input data.  The input
	data is separated into 2 different input layouts.
	1) for the ERI gateway to obtain salary information based on a particular zip code
	2) for the call to business InstantID service
	Calls to each of these services are made and results returned.
	These results are then put back together in a final output structure
	eventually and along the way logic for various business rules
	is added to various layouts to 
	output certain high Risk Indicator codes in the final output structure.
	

	report service - used to gather input information from esp input. and setup
	                 information in certain layouts in order to pass into down stream functions.
	
								 - calls report service records which calls the Business Instant Id batch service.
								 
	Raw -- use as a store house of function to call the ERI gateway obtain results back and
	       keep data in layouts
				 
				 used to setup layouts in preparation for calling business instant ID.
	
	raw is module which contains functions to setup data structures
	
	for to call business instant id and to call the eri gateway
		*/		
import iesp, risk_indicators, business_risk, IncomeRisk_Services, ut, patriot;
export ReportService := MACRO
		#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
    // ds_in2 := DATASET ([], rec_in) : STORED ('ERISalaryReportRequest', FEW);
		// first_row2 := ds_in[1] : independent;
		
		// rec_in := iesp.gateway_eri_salaryreport.t_ERISalaryReportRequest;
    // ds_in := DATASET ([], rec_in) : STORED ('ERISalaryReportRequest', FEW);
		// first_row := ds_in[1] : independent;
		
    // for direct input into business instant ID product 
			
		//df_box   := dataset([],business_risk.Layout_Input_Moxie_2) : stored('BusinessRisk',few);
		// bus_risk_rec_in :=  business_risk.Layout_Input_Moxie_2;
		// bus_risk_ds_in := DATASET ([], rec_in) : STORED ('BusinessRisk', FEW);
		// bus_Risk_First_Row := ds_in[1] : independent;
		// report_By_Bus_risk := global(bus_Risk_first_Row.reportby);	

				
		//end;
			// #stored('RepresentativeSSN',ssn);
			// #stored('RepresentativeDOB',dob);
			// #stored('RepresentativeFirstName',firstname);
			// #stored('RepresentativeLastName',lastname);
			// #stored('RepresentativeMiddleName',middlename);
			
      // #stored('RepresentativeAddr', addr);
			// #stored('RepresentativeCity', city);
			// #stored('RepresentativeState', state);
			// #stored('RepresentativeZip', zip);

			// #stored('RepresentativeAge', 'age');
			// #stored('RepresentativeHomePhone', phone); 		    
		
		
		//incomeRisk_Services.raw.readBusRiskInput(report_by_bus_Risk);
		
	  // #stored('JobTitle', report_by.JobTitle);		
		 //#stored('JobTitle', 'SOFTWARE ENGINEER');	
		// #stored('Employer', report_by.Employer);		
	//	#stored('Employer', 'LEXISNEXIS');
	  // #stored('EmployerMatch', report_by.EmployerMatch);		
		//#stored('EmployerMatch', true);
		// #stored('JobExperience', report_by.JobExperience);		
		//#stored('JobExperience', 14);
		// #stored('ProfessionalExperience', report_by.ProfessionalExperience);		
		//#stored('ProfessionalExperience', 15);
    // #stored('AnnualIncome', report_by.AnnualIncome);		
		//#stored('AnnualIncome', 35000);
	  //#stored('SIC', report_by.SIC);		
		//#stored('NAICS', report_by.NAICS);		
		//#stored('SOC', report_by.SOC);		
		// #stored('BorrowerPostalCode', report_by.BorrowerPostalCode);
		//#stored('BorrowerPostalCode','45342');
		
		//
		// <SOAP VALUES FOR calling gateway directly>
		//
		
		// String JobTitle := '' : stored('JobTitle');
		// String Employer := '' : stored('Employer');
		// Boolean EmployerMatch := true : stored('EmployerMatch');
		// integer JobExperience := 0 : stored('JobExperience');
		// integer ProfessionalExperience := 0 : stored('ProfessionalExperience');
		// integer AnnualIncome := 0 : stored('AnnualIncome');
		// string SIC := '' : stored('SIC');
		// string NAICS := '' : stored('NAICS');
		// string SOC := '' : stored('SOC');
		// string BorrowerPostalCode := '' : stored('BorrowerPostalCode');
		
		// </SOAP VALUES FOR calling gateway directly>
			
	  // iesp.gateway_eri_salaryReport.t_ERISalaryReportRequest prep_for_basic() := TRANSFORM

			// SELF.RemoteLocations:=[];
			// SELF.ServiceLocations:=[];
	
			// SELF.user.GLBPurpose := '1';
			// SELF.user.DLPurpose := '1';
			// SELF.user.QueryID := '';
			// SELF.user.ReferenceCode := '';
			// SELF.user.BillingCode := '';
			// SELF.user :=[];
	
			// SELF.Reportby.JobTitle := JobTitle;
			// SELF.Reportby.Employer := Employer;
			// SELF.Reportby.EmployerMatch := true;
	
			// SELF.Reportby.JobExperience := JobExperience;
			// SELF.ReportBy.Professionalexperience := ProfessionalExperience;
			// SELF.ReportBy.AnnualIncome := AnnualIncome;
			// SELF.ReportBy.SIC := '';
			// SELF.ReportBy.NAICS := '';
	
			// SELF.ReportBy.SOC := '';
			// SELF.ReportBy.BorrowerPostalCode := BorrowerPostalCode;	
			// SELF.options:=[];
	// END;
   // *** UNCOMMENT TO TEST GATEWAY
	// eri_in_test := DATASET ([prep_for_basic ()]);
	// eri_gtway_results_test := incomeRisk_services.raw.report_view.eri_Gateway(eri_in_test);
	// *** UNCOMMENT TO TEST GATEWAY

    // gateways_in := dataset([{'erisalary','HTTPS://webapp_roxie_test:[PASSWORD_REDACTED]@securedev.accurint.com/espdev/gw/ERISalaryReport'}]
		                                // ,risk_indicators.Layout_Gateways_In) : STORED('gateways',few);     
    gateways_in := Gateway.Configuration.Get();
		
    // string gateways_in_eri := gateways_in (servicename = 'erisalary')[1].url;	
      //string     gateway_in_eri := '';
 // NEEDED to put watchlists into this format for input structure as opposed to in options in soap
 // 
 // watchlists are passed into report service as needed in watchlist/name structure
 // this format may 
	temp := record
		dataset(iesp.share.t_StringArrayItem) WatchList {xpath('WatchList/Name'), MAXCOUNT(iesp.Constants.MaxCountWatchLists)};
	end;

	watchlist_options := dataset([],temp) :stored('WatchList', few);
	watchlists_request := watchlist_options[1].WatchList;
			 												
    ds_rep_by := dataset([], iesp.income_risk.t_IncomeRiskAssessmentReportRequest)
	                            : stored('IncomeRiskAssessmentReportRequest', few);
	 
	 	first_row_incomeRisk := ds_rep_by[1] : independent;
		incomeRisk_user      := global (first_row_incomeRisk.User); // set glb/dppa here.
		//df_userInfo := incomeRisk_Services.raw.setUserInput(incomeRisk_user);
		iesp.ecl2esp.SetInputUser(incomeRisk_user); // set glb/dppa in here		
		incomeRisk_report_by := global (first_row_incomeRisk.ReportBy);		
		incomeRisk_options := global (first_row_incomeRisk.Options);	
	
		unsigned3 history_date := 999999 : stored('HistoryDateYYYYMM');
		
		df := incomeRisk_Services.raw.setReportInput(incomeRisk_report_by,																								 
		                                             incomeRisk_report_by.Name,
		                                             incomeRisk_report_by.Address,
																								 incomeRisk_report_by.Dob,
																								 incomeRisk_report_by.Employment,
																								 incomeRisk_report_by.Employment.Employer,																								 
																								 history_date);
     // use DF fields to calculate miles here.																								 
	  integer miles := IncomeRisk_Services.functions.distance_between_addr(df); 	
		                                                
		eri_in := incomeRisk_Services.raw.setGatewayRequest(incomeRisk_user,
		                                                    incomeRisk_options,
																												incomeRisk_report_by.Employment,
		                                                    incomeRisk_report_by.Employment.Employer,
																												df);
																												
		eri_gtway_results := incomeRisk_services.raw.report_view.eri_Gateway(eri_in, gateways_in);
			  
	Risk_Indicators.Mac_UnparsedFullName(title_val,rep_Fname,rep_Mname,rep_Lname,rep_name_suffix,'RepresentativeFirstName','RepresentativeMiddleName','RepresentativeLastName','RepresentativeNameSuffix');


	


	boolean Include_Additional_watchlists := FALSE: stored('IncludeAdditionalWatchlists');
	//boolean Include_Ofac := FALSE: stored('IncludeOfac');
	real Global_WatchList_Threshold :=.84 :stored('GlobalWatchlistThreshold');
	boolean Test_Data_Enabled := FALSE   : stored('TestDataEnabled');
	string20 Test_Data_Table_Name := ''   : stored('TestDataTableName');
	boolean use_dob_filter := FALSE :stored('UseDobFilter');
	integer2 dob_radius := 2 :stored('DobRadius');
	string6 ssnmask := 'NONE' 		 : stored('SSNMask');
	string6 dobmask	:= 'NONE'		: stored('DOBMask');
	unsigned1 dlmask := 0			: stored('DLMask');
	boolean IncludeTargus3220 := false : stored('IncludeTargusE3220');
	string50 DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
	string DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
	string10 exactMatchlevel := risk_indicators.iid_constants.default_ExactMatchLevel;
	 
	boolean hb := false;  // set directly here.
	boolean isUtility  := false;
	boolean ln_branded_value := false; // set directly here.
	string4 tribcode := '';

	 boolean includeMSoverride := false;
	 boolean IncludeDLverification  := false;
	 	 
	 boolean suppressNearDups := false;
	 
	 boolean require2ele := false;
	 boolean fromBiid := false;
	 boolean isFCRA := false;
	 boolean from_IT1O := false;
	 boolean nugen := false;
	 string  model_name_value := '' : stored('ModelName');
	 model_name := StringLib.StringToLowerCase(model_name_value);
	 	 
	 // set stored stuff for reading by autostandardi 
	 iesp.ECL2ESP.SetInputName(incomeRisk_report_by.Name);
	 iesp.ECL2ESP.SetInputAddress(incomeRisk_report_by.Address);
	 iesp.ECL2ESP.SetInputDate(incomeRisk_report_by.Dob,'');
		
	 gm_params := AutoStandardI.GlobalModule();
	 tempmod := module(project(gm_params, autoheaderI.LIBIN.FetchI_Hdr_Indv.full, opt))
			export forceLocal := true;
	 end;
	 		
	 dob := AutoStandardI.InterfaceTranslator.dob_val.val(project(gm_params,AutoStandardI.InterfaceTranslator.dob_val.params)); 
   unsigned1 glb := AutoStandardI.InterfaceTranslator.glb_purpose.val(project(gm_params,AutoStandardI.InterfaceTranslator.glb_purpose.params)); 
	 unsigned1 dppa := AutoStandardI.InterfaceTranslator.dppa_purpose.val(project(gm_params,AutoStandardI.InterfaceTranslator.dppa_purpose.params)); 
	 	 

	 boolean POBoxCompliance := incomeRisk_options.POBoxCompliance;
	 boolean includeTargus3200 := ~(incomeRisk_options.DisallowTargusEID3220); 
	
	 biidrec := IncomeRisk_Services.ReportService_records.records(gateways_in,
	                                                      df, // change this to df_box to use XML input directly from business_risk box.
																												hb,
																												glb, // defined by autostandardi
																												dppa, // defined by autostandardi
																												isUtility,
																												ln_branded_value,
																												tribcode,
																												,//excludeWatchLists,
																												,//ofac_only,
																												,//ofac_version,
																												,//include_ofac,
																												include_additional_watchlists,
																												global_watchlist_threshold,
																												,//dob_radius_use,
																												POBoxCompliance,
																												IncludeTargus3220,
																												DataRestriction,
																												includeMSoverride,
																												IncludeDLverification,
																												watchlists_request,
																												suppressNearDups,
																												require2ele,
																												fromBiid,
																												isFCRA,
																												from_IT1O,
																												nugen,
																												Model_name,
																												//IncludeFraudScores
																												DataPermission := DataPermission 
																												);
																													 				
		unsigned8 age := (unsigned8) ut.GetAgeI((integer) dob);
		
		integer yearsInProfession :=  incomeRisk_report_by.Employment.YearsInProfession;
		
		integer borrowerIncome := (integer) incomeRisk_report_by.Employment.AnnualIncome;

    string11 taxId         :=  incomeRisk_report_by.Employment.Employer.TaxID;
		dobRiskCode := incomeRisk_services.functions.checkDOB(dob,age,yearsInProfession);
						
    results  := incomeRisk_services.raw.setReportOutput(eri_gtway_results
		,biidrec
		,miles
		,taxId
		,incomeRisk_report_by.Employment.Employer.Address
		,borrowerIncome
		, tempmod
		, dobRiskCode
		);
	 
	 //output(rep_info, named('rep_info'));			
	  
	 //output(eri_in, named('eri_in'));
	 //output(rep_city, named('rep_city'));						
	 // TEST DEBUG
    // output(dobRiskCode, named('dobRiskCode'));
	  // output(dppa, named('dppa'));
	  // output(df, named('df'));
	   // output(biidrec, named('biidrec'));
	 // output(eri_gtway_results, named('eri_gtway_results'));
	   output(results, named('Results'));	
	
ENDMACRO;

// IncomeRisk_Services.SearchService()
/*
<ERISalaryReportRequest>
<row>
<User>
  <ReferenceCode></ReferenceCode>
  <BillingCode></BillingCode>
  <QueryId></QueryId>
  <GLBPurpose>1</GLBPurpose>
  <DLPurpose>1</DLPurpose>
	<SSNMask></SSNMask>
  <EndUser>
    <CompanyName></CompanyName>
    <StreetAddress1></StreetAddress1>
    <City></City>
    <State></State>
    <Zip5></Zip5>
  </EndUser>
  <MaxWaitSeconds></MaxWaitSeconds>
</User>
<RemoteLocations></RemoteLocations>
<ServiceLocations></ServiceLocations>
<ReportBy>
  <JobTitle>SOFTWARE ENGINEER</JobTitle>
    <Employer>LEXIS NEXIS</Employer>
    <EmployerMatch>TRUE</EmployerMatch>
    <JobExperience>10</JobExperience>
    <ProfessionalExperience>15</ProfessionalExperience>
    <AnnualIncome>35000</AnnualIncome>
    <SIC></SIC>
		<NAICS></NAICS>
		<SOC></SOC>
		<BorrowerPostalCode>45342</BorrowerPostalCode>
</ReportBy>
<Options>
  <ReturnCount>100</ReturnCount>
  <StartingRecord>1</StartingRecord>

</Options>
</row>
</ERISalaryReportRequest>

<IncomeRiskReportRequest>
<row>
<User>
<GLBPurpose>1</GLBPurpose>
<DLPurpose>1</DLPurpose>
</User>
<ReportBy>
  <SSN></SSN>
  <Name>
    <Full></Full>
    <First></First>
    <Middle></Middle>
    <Last></Last>
    <Suffix></Suffix>
    <Prefix></Prefix>
  </Name>
  <Address>
    <StreetName></StreetName>
    <StreetNumber></StreetNumber>
    <StreetPreDirection></StreetPreDirection>
    <StreetPostDirection></StreetPostDirection>
    <StreetSuffix></StreetSuffix>
    <UnitDesignation></UnitDesignation>
    <UnitNumber></UnitNumber>
    <StreetAddress1></StreetAddress1>
    <StreetAddress2></StreetAddress2>
    <State></State>
    <City></City>
    <Zip5></Zip5>
    <Zip4></Zip4>
    <County></County>
    <PostalCode></PostalCode>
    <StateCityZip></StateCityZip>
  </Address>
    <DOB>
    <Year></Year>
    <Month></Month>
    <Day></Day>
    </DOB>
    <UniqueID></UniqueID>
    <PhoneNumber></PhoneNumber>
    <DriverLicenseNumber></DriverLicenseNumber>
    <DriverLicenseState></DriverLicenseState>
    <Employment>
       <JobTitle></JobTitle>
       <AnnualIncome></AnnualIncome>
       <YearsInJob></YearsInJob>
       <YearsInProfession></YearsInProfession>
       <Employer>
	 <CompanyName></CompanyName>
	 <DBA></DBA>
	 <PhoneNumber></PhoneNumber>
	 <TaxId></TaxId>
         <Address>
          <StreetName></StreetName>
          <StreetNumber></StreetNumber>
          <StreetPreDirection></StreetPreDirection>
          <StreetPostDirection></StreetPostDirection>
          <StreetSuffix></StreetSuffix>
          <UnitDesignation></UnitDesignation>
          <UnitNumber></UnitNumber>	
          <StreetAddress1></StreetAddress1>
          <StreetAddress2></StreetAddress2>
 	  <State></State>
 	  <City></City>
 	  <Zip5></Zip5>
 	  <Zip4></Zip4>
 	  <County></County>
          <PostalCode></PostalCode>
    	 <StateCityZip></StateCityZip>
	</Address>
	</Employer>
	</Employment>
</ReportBy>
<Options>
        <EmployerMatch></EmployerMatch>
				<PoBoxCompliance></PoBoxCompliance>
				<includeMSoverride></includeMSoverride>
				<IncludeDLverification></IncludeDLverification>
				<WatchLists></WatchLists> ** DATASET **
				<GlobalWatchlistThreshold></GlobalWatchlistThreshold>
        <SIC></SIC>
        <NAICS></NAICS>
        <SOC></SOC>                                    
</Options>
</row>
</IncomeRiskReportRequest>

*/