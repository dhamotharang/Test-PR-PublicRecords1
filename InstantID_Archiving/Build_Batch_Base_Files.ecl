IMPORT address, ut, standard, Data_Services;

export Build_Batch_Base_files(string version) := function

// OUTPUT IID ARCHIVE BATCH INPUT FILES + PROCESSED BATCH BASE INPUT FILES
build_base := SEQUENTIAL(
output(InstantID_Archiving.Files_Batch.InstantID_Model_in + InstantID_Archiving.Files_Batch.InstantID_Model,,'~thor_data400::base::InstantID_Archive::delta_model_ciid_'+version,CSV(heading(1),separator('|'), TERMINATOR('\n')),overwrite,__compressed__),
output(InstantID_Archiving.Files_Batch.InstantID_Modelrisk_in + InstantID_Archiving.Files_Batch.InstantID_Modelrisk,,'~thor_data400::base::InstantId_Archive::delta_modelriskindicator_ciid_'+version,CSV(heading(1),separator('|'), TERMINATOR('\n')),overwrite,__compressed__),
output(InstantID_Archiving.Files_Batch.InstantID_Modelindex_in + InstantID_Archiving.Files_Batch.InstantID_Modelindex,,'~thor_data400::base::InstantID_Archive::delta_modelriskindex_ciid_'+version,CSV(heading(1),separator('|'), TERMINATOR('\n')),overwrite,__compressed__),
output(InstantID_Archiving.Files_Batch.InstantID_Risk_in + InstantID_Archiving.Files_Batch.InstantID_Risk,,'~thor_data400::base::InstantID_Archive::delta_risk_ciid_'+version,CSV(heading(1),separator('|'), TERMINATOR('\n')),overwrite,__compressed__),
output(InstantID_Archiving.Files_Batch.InstantID_Report_in + InstantID_Archiving.Files_Batch.InstantID_Report,,'~thor_data400::base::InstantID_Archive::delta_report_ciid_'+version,CSV(heading(1),separator('|'), TERMINATOR('\n')),overwrite,__compressed__),
output(InstantID_Archiving.Files_Batch.InstantID_RedFlags_in + InstantID_Archiving.Files_Batch.InstantID_RedFlags,,'~thor_data400::base::InstantID_Archive::delta_redflags_ciid_'+version,CSV(heading(1),separator('|'), TERMINATOR('\n')),overwrite,__compressed__),
output(InstantID_Archiving.Files_Batch.FlexID_Model_in + InstantID_Archiving.Files_Batch.FlexID_Model,,'~thor_data400::base::InstantID_Archive::delta_model_flexid_batch_'+version,CSV(heading(1),separator('|'), TERMINATOR('\n')),overwrite,__compressed__),
output(InstantID_Archiving.Files_Batch.FlexID_Modelrisk_in + InstantID_Archiving.Files_Batch.FlexID_Modelrisk,,'~thor_data400::base::InstantID_Archive::delta_modelriskindicator_flexid_batch_'+version,CSV(heading(1),separator('|'), TERMINATOR('\n')),overwrite,__compressed__),
output(InstantID_Archiving.Files_Batch.FlexID_Risk_in + InstantID_Archiving.Files_Batch.FlexID_Risk,,'~thor_data400::base::InstantID_Archive::delta_risk_flexid_batch_'+version,CSV(heading(1),separator('|'), TERMINATOR('\n')),overwrite,__compressed__),
output(InstantID_Archiving.Files_Batch.FlexID_Report_in + InstantID_Archiving.Files_Batch.FlexID_Report,,'~thor_data400::base::InstantID_Archive::delta_report_flexid_batch_'+version,CSV(heading(1),separator('|'), TERMINATOR('\n')),overwrite,__compressed__));

// BASE FILE SUPERFILE TRANSACTIONS
base_SF_moves := SEQUENTIAL(
  		
	FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::base::Instantid_Archive::delta_model_ciid','~thor_data400::base::Instantid_Archive::delta_model_ciid_father',
'~thor_data400::base::Instantid_Archive::delta_model_ciid_grandfather'],'~thor_data400::base::InstantID_Archive::delta_model_ciid_'+version, true),
	
	FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::base::Instantid_Archive::delta_modelriskindicator_ciid','~thor_data400::base::Instantid_Archive::delta_modelriskindicator_ciid_father',
'~thor_data400::base::Instantid_Archive::delta_modelriskindicator_ciid_grandfather'],'~thor_data400::base::InstantID_Archive::delta_modelriskindicator_ciid_'+version, true),
	
	FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::base::Instantid_Archive::delta_modelriskindex_ciid','~thor_data400::base::Instantid_Archive::delta_modelriskindex_ciid_father',
'~thor_data400::base::Instantid_Archive::delta_modelriskindex_ciid_grandfather'],'~thor_data400::base::InstantID_Archive::delta_modelriskindex_ciid_'+version, true),
	
	FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::base::Instantid_Archive::delta_risk_ciid','~thor_data400::base::Instantid_Archive::delta_risk_ciid_father',
'~thor_data400::base::Instantid_Archive::delta_risk_ciid_grandfather'],'~thor_data400::base::InstantID_Archive::delta_risk_ciid_'+version, true),
	
	FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::base::Instantid_Archive::delta_report_ciid','~thor_data400::base::Instantid_Archive::delta_report_ciid_father',
'~thor_data400::base::Instantid_Archive::delta_report_ciid_grandfather'],'~thor_data400::base::InstantID_Archive::delta_report_ciid_'+version, true),
	
	FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::base::Instantid_Archive::delta_redflags_ciid','~thor_data400::base::Instantid_Archive::delta_redflags_ciid_father',
