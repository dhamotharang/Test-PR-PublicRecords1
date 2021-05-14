IMPORT Scrubs_OneKey, OneKey, Data_Services;

// EXPORT Base_In_OneKey := OneKey.Files().base.qa;
EXPORT Base_In_OneKey := DATASET('~thor_data400::base::ska::qa', Scrubs_OneKey.Base_Layout_OneKey, THOR);
