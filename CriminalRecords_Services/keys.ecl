import doxie_files, Criminal_Records;

export keys := module
	// direct search keys
	export k_offender_sdid			:= doxie_files.Key_Offenders;
	export k_offender_docnum		:= doxie_files.Key_offenders_docnum;
	
	// report-generation keys
	export k_offender_ofk				:= doxie_files.Key_Offenders_OffenderKey;
	export k_activity_ok				:= doxie_files.Key_Activity;
	export k_punishment_ok			:= doxie_files.Key_Punishment;
	export k_offenses_ok				:= doxie_files.Key_Offenses;
	export k_courtOffenses_ofk	:= doxie_files.Key_Court_Offenses;

	// key availability tests
	export testkeys := macro
		output(CriminalRecords_Services.keys.k_offender_sdid,			named('k_offender_sdid'));
		output(CriminalRecords_Services.keys.k_offender_docnum,		named('k_offender_docnum'));
		output(CriminalRecords_Services.keys.k_offender_ofk,			named('k_offender_ofk'));
		output(CriminalRecords_Services.keys.k_activity_ok,				named('k_activity_ok'));
		output(CriminalRecords_Services.keys.k_punishment_ok,			named('k_punishment_ok'));
		output(CriminalRecords_Services.keys.k_offenses_ok,				named('k_offenses_ok'));
		output(CriminalRecords_Services.keys.k_courtOffenses_ofk,	named('k_courtOffenses_ofk'));
		output(Criminal_Records.Key_Payload,											named('k_auto')); // for testing only
	endmacro;
end;