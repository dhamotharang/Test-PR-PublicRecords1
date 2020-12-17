/*
  PLEASE BE AWARE that of the 2 categories of FDN data (contributory & inquiry),  
  this function currently returns contributory data even if it is not permitted via 
  DataPermissionMask position 11.

  This was done at the time the function was created because the person search & report 
  queries needed to know if fdn contributory data existed so a special FDN "We Also Found"
  contributory data indicator could be set on.

  !!! Therefore callers of this function (or the FraudDefenseNetwork_Services.func_CheckForFdnData function)
  SHOULD CHECK WHETHER DPM 11/FDN CONTRIBUTORY DATA IS PERMITTED before returning it, 
  as is currently being done in:
  FraudDefenseNetwork_Services.SearchService and BatchServices.trisv31_get_fdn 
 */ 

IMPORT AutoStandardI, doxie, FraudShared_Services, iesp;

EXPORT Search_Records(
	DATASET(FraudDefenseNetwork_Services.Layouts.batch_search_rec) ds_in,
	unsigned6 gc_id_in, 
	unsigned2 ind_type_in, 
	unsigned6 product_code_in, 
	DATASET(iesp.frauddefensenetwork.t_FDNIndType) ds_industry_types_in,
	DATASET(iesp.frauddefensenetwork.t_FDNFileType) ds_file_types_in,
	INTEGER DeltaUse = 0,
	INTEGER DeltaStrict = 0,
  string fraud_platform = FraudShared_Services.Constants.Platform.FDN,
  boolean filterBy_entity_type = TRUE
  //,boolean ForceReturnContribData? = false // 03/2016 enhancement??? use some other/better parm name???
	//  ^--- when added, this new parm & DPM 11 will need checked below to determine whether
	//       to return contributory data even if not permitted.
	// Then the DPM 11/contrib filter in FraudDefenseNetwork_Services.SearchService and BatchServices.trisv31_get_fdn
	// could be removed.
  
) := FUNCTION
  
  global_mod := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (global_mod);
  
  ds_in_seq := FraudDefenseNetwork_Services.Functions.SetSequences(ds_in);

  ds_filterBys := PROJECT(ds_in_seq, FraudDefenseNetwork_Services.Layouts.FilterBy_With_Seq_rec);
  
  ds_batch_in := FraudDefenseNetwork_Services.StandardizeBatchInput(ds_in_seq);

	ds_ids := FraudDefenseNetwork_Services.Search_IDs(ds_batch_in, fraud_platform, filterBy_entity_type);
	
	ds_Raw := FraudShared_Services.GetPayloadRecords(ds_ids, fraud_platform, mod_access);
  
  ds_Raw_With_Filter := JOIN(
    ds_Raw, ds_filterBys,
    (integer)LEFT.acctno = RIGHT.seq,
    TRANSFORM(FraudDefenseNetwork_Services.Layouts.Raw_Payload_rec,
			SELF := RIGHT,
      SELF := LEFT,
			SELF := []));

	ds_filtered:= FraudDefenseNetwork_Services.Filter.filterRecs(ds_Raw_With_Filter);
  
  ds_x_filtered := PROJECT(ds_filtered, FraudShared_Services.Layouts.Raw_Payload_rec);
		
	ds_recs_pulled := FraudShared_Services.Common_Suppress(ds_x_filtered);

  ds_appendDeltabase := FraudShared_Services.Common_Deltabase(ds_batch_in, ds_recs_pulled, ds_file_types_in, DeltaUse, DeltaStrict);
															
	ds_FilterThruMBS := FraudShared_Services.FilterThruMBS(
    ds_appendDeltabase, gc_id_in, ind_type_in, product_code_in, ds_industry_types_in, ds_file_types_in, fraud_platform);

	//When add ForceReturnContribData, this whole filter logic might need revised/cleaned up/simplified???
  ds_Restrictions := ds_FilterThruMBS(NOT doxie.DataRestriction.FDNInquiry      
    OR classification_Permissible_use_access.file_type = FraudShared_Services.Constants.FileTypeCodes.CONTRIBUTORY);
	
  // OUTPUT(ds_ids, NAMED('Search_Records__ds_ids'));
  // OUTPUT(ds_Raw, NAMED('Search_Records__ds_Raw'));
  // OUTPUT(ds_filtered, NAMED('Search_Records__ds_filtered'));
  // OUTPUT(ds_recs_pulled, NAMED('Search_Records__ds_recs_pulled'));
  // OUTPUT(ds_appendDeltabase, NAMED('Search_Records__ds_appendDeltabase'));
  // OUTPUT(ds_FilterThruMBS, NAMED('Search_Records__ds_FilterThruMBS'));
  // OUTPUT(ds_Restrictions, NAMED('Search_Records__ds_Restrictions'));
                                    
  RETURN ds_Restrictions;
END;
