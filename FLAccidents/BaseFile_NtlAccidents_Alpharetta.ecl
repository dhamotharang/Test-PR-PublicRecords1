import ut,Data_Services;

export BaseFile_NtlAccidents_Alpharetta := 
		dataset(Data_Services.Data_location.Prefix('ntlcrash')+'thor_data400::base::ntlcrash',FLAccidents.Layout_NtlAccidents_Alpharetta.clean,thor)(ACCT_NBR not in ['533302','533303','535863','530209', '536379' ]);
