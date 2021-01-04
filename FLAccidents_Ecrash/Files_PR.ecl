IMPORT dx_Ecrash AS dx;

EXPORT Files_PR := MODULE
	
//***********************************************************************
//                 	EcrashFLAccidentPRKeys
//***********************************************************************
  EXPORT FILE_KEY_ECRASH0_SF := dx.Files.FILE_KEY_ECRASH0_SF;
	EXPORT FILE_KEY_ECRASH1_SF := dx.Files.FILE_KEY_ECRASH1_SF;
	EXPORT FILE_KEY_ECRASH2V_SF := dx.Files.FILE_KEY_ECRASH2V_SF;
  EXPORT FILE_KEY_ECRASH3V_SF := dx.Files.FILE_KEY_ECRASH3V_SF;
  EXPORT FILE_KEY_ECRASH4_SF := dx.Files.FILE_KEY_ECRASH4_SF;
  EXPORT FILE_KEY_ECRASH5_SF := dx.Files.FILE_KEY_ECRASH5_SF;
  EXPORT FILE_KEY_ECRASH6_SF := dx.Files.FILE_KEY_ECRASH6_SF;
  EXPORT FILE_KEY_ECRASH7_SF := dx.Files.FILE_KEY_ECRASH7_SF;
	
//***********************************************************************
//                 	EcrashPRKeys
//***********************************************************************
  EXPORT FILE_KEY_ACCNBRV1_SF := dx.Files.FILE_KEY_ACCNBRV1_SF;
	EXPORT FILE_KEY_ACCNBR_SF := dx.Files.FILE_KEY_ACCNBR_SF;
  EXPORT FILE_KEY_PARTIAL_ACCNBR_SF := dx.Files.FILE_KEY_PARTIAL_ACCNBR_SF;
  EXPORT FILE_KEY_ACCNBR_FATHER_SF := dx.Files.KEY_PREFIX + '_' + 'accnbr_father';	
  EXPORT FILE_KEY_BDID_SF := dx.Files.FILE_KEY_BDID_SF;
  EXPORT FILE_KEY_DID_SF := dx.Files.FILE_KEY_DID_SF;
  EXPORT FILE_KEY_DL_NBR_SF := dx.Files.FILE_KEY_DL_NBR_SF;
  EXPORT FILE_KEY_TAG_NBR_SF := dx.Files.FILE_KEY_TAG_NBR_SF;
  EXPORT FILE_KEY_VIN7_SF := dx.Files.FILE_KEY_VIN7_SF;
  EXPORT FILE_KEY_VIN_SF := dx.Files.FILE_KEY_VIN_SF;

END;