IMPORT InsuranceHeader;
EXPORT Filenames := MODULE
	// prefixes
	EXPORT Prefix_Base							:= '~thor_data400::base::insuranceheader::';
	EXPORT Prefix_Temp							:= '~thor_data400::temp::insuranceheader::';
	EXPORT Prefix_Base_Archive		  := Prefix_Base + 'base_archive::';
	EXPORT Prefix_Boca_blankrid		  := Prefix_Base + 'base_blank_rid::';
	EXPORT Prefix_AsHeaderAll				:= Prefix_Base + 'as_header_all::';
	EXPORT Prefix_StatsIngest				:= Prefix_Base + 'stats_ingest::';
	
	// superfile names
	EXPORT Base_Archive_SF		  := InsuranceHeader.mod_FileNames(Prefix_Base_Archive);
	EXPORT AsHeaderAll_SF				:= InsuranceHeader.mod_FileNames(Prefix_AsHeaderAll);
	EXPORT Bocablankrid_SF      := InsuranceHeader.mod_FileNames(Prefix_Boca_blankrid);
	EXPORT StatsIngest_SF				:= InsuranceHeader.mod_FileNames(Prefix_StatsIngest);
	
	// logical file names
	EXPORT Base_Archive_LF(STRING version, STRING wu)					:= InsuranceHeader.mod_FileNames(Prefix_Base_Archive).logical(version, wu);
	EXPORT AsHeaderAll_LF(STRING version, STRING wu)					:= InsuranceHeader.mod_FileNames(Prefix_AsHeaderAll).logical(version, wu);
	EXPORT StatsIngest_LF(STRING version, STRING wu)					:= InsuranceHeader.mod_FileNames(Prefix_StatsIngest).logical(version, wu);
	EXPORT Bocablankrid_LF(STRING version, STRING wu)					:= InsuranceHeader.mod_FileNames(Prefix_Boca_blankrid).logical(version, wu);

	
	// persist files
	EXPORT Persist_IngestInput := Prefix_Temp + 'Ingestinput';
	EXPORT Persist_DidChangeAll := Prefix_Temp + 'DidChangeAll0';
	

END;
