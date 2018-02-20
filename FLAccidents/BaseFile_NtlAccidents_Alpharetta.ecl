import data_services;

export BaseFile_NtlAccidents_Alpharetta := 
		dataset(data_services.foreign_prod +'~thor_data400::base::ntlcrash',FLAccidents.Layout_NtlAccidents_Alpharetta.clean,thor);
