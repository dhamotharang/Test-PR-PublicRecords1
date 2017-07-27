EXPORT Functions := MODULE

  // Set shorter alias names to be used in the functions below.
  shared unsigned3 ContribData := // 1 = FDN Event Outcomes (AKA Contributory) data
		                              FDN_Services.Constants.FileTypeCodes.CONTRIBUTORY;
	set of unsigned3 InquiryData := // 2,3,4 = FDN Market Activity (AKA Inquiry) data
		                              [FDN_Services.Constants.FileTypeCodes.PUBLIC_RECORD, 
		                               FDN_Services.Constants.FileTypeCodes.TRANSACTION, 
		                               FDN_Services.Constants.FileTypeCodes.RELATIONSHIP_ANALYTICS];

  // 2 functions used to set the fdn_*_ind or the fdn_waf_contrib_data fields in 
	// the 2 doxie.Header*SearchService and the 2 PersonSearch_Services.Person*Service queries
	// and in doxie.Comprehensive_Report_Service query.
  export unsigned2 set_indicator(unsigned3 file_type, boolean FDNContDataPermitted, boolean FDNInqDataPermitted) := 
    if((FDNContDataPermitted and file_type = ContribData) 
			  or
			 (FDNInqDataPermitted and file_type IN InquiryData),
			 FDN_Services.Constants.FDN_DATA_FOUND,FDN_Services.Constants.FDN_DATA_NOT_FOUND);

 export boolean set_waf(unsigned3 file_type, boolean FDNContDataPermitted, boolean alreadyWAF=false ) := 
	  alreadyWAF or                 // waf already on?, leave it on
		(not FDNContDataPermitted and // or contributory data not permitted to be seen
	   file_type = ContribData);    //    and contributory data was found

END;
