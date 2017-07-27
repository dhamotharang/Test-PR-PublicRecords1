IMPORT iesp;

EXPORT Common_Deltabase(
  DATASET(FraudShared_Services.Layouts.batch_search_rec) flatInput,
  DATASET(FraudShared_Services.Layouts.Raw_Payload_rec) recs_pulled,
  DATASET(iesp.frauddefensenetwork.t_FDNFileType) ds_file_types_in,
  integer DeltaUse = 0,
  integer DeltaStrict = 0
) := FUNCTION

  //Calling deltabase if deltabase = 1
  deltabaseResult := IF(DeltaUse = 1, FraudShared_Services.deltabase(flatInput, recs_pulled, ds_file_types_in, DeltaStrict));  

  //Appending Keys and Deltabase results                
  AppendDeltaKey := IF(EXISTS(deltabaseResult),
    DEDUP((deltabaseResult + recs_pulled), classification_Permissible_use_access.fdn_file_info_id, Transaction_ID), 
    recs_pulled);

  RETURN AppendDeltaKey;
END;
