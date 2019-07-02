IMPORT Scrubs_Thrive,Data_Services;

EXPORT Input_PD_In_Thrive := DATASET('~thor_data400::in::thrive::pd',Scrubs_Thrive.Input_PD_Layout_Thrive,csv( separator(','),heading(1), terminator(['\n', '\r\n']), quote(['\'','"']), MAXLENGTH(40000)));
// EXPORT Input_PD_In_Thrive := DATASET(Data_Services.foreign_prod + 'thor_data400::in::thrive::pd::20190415',Scrubs_Thrive.Input_PD_Layout_Thrive,csv( separator(','),heading(1), terminator(['\n', '\r\n']), quote(['\'','"']), MAXLENGTH(40000)));