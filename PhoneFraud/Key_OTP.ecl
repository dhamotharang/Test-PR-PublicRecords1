IMPORT Data_Services, Doxie;

inFile := project(PhoneFraud.File_OTP.Base, PhoneFraud.Layout_OTP.Base-date_file_loaded);

EXPORT Key_OTP := index(inFile
												,{otp_phone}
												,{inFile}
												,/*Data_Services.Data_location.Prefix('NONAMEGIVEN')+*/'~thor_data400::key::phonefraud_otp_'+doxie.Version_SuperKey);
