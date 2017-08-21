IMPORT corp2_mapping, corp2_raw_la, tools, ut;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
		tools.mac_FilesInput(Corp2_Raw_LA.Filenames(pversion, pUseOtherEnvironment).Input.CorpsEntities, 	Corp2_Raw_LA.Layouts.CorpsEntitiesLayoutIn, 	CorpsEntities,	'Entities/Entity');
		tools.mac_FilesInput(Corp2_Raw_LA.Filenames(pversion, pUseOtherEnvironment).Input.Agents, 				Corp2_Raw_LA.Layouts.AgentsLayoutIn, 					Agents,					'officersAndAgents/Entity');
		tools.mac_FilesInput(Corp2_Raw_LA.Filenames(pversion, pUseOtherEnvironment).Input.Filings,				Corp2_Raw_LA.Layouts.FilingsLayoutIn,			 		Filings,   			'Filings/Entity/');
		tools.mac_FilesInput(Corp2_Raw_LA.Filenames(pversion, pUseOtherEnvironment).Input.Mergers, 				Corp2_Raw_LA.Layouts.MergersLayoutIn,			 		Mergers,  			'Mergers/Entity');
		tools.mac_FilesInput(Corp2_Raw_LA.Filenames(pversion, pUseOtherEnvironment).Input.PreviousNames, 	Corp2_Raw_LA.Layouts.PreviousNamesLayoutIn,		PreviousNames, 	'PreviousNames/Entity');
		tools.mac_FilesInput(Corp2_Raw_LA.Filenames(pversion, pUseOtherEnvironment).Input.TradeServices, 	Corp2_Raw_LA.Layouts.TradeServicesLayoutIn,		TradeServices,  'TradeService/TradeServiceEntity');
		tools.mac_FilesInput(Corp2_Raw_LA.Filenames(pversion, pUseOtherEnvironment).Input.NameReservs, 		Corp2_Raw_LA.Layouts.NameReservsLayoutIn,			NameReservs,   	'NameReservations/NameReservationEntry');																			 
	END;

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
		tools.mac_FilesBase(Corp2_Raw_LA.Filenames(pversion, pUseOtherEnvironment).Base.CorpsEntities, 		Corp2_Raw_LA.Layouts.CorpsEntitiesLayoutBase,	CorpsEntities);
		tools.mac_FilesBase(Corp2_Raw_LA.Filenames(pversion, pUseOtherEnvironment).Base.Agents, 					Corp2_Raw_LA.Layouts.AgentsLayoutBase,				Agents);
		tools.mac_FilesBase(Corp2_Raw_LA.Filenames(pversion, pUseOtherEnvironment).Base.Filings,					Corp2_Raw_LA.Layouts.FilingsLayoutBase,				Filings);
		tools.mac_FilesBase(Corp2_Raw_LA.Filenames(pversion, pUseOtherEnvironment).Base.Mergers, 					Corp2_Raw_LA.Layouts.MergersLayoutBase,				Mergers);
		tools.mac_FilesBase(Corp2_Raw_LA.Filenames(pversion, pUseOtherEnvironment).Base.PreviousNames, 		Corp2_Raw_LA.Layouts.PreviousNamesLayoutBase,	PreviousNames);
		tools.mac_FilesBase(Corp2_Raw_LA.Filenames(pversion, pUseOtherEnvironment).Base.TradeServices, 		Corp2_Raw_LA.Layouts.TradeServicesLayoutBase,	TradeServices);
		tools.mac_FilesBase(Corp2_Raw_LA.Filenames(pversion, pUseOtherEnvironment).Base.NameReservs, 			Corp2_Raw_LA.Layouts.NameReservsLayoutBase,		NameReservs);
	END;

END;