'~thor_data400::base::Instantid_Archive::delta_redflags_ciid_grandfather'],'~thor_data400::base::InstantID_Archive::delta_redflags_ciid_'+version, true),
		
	FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::base::Instantid_Archive::delta_model_flexid_batch','~thor_data400::base::Instantid_Archive::delta_model_flexid_batch_father',
'~thor_data400::base::Instantid_Archive::delta_model_flexid_batch_grandfather'],'~thor_data400::base::InstantID_Archive::delta_model_flexid_batch_'+version, true),
	
	FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::base::Instantid_Archive::delta_modelriskindicator_flexid_batch_','~thor_data400::base::Instantid_Archive::delta_modelriskindicator_flexid_batch_father',
'~thor_data400::base::Instantid_Archive::delta_modelriskindicator_flexid_batch_grandfather'],'~thor_data400::base::InstantID_Archive::delta_modelriskindicator_flexid_batch_'+version, true),
	
	FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::base::Instantid_Archive::delta_risk_flexid_batch','~thor_data400::base::Instantid_Archive::delta_risk_flexid_batch_father',
'~thor_data400::base::Instantid_Archive::delta_risk_flexid_batch_grandfather'],'~thor_data400::base::InstantID_Archive::delta_risk_flexid_batch_'+version, true),
	
	FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::base::Instantid_Archive::delta_report_flexid_batch','~thor_data400::base::Instantid_Archive::delta_report_flexid_batch_father',
'~thor_data400::base::Instantid_Archive::delta_report_flexid_batch_grandfather'],'~thor_data400::base::InstantID_Archive::delta_report_flexid_batch_'+version, true));

//MOVE BATCH INPUT FILES IN THE PROCESSED SUPERFILES
//this step is temporary and the input files will be delete once the batch base files generated

input_SF_moves := sequential(
fileservices.AddSuperFile('~thor_data400::in::Instantid_Archive::delta_key_ciid_processed','~thor_data400::in::Instantid_Archive::delta_key_ciid',,true);
fileservices.AddSuperFile('~thor_data400::in::Instantid_Archive::delta_model_ciid_processed','~thor_data400::in::Instantid_Archive::delta_model_ciid',,true);
fileservices.AddSuperFile('~thor_data400::in::Instantid_Archive::delta_modelriskindicator_ciid_processed','~thor_data400::in::Instantid_Archive::delta_modelriskindicator_ciid',,true);
fileservices.AddSuperFile('~thor_data400::in::Instantid_Archive::delta_modelriskindex_ciid_processed','~thor_data400::in::Instantid_Archive::delta_modelriskindex_ciid',,true);
fileservices.AddSuperFile('~thor_data400::in::Instantid_Archive::delta_risk_ciid_processed','~thor_data400::in::Instantid_Archive::delta_risk_ciid',,true);
fileservices.AddSuperFile('~thor_data400::in::Instantid_Archive::delta_report_ciid_processed','~thor_data400::in::Instantid_Archive::delta_report_ciid',,true);
fileservices.AddSuperFile('~thor_data400::in::Instantid_Archive::delta_redflags_ciid_processed','~thor_data400::in::Instantid_Archive::delta_redflags_ciid',,true);
fileservices.AddSuperFile('~thor_data400::in::Instantid_Archive::delta_key_flexid_batch_processed','~thor_data400::in::Instantid_Archive::delta_key_flexid_batch',,true);
fileservices.AddSuperFile('~thor_data400::in::Instantid_Archive::delta_model_flexid_batch_processed','~thor_data400::in::Instantid_Archive::delta_model_flexid_batch',,true);
fileservices.AddSuperFile('~thor_data400::in::Instantid_Archive::delta_modelriskindicator_flexid_batch_processed','~thor_data400::in::Instantid_Archive::delta_modelriskindicator_flexid_batch',,true);
fileservices.AddSuperFile('~thor_data400::in::Instantid_Archive::delta_risk_flexid_batch_processed','~thor_data400::in::Instantid_Archive::delta_risk_flexid_batch',,true);
fileservices.AddSuperFile('~thor_data400::in::Instantid_Archive::delta_report_flexid_batch_processed','~thor_data400::in::Instantid_Archive::delta_report_flexid_batch',,true));



// REMOVAL OF PROCESSED INPUT FILES
input_SF_clear := sequential(
fileservices.clearsuperfile('~thor_data400::in::InstantID_Archive::delta_key_ciid'),
fileservices.clearsuperfile('~thor_data400::in::InstantID_Archive::delta_model_ciid'),
fileservices.clearsuperfile('~thor_data400::in::InstantID_Archive::delta_modelriskindicator_ciid'),
fileservices.clearsuperfile('~thor_data400::in::InstantID_Archive::delta_modelriskindex_ciid'),
fileservices.clearsuperfile('~thor_data400::in::InstantID_Archive::delta_risk_ciid'),
fileservices.clearsuperfile('~thor_data400::in::InstantID_Archive::delta_report_ciid'),
fileservices.clearsuperfile('~thor_data400::in::InstantID_Archive::delta_redflags_ciid'),
fileservices.clearsuperfile('~thor_data400::in::instantid_archive::delta_key_flexid_batch'),
fileservices.clearsuperfile('~thor_data400::in::instantid_archive::delta_model_flexid_batch'),
fileservices.clearsuperfile('~thor_data400::in::instantid_archive::delta_modelriskindicator_flexid_batch'),
fileservices.clearsuperfile('~thor_data400::in::instantid_archive::delta_risk_flexid_batch'),
fileservices.clearsuperfile('~thor_data400::in::instantid_archive::delta_report_flexid_batch'));

return Sequential(build_base,base_SF_moves,input_SF_moves, input_SF_clear);

end;
