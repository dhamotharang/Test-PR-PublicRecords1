/*--SOAP--
	<message name = "IncomeRisk_Services_BATCH">
	  <part name="batch_in"    type = "tns:XmlDataSet" cols="80" rows="30"/>		
		<part name="gateways" type="tns:XmlDataSet" cols="110" rows="10"/>		
		<part name="DPPAPurpose"          type="xsd:byte"/>
		<part name="GLBPurpose"           type="xsd:byte"/> 
		<part name="DataPermissionMask" type="xsd:string"/>
    <part name="EmployerMatch" type="xsd:boolean"/>
		<part name="POBoxCompliance"  type="xsd:boolean"/>
	  <part name="IncludeMSOverride"  type="xsd:boolean"/>
	  <part name="IncludeDLVerification"  type="xsd:boolean"/>
	  <part name="DisallowTargusEID3220"  type="xsd:boolean"/>
    <part name="OFACversion" type="xsd:unsignedInt"/>
		<part name="ModelName" type="xsd:string"/>
		
	  <part name="Include_ALL_Watchlist" type="xsd:boolean"/>
	  <part name="Include_ALLV4_Watchlist" type="xsd:boolean"/>
	  <part name="Include_BES_Watchlist" type="xsd:boolean"/>
	  <part name="Include_CFTC_Watchlist" type="xsd:boolean"/>
  	<part name="Include_DTC_Watchlist" type="xsd:boolean"/>
  	<part name="Include_EUDT_Watchlist" type="xsd:boolean"/>
  	<part name="Include_FBI_Watchlist" type="xsd:boolean"/>
  	<part name="Include_FCEN_Watchlist" type="xsd:boolean"/>
	  <part name="Include_FAR_Watchlist" type="xsd:boolean"/>
	  <part name="Include_IMW_Watchlist" type="xsd:boolean"/>
	  <part name="Include_OFAC_Watchlist" type="xsd:boolean"/>
	  <part name="Include_OCC_Watchlist" type="xsd:boolean"/>
	  <part name="Include_OSFI_Watchlist" type="xsd:boolean"/>
	  <part name="Include_PEP_Watchlist" type="xsd:boolean"/>
	  <part name="Include_SDT_Watchlist" type="xsd:boolean"/>
	  <part name="Include_BIS_Watchlist" type="xsd:boolean"/>
	  <part name="Include_UNNT_Watchlist" type="xsd:boolean"/>
	  <part name="Include_WBIF_Watchlist" type="xsd:boolean"/>
	  </message>
*/
// these are left here in order to debug in the future in case direct access to ERI gateway or the business instantID product
// is needed.
//    <part name="businessRisk"    type = "tns:XmlDataSet" cols="70" rows="25"/>
// 		<part name="ERISalaryReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />	
//
import doxie, address, business_risk, risk_indicators, incomeRisk_services, iesp, batchservices,gateway, OFAC_XG5;
export Batch_Service() := macro
		
	// Can't have duplicate definitions of Stored with different default values, 
	// so add the default to #stored to eliminate the assignment of a default value.
	#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
	#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);
	  
   gateways_in := 	Gateway.Configuration.Get();
	 
	 batch_in_tmp := IncomeRisk_Services.reportService_records.file_inRiskAssessBatchMaster();

	 batch_in := project(batch_in_tmp, transform(Business_Risk.Layout_Input_Moxie_2,
	                
									//unsigned6 	bdid := 0;
									//unsigned2 	score := 0;
									//string30	 	acctno;
									  self.name_company := left.Comp_Name;
										self.alt_company_name := left.DBA;
									  self.street_addr := left.comp_addr1;
									  self.prim_range := left.comp_prim_range;
									  self.predir := left.comp_predir;
									  self.prim_name := left.comp_prim_name;
									  self.addr_suffix := left.comp_addr_suffix;
									  self.postdir := left.comp_postdir;
									  self.unit_desig := left.comp_unit_desig;
									  self.sec_range := left.comp_sec_range;
									  self.p_city_name := left.comp_p_city_name;
									  self.st := left.comp_st;
									  self.z5 := left.comp_z5;
								    self.zip4 := left.comp_zip4;
									//string10  	lat 
									//string11  	long := '';
									//string1   	addr_type; 
									//string4   	addr_status; 
									//string9   	fein := '';
									  self.phoneno :=  left.company_PhoneNumber; 
									//string16		ip_addr := '';
									//STRING120 unParsedFullName :='';
									//string20		name_first;
									//string20		name_middle;
									//string20		name_last;
									//string5		name_suffix;
									//string20		name_last_alt;
										self.street_addr2 :=  left.addr1;
									  self.prim_range_2 :=  left.prim_range;
									  self.predir_2 :=  left.predir;
									  self.prim_name_2 := left.prim_name;
									  self.addr_suffix_2 :=  left.addr_suffix;
									  self.postdir_2 :=  left.postdir;
									  self.unit_desig_2  :=  left.unit_desig;
									  self.sec_range_2  :=  left.sec_range;
									  self.p_city_name_2 :=  left.p_city_name;
									  self.st_2  :=  left.st;
									  self.z5_2  :=  left.z5;
									  self.zip4_2 :=   left.zip4;
									//string9		  self.ssn;
									//string8		  self.dob;
										self.phone_2 := left.homephone;
									//string3		  rep_age;
										self.dl_number := left.dl;
									  self.dl_state := left.dlstate;
									//string100		rep_email;
										self.HistoryDateYYYYMM := 999999;
									  self := left;
									  self := [];
	               ));
	 
	
		unsigned1	glb			:= RiskWise.permittedUse.fraudGLBA  : stored('GLBPurpose');
		unsigned1	dppa			:= 1  : stored('DPPAPurpose');

		
		boolean hb   := false;
		boolean POBoxCompliance              := false : STORED('POBoxCompliance');
		//boolean ofac_only                     := false : stored('OfacOnly');
		//boolean ExcludeWatchLists             := false : stored('ExcludeWatchLists');
		unsigned1 OFAC_version                := 1 :STORED('OFACversion');
		//boolean Include_Additional_watchlists := FALSE: stored('IncludeAdditionalWatchlists');
		//boolean Include_Ofac                  := FALSE: stored('IncludeOfac');
		// real Global_WatchList_Threshold :=.84 :stored('GlobalWatchlistThreshold');
		//boolean IncludeFraudScores := false :stored('IncludeFraudScores');
		boolean isUtility          := false;
		boolean ln_branded_value   := false;
		string4 tribcode           := '';
		boolean from_IT1O          := false;
		boolean suppressNearDups   := false;
		boolean require2ele        := false;
		boolean fromBiid           := false;
		boolean isFCRA             := false;
		boolean use_dob_filter     := FALSE;
    
    include_ofac := if(ofac_version = 1, false, true);
    global_watchlist_threshold := if(ofac_version in [1, 2, 3], 0.84, 0.85);
		
		string  model_name_value   := '' : stored('ModelName');
		model_name := StringLib.StringToLowerCase(model_name_value);
		boolean ExcludeTargusEID3220 := false : stored('DisallowTargusEID3220');
		boolean IncludeTargus3220 := ~ExcludeTargusEID3220;
		                                      
		string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
		string50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
		nugen := true;

		dob_radius_use := -1 ; 
		
		boolean IncludeMSoverride := false : stored('IncludeMSoverride');
		boolean IncludeDLverification := false : stored('IncludeDLverification');

    // string gateways_in_eri := gateways_in (servicename = 'erisalary')[1].url;

		boolean Include_ALL_Watchlist:= false : stored('Include_ALL_Watchlist');
		boolean Include_ALLV4_Watchlist:= false : stored('Include_ALLV4_Watchlist');
		boolean Include_BES_Watchlist:= false : stored('Include_BES_Watchlist');
		boolean Include_CFTC_Watchlist:= false : stored('Include_CFTC_Watchlist');
		boolean Include_DTC_Watchlist:= false : stored('Include_DTC_Watchlist');
		boolean Include_EUDT_Watchlist:= false : stored('Include_EUDT_Watchlist');
		boolean Include_FBI_Watchlist:= false : stored('Include_FBI_Watchlist');
		boolean Include_FCEN_Watchlist:= false : stored('Include_FCEN_Watchlist');
		boolean Include_FAR_Watchlist:= false : stored('Include_FAR_Watchlist');
		boolean Include_IMW_Watchlist:= false : stored('Include_IMW_Watchlist');
		boolean Include_OFAC_Watchlist:= false : stored('Include_OFAC_Watchlist');
		boolean Include_OCC_Watchlist:= false : stored('Include_OCC_Watchlist');
		boolean Include_OSFI_Watchlist:= false : stored('Include_OSFI_Watchlist');
		boolean Include_PEP_Watchlist:= false : stored('Include_PEP_Watchlist');
		boolean Include_SDT_Watchlist:= false : stored('Include_SDT_Watchlist');
		boolean Include_BIS_Watchlist:= false : stored('Include_BIS_Watchlist');
		boolean Include_UNNT_Watchlist:= false : stored('Include_UNNT_Watchlist');
		boolean Include_WBIF_Watchlist:= false : stored('Include_WBIF_Watchlist');

		dWL := dataset([], iesp.share.t_StringArrayItem) +
		if(Include_ALL_Watchlist, dataset([{patriot.constants.wlALL}], iesp.share.t_StringArrayItem)) +
		if(Include_ALLV4_Watchlist, dataset([{patriot.constants.wlALLV4}], iesp.share.t_StringArrayItem)) +
		if(Include_BES_Watchlist, dataset([{patriot.constants.wlBES}], iesp.share.t_StringArrayItem)) +
		if(Include_CFTC_Watchlist, dataset([{patriot.constants.wlCFTC}], iesp.share.t_StringArrayItem)) +
		if(Include_DTC_Watchlist, dataset([{patriot.constants.wlDTC}], iesp.share.t_StringArrayItem)) +
		if(Include_EUDT_Watchlist, dataset([{patriot.constants.wlEUDT}], iesp.share.t_StringArrayItem)) +
		if(Include_FBI_Watchlist, dataset([{patriot.constants.wlFBI}], iesp.share.t_StringArrayItem)) +
		if(Include_FCEN_Watchlist, dataset([{patriot.constants.wlFCEN}], iesp.share.t_StringArrayItem)) +
		if(Include_FAR_Watchlist, dataset([{patriot.constants.wlFAR}], iesp.share.t_StringArrayItem)) +
		if(Include_IMW_Watchlist, dataset([{patriot.constants.wlIMW}], iesp.share.t_StringArrayItem)) +
		if(Include_OFAC_Watchlist, dataset([{patriot.constants.wlOFAC}], iesp.share.t_StringArrayItem)) +
		if(Include_OCC_Watchlist, dataset([{patriot.constants.wlOCC}], iesp.share.t_StringArrayItem)) +
		if(Include_OSFI_Watchlist, dataset([{patriot.constants.wlOSFI}], iesp.share.t_StringArrayItem)) +
		if(Include_PEP_Watchlist, dataset([{patriot.constants.wlPEP}], iesp.share.t_StringArrayItem)) +
		if(Include_SDT_Watchlist, dataset([{patriot.constants.wlSDT}], iesp.share.t_StringArrayItem)) +
		if(Include_BIS_Watchlist, dataset([{patriot.constants.wlBIS}], iesp.share.t_StringArrayItem)) +
		if(Include_UNNT_Watchlist, dataset([{patriot.constants.wlUNNT}], iesp.share.t_StringArrayItem)) +
		if(Include_WBIF_Watchlist, dataset([{patriot.constants.wlWBIF}], iesp.share.t_StringArrayItem));
		watchlists_request := dWL(value<>'');
		
	 

		eri_in_w_acctno := incomeRisk_Services.raw.batch_view.setERIGatewayRequest(batch_in_tmp);				
		
		eri_gtway_results_w_acct_no := incomeRisk_services.raw.batch_view.eri_gateway(eri_in_w_acctno, gateways_in);
    
    IF( OFAC_version != 4 AND OFAC_XG5.constants.wlALLV4 IN SET(watchlists_request, value),
    FAIL( OFAC_XG5.Constants.ErrorMsg_OFACversion ) );

		// this is modeled after business_Risk.InstantID_Batch_Service_records(
		biidBatch_recs := IncomeRisk_Services.ReportService_records.records(
																			 
																 gateways_in, //risk_indicators.Layout_Gateways_In 																			
																 batch_in,  //business_risk.Layout_Input_Moxie_2 																			
																 hb, //boolean																			
																 glb,  //unsigned2 
															   dppa,  //unsigned2 																			
																 isUtility, //boolean 																			 
																 ln_branded_value, //boolean																			 
																 tribcode, //string4																																							 
																 , //excludeWatchLists, //boolean																				
																 , //ofac_only, //boolean 																			 
																 ofac_version, //unsigned1																				
																 include_ofac, //boolean																				
																 , //include_additional_watchlists  //boolean 																			 
																 global_watchlist_threshold, 	//real																				 
																 , //dob_radius_use, //integer2																				 
																 POBoxCompliance, //boolean
																				//bsversion // set directly,
																				//exactMatchLevel set directly,
																				//	string10 
																 IncludeTargus3220,
																 DataRestriction,																					 
																 includeMSoverride, //boolean																					
																 IncludeDLverification, //boolean 																					
																 watchlists_request, //iesp.share.t_StringArrayItem 
																 suppressNearDups, //boolean
																 require2ele, //boolean
																 fromBiid, //boolean
																 isFCRA, //boolean
																 from_IT1O, //boolean
																 nugen, //boolean
																 Model_name, // string
																 //IncludeFraudScores
																 DataPermission := DataPermission //string
																 );
			
		// used to get PL list
    //iesp.ECL2ESP.SetInputName(incomeRisk_report_by.Name);
		//iesp.ECL2ESP.SetInputAddress(incomeRisk_report_by.Address);
		
		batch_in_slim := project(batch_in, Autokey_batch.Layouts.rec_inBatchMaster);
		
		did_set_acctno := batchservices.functions.fn_find_dids_and_append_to_acctno(batch_in_slim);
		
    results_out  := incomeRisk_services.raw.batch_view.setBatchReportOutput(
		 eri_gtway_results_w_acct_no
		  , biidBatch_recs
		  , batch_in
		  ,did_set_acctno
		  );
	 
		results := dedup(sort(results_out, acctno), acctno); // assuming this is unique
	 
	 // output(batch_in, named('batch_in'));
	 // output(eri_in_w_acctno, named('eri_in_w_acctno'));	 
	 // output(eri_gtway_results_w_acct_no, named('eri_gtway_results_w_acctno'));	 
   // output(biidBatch_recs, named('biidBatch_recs'));
	 // output(batch_in_slim, named('batch_in_slim'));
	 // output(did_set_acctno, named('did_set_acctno'));


   output(results, named('Results'));

