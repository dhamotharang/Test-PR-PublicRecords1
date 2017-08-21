IMPORT Data_Services,ut;

EXPORT FILES := MODULE

EXPORT InstantID_Model 	:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_model_instantid_concatenated', InstantID_Archiving.Layouts.Model, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),OPT);
EXPORT InstantID_ModelRisk 	:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_modelrisk_instantid_concatenated', InstantID_Archiving.Layouts.ModelRisk, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),OPT);
EXPORT InstantID_ModelIndex 	:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_index_instantid_concatenated', InstantID_Archiving.Layouts.ModelIndex, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),OPT);
EXPORT InstantID_Risk 	:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_risk_instantid_concatenated', InstantID_Archiving.Layouts.Risk, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),OPT);
EXPORT InstantID_Key 		:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_key_instantid_concatenated', InstantID_Archiving.Layouts.Key_InstantID, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),OPT);
EXPORT InstantID_Report := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_report_instantid_concatenated', InstantID_Archiving.Layouts.Report, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),OPT);
EXPORT InstantID_RedFlags := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_redflags_instantid_concatenated', InstantID_Archiving.Layouts.Redflags, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),OPT);

EXPORT InstantIDi_Key		:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_key_instantidi_concatenated', InstantID_Archiving.Layouts.Key_InstantIDi, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),OPT);
//+DATASET(ut.foreign_dataland+'thor_data400::in::InstantID_Archive::delta_key_instantidi', InstantID_Archiving.Layouts.Key_InstantIDi, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])));
EXPORT InstantIDi_Verification := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_verification_instantidi_concatenated', InstantID_Archiving.Layouts.Verification, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),OPT);
//+DATASET(ut.foreign_dataland +'thor_data400::in::InstantID_Archive::delta_verification_instantidi', InstantID_Archiving.Layouts.Verification, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])));
EXPORT InstantIDi_Risk	:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_risk_instantidi_concatenated', InstantID_Archiving.Layouts.Risk, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),OPT);
//+DATASET(ut.foreign_dataland +'thor_data400::in::InstantID_Archive::delta_risk_instantidi', InstantID_Archiving.Layouts.Risk, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])));
EXPORT InstantIDi_Report := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_report_instantidi_concatenated', InstantID_Archiving.Layouts.Report, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),OPT);
//+DATASET(ut.foreign_dataland +'thor_data400::in::InstantID_Archive::delta_report_instantidi', InstantID_Archiving.Layouts.Report, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])));

EXPORT FlexID_Key				:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_key_flexid_concatenated', InstantID_Archiving.Layouts.Key_FlexID, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),OPT);
EXPORT FlexID_Model			:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_model_flexid_concatenated', InstantID_Archiving.Layouts.Model, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),OPT);
EXPORT FlexID_Risk			:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_risk_flexid_concatenated', InstantID_Archiving.Layouts.Risk, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),OPT);
EXPORT FlexID_ModelRisk	:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_modelrisk_flexid_concatenated', InstantID_Archiving.Layouts.ModelRisk, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),OPT);
EXPORT FlexID_Report		:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_report_flexid_concatenated', InstantID_Archiving.Layouts.Report, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])),OPT);


// PROCESSED DELTA BASE INPUT FILES
EXPORT InstantID_Model_base       := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::Instantid_Archive::delta_model_instantid_processed', InstantID_Archiving.Layouts.Model, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);
EXPORT InstantID_ModelRisk_base   := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_modelrisk_instantid_processed', InstantID_Archiving.Layouts.ModelRisk, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);
EXPORT InstantID_ModelIndex_base  := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_index_instantid_processed', InstantID_Archiving.Layouts.ModelIndex, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);
EXPORT InstantID_Risk_base	       := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_risk_instantid_processed', InstantID_Archiving.Layouts.Risk, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);
EXPORT InstantID_Report_base      := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_report_instantid_processed', InstantID_Archiving.Layouts.Report, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);
EXPORT InstantID_RedFlags_base    := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_redflags_instantid_processed', InstantID_Archiving.Layouts.Redflags, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);
EXPORT InstantIDi_Verification_base := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_verification_instantidi_processed', InstantID_Archiving.Layouts.Verification, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);
EXPORT InstantIDi_Risk_base       := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_risk_instantidi_processed', InstantID_Archiving.Layouts.Risk, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);
EXPORT InstantIDi_Report_base     := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_report_instantidi_processed', InstantID_Archiving.Layouts.Report, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);
EXPORT FlexID_Model_base	         := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_model_flexid_processed', InstantID_Archiving.Layouts.Model, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);
EXPORT FlexID_Risk_base           := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_risk_flexid_processed', InstantID_Archiving.Layouts.Risk, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);
EXPORT FlexID_ModelRisk_base	     := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_modelrisk_flexid_processed', InstantID_Archiving.Layouts.ModelRisk, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);
EXPORT FlexID_Report_base		     := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_report_flexid_processed', InstantID_Archiving.Layouts.Report, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);

END;