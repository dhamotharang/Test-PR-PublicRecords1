IMPORT Data_Services, doxie;

EXPORT Files_PR := MODULE
  EXPORT LOCATION_PREFIX := Data_Services.Data_location.Prefix('ecrash');
  EXPORT VERSION := doxie.Version_SuperKey;
	EXPORT KEY_PREFIX := 'thor_data400::key::ecrashV2';
	
	EXPORT DID_SUFFIX := 'did';
  EXPORT FILE_KEY_DID_SF := LOCATION_PREFIX + KEY_PREFIX + '_' + DID_SUFFIX + '_' + VERSION;
	
	EXPORT VIN_SUFFIX := 'vin';
  EXPORT FILE_KEY_VIN_SF := LOCATION_PREFIX + KEY_PREFIX + '_' + VIN_SUFFIX + '_' + VERSION;

END;