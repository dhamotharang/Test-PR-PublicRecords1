IMPORT IDL_Header,InsuranceHeader_PreProcess , InsuranceHeader_Ingest,InsuranceHeader_Incremental,InsuranceHeader_Salt_T46;
#WORKUNIT('name','InsuranceHeader ingest');
// INCREMENTAL => FEEDS RAW INCREMENTAL INGEST FILES 
// FULLINC => FULL INGEST RECORDS FEEDS INTO INCREMENTAL 
// For fullinc we do full build ingest first and feed new records from full ingest to incremental ingest along with correction/suppression output 

EXPORT Proc_Ingest(STRING versionIn , BOOLEAN FullInc = FALSE) := FUNCTION
	
	// dsbase equals to IDL_Header.Files.DS_IDL_POLICY_HEADER_BASE, when latest postprocess running it equals to father file
	
	ds              := InsuranceHeader_Incremental.Files.dsBase; 

// As header all base for ingest 
	dsDelta 			  := PROJECT(Files.AsHeaderAll_Current_DS(BuildDate >= (UNSIGNED)InsuranceHeader_Incremental.Build_Date.AlphaKeyFull) , TRANSFORM(Layout_Base ,
	                              SELF.src_orig := LEFT.src ; 
																SELF.src := MAP(LEFT.src[1..3] = 'IVS' => 'IVS', 
																                 LEFT.src[1..3] = 'ICA' => 'ICA',
																								 LEFT.src[1..3] = 'ICP' => 'ICP' , LEFT.src);													 
																SELF := LEFT)); 
																
	dsFullNonBlankBase  := In_Base;			
	dsBoca          := Files.RawAsHeader_Boca_Current_DS; 
	dsBocaNonBlank  := dsBoca(not(fname = '' and lname = ''and prim_name = '' and city_name = ''));
	
	// apply suppression to input data 	
	
	Suppress_DS  := InsuranceHeader_Salt_T46.ManualSuppression.data_file;
	
	Inds         := InsuranceHeader_Ingest.Add_Update_BocaData(dsBocaNonBlank).getRecords +
                 InsuranceHeader_Ingest.Add_Update_InsuranceData(ds).getRecords  ; 
	
	dsInputsuppressed := JOIN(Inds,
														 Suppress_DS,
														 LEFT.ssn         = RIGHT.ssn and
														 LEFT.dob         = RIGHT.dob and
														 LEFT.dl_nbr      = RIGHT.dl_nbr and
														 LEFT.dl_state    = RIGHT.dl_state and
														 LEFT.fname       = RIGHT.fname and
														 LEFT.mname       = RIGHT.mname and
														 LEFT.lname       = RIGHT.lname and
														 LEFT.sname       = RIGHT.sname and
														 LEFT.gender      = RIGHT.gender and
														 LEFT.prim_range  = RIGHT.prim_range and
														 LEFT.predir      = RIGHT.predir and
														 LEFT.prim_name   = RIGHT.prim_name and
														 LEFT.addr_suffix = RIGHT.addr_suffix and
														 LEFT.postdir     = RIGHT.postdir and
														 LEFT.sec_range   = RIGHT.sec_range and
														 LEFT.city        = RIGHT.city and
														 LEFT.st          = RIGHT.st and
														 LEFT.zip         = RIGHT.zip,
														 TRANSFORM(Layout_Base, SELF:=LEFT) ,LEFT ONLY , LOOKUP):INDEPENDENT;
														 
	dsIngest   		  := IF (FullInc , 	
										 LinkCorrection.ridLatest + 
										 RemoveRecord.ridLatest ,										 
										 dsInputsuppressed +
										 LinkCorrection.ridLatest + 
										 RemoveRecord.ridLatest ):PERSIST(Filenames.Persist_IngestInput, EXPIRE(30));							 
														
	Mod_Ingest      := InsuranceHeader_Ingest.Ingest(TRUE,dsDelta,dsFullNonBlankBase,dsIngest);
	
	dsBasePlusIngest 	   := mod_Ingest.AllRecords;
	IngestInputStats	   := mod_Ingest.InputSourceCounts;
	IngestUpdateStats    := mod_Ingest.UpdateStatsSrc;
	
		// Assign __type and add blank records 
	dsBaseType  := PROJECT(dsBasePlusIngest,
															TRANSFORM(Layout_Header_Plus,
															SELF.SRC := LEFT.SRC_ORIG, 
															SELF.RecChangeType := LEFT.__Tpe,
															SELF := LEFT));
	
	dsBaseType0  := IF (FullInc 
	                  , dsBaseType + InsuranceHeader_Ingest.Files.AsHeaderAll_Current_DS(RecChangeType = Constants.RecordChangeType.New)
	                  , dsBaseType 
										); 
	// Assign gender
	hdrWithUpdatedGender := InsuranceHeader_PreProcess.UpdateGender(dsBaseType0);
	
 	// output result to logical file and promote to superfile
	
	outLogicalFile 	    := Filenames.AsHeader_LF(versionIn, WORKUNIT);
	outputFile 			    := OUTPUT(hdrWithUpdatedGender,, outLogicalFile, COMPRESSED);
	promoteSF  			    := Superfiles.updateSF(outLogicalFile, Filenames.AsHeader_SF);
	
	// Incremental base with all as header logical files 
	// Add build date to so that delta file can filter records according to the ingest date from full file 
	Delta := PROJECT (hdrWithUpdatedGender , TRANSFORM(Layout_Header_Delta,  SELF.BuildDate := (UNSIGNED)versionIn ,SELF := LEFT )); 
	outLogicalAllFile 	    := Filenames.AsHeaderAll_LF(versionIn, WORKUNIT);
	outputAllFile 			    := OUTPUT(Delta,, outLogicalAllFile, COMPRESSED);
	UpdateSFAsHeaderAll     := Superfiles.AddSuper(Filenames.AsHeaderAll_SF.Current, outLogicalAllFile); 	
	
	// full suppression file 
  outSuppLogicalFile 	:= Filenames.IncSuppression_LF(versionIn, WORKUNIT);
  outputSuppFile      := OUTPUT(RemoveRecord.SuppressedFull,, outSuppLogicalFile, COMPRESSED);
  promoteSuppSF       := Superfiles.updateSF(outSuppLogicalFile, Filenames.IncSuppression_SF);
	
		// full Correction file 
  outCorrLogicalFile 	:= Filenames.IncCorrection_LF(versionIn, WORKUNIT);
  outputCorrFile      := OUTPUT(LinkCorrection.Full_,, outCorrLogicalFile, COMPRESSED);
  promoteCorrSF       := Superfiles.updateSF(outCorrLogicalFile, Filenames.IncCorrection_SF);
		
	SequentialSteps := SEQUENTIAL(
											STD.File.StartSuperFileTransaction(),
											OUTPUT(IngestUpdateStats, NAMED('IngestUpdateStats'), ALL),
											OUTPUT(IngestInputStats, NAMED('IngestInputSourceCounts'), ALL),
											outputFile,
											promoteSF,
											outputAllFile,
											UpdateSFAsHeaderAll,
											outputSuppFile,
											promoteSuppSF,
											outputCorrFile,
											promoteCorrSF,
											STD.File.FinishSuperFileTransaction()); 
											
	alreadyRunningFail := FAIL('Ingest process is already running');
	
	Run := IF(IngestRunningCheck,alreadyRunningFail, 
	          IF(FullBuildDeltaRunningCheck, WAIT(Constants.FullBuildDeltaEventName), sequentialSteps)
						); 
						 
	RETURN  Run ; 
	
END;			
