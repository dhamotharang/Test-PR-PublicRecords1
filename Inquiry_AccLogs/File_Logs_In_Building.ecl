export File_Logs_In_Building := module

export testnum := 1000000;

	export accurint := dataset('~thor_data400::in::accurint_acclogs_building', inquiry_acclogs.Layout_Accurint_Logs, csv(quote(''), separator('~~'), terminator(['\r\n', '\n'])));
	
	export banko := dataset('~thor_data400::in::banko_acclogs_building', inquiry_acclogs.Layout_Banko_Logs, csv(quote(''), separator('~~'), terminator(['\r\n', '\n'])));
	
	export custom := dataset('~thor_data400::in::custom_acclogs_building', inquiry_acclogs.Layout_Custom_Logs, csv(quote(''), separator('~~'), terminator(['\r\n', '\n'])));
	
	export riskwise := dataset('~thor_data400::in::riskwise_acclogs_building', inquiry_acclogs.Layout_Riskwise_Logs.Input, csv(quote(''), separator('~~'), terminator(['\r\n', '\n'])));

end;