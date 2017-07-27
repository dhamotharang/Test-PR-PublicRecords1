/*--SOAP--
<message name="SearchService">
                <!-- COMPLIANCE SETTINGS -->
                <part name="AffiliationSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/

IMPORT iesp, Healthcare_Affiliations, Healthcare_Shared;

EXPORT SearchService := MACRO
	
	ds_in := DATASET ([],iesp.healthcare_provideraffiliation.t_AffiliationSearchRequest) : STORED('AffiliationSearchRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;     
	#STORED('_transactionID', first_row.AccountContext.Common.TransactionID);  	// As per Steven Christy's email on Aug 01, 2016, transactionid should be overwriten with that of AccountContext.Common.TransactionID and not the one in _Header
  iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);

	cfgMaxRecordsPerMatch := 	if(first_row.options.MaxRecordsPerMatch>0,first_row.options.MaxRecordsPerMatch,Healthcare_Affiliations.Constants.MaxRecordsPerMatch);
	inRec := dataset([{'1',first_row.SearchBy.EntityID,map(first_row.SearchBy.EntityIDType in Healthcare_Affiliations.Constants.ValidProviderSearchInput => Healthcare_Affiliations.Constants.ProviderIndicator,
																													first_row.SearchBy.EntityIDType in Healthcare_Affiliations.Constants.ValidFacilitySearchInput  => Healthcare_Affiliations.Constants.FacilityIndicator,
																													'')}],Healthcare_Affiliations.Layouts.Batch_in);
	cfg := row({cfgMaxRecordsPerMatch},Healthcare_Affiliations.Layouts.RunTimeConfig);
	rawResult := Healthcare_Affiliations.Raw.getRecords(inRec,cfg);
	
	fmtResults := project(rawResult,transform(iesp.healthcare_provideraffiliation.t_AffiliationSearchResult, self:=left));	 
	
  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(fmtResults, marshallResults, iesp.healthcare_provideraffiliation.t_AffiliationSearchResponse, Affiliations, false);
																
	Results := project(marshallResults, transform(iesp.healthcare_provideraffiliation.t_AffiliationSearchResponse,																					
																						self.SearchBy:= first_row.SearchBy;
																						self.SearchOptions:=first_row.options;
																						self:=left;self := [];));																						
	// LOGGING	

	// Populate the input fields	
	myloggingdata0 := PROJECT(ds_in, Healthcare_Shared.Transforms_Logging.Affiliations(LEFT));
	
		// Populate all non input fields
	rec_in := Healthcare_Shared.layouts_logging.transactionlog;
	
	rec_in setNonInput(Healthcare_Shared.layouts_logging.transactionlog L):=transform						
			self.product_id := Healthcare_Shared.Constants.Healthcare_product_id; 
			self.sub_product_id := Healthcare_Shared.Constants.HMS_sub_product_id;
			self.record_count := results[1].RecordCount;
			self:=L;
	end;	
	
	myloggingdata	:= PROJECT(myloggingdata0, setNonInput(LEFT));

	// Populate the output fields
	// myloggingdataOut := join(myloggingdata, fmtResults, TRUE, LEFT OUTER, ALL);	The results are not part of the logging as per Steven Christy (Jul 13, 2016)
	
	// Wraps Logging into Records.Rec since that's the format ESP expects	
	myloggingdataWrap := PROJECT(myloggingdata, TRANSFORM(Healthcare_Shared.layouts_logging.transactionLogWrap, SELF.Rec := LEFT));
	loggingResult := PROJECT(myloggingdataWrap, TRANSFORM(Healthcare_Shared.layouts_logging.transactionLogWrapWrap, SELF.Records := LEFT));
	
	// END LOGGING
	
	OUTPUT(Results, NAMED('Results'));	
	OUTPUT(loggingResult, NAMED('LOG_log__hcar_transaction__log'));
	
	// OUTPUT(first_row, NAMED('first_row'));	
	// OUTPUT(inRec, NAMED('inRec'));
	// OUTPUT(TempResult, NAMED('TempResult'));
	// OUTPUT(rawResult, NAMED('rawResult'));

ENDMACRO;