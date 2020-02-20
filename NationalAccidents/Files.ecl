IMPORT Data_Services;

EXPORT Files := MODULE

	EXPORT isNAccidentsInquiry      := TRUE:STORED('NtlAccInq');
	EXPORT isNAccidentsInquiryQC    := FALSE:STORED('NtlAccInqQC');
	EXPORT isNAccidentsInquiryCT    := FALSE:STORED('NtlAccInqCT');
	EXPORT isNAccidentsInquiryDev   := FALSE:STORED('NtlAccInqDev');
	

	EXPORT TrimString (STRING str)  := TRIM(str, LEFT, RIGHT);	
	EXPORT DataServicesLocation     := Data_Services.Data_location.Prefix('NTL_ACCIDENTS_INQUIRY'); 
	
	EXPORT mac_fn_GetPrefix(iLabel) := FUNCTIONMACRO
     Prefix := TrimString(
	                        MAP (isNAccidentsInquiryCT       => Files_CustomerTest.iLabel, 
							                 isNAccidentsInquiryQC       => Files_QC.iLabel,  
							                 isNAccidentsInquiryDev      => Files_Dev.iLabel, 
							                 isNAccidentsInquiry         => Files_Prefix.iLabel,
							                 Files_Prefix.iLabel)
                         );
     RETURN Prefix;	 
  ENDMACRO;

	// #################################################################################
	//                                 NAccidentsInquiry Prefix
	// #################################################################################

	EXPORT SPRAY_NAI_PREFIX := mac_fn_GetPrefix(SPRAY_NAI_PREFIX);
	
	EXPORT BASE_NAI_PREFIX := mac_fn_GetPrefix(BASE_NAI_PREFIX);

END;