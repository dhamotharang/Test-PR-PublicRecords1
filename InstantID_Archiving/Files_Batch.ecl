IMPORT Data_Services;

EXPORT FILES_Batch := MODULE

EXPORT InstantID_Key 		:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_key_ciid', InstantID_Archiving.Layouts.Key_InstantID, CSV(heading(1),separator('|'), TERMINATOR('\n')), OPT);
EXPORT InstantID_Model_in 	:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_model_ciid', InstantID_Archiving.Layouts.Model,  CSV(heading(1),separator('|'), TERMINATOR('\n')), OPT);
EXPORT InstantID_Modelrisk_in 	:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_modelriskindicator_ciid', InstantID_Archiving.Layouts.Modelrisk,  CSV(heading(1),separator('|'), TERMINATOR('\n')), OPT);
EXPORT InstantID_Modelindex_in 	:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_modelriskindex_ciid', InstantID_Archiving.Layouts.Modelindex,  CSV(heading(1),separator('|'), TERMINATOR('\n')), OPT);

EXPORT InstantID_Risk_in 	:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_risk_ciid', InstantID_Archiving.Layouts.Risk, CSV(heading(1),separator('|'), TERMINATOR('\n')), OPT);
EXPORT InstantID_Report_in := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_report_ciid', InstantID_Archiving.Layouts.Report, CSV(heading(1),separator('|'), quote('"'), TERMINATOR('\n')), OPT);
EXPORT InstantID_RedFlags_in := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::InstantID_Archive::delta_redflags_ciid', InstantID_Archiving.Layouts.Redflags, CSV(heading('1'),separator('|'), TERMINATOR('\n')), OPT);

EXPORT FlexID_Key				:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::instantid_archive::delta_key_flexid_batch', InstantID_Archiving.Layouts.Key_FlexID, CSV(heading(1),separator('|'), TERMINATOR('\n')), OPT);
EXPORT FlexID_Model_in			:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::instantid_archive::delta_model_flexid_batch', InstantID_Archiving.Layouts.Model, CSV(heading(1),separator('|'), TERMINATOR('\n')), OPT);
EXPORT FlexID_Modelrisk_in			:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::instantid_archive::delta_modelriskindicator_flexid_batch', InstantID_Archiving.Layouts.Modelrisk, CSV(heading(1),separator('|'), TERMINATOR('\n')), OPT);
EXPORT FlexID_Risk_in			:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::instantid_archive::delta_risk_flexid_batch', InstantID_Archiving.Layouts.Risk, CSV(heading(1),separator('|'), TERMINATOR('\n')), OPT);
EXPORT FlexID_Report_in		:= DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::in::instantid_archive::delta_report_flexid_batch', InstantID_Archiving.Layouts.Report, CSV(heading(1),separator('|'), TERMINATOR('\n')), OPT);

// PROCESSED BATCH BASE INPUT FILES
EXPORT InstantID_Model   := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_model_ciid', InstantID_Archiving.Layouts.Model, CSV(heading(1),separator('|'), TERMINATOR('\n')), OPT);
EXPORT InstantID_Modelrisk  := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_modelriskindicator_ciid', InstantID_Archiving.Layouts.Modelrisk, CSV(heading(1),separator('|'), TERMINATOR('\n')), OPT);
EXPORT InstantID_Modelindex	       := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_modelriskindex_ciid', InstantID_Archiving.Layouts.Modelindex, CSV(heading(1),separator('|'), TERMINATOR('\n')), OPT);
EXPORT InstantID_Risk      := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_risk_ciid', InstantID_Archiving.Layouts.Risk, CSV(heading(1),separator('|'), TERMINATOR('\n')), OPT);
EXPORT InstantID_Report    := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_report_ciid', InstantID_Archiving.Layouts.Report, CSV(heading(1),separator('|'), TERMINATOR('\n')), OPT);
EXPORT InstantID_RedFlags := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_redflags_ciid', InstantID_Archiving.Layouts.Redflags, CSV(heading(1),separator('|'), TERMINATOR('\n')), OPT);
EXPORT FlexID_Model	         := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_model_flexid_batch', InstantID_Archiving.Layouts.Model, CSV(heading(1),separator('|'), TERMINATOR('\n')), OPT);
EXPORT FlexID_ModelRisk	     := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_modelriskindicator_flexid_batch', InstantID_Archiving.Layouts.ModelRisk, CSV(heading(1),separator('|'), TERMINATOR('\n')), OPT);
EXPORT FlexID_Risk          := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_risk_flexid_batch', InstantID_Archiving.Layouts.Risk, CSV(heading(1),separator('|'), TERMINATOR('\n')), OPT);
EXPORT FlexID_Report		     := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::base::InstantID_Archive::delta_report_flexid_batch', InstantID_Archiving.Layouts.Report, CSV(heading(1),separator('|'), TERMINATOR('\n')), OPT);

END; 