endmacro;			

// <row>
// <acctno></acctno>
// <name_last></name_last>
// <name_first></name_first>
// <prim_range></prim_range>
// <predir></predir>
// <prim_name></prim_name>
// <addr_suffix></addr_suffix>
// <p_city_name></p_city_name>
// <st></st>
// <z5></z5>
// <z4></z4>
// <ssn></ssn>
// <JobTitle></JobTitle>
// <AnnualIncome></AnnualIncome>
// <YearsInJob></YearsInJob>
// <ProfessionalExperience></ProfessionalExperience>
// <Comp_Name></Comp_Name>
// <Comp_prim_range></Comp_prim_range>
// <Comp_predir></Comp_predir>
// <Comp_prim_name></Comp_prim_name>
// <Comp_addr_suffix></Comp_addr_suffix>
// <Comp_postdir></Comp_postdir>
// <Comp_unit_desig></Comp_unit_desig>
// <Comp_sec_range></Comp_sec_range>
// <Comp_p_city_name></Comp_p_city_name>
// <Comp_st></Comp_st>
// <Comp_z5></Comp_z5>
// <Comp_zip4></Comp_zip4>
// <DBA></DBA>
// <CompanyPhone></CompanyPhone>
// <TaxID></TaxID>
// <dob></dob>
// <homephone></homephone>
// </row>
// </dataset>													 