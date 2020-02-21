EXPORT Files_QC := MODULE
	
	SHARED QC_PREFIX                 := '::QC';
	
	EXPORT SPRAY_NAI_PREFIX          := Files_Prefix.SPRAY_NAI_PREFIX + QC_PREFIX;																												
	EXPORT BASE_NAI_PREFIX           := Files_Prefix.BASE_NAI_PREFIX + QC_PREFIX;
	
END;