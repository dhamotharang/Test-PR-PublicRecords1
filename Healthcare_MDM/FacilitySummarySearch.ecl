/*--SOAP--
<message name="ADMOrganizationSearchRequest">
	<!-- COMPLIANCE SETTINGS -->
	<part name="ADMOrganizationSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
IMPORT Healthcare_Shared, iesp;
export FacilitySummarySearch := MACRO
	/* This is the MDM Provider Search it calls the standard ln HCO search under the covers then applies MDM customer data over the results based on a view	*/
	ds_in := DATASET ([], iesp.healthcare_admorgsearchandreport.t_ADMOrganizationSearchRequest) : STORED('ADMOrganizationSearchRequest', FEW);
	first_row := ds_in[1] : INDEPENDENT;
	iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);
	SearchCriteria := first_row.SearchBy;
	SearchOptions := first_row.Options;
	// #STORED('_transactionID', first_row.AccountContext.Common.TransactionID);
	// #STORED('GC_ID', first_row.AccountContext.Common.GlobalCompanyId);  // Used to derive MDMId on esp side. // As per Steven Christy's email on Aug 01, 2016, transactionid should be overwriten with that of AccountContext.Common.TransactionID and not the one in _Header
	ds1 := Healthcare_MDM.Stubs.StubbedSearch1();
	ds2 := Healthcare_MDM.Stubs.StubbedSearch2();
	
	SummaryStubs := project(ds1 + ds2,transform(iesp.healthcare_admorgsearchandreport.t_ADMOrganizationSearchOrganization, self.CLIARecords := []; self := left; self := [];));
	ResultsSearchBy := project(SearchCriteria, transform(iesp.healthcare_admorgsearchandreport.t_ADMOrganizationSearchResponse,		
																						self.SearchOptions:=SearchOptions;
																						self.RecordCount := 2;
																						self._Header.TransactionId := first_row.AccountContext.Common.TransactionID;
																						self.SearchBy:= left;
																						self := [];));
	Results := project(ResultsSearchBy, transform(iesp.healthcare_admorgsearchandreport.t_ADMOrganizationSearchResponse,		
																						self.Organizations := SummaryStubs; self:=left;self := [];));
	// Populate the input fields
	 myloggingdata0 := PROJECT(ds_in, Healthcare_Shared.Transforms_Logging.MDMFacilitiesSummary(LEFT));
	 
	// Populate all non input fields
	rec_in := Healthcare_Shared.layouts_logging.transactionlog;
	
	rec_in setNonInput(Healthcare_Shared.layouts_logging.transactionlog L):=transform
			self.product_id := Healthcare_Shared.Constants.Healthcare_product_id; 
			self.sub_product_id := Healthcare_Shared.Constants.HMS_sub_product_id;
			// self.record_count := results[1].RecordCount;
			self.record_count := 2; // agreed with SChristy for stub
			self:=L;
	end;
	 
	myloggingdata	:= PROJECT(myloggingdata0, setNonInput(LEFT));	 
	myloggingdataWrap := PROJECT(myloggingdata, TRANSFORM(Healthcare_Shared.layouts_logging.transactionLogWrap, SELF.Rec := LEFT));
	loggingResult := PROJECT(myloggingdataWrap, TRANSFORM(Healthcare_Shared.layouts_logging.transactionLogWrapWrap, SELF.Records := LEFT));
	
	output(Results, named('Results'));
	OUTPUT(loggingResult, NAMED('LOG_log__hcar_transaction__log'));
ENDMACRO;