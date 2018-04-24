import std, _control, GlobalWatchLists_Preprocess;

sfBankOfEngland 						:= root + 'bank_of_england';
sfDebarredParties 					:= root + 'debarred_parties';
sfDeniedEntity 							:= root + 'denied_entity';
sfDeniedPersons 						:= root + 'denied_persons';
sfEUterroristPersons 				:= root + 'eu_terrorist_list::persons';
sfEUterroristGroups 				:= root + 'eu_terrorist_list::groups';
sfForeignAgentsRegistration := root + 'foreign_agents_registration';
sfForeignAgentsFP 					:= root + 'foreign_agents_registration::FP';
sfForeignAgentsRE						:= root + 'foreign_agents_registration::RE';
sfForeignAgentsSRE					:= root + 'foreign_agents_registration::SRE';
sfInnovativeSystemsCFT 			:= root + 'innovative_systems::CFT';
sfInnovativeSystemsFBI 			:= root + 'innovative_systems::FBI';
sfInnovativeSystemsOCC 			:= root + 'innovative_systems::OCC';
sfInnovativeSystemsOSC 			:= root + 'innovative_systems::OSC';
sfInnovativeSystemsPEP 			:= root + 'innovative_systems::PEP';
sfInnovativeSystemsUNS 			:= root + 'innovative_systems::UNS';
sfInterpolMostWanted 				:= root + 'interpol_most_wanted';
sfInterpolMostWantedINT			:= root + 'interpol_most_wanted::INT';
sfOFAC 											:= root + 'ofac';
sfOfacNewPLC 								:= root + 'ofac::new_plc';
sfOSFICanadaEntity 					:= root + 'osfi_canada::entities';
sfOSFICanadaIndividuals 		:= root + 'osfi_canada::individuals';
sfStateDepartment 					:= root + 'state_department_terrorist_exclusion';
sfStateDepartmentterrorist 	:= root + 'state_department_terrorist';
sfUnverified 								:= root + 'unverified';
sfWorldBank 								:= root + 'world_bank';

CreateSuperfiles := SEQUENTIAL(
 		if (NOT STD.File.SuperFileExists(sfBankOfEngland),
   			STD.File.CreateSuperFile(sfBankOfEngland));
		if (NOT STD.File.SuperFileExists(sfDebarredParties),
				STD.File.CreateSuperFile(sfDebarredParties));
		if (NOT STD.File.SuperFileExists(sfDeniedEntity),
				STD.File.CreateSuperFile(sfDeniedEntity));
		if (NOT STD.File.SuperFileExists(sfDeniedPersons),
				STD.File.CreateSuperFile(sfDeniedPersons));
		if (NOT STD.File.SuperFileExists(sfEUterroristPersons),
				STD.File.CreateSuperFile(sfEUterroristPersons));
		if (NOT STD.File.SuperFileExists(sfEUterroristGroups),
				STD.File.CreateSuperFile(sfEUterroristGroups));		
		if (NOT STD.File.SuperFileExists(sfForeignAgentsRegistration),
				STD.File.CreateSuperFile(sfForeignAgentsRegistration));
		if (NOT STD.File.SuperFileExists(sfForeignAgentsFP),
				STD.File.CreateSuperFile(sfForeignAgentsFP));
		if (NOT STD.File.SuperFileExists(sfForeignAgentsRE),
				STD.File.CreateSuperFile(sfForeignAgentsRE));
		if (NOT STD.File.SuperFileExists(sfForeignAgentsSRE),
				STD.File.CreateSuperFile(sfForeignAgentsSRE));					
		if (NOT STD.File.SuperFileExists(sfInnovativeSystemsCFT),
			STD.File.CreateSuperFile(sfInnovativeSystemsCFT));
		if (NOT STD.File.SuperFileExists(sfInnovativeSystemsFBI),
				STD.File.CreateSuperFile(sfInnovativeSystemsFBI));
		if (NOT STD.File.SuperFileExists(sfInnovativeSystemsOCC),
				STD.File.CreateSuperFile(sfInnovativeSystemsOCC));
		if (NOT STD.File.SuperFileExists(sfInnovativeSystemsOSC),
				STD.File.CreateSuperFile(sfInnovativeSystemsOSC));		
		if (NOT STD.File.SuperFileExists(sfInnovativeSystemsPEP),
				STD.File.CreateSuperFile(sfInnovativeSystemsPEP));
		if (NOT STD.File.SuperFileExists(sfInnovativeSystemsUNS),
				STD.File.CreateSuperFile(sfInnovativeSystemsUNS));
		if (NOT STD.File.SuperFileExists(sfInterpolMostWanted),
				STD.File.CreateSuperFile(sfInterpolMostWanted));
		if (NOT STD.File.SuperFileExists(sfInterpolMostWantedINT),
   				STD.File.CreateSuperFile(sfInterpolMostWantedINT));
		if (NOT STD.File.SuperFileExists(sfOFAC),
				STD.File.CreateSuperFile(sfOFAC));
		if (NOT STD.File.SuperFileExists(sfOfacNewPLC),
				STD.File.CreateSuperFile(sfOfacNewPLC));
		if (NOT STD.File.SuperFileExists(sfOSFICanadaEntity),
				STD.File.CreateSuperFile(sfOSFICanadaEntity));
		if (NOT STD.File.SuperFileExists(sfOSFICanadaIndividuals),
				STD.File.CreateSuperFile(sfOSFICanadaIndividuals));
		if (NOT STD.File.SuperFileExists(sfStateDepartment),
				STD.File.CreateSuperFile(sfStateDepartment));
		if (NOT STD.File.SuperFileExists(sfStateDepartmentterrorist),
				STD.File.CreateSuperFile(sfStateDepartmentterrorist));
		if (NOT STD.File.SuperFileExists(sfUnverified),
				STD.File.CreateSuperFile(sfUnverified));
		if (NOT STD.File.SuperFileExists(sfWorldBank),
				STD.File.CreateSuperFile(sfWorldBank));
);
//************************************************************************************************************
//Prior to running script, each available version needs to be changed in GlobalWatchLists_Preprocess_Versions.
//************************************************************************************************************

