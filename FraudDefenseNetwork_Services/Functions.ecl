IMPORT FraudShared_Services;

EXPORT Functions := MODULE

  // Set shorter alias names to be used in the functions below.
  SHARED unsigned3 ContribData := // 1 = FDN Event Outcomes (AKA Contributory) data
		                              FraudShared_Services.Constants.FileTypeCodes.CONTRIBUTORY;
	SET OF unsigned3 InquiryData := // 2,3,4 = FDN Market Activity (AKA Inquiry) data
		                              [FraudShared_Services.Constants.FileTypeCodes.PUBLIC_RECORD, 
		                               FraudShared_Services.Constants.FileTypeCodes.TRANSACTION, 
		                               FraudShared_Services.Constants.FileTypeCodes.RELATIONSHIP_ANALYTICS];

  // 2 functions used to set the fdn_*_ind or the fdn_waf_contrib_data fields in 
	// the 2 doxie.Header*SearchService and the 2 PersonSearch_Services.Person*Service queries
	// and in doxie.Comprehensive_Report_Service query.
  EXPORT unsigned2 set_indicator(unsigned3 file_type, boolean FDNContDataPermitted, boolean FDNInqDataPermitted) := 
    IF((FDNContDataPermitted and file_type = ContribData) OR (FDNInqDataPermitted and file_type IN InquiryData),
      FraudShared_Services.Constants.FDN_DATA_FOUND,
      FraudShared_Services.Constants.FDN_DATA_NOT_FOUND);

  EXPORT boolean set_waf(unsigned3 file_type, boolean FDNContDataPermitted, boolean alreadyWAF=false ) := 
	  alreadyWAF // waf already on?, leave it on
      OR (NOT FDNContDataPermitted and file_type = ContribData);
      // or contributory data not permitted to be seen and contributory data was found

  EXPORT SetSequences(
    DATASET(FraudDefenseNetwork_Services.Layouts.batch_search_rec) ds_in
  ) := FUNCTION
    // Coded that if a person bothered to put the seq numbers in, 
    // we should keep them because they probably may care about them
    FraudDefenseNetwork_Services.Layouts.batch_search_rec xfm_SetSequence(FraudDefenseNetwork_Services.Layouts.batch_search_rec L, integer C) := TRANSFORM
      SELF.seq := IF(L.seq != 0, L.seq, C);
      SELF := L;
    END;
  
    RETURN PROJECT(ds_in, xfm_SetSequence(LEFT, COUNTER));
  
  END;
  
  EXPORT boolean IsFirstRecordValid(
    DATASET(FraudDefenseNetwork_Services.Layouts.batch_search_rec) ds_in
  ) := FUNCTION
    // I know this is convoluted, but logically easier since it leads more toward the future developmnen of FDN as a batchable service
    ds_batch_in := FraudDefenseNetwork_Services.StandardizeBatchInput(ds_in);
    ds_valid_in := FraudShared_Services.ValidateInput.BuildValidityRecs(ds_batch_in);
    RETURN ds_Valid_In[1].hasValidInput;
  END;
  
  

END;
