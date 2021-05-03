IMPORT Data_Services, Doxie;


EXPORT Bld_Key_SPOOFING(string version) := FUNCTION
    inFile := project(dataset('~thor_data400::base::phonefraud_SPOOFING_'+version, PhoneFraud.Layout_SPOOFING.Base,flat), PhoneFraud.Layout_SPOOFING.Base-date_file_loaded);
    
    return index(inFile
                ,{phone}
                ,{inFile}
                ,/*Data_Services.Data_location.Prefix('NONAMEGIVEN')+*/'~thor_data400::key::phonefraud_spoofing_'+doxie.Version_SuperKey);
END;