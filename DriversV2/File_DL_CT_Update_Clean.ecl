IMPORT Drivers;

EXPORT File_DL_CT_Update_Clean := DATASET(DriversV2.Constants.cluster + 'in::dl2::ct_clean_updates::superfile',	Drivers.Layout_CT_Full,thor);
