EXPORT Proc_FullbuildDelta(STRING versionIn ) := FUNCTION
  
	//Corrections went since last Boca full build Roxie Version 
 	
	Corrections         := Files.IncBaseAll_Current_DS(RecChangeType <> Constants.RecordChangeType.New AND DT_EFFECTIVE_LAST = 0 AND ((STRING)buildDateTimeStamp)[1..8] >= (STRING)Build_Date.BocaDops);

	// New records since last Boca full build Roxie Version 
 
	New_Records         := Files.IncBaseAll_Current_DS(RecChangeType = Constants.RecordChangeType.New AND ((STRING)buildDateTimeStamp)[1..8] >=(STRING)Build_Date.BocaDops);
  
	mod_fullbuilddelta  := FullbuildDelta(Corrections, New_Records, versionIn);
	
	dsNewAsHeader       := mod_fullbuilddelta.Asheader;
	dsNewbase           := mod_fullbuilddelta.Incbase;

		// output result to logical file and promote to superfile
	
	outLogicalFile 	     := Filenames.AsHeader_LF(versionIn, WORKUNIT);
	outputFile 			     := OUTPUT(dsNewAsHeader,, outLogicalFile, COMPRESSED);
	promoteSF  			     := Superfiles.updateSF(outLogicalFile, Filenames.AsHeader_SF);
	
			// Incremental base with all as header logical files 
	// Add build date to so that delta file can filter records according to the ingest date from full file 
	
	Delta                := PROJECT (dsNewAsHeader , TRANSFORM(Layout_Header_Delta,  SELF.BuildDate := (UNSIGNED)versionIn ,SELF := LEFT )); 
	outLogicalAllFile 	 := Filenames.AsHeaderAll_LF(versionIn, WORKUNIT);
	outputAllFile 			 := OUTPUT(Delta,, outLogicalAllFile, COMPRESSED);
	UpdateSFAsHeaderAll  := Superfiles.AddSuper(Filenames.AsHeaderAll_SF.Current, outLogicalAllFile); 	
		
		// new incremental base
	filenameNewBase 		 := Filenames.IncBase_LF(versionIn, WORKUNIT);
	outNewBase 					 := OUTPUT(dsNewbase,, filenameNewBase, COMPRESSED);
	updateSFNewBase 		 := Superfiles.updateSF(filenameNewBase, Filenames.IncBase_SF);
	
	// Incremental base with all newbase logical files temporary will be archived once the build stable 
	
	outLogicalAllFile0 	  := Filenames.IncBaseAll_LF(versionIn, WORKUNIT);
	outNewBaseAll 			  := OUTPUT(dsNewbase,, outLogicalAllFile0, COMPRESSED);
	UpdateSFNewBaseAll    := Superfiles.AddSuper(Filenames.IncBaseAll_SF.Current, outLogicalAllFile0); 
		
  sequentialSteps := SEQUENTIAL(PARALLEL(outputFile, outputAllFile, outNewBase,outNewBaseAll),
	                              STD.File.StartSuperFileTransaction(),
																PARALLEL(promoteSF,UpdateSFAsHeaderAll,updateSFNewBase,UpdateSFNewBaseAll),
																STD.File.FinishSuperFileTransaction()																
																); 
																
RETURN 	IF(IncBuildRunningCheck, 
            WAIT(Constants.XlinkIncBuildEventName) , sequentialSteps)  ; 
															
END; 
