EXPORT Files_Dev := MODULE
	
	SHARED DEV_PREFIX                := '::DEV';
	
	EXPORT SPRAY_NAI_PREFIX          := Files_Prefix.SPRAY_NAI_PREFIX + DEV_PREFIX;																												
	EXPORT BASE_NAI_PREFIX           := Files_Prefix.BASE_NAI_PREFIX + DEV_PREFIX;
	
END;