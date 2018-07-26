IMPORT Data_Services;

EXPORT Constants := module

	EXPORT dops_name := 'PhoneFraudKeys';
 
 //infiles are current production copies of the PhoneFraud base files at the time of the prte build
	EXPORT in_PhoneFraud_otp						:= Data_Services.foreign_prod + 'thor_data400::base::PhoneFraud_otp';
	EXPORT in_PhoneFraud_spoofing	:= Data_Services.foreign_prod + 'thor_data400::base::PhoneFraud_spoofing';
			
	EXPORT base_PhoneFraud_otp 			 	:= '~prte::base::PhoneFraud_otp';
	EXPORT base_PhoneFraud_spoofing	:= '~prte::base::PhoneFraud_spoofing';

 EXPORT KeyName_PhoneFraud := '~prte::key::';
	 
 EXPORT KeyName_PhoneFraud_otp := 	'PhoneFraud_otp'; 

 EXPORT KeyName_PhoneFraud_spoofing := 	'PhoneFraud_spoofing'; 

END;