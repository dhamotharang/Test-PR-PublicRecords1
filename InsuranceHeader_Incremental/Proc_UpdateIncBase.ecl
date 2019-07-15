EXPORT Proc_UpdateIncBase(STRING versionIn) := FUNCTION

	useDateTimeStamp := CurrentDateTimeStamp : INDEPENDENT;
	
	// current SALT output file, projected to include  RecChangeType
	
	dsSALTOutput0 := PROJECT(Files.SALT_Output_Current_DS, TRANSFORM(Layout_Header_Plus , SELF := LEFT , SELF.RecChangeType := 6 ));
	
	//Correction Suppression records 
	
	dsLinkChange := Files.AsHeader_Current_DS(RecChangeType <> Constants.RecordChangeType.New);

 // Updates to existing entities 
 
 dsExistingRecords0 := Files.AsHeaderExisting_Current_DS ; 
 
 // Remove corrections from updates 
 
 dsExistingRecords := JOIN (dsExistingRecords0 , dsLinkChange , LEFT.did = RIGHT.did , TRANSFORM (RECORDOF(dsExistingRecords0) ,
                             SELF := LEFT) ,LEFT ONLY, HASH );
 
 // Remove updated RID's from new entities  
 
 dsSALTOutput  := JOIN ( dsExistingRecords , dsSALTOutput0 , LEFT.RID = RIGHT.RID , 
                           TRANSFORM (Layout_Header_Plus , SELF := RIGHT), RIGHT ONLY, HASH) ; 
 
	mod_updateIncBase := UpdateIncBase(dsLinkChange, dsSALTOutput, dsExistingRecords,  versionIn, useDateTimeStamp);
	
	// new incremental base
	filenameNewBase 		:= Filenames.IncBase_LF(versionIn, WORKUNIT);
	outNewBase 					  := OUTPUT(mod_updateIncBase.NewBase,, filenameNewBase, COMPRESSED);
	updateSFNewBase 		:= Superfiles.updateSF(filenameNewBase, Filenames.IncBase_SF);
	
	// Incremental base with all newbase logical files temporary will be archived once the build stable 
	
	outLogicalAllFile 	  := Filenames.IncBaseAll_LF(versionIn, WORKUNIT);
	outNewBaseAll 			    := OUTPUT(mod_updateIncBase.NewBase,, outLogicalAllFile, COMPRESSED);
	UpdateSFNewBaseAll   := Superfiles.AddSuper(Filenames.IncBaseAll_SF.Current, outLogicalAllFile); 
	
	// stats
	filenameStats       := Filenames.StatsIncBase_LF(versionIn, WORKUNIT);
	outStats 						     := OUTPUT(Files.StatsIncBase_Current_DS & mod_updateIncBase.Stats,, filenameStats, THOR);
	updateSFStats 			   := Superfiles.updateSF(filenameStats, Filenames.StatsIncBase_SF);
	
	RETURN SEQUENTIAL(PARALLEL(outNewBase, outNewBaseAll,outStats),
	                  STD.File.StartSuperFileTransaction(),
										updateSFNewBase,
										UpdateSFNewBaseAll,
										updateSFStats,
										STD.File.FinishSuperFileTransaction()); 
	
END;