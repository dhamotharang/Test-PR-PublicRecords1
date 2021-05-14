IMPORT data_services, doxie, STD;

string common := data_services.data_location.prefix('PhoneFraud')  + 'thor_data400::key';
EXPORT names := MODULE

		EXPORT otp := common + '::phonefraud_otp_qa';
		
		EXPORT spoofing := common + '::phonefraud_spoofing_qa';	
END;