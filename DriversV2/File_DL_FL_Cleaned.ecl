IMPORT Drivers;

EXPORT File_DL_FL_Cleaned := DATASET(DriversV2.Constants.cluster + 'in::dl2::fl_clean_updates::superfile', drivers.Layout_FL_Update, THOR);