IMPORT Data_Services;

EXPORT FILES := MODULE

EXPORT InstantID_Model 	:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_model_instantid', InstantID_Archiving.Layouts.Model, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);
EXPORT InstantID_ModelRisk 	:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_modelrisk_instantid', InstantID_Archiving.Layouts.ModelRisk, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);
EXPORT InstantID_ModelIndex 	:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_index_instantid', InstantID_Archiving.Layouts.ModelIndex, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);
EXPORT InstantID_Risk 	:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_risk_instantid', InstantID_Archiving.Layouts.Risk, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);
EXPORT InstantID_Key 		:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_key_instantid', InstantID_Archiving.Layouts.Key_InstantID, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);
EXPORT InstantID_Report := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_report_instantid', InstantID_Archiving.Layouts.Report, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);
EXPORT InstantID_RedFlags := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_redflags_instantid', InstantID_Archiving.Layouts.Redflags, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);

EXPORT InstantIDi_Key		:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_key_instantidi', InstantID_Archiving.Layouts.Key_InstantIDi, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);
EXPORT InstantIDi_Verification := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_verification_instantidi', InstantID_Archiving.Layouts.Verification, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);
EXPORT InstantIDi_Risk	:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_risk_instantidi', InstantID_Archiving.Layouts.Risk, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);
EXPORT InstantIDi_Report := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_report_instantidi', InstantID_Archiving.Layouts.Report, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);

EXPORT FlexID_Key				:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_key_flexid', InstantID_Archiving.Layouts.Key_FlexID, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);
EXPORT FlexID_Model			:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_model_flexid', InstantID_Archiving.Layouts.Model, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);
EXPORT FlexID_Risk			:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_risk_flexid', InstantID_Archiving.Layouts.Risk, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);
EXPORT FlexID_ModelRisk	:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_modelrisk_flexid', InstantID_Archiving.Layouts.ModelRisk, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);
EXPORT FlexID_Report		:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_report_flexid', InstantID_Archiving.Layouts.Report, CSV(separator(['~~~']), TERMINATOR(['~~^~~'])), OPT);


END;