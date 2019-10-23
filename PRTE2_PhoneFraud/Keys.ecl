IMPORT  doxie;

EXPORT keys := MODULE

//key_otp
inFile_otp := project(Files.phonefraud_otp_base, Layouts.layout_phonefraud_otp_base_in - date_file_loaded);

EXPORT Key_OTP := index(inFile_otp
												,{otp_phone}
												,{inFile_otp}
												,Constants.KeyName_phonefraud_otp + doxie.Version_SuperKey);
												
												
//key_spoofing
inFile_spoofing := project(Files.phonefraud_spoofing_base, Layouts.layout_phonefraud_spoofing_base_in - date_file_loaded);

EXPORT Key_Spoofing := index(inFile_spoofing
															,{phone}
															,{inFile_spoofing}
															,Constants.KeyName_phonefraud_spoofing + doxie.Version_SuperKey);

END;
