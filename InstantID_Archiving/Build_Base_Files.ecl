IMPORT address, ut, standard, Data_Services;

version:= ut.GetDate;


// OUTPUT IID ARCHIVE DELTA INPUT FILES + PROCESSED DELTA BASE INPUT FILES
build_base := SEQUENTIAL(
output(InstantID_Archiving.Files.InstantID_Model + InstantID_Archiving.Files.InstantID_Model_base,,'~thor_data400::base::InstantID_Archive::delta_model_instantid_'+version,CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),overwrite,__compressed__),
output(InstantID_Archiving.Files.InstantID_ModelRisk + InstantID_Archiving.Files.InstantID_ModelRisk_base,,'~thor_data400::base::InstantID_Archive::delta_modelrisk_instantid_'+version,CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),overwrite,__compressed__),
output(InstantID_Archiving.Files.InstantID_ModelIndex + InstantID_Archiving.Files.InstantID_ModelIndex_base,,'~thor_data400::base::InstantId_Archive::delta_model_index_instantid_'+version,CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),overwrite,__compressed__),
output(InstantID_Archiving.Files.InstantID_Risk + InstantID_Archiving.Files.InstantID_Risk_base,,'~thor_data400::base::InstantID_Archive::delta_risk_instantid_'+version,CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),overwrite,__compressed__),
output(InstantID_Archiving.Files.InstantID_Report + InstantID_Archiving.Files.InstantID_Report_base,,'~thor_data400::base::InstantID_Archive::delta_report_instantid_'+version,CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),overwrite,__compressed__),
output(InstantID_Archiving.Files.InstantID_RedFlags + InstantID_Archiving.Files.InstantID_RedFlags_base,,'~thor_data400::base::InstantID_Archive::delta_redflags_instantid_'+version,CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),overwrite,__compressed__),
output(InstantID_Archiving.Files.InstantIDi_Verification + InstantID_Archiving.Files.InstantIDi_Verification_base,,'~thor_data400::base::InstantID_Archive::delta_verification_instantidi_'+version,CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),overwrite,__compressed__),
output(InstantID_Archiving.Files.InstantIDi_Risk + InstantID_Archiving.Files.InstantIDi_Risk_base,,'~thor_data400::base::InstantID_Archive::delta_risk_instantidi_'+version,CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),overwrite,__compressed__),
output(InstantID_Archiving.Files.InstantIDi_Report + InstantID_Archiving.Files.InstantIDi_Report_base,,'~thor_data400::base::InstantID_Archive::delta_report_instantidi_'+version,CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),overwrite,__compressed__),
output(InstantID_Archiving.Files.FlexID_Model + InstantID_Archiving.Files.FlexID_Model_base,,'~thor_data400::base::InstantID_Archive::delta_model_flexid_'+version,CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),overwrite,__compressed__),
output(InstantID_Archiving.Files.FlexID_Risk + InstantID_Archiving.Files.FlexID_Risk_base,,'~thor_data400::base::InstantID_Archive::delta_risk_flexid_'+version,CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),overwrite,__compressed__),
output(InstantID_Archiving.Files.FlexID_ModelRisk + InstantID_Archiving.Files.FlexID_ModelRisk_base,,'~thor_data400::base::InstantID_Archive::delta_modelrisk_flexid_'+version,CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),overwrite,__compressed__),
output(InstantID_Archiving.Files.FlexID_Report + InstantID_Archiving.Files.FlexID_Report_base,,'~thor_data400::base::InstantID_Archive::delta_report_flexid_'+version,CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),overwrite,__compressed__));

// BASE FILE SUPERFILE TRANSACTIONS
base_SF_moves := SEQUENTIAL(
FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::base::Instantid_Archive::delta_model_instantid_processed','~thor_data400::base::Instantid_Archive::delta_model_instantid_processed_father',
'~thor_data400::base::Instantid_Archive::delta_model_instantid_processed_grandfather','~thor_data400::base::Instantid_Archive::delta_model_instantid_processed_delete'],
	'~thor_data400::base::InstantID_Archive::delta_model_instantid_'+version, true),
	
	FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::base::Instantid_Archive::delta_modelrisk_instantid_processed','~thor_data400::base::Instantid_Archive::delta_modelrisk_instantid_processed_father',
'~thor_data400::base::Instantid_Archive::delta_modelrisk_instantid_processed_grandfather','~thor_data400::base::Instantid_Archive::delta_modelrisk_instantid_processed_delete'],
	'~thor_data400::base::InstantID_Archive::delta_modelrisk_instantid_'+version, true),
	
	FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::base::Instantid_Archive::delta_risk_instantid_processed','~thor_data400::base::Instantid_Archive::delta_risk_instantid_processed_father',
'~thor_data400::base::Instantid_Archive::delta_risk_instantid_processed_grandfather','~thor_data400::base::Instantid_Archive::delta_risk_instantid_processed_delete'],
	'~thor_data400::base::InstantID_Archive::delta_risk_instantid_'+version, true),
	
	FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::base::Instantid_Archive::delta_report_instantid_processed','~thor_data400::base::Instantid_Archive::delta_report_instantid_processed_father',
'~thor_data400::base::Instantid_Archive::delta_report_instantid_processed_grandfather','~thor_data400::base::Instantid_Archive::delta_report_instantid_processed_delete'],
	'~thor_data400::base::InstantID_Archive::delta_report_instantid_'+version, true),
	
	FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::base::Instantid_Archive::delta_redflags_instantid_processed','~thor_data400::base::Instantid_Archive::delta_redflags_instantid_processed_father',
