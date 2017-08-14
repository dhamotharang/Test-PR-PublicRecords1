/*  PLEASE BE AWARE that of the 2 categories of FDN data (contributory & inquiry),  
    this function returns contributory data even if it is not permitted via 
    DataPermissionMask position 11.
    
    This was done at the time the function was created because the person search & report 
    queries needed to know if fdn contributory data existed so a special FDN "We Also Found"
    contributory data boolean indicator could be set on.

    !!! Therefore callers of this function (or the FraudDefenseNetwork_Services.Search_Records function)
    SHOULD CHECK WHETHER DPM 11/FDN CONTRIBUTORY DATA IS PERMITTED before returning it, 
    as is currently being done in:
        doxie.Append_FDN_Inds 
        doxie.func_FdnCheckRollupRecs 
        doxie.func_FdnCheckSearchRecs
        PersonSearch_Services.Functions 
 */
IMPORT iesp, FraudShared_Services;

EXPORT func_CheckForFdnData(
  DATASET(FraudDefenseNetwork_Services.Layouts.batch_search_rec) ds_in,
  unsigned6 gc_id_in,
  unsigned2 ind_type_in,
  unsigned6 product_code_in,
  DATASET(iesp.frauddefensenetwork.t_FDNIndType) ds_excl_ind_types_in = DATASET([],iesp.frauddefensenetwork.t_FDNIndType),
  DATASET(iesp.frauddefensenetwork.t_FDNFileType) ds_file_types_in = DATASET([],iesp.frauddefensenetwork.t_FDNFileType)
/*
    boolean ForceReturnContribData? = false // 03/2015 enhancement? use some other/better parm name???
    ^--- when added, this new parm will need set to "true" where this function is called in:
        doxie.Append_FDN_Inds
        doxie.func_FdnCheckRollupRecs
        doxie.func_FdnCheckSearchRecs
        PersonSearch_Services.Functions
    AND it also will need passed into FraudDefenseNetwork_Services.Search_Records below to be checked there, 
    once that function is also revised to use it.
*/

) := FUNCTION

  ds_input_seq := FraudDefenseNetwork_Services.Functions.SetSequences(ds_in);

  // Use Search_records to get the fdn id key records for the input dataset non-blank field values.
	ds_search_recs := FraudDefenseNetwork_Services.Search_Records(
    ds_input_seq, gc_id_in, ind_type_in, product_code_in, ds_excl_ind_types_in, ds_file_types_in
    //, ForceReturnContribData //future enhancement???
  );
    
  /*
  NOTE: FraudDefenseNetwork_Services.Layouts.batch_response_rec layout is made up of both the 
	FraudDefenseNetwork_Services.Layouts.batch_search_rec & frauddefensenetwork.Layouts_Key.Main
	layouts, which both have a did & ssn field on them.
	Since only the ones from the FraudDefenseNetwork_Services.Layouts.batch_search_rec are kept due to the 
	self := L below, added 2 fdn_idkey_* fields to preserve the fdn id key rec data.
  */
	FraudDefenseNetwork_Services.Layouts.batch_response_rec tf_dojoin(
    FraudDefenseNetwork_Services.Layouts.batch_search_rec L,
    FraudShared_Services.Layouts.Raw_Payload_rec R
  ) := TRANSFORM
    SELF.fdn_idkey_ssn := R.ssn;
    SELF.fdn_idkey_did := R.did;
		SELF := L; // input ds fields
		SELF := R; // fdn id key record fields
	END;

  // Join the input dataset to the search_recs output ds, joining on seq#/acctno to only return 
	// input records that had data found in the fdn keys.
	// Also filter to only include records where the input "search by" field type corresponds 
	// to the appropriate fdn id key entity_type field data value.
  ds_results := JOIN(
    ds_input_seq, ds_search_recs,
    LEFT.seq = (integer) RIGHT.acctno,
    tf_dojoin(LEFT,RIGHT));	

    // output(ds_input_seq,   named('ds_input_seq'));
    // output(ds_search_recs, named('ds_search_recs'));
    // output(ds_results,     named('ds_results'));

    RETURN ds_results;
END;
