IMPORT Data_Services, Doxie;

inFile := project(PhoneFraud.File_Spoofing.Base, PhoneFraud.Layout_Spoofing.Base-date_file_loaded);

EXPORT Key_Spoofing := index(inFile
															,{phone}
															,{inFile}
															,/*Data_Services.Data_location.Prefix('NONAMEGIVEN')+*/'~thor_data400::key::phonefraud_spoofing_'+doxie.Version_SuperKey);

