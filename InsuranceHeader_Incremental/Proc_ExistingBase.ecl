IMPORT STD;

EXPORT Proc_ExistingBase(STRING VersionIn) := FUNCTION

	dsNewBase := Files.AsHeader_Current_DS;
	
	nowDateTime        := CurrentDateTimeStamp : INDEPENDENT;
	mod_ExistingBase   := ExistingBase(dsNewBase, versionIn, nowDateTime);
	dsExistingEntities := mod_ExistingBase.OutData;
	
	// output result to logical file and promote to superfile
	
	outLogicalFileExisting 	:= Filenames.AsHeaderExisting_LF(versionIn, WORKUNIT);
	outputFileExisting 			  := OUTPUT(dsExistingEntities,, outLogicalFileExisting, COMPRESSED);
	promoteSFExisting  			  := Superfiles.updateSF(outLogicalFileExisting, Filenames.AsHeaderExisting_SF);
	
	SequentialSteps := SEQUENTIAL(outputFileExisting, 
	                              STD.File.StartSuperFileTransaction(),
																               promoteSFExisting,
																               STD.File.FinishSuperFileTransaction()); 
	RETURN SequentialSteps;
	
END;