EXPORT SprayAllFiles := SEQUENTIAL 
(
	CreateSuperFiles,
	FileServices.StartSuperFileTransaction( ),
		IF(NOT STD.File.FileExists(sfBankOfEngland +'::'+ Versions.BankOfEngland_Version), FileServices.ClearSuperFile(sfBankOfEngland, false)),
		IF(NOT STD.File.FileExists(sfDebarredParties +'::'+ Versions.DebbaredParties_Version), FileServices.ClearSuperFile(sfDebarredParties, false)),
		IF(NOT STD.File.FileExists(sfDeniedEntity +'::'+ Versions.DeniedEntity_Version), FileServices.ClearSuperFile(sfDeniedEntity, false)),
		IF(NOT STD.File.FileExists(sfDeniedPersons +'::'+ Versions.DeniedPersons_Version), FileServices.ClearSuperFile(sfDeniedPersons, false)),
		IF(NOT STD.File.FileExists(sfEUterroristPersons +'::'+ Versions.EUTerrorist_Version), FileServices.ClearSuperFile(sfEUterroristPersons, false)),
		IF(NOT STD.File.FileExists(sfEUterroristGroups +'::'+ Versions.EUTerrorist_Version), FileServices.ClearSuperFile(sfEUterroristGroups, false)),
		//IF(NOT STD.File.FileExists(sfForeignAgentsRegistration +'::'+ Versions.Foreign_Agents_Version), FileServices.ClearSuperFile(sfForeignAgentsRegistration, false)), --historical file
		IF(NOT STD.File.FileExists(sfForeignAgentsFP +'::'+ Versions.Foreign_Agents_Version), FileServices.ClearSuperFile(sfForeignAgentsFP, false)),
		IF(NOT STD.File.FileExists(sfForeignAgentsRE +'::'+ Versions.Foreign_Agents_Version), FileServices.ClearSuperFile(sfForeignAgentsRE, false)),
		IF(NOT STD.File.FileExists(sfForeignAgentsSRE +'::'+ Versions.Foreign_Agents_Version), FileServices.ClearSuperFile(sfForeignAgentsSRE, false)),
		IF(NOT STD.File.FileExists(sfInnovativeSystemsCFT +'::'+ Versions.InnovativeCFT_Version), FileServices.ClearSuperFile(sfInnovativeSystemsCFT, false)),
		IF(NOT STD.File.FileExists(sfInnovativeSystemsFBI +'::'+ Versions.InnovativeFBI_Version), FileServices.ClearSuperFile(sfInnovativeSystemsFBI, false)),
		//IF(NOT STD.File.FileExists(sfInnovativeSystemsOCC +'::'+ Versions.InnovativeOCC_Version), FileServices.ClearSuperFile(sfInnovativeSystemsOCC, false)),
		IF(NOT STD.File.FileExists(sfInnovativeSystemsOSC +'::'+ Versions.InnovativeOSC_Version), FileServices.ClearSuperFile(sfInnovativeSystemsOSC, false)),
		IF(NOT STD.File.FileExists(sfInnovativeSystemsPEP +'::'+ Versions.InnovativePEP_Version), FileServices.ClearSuperFile(sfInnovativeSystemsPEP, false)),
		IF(NOT STD.File.FileExists(sfInnovativeSystemsUNS +'::'+ Versions.InnovativeUNS_Version), FileServices.ClearSuperFile(sfInnovativeSystemsUNS, false)),
		IF(NOT STD.File.FileExists(sfInterpolMostWanted +'::'+ Versions.IMW_Version), FileServices.ClearSuperFile(sfInterpolMostWanted, false)),
		IF(NOT STD.File.FileExists(sfInterpolMostWantedINT +'::'+ Versions.IMW_INT_Version), FileServices.ClearSuperFile(sfInterpolMostWantedINT, false)),
		IF(NOT STD.File.FileExists(sfOFAC +'::'+ Versions.OFAC_Version), FileServices.ClearSuperFile(sfOFAC, false)),
		IF(NOT STD.File.FileExists(sfOfacNewPLC +'::'+ Versions.OFAC_PLC_Version), FileServices.ClearSuperFile(sfOfacNewPLC, false)),
		IF(NOT STD.File.FileExists(sfOSFICanadaEntity +'::'+ Versions.OSFI_Ent_Version), FileServices.ClearSuperFile(sfOSFICanadaEntity, false)),
		IF(NOT STD.File.FileExists(sfOSFICanadaIndividuals +'::'+ Versions.OSFI_Ind_Version), FileServices.ClearSuperFile(sfOSFICanadaIndividuals, false)),
		IF(NOT STD.File.FileExists(sfStateDepartmentterrorist +'::'+ Versions.StateDeptForeign_Version), FileServices.ClearSuperFile(sfStateDepartmentterrorist, false)),
		//IF(NOT STD.File.FileExists(sfStateDepartment +'::'+ Versions.StateDeptExcl_Version), FileServices.ClearSuperFile(sfStateDepartment, false)),
		IF(NOT STD.File.FileExists(sfUnverified +'::'+ Versions.Unverified_Version), FileServices.ClearSuperFile(sfUnverified, false)),
		IF(NOT STD.File.FileExists(sfWorldBank +'::'+ Versions.WorldBankDeb_Version), FileServices.ClearSuperFile(sfWorldBank, false)),
	FileServices.FinishSuperFileTransaction( ),
	PARALLEL(
						//------Bank Of England-----//
						IF(NOT STD.File.FileExists(sfBankOfEngland +'::'+ Versions.BankOfEngland_Version)
						,sprayFile('data/bank_of_england', Versions.BankOfEngland_Version + '.' + 'sanctionsconlist.txt', ';', 'bank_of_england::' + Versions.BankOfEngland_Version)
						,OUTPUT('Bank Of Engalnd - Excluded from Spray list')),						

						//------Debarred Parties-----//
						IF(NOT STD.File.FileExists(sfDebarredParties +'::'+ Versions.DebbaredParties_Version)
						,sprayFile('data/debarred_parties', Versions.DebbaredParties_Version + '.' + 'debarred_parties.txt', '\t', 'debarred_parties::' + Versions.DebbaredParties_Version)
						,OUTPUT('Debarred Parties - Excluded from Spray list')),
						
						//------Denied entities and persons-----//
						IF(NOT STD.File.FileExists(sfDeniedEntity +'::'+ Versions.DeniedEntity_Version)				
						,sprayFile('data/denied_entity', Versions.DeniedEntity_Version + '_' + 'text_output_Sheet1.csv', '|', 'denied_entity::' + Versions.DeniedEntity_Version)
						,OUTPUT('Denied entities - Excluded from Spray list')),

						IF(NOT STD.File.FileExists(sfDeniedPersons +'::'+ Versions.DeniedPersons_Version)
						,sprayFile('data/denied_persons', Versions.DeniedPersons_Version + '.' + 'Denied_Persons_List.txt', '\t', 'denied_persons::' + Versions.DeniedPersons_Version)
						,OUTPUT('Denied persons - Excluded from Spray list')),
						
						//------EU terrorist list-----//
						IF(NOT STD.File.FileExists(sfEUterroristPersons +'::'+ Versions.EUTerrorist_Version)
						,sprayFile('data/eu_terrorist_list' + '/' + Versions.EUTerrorist_Version + '_' + 'data', Versions.EUTerrorist_Version + '_' + 'text_output_persons.csv', '|', 'eu_terrorist_list::persons::' + Versions.EUTerrorist_Version)
						,OUTPUT('EU terrorist list Persons - Excluded from Spray list')),

						IF(NOT STD.File.FileExists(sfEUterroristGroups +'::'+ Versions.EUTerrorist_Version)
						,sprayFile('data/eu_terrorist_list' + '/' + Versions.EUTerrorist_Version + '_' + 'data', Versions.EUTerrorist_Version + '_' + 'text_output_Groups.csv', '|', 'eu_terrorist_list::groups::' + Versions.EUTerrorist_Version)
						,OUTPUT('EU terrorist list Groups - Excluded from Spray list')),
						
						//------Foreign Agents registration-----//
						// if(FAR_VERSION <> ''
						// ,sprayFile('foreign_agents_registration' + '/' + FAR_VERSION, 'farareport.txt', '', 'foreign_agents_registration::' + FAR_VERSION)
						// ,OUTPUT('Foreign Agents registration - Excluded from Spray list')), --historical file
						
						IF(NOT STD.File.FileExists(sfForeignAgentsFP +'::'+ Versions.Foreign_Agents_Version)
						,sprayFile('data/foreign_agents_registration' + '/' + Versions.Foreign_Agents_Version, 'active_foreign_principals_for_all_countries_locations__as_of_' + Versions.Foreign_Agents_Version[5..6] + '_' + Versions.Foreign_Agents_Version[7..8] + '_' + Versions.Foreign_Agents_Version[1..4] + '.csv', '', 'foreign_agents_registration::FP::' + Versions.Foreign_Agents_Version)
						,OUTPUT('FAR Active Foreign Principals for all countries - Excluded from Spray list')),
						
						IF(NOT STD.File.FileExists(sfForeignAgentsRE +'::'+ Versions.Foreign_Agents_Version)
						,sprayFile('data/foreign_agents_registration' + '/' + Versions.Foreign_Agents_Version, 'active_registrants_as_of_' + Versions.Foreign_Agents_Version[5..6] + '_' + Versions.Foreign_Agents_Version[7..8] + '_' + Versions.Foreign_Agents_Version[1..4] + '.csv', '', 'foreign_agents_registration::RE::' + Versions.Foreign_Agents_Version)
						,OUTPUT('FAR Active Registrants - Excluded from Spray list')),
						
						IF(NOT STD.File.FileExists(sfForeignAgentsSRE +'::'+ Versions.Foreign_Agents_Version)
						,sprayFile('data/foreign_agents_registration' + '/' + Versions.Foreign_Agents_Version, 'active_short_form_registrants__as_of_' + Versions.Foreign_Agents_Version[5..6] + '_' + Versions.Foreign_Agents_Version[7..8] + '_' + Versions.Foreign_Agents_Version[1..4] + '.csv', '', 'foreign_agents_registration::SRE::' + Versions.Foreign_Agents_Version)
						,OUTPUT('FAR Active Short Form Registrants - Excluded from Spray list')),
						
						//------OFAC Enhanced from Innovative-----//
						IF(NOT STD.File.FileExists(sfInnovativeSystemsCFT +'::'+ Versions.InnovativeCFT_Version)
						,sprayFile('data/innovative_systems' + '/' + Versions.InnovativeCFT_Version + '_' + 'data', Versions.InnovativeCFT_Version + '.' + 'CFT_825_parsed_orig.dat', '', 'innovative_systems::CFT::' + Versions.InnovativeCFT_Version, 15680)
						,OUTPUT('Innovative Systems CFT - Excluded from Spray list')),

						IF(NOT STD.File.FileExists(sfInnovativeSystemsFBI +'::'+ Versions.InnovativeFBI_Version)
						,sprayFile('data/innovative_systems' + '/' + Versions.InnovativeFBI_Version + '_' + 'data', Versions.InnovativeFBI_Version + '.' + 'FBI_825_parsed_orig.dat', '', 'innovative_systems::FBI::' + Versions.InnovativeFBI_Version, 15680)
						,OUTPUT('Innovative Systems FBI- Excluded from Spray list')),
						
						// IF(NOT STD.File.FileExists(sfInnovativeSystemsOCC +'::'+ Versions.InnovativeOCC_Version)
						// ,sprayFile('data/innovative_systems' + '/' + Versions.InnovativeOCC_Version + '_' + 'data', Versions.InnovativeOCC_Version + '.' + 'OCC_825_parsed_orig.dat', '', 'innovative_systems::OCC::' + Versions.InnovativeOCC_Version, 15680)
						// ,OUTPUT('Innovative Systems OCC - Excluded from Spray list')), --historical file
						
						IF(NOT STD.File.FileExists(sfInnovativeSystemsOSC +'::'+ Versions.InnovativeOSC_Version)
						,sprayFile('data/innovative_systems' + '/' + Versions.InnovativeOSC_Version + '_' + 'data', Versions.InnovativeOSC_Version + '.' + 'OSC_825_parsed_orig.dat', '', 'innovative_systems::OSC::' + Versions.InnovativeOSC_Version, 15680)
						,OUTPUT('Innovative Systems OSC - Excluded from Spray list')),
						
						IF(NOT STD.File.FileExists(sfInnovativeSystemsPEP +'::'+ Versions.InnovativePEP_Version)
						,sprayFile('data/innovative_systems' + '/' + Versions.InnovativePEP_Version + '_' + 'data', Versions.InnovativePEP_Version + '.' + 'PEP_825_parsed_orig.dat', '', 'innovative_systems::PEP::' + Versions.InnovativePEP_Version, 15680)
						,OUTPUT('Innovative Systems PEP - Excluded from Spray list')),

						IF(NOT STD.File.FileExists(sfInnovativeSystemsUNS +'::'+ Versions.InnovativeUNS_Version)
						,sprayFile('data/innovative_systems' + '/' + Versions.InnovativeUNS_Version + '_' + 'data', Versions.InnovativeUNS_Version + '.' + 'UNS_825_parsed_orig.dat', '', 'innovative_systems::UNS::' + Versions.InnovativeUNS_Version, 15680)
						,OUTPUT('Innovative Systems UNS - Excluded from Spray list')),
						
						//------Interpol Most wanted-----//
						IF(NOT STD.File.FileExists(sfInterpolMostWanted +'::'+ Versions.IMW_Version)
						,sprayFile('data/interpol_most_wanted' + '/' + Versions.IMW_Version + '_' + 'data', 'interpol.txt', '', 'interpol_most_wanted::' + Versions.IMW_Version)
						,OUTPUT('Interpol Most Wanted - Excluded from Spray list')),
						
						//------Interpol Most wanted(INT) - Red Notice-----//
						IF(NOT STD.File.FileExists(sfInterpolMostWantedINT +'::'+ Versions.IMW_INT_Version)
						,sprayFile('data/innovative_systems' + '/' + Versions.IMW_INT_Version + '_' + 'data', Versions.IMW_INT_Version + '.' + 'INT_825_parsed_orig.dat', '', 'interpol_most_wanted::INT::' + Versions.IMW_INT_Version, 15680)
						,OUTPUT('Interpol Most Wanted(INT) - Excluded from Spray list')),
						
						//------OFAC-----//
						IF(NOT STD.File.FileExists(sfOFAC +'::'+ Versions.OFAC_Version)
						,sprayFile('ofac' + '/' + 'weekly_files' + '/', Versions.OFAC_Version +'.'+'sdn.out', '', 'ofac::' + Versions.OFAC_Version)
						,OUTPUT('OFAC SDN - Excluded from Spray list')),
						
						//------OFAC PLC data-----//
						IF(NOT STD.File.FileExists(sfOfacNewPLC +'::'+ Versions.OFAC_PLC_Version)
						,sprayFile('ofac' + '/' + 'weekly_files' + '/', Versions.OFAC_PLC_Version +'.'+'nsp.out', '', 'ofac::new_plc::' + Versions.OFAC_PLC_Version)
						,OUTPUT('PLC NSP - Excluded from Spray list')),
						
						//------OSFI Canada-----//
						IF(NOT STD.File.FileExists(sfOSFICanadaEntity +'::'+ Versions.OSFI_Ent_Version)
						,sprayFile('data/osfi_canada', Versions.OSFI_Ent_Version + '.' + 'entstld_e.txt', '', 'osfi_canada::entities::' + Versions.OSFI_Ent_Version)
						,OUTPUT('OSFI Canada entities - Excluded from Spray list')),

						IF(NOT STD.File.FileExists(sfOSFICanadaIndividuals +'::'+ Versions.OSFI_Ind_Version)
						,sprayFile('data/osfi_canada', Versions.OSFI_Ind_Version + '.' + 'indstld_e.txt', '', 'osfi_canada::individuals::' + Versions.OSFI_Ind_Version)
						,OUTPUT('OSFI Canada individuals - Excluded from Spray list')),						
												
						//------State Department foreign terrorists-----//
						IF(NOT STD.File.FileExists(sfStateDepartmentterrorist +'::'+ Versions.StateDeptForeign_Version)
						,sprayFile('data/state_department' + '/' + Versions.StateDeptForeign_Version + '_' + 'data', Versions.StateDeptForeign_Version + '.' + 'foreign_terrorists.csv', '|', 'state_department_terrorist::' + Versions.StateDeptForeign_Version)
						,OUTPUT('State Department terrorists - Excluded from Spray list')),
						
						//------State Department Terrorist Exclusion-----//
						// IF(NOT STD.File.FileExists(sfStateDepartment +'::'+ Versions.StateDeptExcl_Version)
						// ,sprayFile('data/state_department' + '/' + Versions.StateDeptExcl_Version + '_' + 'data', Versions.StateDeptExcl_Version + '.' + 'terrorists.csv', '|', 'state_department::' + Versions.StateDeptExcl_Version)
						// ,OUTPUT('State Department Terrorist Exclusions - Excluded from Spray list')), -- historical file
						
						//------Unverified-----//
						IF(NOT STD.File.FileExists(sfUnverified +'::'+ Versions.Unverified_Version)
						,sprayFile('data/unverified', Versions.Unverified_Version + '.' + 'unverified.txt', '\t', 'unverified::' + Versions.Unverified_Version)
						,OUTPUT('Unverified - Excluded from Spray list')),
						
						//------World Bank-----// ??????
						IF(NOT STD.File.FileExists(sfWorldBank +'::'+ Versions.WorldBankDeb_Version)
						,sprayFile('data/world_bank', Versions.WorldBankDeb_Version + '.' + 'Worldbank_Debarred_Firms.txt', '\t', 'world_bank::' + Versions.WorldBankDeb_Version)
						,OUTPUT('World Bank - Excluded from Spray list')),
						
						//-----Lookup Tables(ofac sanction codes, country codes)-----//
						std.File.SprayVariable(_control.IPAddress.edata12,
														'/data_999/sanctions/data/ofac/ofac_sanction_programs.srt',
														8192,,,,
														'thor50_dev',
														root + 'ofac_sanctions_lookup',
														,,,true,false,false
													),
						std.File.SprayFixed(_control.IPAddress.edata12,
														'/export/home/abinitio/lib/iso_country_code_2.srt',
														164,'thor50_dev',
														root + 'county_code_lookup',
														,,,true,false,false);						
	),
	FileServices.StartSuperFileTransaction( ),
			IF(STD.File.FileExists(sfBankOfEngland +'::'+ Versions.BankOfEngland_Version) and STD.File.GetSuperFileSubCount(sfBankOfEngland) = 0,
				FileServices.AddSuperFile(sfBankOfEngland, root + 'bank_of_england::' + Versions.BankOfEngland_Version), OUTPUT('Bank Of England - New file not found')
			),
			IF(STD.File.FileExists(sfDebarredParties +'::'+ Versions.DebbaredParties_Version) and STD.File.GetSuperFileSubCount(sfDebarredParties) = 0,
				FileServices.AddSuperFile(sfDebarredParties, root + 'debarred_parties::' + Versions.DebbaredParties_Version), OUTPUT('Debarred parties - New file not found')
			),
			IF(STD.File.FileExists(sfDeniedEntity +'::'+ Versions.DeniedEntity_Version) and STD.File.GetSuperFileSubCount(sfDeniedEntity) = 0,
				FileServices.AddSuperFile(sfDeniedEntity, root + 'denied_entity::' + Versions.DeniedEntity_Version), OUTPUT('Denied Entity List - New file not found')
			),
			IF(STD.File.FileExists(sfDeniedPersons +'::'+ Versions.DeniedPersons_Version) and STD.File.GetSuperFileSubCount(sfDeniedPersons) = 0,
				FileServices.AddSuperFile(sfDeniedPersons, root + 'denied_persons::' + Versions.DeniedPersons_Version), OUTPUT('Denied Persons List- New file not found')
			),
			IF(STD.File.FileExists(sfEUterroristPersons +'::'+ Versions.EUTerrorist_Version) and STD.File.GetSuperFileSubCount(sfEUterroristPersons) = 0,
				FileServices.AddSuperFile(sfEUterroristPersons, root + 'eu_terrorist_list::persons::' + Versions.EUTerrorist_Version), OUTPUT('EU terrorist persons - New file not found')
			),
			IF(STD.File.FileExists(sfEUterroristGroups +'::'+ Versions.EUTerrorist_Version) and STD.File.GetSuperFileSubCount(sfEUterroristGroups) = 0,
				FileServices.AddSuperFile(sfEUterroristGroups, root + 'eu_terrorist_list::groups::' + Versions.EUTerrorist_Version), OUTPUT('EU terrorist groups - New file not found')
			),
			// if(FAR_VERSION <> '',
				// FileServices.AddSuperFile(sfForeignAgentsRegistration, root + 'foreign_agents_registration::' + FAR_VERSION), OUTPUT('Foreign Agents Registration - Excluded from Spray list')
			// ),
			IF(STD.File.FileExists(sfForeignAgentsFP +'::'+ Versions.Foreign_Agents_Version) and STD.File.GetSuperFileSubCount(sfForeignAgentsFP) = 0,
				FileServices.AddSuperFile(sfForeignAgentsFP, root + 'foreign_agents_registration::FP::' + Versions.Foreign_Agents_Version), OUTPUT('FAR Active Foreign Principals for all countries - New file not found')
			),
			IF(STD.File.FileExists(sfForeignAgentsRE +'::'+ Versions.Foreign_Agents_Version) and STD.File.GetSuperFileSubCount(sfForeignAgentsRE) = 0,
				FileServices.AddSuperFile(sfForeignAgentsRE, root + 'foreign_agents_registration::RE::' + Versions.Foreign_Agents_Version), OUTPUT('FAR Active Registrants - New file not found')
			),
			IF(STD.File.FileExists(sfForeignAgentsSRE +'::'+ Versions.Foreign_Agents_Version) and STD.File.GetSuperFileSubCount(sfForeignAgentsSRE) = 0,
				FileServices.AddSuperFile(sfForeignAgentsSRE, root + 'foreign_agents_registration::SRE::' + Versions.Foreign_Agents_Version), OUTPUT('FAR Active Short Form Registrants - New file not found')
			),
			IF(STD.File.FileExists(sfInnovativeSystemsCFT +'::'+ Versions.InnovativeCFT_Version) and STD.File.GetSuperFileSubCount(sfInnovativeSystemsCFT) = 0,
				FileServices.AddSuperFile(sfInnovativeSystemsCFT, root + 'innovative_systems::CFT::' + Versions.InnovativeCFT_Version), OUTPUT('Innovative Systems CFT - New file not found')
			),
			IF(STD.File.FileExists(sfInnovativeSystemsFBI +'::'+ Versions.InnovativeFBI_Version) and STD.File.GetSuperFileSubCount(sfInnovativeSystemsFBI) = 0,
				FileServices.AddSuperFile(sfInnovativeSystemsFBI, root + 'innovative_systems::FBI::' + Versions.InnovativeFBI_Version), OUTPUT('Innovative Systems FBI - New file not found')
			),
			// IF(STD.File.FileExists(sfInnovativeSystemsOCC +'::'+ Versions.InnovativeOCC_Version) and STD.File.GetSuperFileSubCount(sfInnovativeSystemsOCC) = 0,
				// FileServices.AddSuperFile(sfInnovativeSystemsOCC, root + 'innovative_systems::OCC::' + Versions.InnovativeOCC_Version), OUTPUT('Innovative Systems OCC - New file not found')
			// ),
			IF(STD.File.FileExists(sfInnovativeSystemsOSC +'::'+ Versions.InnovativeOSC_Version) and STD.File.GetSuperFileSubCount(sfInnovativeSystemsOSC) = 0,
				FileServices.AddSuperFile(sfInnovativeSystemsOSC, root + 'innovative_systems::OSC::' + Versions.InnovativeOSC_Version), OUTPUT('Innovative Systems OSC - New file not found')
			),
			IF(STD.File.FileExists(sfInnovativeSystemsPEP +'::'+ Versions.InnovativePEP_Version) and STD.File.GetSuperFileSubCount(sfInnovativeSystemsPEP) = 0,
				FileServices.AddSuperFile(sfInnovativeSystemsPEP, root + 'innovative_systems::PEP::' + Versions.InnovativePEP_Version), OUTPUT('Innovative Systems PEP - New file not found')
			),
			IF(STD.File.FileExists(sfInnovativeSystemsUNS +'::'+ Versions.InnovativeUNS_Version) and STD.File.GetSuperFileSubCount(sfInnovativeSystemsUNS) = 0,
				FileServices.AddSuperFile(sfInnovativeSystemsUNS, root + 'innovative_systems::UNS::' + Versions.InnovativeUNS_Version), OUTPUT('Innovative Systems UNS - New file not found')
			),
			IF(STD.File.FileExists(sfInterpolMostWanted +'::'+ Versions.IMW_Version) and STD.File.GetSuperFileSubCount(sfInterpolMostWanted) = 0,
				FileServices.AddSuperFile(sfInterpolMostWanted, root + 'interpol_most_wanted::' + Versions.IMW_Version), OUTPUT('Interpol Most Wanted - New file not found')
			),
			IF(STD.File.FileExists(sfInterpolMostWantedINT +'::'+ Versions.IMW_INT_Version) and STD.File.GetSuperFileSubCount(sfInterpolMostWantedINT) = 0,
				FileServices.AddSuperFile(sfInterpolMostWantedINT, root + 'interpol_most_wanted::INT::' + Versions.IMW_INT_Version), OUTPUT('Interpol Most Wanted(INT) - New file not found')
			),
			IF(STD.File.FileExists(sfOFAC +'::'+ Versions.OFAC_Version) and STD.File.GetSuperFileSubCount(sfOFAC) = 0,
				FileServices.AddSuperFile(sfOFAC, root + 'ofac::' + Versions.OFAC_Version), OUTPUT('OFAC SDN - New file not found')
			),
			IF(STD.File.FileExists(sfOfacNewPLC +'::'+ Versions.OFAC_PLC_Version) and STD.File.GetSuperFileSubCount(sfOfacNewPLC) = 0,
				FileServices.AddSuperFile(sfOfacNewPLC, root + 'ofac::new_plc::' + Versions.OFAC_PLC_Version), OUTPUT('OFAC NSP - New file not found')
			),	
			IF(STD.File.FileExists(sfOSFICanadaEntity +'::'+ Versions.OSFI_Ent_Version) and STD.File.GetSuperFileSubCount(sfOSFICanadaEntity) = 0,
				FileServices.AddSuperFile(sfOSFICanadaEntity, root + 'osfi_canada::entities::' + Versions.OSFI_Ent_Version), OUTPUT('OSFI Canada Entities - New file not found')
			),
			IF(STD.File.FileExists(sfOSFICanadaIndividuals +'::'+ Versions.OSFI_Ind_Version) and STD.File.GetSuperFileSubCount(sfOSFICanadaIndividuals) = 0,
				FileServices.AddSuperFile(sfOSFICanadaIndividuals, root + 'osfi_canada::individuals::' + Versions.OSFI_Ind_Version), OUTPUT('OSFI Canada Individuals - New file not found')
			),		
			IF(STD.File.FileExists(sfStateDepartmentterrorist +'::'+ Versions.StateDeptForeign_Version) and STD.File.GetSuperFileSubCount(sfStateDepartmentterrorist) = 0,
				FileServices.AddSuperFile(sfStateDepartmentterrorist, root + 'state_department_terrorist::' + Versions.StateDeptForeign_Version), OUTPUT('State Department terrorists - New file not found')
			),
			// IF(STD.File.FileExists(sfStateDepartment +'::'+ Versions.StateDeptExcl_Version) and STD.File.GetSuperFileSubCount(sfStateDepartment) = 0,
				// FileServices.AddSuperFile(sfStateDepartment, root + 'state_department_terrorist_exclusion::' + Versions.StateDeptExcl_Version), OUTPUT('State Department Terrorist Exclusion - New file not found')
			// ),
			IF(STD.File.FileExists(sfUnverified +'::'+ Versions.Unverified_Version) and STD.File.GetSuperFileSubCount(sfUnverified) = 0,
				FileServices.AddSuperFile(sfUnverified, root + 'unverified::' + Versions.Unverified_Version), OUTPUT('Unverified - New file not found')
			),
			IF(STD.File.FileExists(sfWorldBank +'::'+ Versions.WorldBankDeb_Version) and STD.File.GetSuperFileSubCount(sfWorldBank) = 0,
				FileServices.AddSuperFile(sfWorldBank, root + 'world_bank::' + Versions.WorldBankDeb_Version), OUTPUT('World Bank - New file not found')
			),
	FileServices.FinishSuperFileTransaction( )
);