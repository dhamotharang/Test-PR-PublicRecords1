IMPORT Scrubs_Thrive,Data_Services;

EXPORT Input_LT_In_Thrive := DATASET('~thor_data400::in::thrive::lt',Scrubs_Thrive.Input_LT_Layout_Thrive,csv( separator(','),heading(1), terminator(['\n', '\r\n']), quote(['\'','"']), MAXLENGTH(40000)));
