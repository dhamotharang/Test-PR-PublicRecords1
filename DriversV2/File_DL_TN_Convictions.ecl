IMPORT DriversV2;
EXPORT File_DL_TN_Convictions := DATASET(DriversV2.Constants.Cluster + 'in::dl2::TN_CP_Clean_updates::Superfile', Layouts_DL_TN_In.Layout_TN_CP_All_Cleaned, THOR);