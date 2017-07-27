/*  PLEASE BE AWARE that of the 2 categories of FDN data (contributory & inquiry),  
    this function currently returns contributory data even if it is not permitted via 
    DataPermissionMask position 11.
    This was done at the time the function was created because the person search & report 
    queries needed to know if fdn contributory data existed so a special FDN "We Also Found"
    contributory data indicator could be set on.

    !!!Therefore callers of this function (or the FDN_Services.func_CheckForFdnData function)
      SHOULD CHECK WHETHER DPM 11/FDN CONTRIBUTORY DATA IS PERMITTED before returning it, 
      as is currently being done in:
          FDN_Services.SearchService and BatchServices.trisv31_get_fdn
 */ 
IMPORT iesp, doxie; 

EXPORT Search_Records(
   dataset(FDN_Services.Layouts.batch_search_rec) flatInput,
   unsigned6 gc_id_in, 
   unsigned2 ind_type_in, 
   unsigned6 product_code_in, 
   dataset(iesp.frauddefensenetwork.t_FDNIndType) ds_industry_types_in,
   dataset(iesp.frauddefensenetwork.t_FDNFileType) ds_file_types_in,
	 INTEGER DeltaUse = 0,
	 INTEGER DeltaStrict = 0
	)
	 //,boolean ForceReturnContribData? = false // 03/2016 enhancement??? use some other/better parm name???
	 //  ^--- when added, this new parm & DPM 11 will need checked below to determine whether
	 //       to return contributory data even if not permitted.
	 // Then the DPM 11/contrib filter in FDN_Services.SearchService and BatchServices.trisv31_get_fdn
	 // could be removed.
   := FUNCTION
	 
	//Get FDN Record_Ids by various keys depending upon input search by fields
	ds_ids := FDN_Services.Search_IDs(flatInput);
		
	ds_Raw := FDN_Services.Raw.byRecSrch(ds_ids, flatInput, gc_id_in, ind_type_in, product_code_in, 
																							 ds_industry_types_in, ds_file_types_in, DeltaUse, DeltaStrict);
	
	//When add ForceReturnContribData, this whole filter logic might need revised/cleaned up/simplified???
	ds_restriction := ds_Raw (//(classification_Permissible_use_access.file_type !=
                            //     FDN_Services.Constants.FileTypeCodes.CONTRIBUTORY //not contrib=inquiry
														// AND
	                          NOT doxie.DataRestriction.FDNInquiry //)
	                          OR
										        //(
														classification_Permissible_use_access.file_type =
                                FDN_Services.Constants.FileTypeCodes.CONTRIBUTORY //AND???
														//(doxie.DataPermission.use_FDNContributoryData???   OR???
														// ForceReturnContribData???))
														);
													
  RETURN ds_restriction;
END;
