IMPORT Data_Services;
EXPORT Files_Base := MODULE

/* Accounting logs files processed list from logs and fcra logs thor */
EXPORT Processed_Files := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING') + 'thor_data400::out::instantid_archive::processed_files', {string name{maxlength(256)}}, thor, __compressed__, opt);

EXPORT Delta := DATASET(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING') + 'thor_data400::base::InstantID_Archive::key_files', InstantID_Archiving.Layout_Base, thor, __compressed__, opt);

EXPORT InstantID_Model := InstantID_Archiving.Files.InstantID_Model;
EXPORT InstantID_ModelRisk := InstantID_Archiving.Files.InstantID_ModelRisk;
EXPORT InstantID_ModelIndex := InstantID_Archiving.Files.InstantID_ModelIndex;
EXPORT InstantID_Risk := InstantID_Archiving.Files.InstantID_Risk;
EXPORT InstantID_Key := InstantID_Archiving.Files.InstantID_Key;
EXPORT InstantID_Report := InstantID_Archiving.Files.InstantID_Report;
EXPORT InstantID_RedFlags := InstantID_Archiving.Files.InstantID_RedFlags;

EXPORT InstantIDi_Key := InstantID_Archiving.Files.InstantIDi_Key;
EXPORT InstantIDi_Verification := InstantID_Archiving.Files.InstantIDi_Verification;
EXPORT InstantIDi_Risk := InstantID_Archiving.Files.InstantIDi_Risk;
EXPORT InstantIDi_Report := InstantID_Archiving.Files.InstantIDi_Report;

EXPORT FlexID_Key := InstantID_Archiving.Files.FlexID_Key;
EXPORT FlexID_Model := InstantID_Archiving.Files.FlexID_Model;
EXPORT FlexID_Risk := InstantID_Archiving.Files.FlexID_Risk;
EXPORT FlexID_ModelRisk := InstantID_Archiving.Files.FlexID_ModelRisk;
EXPORT FlexID_Report := InstantID_Archiving.Files.FlexID_Report;

END;