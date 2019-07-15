IMPORT STD;
EXPORT Proc_NewOnlyBase(STRING versionIn, BOOLEAN createSALTInput = TRUE) := FUNCTION

	dsNewBase := Files.AsHeader_Current_DS;
	
	nowDateTime := CurrentDateTimeStamp : INDEPENDENT;
	mod_NewOnlyBase := NewOnlyBase(dsNewBase, versionIn, nowDateTime);
	dsNewOnlyEntities := mod_NewOnlyBase.OutData;
	dsNewOnlyStats    := mod_NewOnlyBase.Stats;
	outStats := Files.StatsNewOnly_Current_DS & dsNewOnlyStats;
	
	// output result to logical file and promote to superfile
	outLogicalFileNewOnly 	:= Filenames.AsHeaderNewOnly_LF(versionIn, WORKUNIT);
	outputFileNewOnly 			:= OUTPUT(dsNewOnlyEntities,, outLogicalFileNewOnly, COMPRESSED);
	promoteSFNewOnly  			:= Superfiles.updateSF(outLogicalFileNewOnly, Filenames.AsHeaderNewOnly_SF);
	
	// SALT input logical/super files
	outLogicalFileSALTInput 	:= Filenames.SALT_Input_LF(versionIn, WORKUNIT, '0');
	outputFileSALTInput  			:= OUTPUT(PROJECT(dsNewOnlyEntities, Layout_Header),, outLogicalFileSALTInput, COMPRESSED);
	promoteSFSALTInput   			:= Superfiles.updateSF(outLogicalFileSALTInput, Filenames.SALT_Input_SF);
	
	// stats logical/super files
	outLogicalFileStats      := Filenames.StatsNewOnly_LF(versionIn, WORKUNIT);
	outputFileStats          := OUTPUT(outStats,, outLogicalFileStats, COMPRESSED);
	promoteSFStats           := Superfiles.updateSF(outLogicalFileStats, Filenames.StatsNewOnly_SF);
	
	sequentialSteps := SEQUENTIAL(PARALLEL(outputFileNewOnly, outputFileStats, IF(createSALTInput, outputFileSALTInput)),
	                              STD.File.StartSuperFileTransaction(),
																PARALLEL(promoteSFNewOnly, promoteSFStats, IF(createSALTInput, promoteSFSALTInput)),
																STD.File.FinishSuperFileTransaction()); 
	RETURN sequentialSteps;
	
END;
