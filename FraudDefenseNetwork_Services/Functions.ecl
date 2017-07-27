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

END;
