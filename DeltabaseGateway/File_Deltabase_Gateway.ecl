IMPORT data_services, dx_PhonesInfo, PhonesInfo;

EXPORT File_Deltabase_Gateway := MODULE

	EXPORT Historic_Results_Raw 									:= dataset('~thor_data400::in::deltabase_gateway::historic_results_daily', 									DeltabaseGateway.Layout_Deltabase_Gateway.Historic_Results_Raw, csv(heading(1), separator(['|\t|']), terminator(['\r\n', '\n']), quote('"')));
	EXPORT Historic_Results_History		 						:= dataset('~thor_data400::in::deltabase_gateway::historic_results_history', 								DeltabaseGateway.Layout_Deltabase_Gateway.Historic_Results_Raw, flat);
	EXPORT Historic_Results_Base 									:= dataset('~thor_data400::base::deltabase_gateway::historic_results', 											DeltabaseGateway.Layout_Deltabase_Gateway.Historic_Results_Base,flat);
	EXPORT Historic_Results_LIDB_Base 						:= dataset('~thor_data400::base::deltabase_gateway::lidb_historic_results', 								DeltabaseGateway.Layout_Deltabase_Gateway.Historic_Results_Base,flat);

	//Reformat w/ Appended Carrier Info
	EXPORT Historic_LIDB_Results_CR_Append				:= dataset('~thor_data400::base::deltabase_gateway::lidb_historic_results_cr_append', 			PhonesInfo.Layout_Common.temp_PortedMetadata_Main,	flat);	//DF-26977
	EXPORT Historic_LIDB_Results_CR_Append_PType	:= dataset('~thor_data400::base::deltabase_gateway::lidb_historic_results_cr_append_ptype', dx_PhonesInfo.Layouts.Phones_Type_Main,	flat);							//DF-26977

END;