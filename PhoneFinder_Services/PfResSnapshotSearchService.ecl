/*--SOAP--
<message name="PFReportsSearchService">
	<part name="PFResSnapshotServiceRequest" type="tns:XmlDataSet" cols="80" rows="30"/> 
</message>
*/
/*--INFO-- This service hits the Phonefinder reporting keys by userid, billing group, lexid, phonenumber and returns transaction records. 
						The search requires a a transaction date/range.
*/
IMPORT doxie;
EXPORT PfResSnapshotSearchService := MACRO

  WSInput.MAC_PFResSnapshotSearchService();

  // Get XML Input
  rec_in		:= iesp.phonefindertransactionsearch.t_PhoneFinderTransactionSearchRequest;
  ds_in			:= DATASET([], rec_in) : STORED('PfResSnapshotServiceRequest', few);
  first_row	:= ds_in[1] : INDEPENDENT;

  iesp.ECL2ESP.SetInputBaseRequest(first_row);
  iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);
  search_by    := GLOBAL(first_row.SearchBy);
  
  // Fail the Service if No Input is Provided 
  MAP(~EXISTS(search_by.CompanyIds) and search_by.ReferenceCode = '' and  search_by.UserId = '' and search_by.PhoneNumber ='' and search_by.UniqueId = '' => FAIL(301, doxie.ErrorCodes(301)),
		  (EXISTS(search_by.CompanyIds) or search_by.ReferenceCode <> '' or  search_by.UserId <> '' or search_by.PhoneNumber <> '') and 
			search_by.TransactionDateRange.StartDate.Year = 0  => FAIL(301, doxie.ErrorCodes(301))); 
     
  PhoneFinder_Services.Layouts.PFResSnapShotSearch t_input(iesp.phonefindertransactionsearch.t_PhoneFinderTransactionSearchRequest l) := TRANSFORM
		self.Companies := CHOOSEN(PROJECT(l.SearchBy.CompanyIds, PhoneFinder_Services.Layouts.Input_CompanyId), iesp.Constants.PfResSnapshot.MaxCompanyIds);
		self.PhoneNumber := l.SearchBy.PhoneNumber;
		self.UserId := l.SearchBy.UserId;
		self.ReferenceCode := l.SearchBy.ReferenceCode;
		self.UniqueId := (UNSIGNED8)l.SearchBy.UniqueId;
		self.StartDate := iesp.ECL2ESP.t_DateToString8(l.SearchBy.TransactionDateRange.StartDate);
		self.EndDate := iesp.ECL2ESP.t_DateToString8(l.SearchBy.TransactionDateRange.EndDate);
  END;

  ds_searchby := PROJECT(ds_in, t_input(LEFT));
    
  ds_out := PhoneFinder_Services.PfResSnapshotSearchRecords(ds_searchby[1]);
  
  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(ds_out, Results, 
                                             iesp.phonefindertransactionsearch.t_PhoneFinderTransactionSearchResponse,,false,, InputEcho, search_by,
                                             iesp.Constants.PfResSnapshot.MaxSearchRecords);
  
  OUTPUT(Results, NAMED('Results'));
ENDMACRO;