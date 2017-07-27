IMPORT iesp, FraudShared;

EXPORT FilterThruMBS(
  DATASET(FraudShared_Services.Layouts.Raw_Payload_rec) ds_ids = DATASET([],FraudShared_Services.Layouts.Raw_Payload_rec),
  unsigned6 gc_id_in, 
  unsigned2 ind_type_in, 
  unsigned6 product_code_in, 
  DATASET(iesp.frauddefensenetwork.t_FDNIndType) ds_excl_ind_types_in,
  DATASET(iesp.frauddefensenetwork.t_FDNFileType) ds_file_types_in,
  string fraud_platform
) := FUNCTION

  // mapping the gc_id to the to one or more FDN Master IDs
  ds_gc_ids_mappedToMaster := CHOOSEN(FraudShared.Key_Gcid_2_Mbsfdnmasterid(fraud_platform)(KEYED(gc_id = gc_id_in)),FraudShared_Services.Constants.MAX_RECS_ON_JOIN);
    
  // Next, Change the layout & add a "set of DATA16" field (setFdnMasterIds) that will 
  // allow the following rollup to build/create the set of FDN Master Ids later used in the join
  ds_MastIds_withSetLayout := PROJECT(
    ds_gc_ids_mappedToMaster, 
    TRANSFORM(FraudShared_Services.Layouts.SetOfFdnMasterId_rec,
      SELF.setFdnMasterIds := [LEFT.FdnMasterId],
      SELF := LEFT));
    
  // Rolling up by gc_id to concatenate left and right fdn Master IDs in set format to create one set
  ds_rollupMasterIds := ROLLUP(
    ds_MastIds_withSetLayout, 
    LEFT.gc_id = RIGHT.gc_id,
    TRANSFORM(FraudShared_Services.Layouts.SetOfFdnMasterId_rec,
      SELF.setFdnMasterIds := LEFT.setFdnMasterIds + RIGHT.setFdnMasterIds,
      SELF := LEFT));
                                                 
  // assigning the set to a variable
  SetFdnMasterIds := ds_rollupMasterIds[1].setFdnMasterIds;

  /* JOIN PAYLOAD WITH MbsFDNMasterIDExclKey */
  // here we replaced the single gc_id compare to the of master IDs created above
  FdnMasterId_exclude_result := JOIN(
    ds_ids, FraudShared.Key_mbsfdnmasteridexclusion(fraud_platform), 
    KEYED (LEFT.classification_Permissible_use_access.fdn_file_info_id = RIGHT.fdn_file_info_id) 
      AND RIGHT.FdnMasterId IN SetFdnMasterIds
			AND RIGHT.Status = FraudShared_Services.Constants.ActiveStatus,  // Only active status records
    TRANSFORM(LEFT), 
    LEFT ONLY);
          
  /* JOIN WITH MBSIndusryTypeExclusion*/    
  ind_exclude_result := JOIN(
    FdnMasterId_exclude_result, FraudShared.Key_Mbsindtypeexclusion(fraud_platform),
    KEYED (LEFT.classification_Permissible_use_access.fdn_file_info_id = RIGHT.fdn_file_info_id) 
      AND RIGHT.ind_type = ind_type_in
			AND RIGHT.Status = FraudShared_Services.Constants.ActiveStatus,  // Only active status records
    TRANSFORM(LEFT), 
    LEFT ONLY);  
          
  /* Keeping all product_include = 1 which is ALL*/
  boolean prod_include_code := ind_exclude_result.classification_Permissible_use_access.product_include = FraudShared_Services.Constants.PRODUCT_INCLUDE_CODE_ALL;
  product_include_one := ind_exclude_result(prod_include_code);
  product_include_rest := ind_exclude_result(NOT prod_include_code);
    
  /* JOIN WITH MbsProductInclude = When one or more products are not included*/    
  pro_include_Code := JOIN(
    product_include_rest, FraudShared.Key_Mbsproductinclude(fraud_platform),
    KEYED (LEFT.classification_Permissible_use_access.fdn_file_info_id = RIGHT.fdn_file_info_id) 
      AND product_code_in = RIGHT.product_id
			AND RIGHT.Status = FraudShared_Services.Constants.ActiveStatus,  // Only active status records
    TRANSFORM(LEFT),
    KEEP(FraudShared_Services.Constants.MAX_RECS_ON_JOIN),
    LIMIT(0));
          
  /* Joining the results together */
  pro_include_all := pro_include_Code + product_include_one;
    
  /* exclude all records that matches the dataset */   
  Exclude_Ind_Type := JOIN(
    pro_include_all, ds_excl_ind_types_in,
    LEFT.classification_Permissible_use_access.ind_type = RIGHT.IndType,
    TRANSFORM(LEFT), 
    LEFT ONLY);

  /* Include all records that matches the dataset, if dataset is provided. */
  Include_file_Type := JOIN(
    Exclude_Ind_Type, ds_file_types_in,
    LEFT.classification_Permissible_use_access.file_type = RIGHT.FileType,
    TRANSFORM(LEFT));
          
  ALlFilteringResult := IF(EXISTS(ds_file_types_in), Include_file_Type, Exclude_Ind_Type);
    
  // OUTPUT(FdnMasterId_exclude_result, NAMED('FdnMasterId_exclude_result'));  
  // OUTPUT(ind_exclude_result,       NAMED('ind_exclude_result'));
  // OUTPUT(product_include_one,      NAMED('product_include_one'));
  // OUTPUT(product_include_rest,    NAMED('product_include_rest'));
  // OUTPUT(pro_include_Code,        NAMED('pro_include_Code'));
  // OUTPUT(pro_include_all,           NAMED('pro_include_all'));
  // OUTPUT(Exclude_Ind_Type,        NAMED('ExcludeInd_Type'));
  // OUTPUT(Include_file_Type,        NAMED('Include_file_Type'));
  // OUTPUT(ALlFilteringResult,      NAMED('ALlFilteringResult'));

  RETURN AllFilteringResult;
  
END;