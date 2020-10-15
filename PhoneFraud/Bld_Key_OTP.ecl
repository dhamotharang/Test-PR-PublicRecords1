IMPORT Data_Services, Doxie;


EXPORT Bld_Key_OTP(string version) := FUNCTION
    inFile := project(dataset('~thor_data400::base::phonefraud_OTP_'+version, PhoneFraud.Layout_OTP.Base,flat), PhoneFraud.Layout_OTP.Base-date_file_loaded);
    
    return index(inFile
                ,{otp_phone}
                ,{inFile}
                ,/*Data_Services.Data_location.Prefix('NONAMEGIVEN')+*/'~thor_data400::key::phonefraud_otp_'+doxie.Version_SuperKey);
END;