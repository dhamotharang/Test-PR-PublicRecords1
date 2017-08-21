import Data_Services;

//Datasets
inrec := InstantID_Archiving.Layout_Base;
df_IID_rec := dataset('~thor_data400::base::instantid_archive::key_files::father', inrec, thor);
df_IID_new_rec := dataset('~thor_data400::base::instantid_archive::key_files', inrec, thor);

InstantID_Model_base              := InstantID_Archiving.Files.InstantID_Model_base;
InstantID_Model_base_father       := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::Instantid_Archive::delta_model_instantid_processed_father', InstantID_Archiving.Layouts.Model, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);

InstantID_ModelRisk_base          := InstantID_Archiving.Files.InstantID_ModelRisk_base;
InstantID_ModelRisk_base_father   := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_modelrisk_instantid_processed_father', InstantID_Archiving.Layouts.ModelRisk, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);

InstantID_ModelIndex_base         := InstantID_Archiving.Files.InstantID_ModelIndex_base;
InstantID_ModelIndex_base_father  := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_index_instantid_processed_father', InstantID_Archiving.Layouts.ModelIndex, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);

InstantID_Risk_base               := InstantID_Archiving.Files.InstantID_Risk_base;
InstantID_Risk_base_father	       := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_risk_instantid_processed_father', InstantID_Archiving.Layouts.Risk, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);

InstantID_Report_base             := InstantID_Archiving.Files.InstantID_Report_base;
InstantID_Report_base_father      := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_report_instantid_processed_father', InstantID_Archiving.Layouts.Report, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);

InstantID_RedFlags_base           := InstantID_Archiving.Files.InstantID_RedFlags_base;
InstantID_RedFlags_base_father    := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_redflags_instantid_processed_father', InstantID_Archiving.Layouts.Redflags, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);

InstantIDi_Verification_base        := InstantID_Archiving.Files.InstantIDi_Verification_base;
InstantIDi_Verification_base_father := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_verification_instantidi_processed_father', InstantID_Archiving.Layouts.Verification, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);

InstantIDi_Risk_base             := InstantID_Archiving.Files.InstantIDi_Risk_base;
InstantIDi_Risk_base_father      := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_risk_instantidi_processed_father', InstantID_Archiving.Layouts.Risk, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);

InstantIDi_Report_base           := InstantID_Archiving.Files.InstantIDi_Report_base;
InstantIDi_Report_base_father    := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_report_instantidi_processed_father', InstantID_Archiving.Layouts.Report, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);

FlexID_Model_base                := InstantID_Archiving.Files.FlexID_Model_base;
FlexID_Model_base_father         := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_model_flexid_processed_father', InstantID_Archiving.Layouts.Model, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);

FlexID_Risk_base                 := InstantID_Archiving.Files.FlexID_Risk_base;
FlexID_Risk_base_father          := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_risk_flexid_processed_father', InstantID_Archiving.Layouts.Risk, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);

FlexID_ModelRisk_base            := InstantID_Archiving.Files.FlexID_ModelRisk_base;
FlexID_ModelRisk_base_father	    := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_modelrisk_flexid_processed_father', InstantID_Archiving.Layouts.ModelRisk, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);

FlexID_Report_base               := InstantID_Archiving.Files.FlexID_Report_base;
FlexID_Report_base_father	      := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_report_flexid_processed_father', InstantID_Archiving.Layouts.Report, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);



export updated_samples := 

Sequential(
output(join(df_IID_rec, df_IID_new_rec, left.transaction_id=right.transaction_id,right only),,'~thor_data400::out::instantid_archive::key_files_base::samples', named('InstantID_Key_Files_Base_Samples'),overwrite);
output(join(InstantID_Model_base_father, InstantID_Model_base, left.transaction_id=right.transaction_id, right only),,'~thor_data400::out::instantid_archive::model_base::samples', named('InstantID_Model_Base_Samples'),overwrite);
output(join(InstantID_ModelRisk_base_father, InstantID_ModelRisk_base, left.transaction_id=right.transaction_id, right only),,'~thor_data400::out::instantid_archive::modelrisk_base::samples', named('InstantID_ModelRisk_Base_Samples'),overwrite);
output(join(InstantID_ModelIndex_base_father, InstantID_ModelIndex_base, left.transaction_id=right.transaction_id, right only),,'~thor_data400::out::instantid_archive::modelindex_base::samples', named('InstantID_ModelIndex_Base_Samples'),overwrite);
output(join(InstantID_Risk_base_father, InstantID_Risk_base, left.transaction_id=right.transaction_id, right only),,'~thor_data400::out::instantid_archive::risk_base::samples', named('InstantID_Risk_Base_Samples'),overwrite);
output(join(InstantID_Report_base_father, InstantID_Report_base, left.transaction_id=right.transaction_id, right only),,'~thor_data400::out::instantid_archive::report_base::samples', named('InstantID_Report_Base_Samples'),overwrite);
output(join(InstantID_Redflags_base_father, InstantID_Redflags_base, left.transaction_id=right.transaction_id, right only),,'~thor_data400::out::instantid_archive::redflags_base::samples', named('InstantID_Redflags_Base_Samples'),overwrite);
output(join(InstantIDi_Verification_base_father, InstantIDi_Verification_base, left.transaction_id=right.transaction_id, right only),,'~thor_data400::out::instantid_archive::verification_base::samples', named('InstantID_Verification_Base_Samples'),overwrite);
output(join(InstantIDi_Risk_base_father, InstantIDi_Risk_base, left.transaction_id=right.transaction_id, right only),,'~thor_data400::out::instantid_archive::idirisk_base::samples', named('InstantID_IDiRisk_Base_Samples'),overwrite);
output(join(InstantIDi_Report_base_father, InstantIDi_Report_base, left.transaction_id=right.transaction_id, right only),,'~thor_data400::out::instantid_archive::idireport_base::samples', named('InstantID_IDiReport_Base_Samples'),overwrite);
output(join(FlexID_Model_base_father, FlexID_Model_base, left.transaction_id=right.transaction_id, right only),,'~thor_data400::out::instantid_archive::FlexID_Model_base::samples', named('FlexID_Model_Base_Samples'),overwrite);
output(join(FlexID_Risk_base_father, FlexID_Risk_base, left.transaction_id=right.transaction_id, right only),,'~thor_data400::out::instantid_archive::FlexID_Risk_base::samples', named('FlexID_Risk_Base_Samples'),overwrite);
output(join(FlexID_ModelRisk_base_father, FlexID_ModelRisk_base, left.transaction_id=right.transaction_id, right only),,'~thor_data400::out::instantid_archive::FlexID_ModelRisk_base::samples', named('FlexID_ModelRisk_Base_Samples'),overwrite);
output(join(FlexID_Report_base_father, FlexID_Report_base, left.transaction_id=right.transaction_id, right only),,'~thor_data400::out::instantid_archive::FlexID_Report_base::samples', named('FlexID_Report_Base_Samples'),overwrite));