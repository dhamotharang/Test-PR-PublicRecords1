IMPORT FraudDefenseNetwork_Services, iesp, FraudShared_Services;
// A function that will build the new (as of 11/03/2015) Fraud Defense Network (FDN) section 
// of the Comprehensive Person Report using a dataset of input fdn id key records.
EXPORT FDN_Records(dataset(FraudShared_Services.Layouts.Raw_Payload_rec) ds_fdnidkey_recs_in
                  ) := FUNCTION

  // Use the ds of recs input and transform the fdn id key data into the iesp layout.
  ds_fdn_getresults := FraudDefenseNetwork_Services.GetResults(ds_fdnidkey_recs_in);

	// Dataset out of FraudDefenseNetwork_Services.GetResults is not really in the correct iesp layout and it only 
	// has 1 rec/row on it, so pull the 1 row off and project it onto the iesp layout we really want.
  ds_fdn_section    := project(ds_fdn_getresults,
	                             transform(iesp.frauddefensenetwork.t_FDNSearchRecord,
														                self := left.Records[1])); // only 1 record in the left ds
											 
  //Debugging outputs
  //output(ds_fdnidkey_recs_in,         named('ds_fdnidkey_recs_in'));
	//output(ds_fdn_getresults,           named('ds_fdn_getresults'));
  //output(ds_fdn_section,              named('ds_fdn_section'));

  return ds_fdn_section;

END;
