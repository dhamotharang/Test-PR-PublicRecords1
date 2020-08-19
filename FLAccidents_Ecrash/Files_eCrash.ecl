IMPORT Data_Services, doxie;

EXPORT Files_eCrash := MODULE
  EXPORT LOCATION_PREFIX := Data_Services.Data_location.Prefix('ecrash');
  EXPORT VERSION := doxie.Version_SuperKey;
	EXPORT KEY_PREFIX := 'thor_data400::key::ecrashV2';
	
	EXPORT AGENCY_SUFFIX := 'agency';
  EXPORT FILE_KEY_AGENCY_SF := LOCATION_PREFIX + KEY_PREFIX + '_' + AGENCY_SUFFIX + '_' + VERSION;
	
	EXPORT PHOTO_ID_SUFFIX := 'PhotoId';
  EXPORT FILE_KEY_PHOTO_ID_SF := LOCATION_PREFIX + KEY_PREFIX + '_' + PHOTO_ID_SUFFIX + '_' + VERSION;

END;