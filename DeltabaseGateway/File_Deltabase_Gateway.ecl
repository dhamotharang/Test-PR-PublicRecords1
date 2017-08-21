EXPORT File_Deltabase_Gateway := MODULE

	EXPORT Historic_Results_Raw 		:= dataset('~thor_data400::in::deltabase_gateway::historic_results_daily', 		DeltabaseGateway.Layout_Deltabase_Gateway.Historic_Results_Raw, csv(heading(1), separator(['|\t|']), terminator(['\r\n', '\n']), quote('"')));
	EXPORT Historic_Results_History := dataset('~thor_data400::in::deltabase_gateway::historic_results_history', 	DeltabaseGateway.Layout_Deltabase_Gateway.Historic_Results_Raw, flat);
	EXPORT Historic_Results_Base 		:= dataset('~thor_data400::base::deltabase_gateway::historic_results', 				DeltabaseGateway.Layout_Deltabase_Gateway.Historic_Results_Base,flat);

END;