import tools,FraudShared;

export Create_Supers := sequential(
	tools.mod_Utilities.createallsupers(
		filenames().Input.dAll_filenames +
		FraudShared.filenames().Input.dAll_filenames,
		filenames().dAll_filenames +
		keynames().dAll_filenames +
		FraudShared.filenames().dAll_filenames +
		FraudShared.keynames().dAll_filenames
		),		
		// Input Files
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'in::passed::knownfraud'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'in::passed::identitydata'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'in::passed::deltabase'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'in::passed::nac'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'in::passed::inquirylogs'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'in::rejected::knownfraud'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'in::rejected::identitydata'),	
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'in::rejected::deltabase'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'in::rejected::nac'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'in::rejected::inquirylogs'),	
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'in::delete::knownfraud'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'in::delete::identitydata'),	
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'in::delete::deltabase'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'in::delete::nac'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'in::delete::inquirylogs'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'in::sprayed::mbsinclusiondemodata'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'in::sprayed::demodata'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'in::sprayed::sourcestoanonymize'),
		//Output Files
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'flags::NewHeader_flag'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'flags::NewHeader_flag_father'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'flags::RefreshAddresses_flag'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'flags::RefreshAddresses_flag_father'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'flags::NewFraudgov_flag'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'flags::NewFraudgov_flag_father'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'flags::SkipModules_flag'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'flags::SkipModules_flag_father'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'flags::SkipValidationByGCID_flag'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'flags::SkipValidationByGCID_flag_father'),		
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'out::Scrubs_FraudGov::CCID'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'out::Scrubs_FraudGov::ColvalDesc'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'out::Scrubs_FraudGov::HHID'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'out::Scrubs_FraudGov::IndType'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'out::Scrubs_FraudGov::IndTypeExclusion'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'out::Scrubs_FraudGov::MarketAppend'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'out::Scrubs_FraudGov::MasterIdIndTypeIncl'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'out::Scrubs_FraudGov::MBS'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'out::Scrubs_FraudGov::NewGcIdExcl'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'out::Scrubs_FraudGov::ProductInclude'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'out::Scrubs_FraudGov::SourceGcExclusion'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'out::Scrubs_FraudGov::TableCol'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'out::Scrubs_FraudGov::InquiryLogs'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'out::Scrubs_FraudGov::NAC'),
		tools.mod_Utilities.createsuper(_Dataset().thor_cluster_Files + 'out::Scrubs_FraudGov::Log'));
	

