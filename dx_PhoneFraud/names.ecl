IMPORT data_services, doxie, STD;

string common := data_services.foreign_prod + 'thor_data400::key';
EXPORT names := module

		export otp := common + '::phonefraud_otp_qa';
		
		export spoofing := common + '::phonefraud_spoofing_qa';	
end;