'~thor_data400::base::Instantid_Archive::delta_redflags_instantid_processed_grandfather','~thor_data400::base::Instantid_Archive::delta_redflags_instantid_processed_delete'],
	'~thor_data400::base::InstantID_Archive::delta_redflags_instantid_'+version, true),
	
	FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::base::Instantid_Archive::delta_verification_instantidi_processed','~thor_data400::base::Instantid_Archive::delta_verification_instantidi_processed_father',
'~thor_data400::base::Instantid_Archive::delta_verification_instantidi_processed_grandfather','~thor_data400::base::Instantid_Archive::delta_verification_instantidi_processed_delete'],
	'~thor_data400::base::InstantID_Archive::delta_verification_instantidi_'+version, true),
	
	FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::base::Instantid_Archive::delta_risk_instantidi_processed','~thor_data400::base::Instantid_Archive::delta_risk_instantidi_processed_father',
'~thor_data400::base::Instantid_Archive::delta_risk_instantidi_processed_grandfather','~thor_data400::base::Instantid_Archive::delta_risk_instantidi_processed_delete'],
	'~thor_data400::base::InstantID_Archive::delta_risk_instantidi_'+version, true),
	
	FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::base::Instantid_Archive::delta_report_instantidi_processed','~thor_data400::base::Instantid_Archive::delta_report_instantidi_processed_father',
'~thor_data400::base::Instantid_Archive::delta_report_instantidi_processed_grandfather','~thor_data400::base::Instantid_Archive::delta_report_instantidi_processed_delete'],
	'~thor_data400::base::InstantID_Archive::delta_report_instantidi_'+version, true),
	
	FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::base::Instantid_Archive::delta_model_flexid_processed','~thor_data400::base::Instantid_Archive::delta_model_flexid_processed_father',
'~thor_data400::base::Instantid_Archive::delta_model_flexid_processed_grandfather','~thor_data400::base::Instantid_Archive::delta_model_flexid_processed_delete'],
	'~thor_data400::base::InstantID_Archive::delta_model_flexid_'+version, true),
	
	FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::base::Instantid_Archive::delta_risk_flexid_processed','~thor_data400::base::Instantid_Archive::delta_risk_flexid_processed_father',
'~thor_data400::base::Instantid_Archive::delta_risk_flexid_processed_grandfather','~thor_data400::base::Instantid_Archive::delta_risk_flexid_processed_delete'],
	'~thor_data400::base::InstantID_Archive::delta_risk_flexid_'+version, true),
	
	FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::base::Instantid_Archive::delta_modelrisk_flexid_processed','~thor_data400::base::Instantid_Archive::delta_modelrisk_flexid_processed_father',
'~thor_data400::base::Instantid_Archive::delta_modelrisk_flexid_processed_grandfather','~thor_data400::base::Instantid_Archive::delta_modelrisk_flexid_processed_delete'],
	'~thor_data400::base::InstantID_Archive::delta_modelrisk_flexid_'+version, true),
	
	FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::base::Instantid_Archive::delta_report_flexid_processed','~thor_data400::base::Instantid_Archive::delta_report_flexid_processed_father',
'~thor_data400::base::Instantid_Archive::delta_report_flexid_processed_grandfather','~thor_data400::base::Instantid_Archive::delta_report_flexid_processed_delete'],
	'~thor_data400::base::InstantID_Archive::delta_report_flexid_'+version, true),
	
	FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::base::instantid_archive::delta_index_instantid_processed','~thor_data400::base::instantid_archive::delta_index_instantid_processed_father',
'~thor_data400::base::instantid_archive::delta_index_instantid_processed_grandfather','~thor_data400::base::instantid_archive::delta_index_instantid_processed_delete'],
	'~thor_data400::base::instantid_archive::delta_model_index_instantid_'+version, true));

// REMOVAL OF PROCESSED INPUT FILES
input_SF_moves := sequential(
fileservices.clearsuperfile('~thor_data400::in::InstantID_Archive::delta_model_instantid_concatenated',true),
fileservices.clearsuperfile('~thor_data400::in::InstantID_Archive::delta_modelrisk_instantid_concatenated',true),
fileservices.clearsuperfile('~thor_data400::in::InstantID_Archive::delta_index_instantid_concatenated',true),
fileservices.clearsuperfile('~thor_data400::in::InstantID_Archive::delta_risk_instantid_concatenated',true),
fileservices.clearsuperfile('~thor_data400::in::InstantID_Archive::delta_key_instantid_concatenated',true),
fileservices.clearsuperfile('~thor_data400::in::InstantID_Archive::delta_report_instantid_concatenated',true),
fileservices.clearsuperfile('~thor_data400::in::InstantID_Archive::delta_redflags_instantid_concatenated',true),
fileservices.clearsuperfile('~thor_data400::in::InstantID_Archive::delta_key_instantidi_concatenated',true),
fileservices.clearsuperfile('~thor_data400::in::InstantID_Archive::delta_verification_instantidi_concatenated',true),
fileservices.clearsuperfile('~thor_data400::in::InstantID_Archive::delta_risk_instantidi_concatenated',true),
fileservices.clearsuperfile('~thor_data400::in::InstantID_Archive::delta_report_instantidi_concatenated',true),
fileservices.clearsuperfile('~thor_data400::in::InstantID_Archive::delta_key_flexid_concatenated',true),
fileservices.clearsuperfile('~thor_data400::in::InstantID_Archive::delta_model_flexid_concatenated',true),
fileservices.clearsuperfile('~thor_data400::in::InstantID_Archive::delta_risk_flexid_concatenated',true),
fileservices.clearsuperfile('~thor_data400::in::InstantID_Archive::delta_modelrisk_flexid_concatenated',true),
fileservices.clearsuperfile('~thor_data400::in::InstantID_Archive::delta_report_flexid_concatenated',true));


Sequential(build_base,base_SF_moves,input_SF_moves);
