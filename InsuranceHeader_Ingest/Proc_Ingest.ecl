IMPORT IDL_Header,InsuranceHeader_PreProcess , InsuranceHeader_Salt_T46,Insurance_Header_Auto,Insurance_Header_Property,InsuranceHeader_Incremental,ut;

EXPORT Proc_Ingest(STRING versionIn ) := FUNCTION

	#WORKUNIT ('NAME','Insurance Header Ingest');
	
	ds              := InsuranceHeader_Ingest.File_Base; 
 dsAlpha         := ds(src[1..3] <> 'ADL') ; 
	dsAlphaBlank    := dsAlpha (fname = '' and lname = ''and prim_name = '' and city = '');	
	dsFullNonBlank  := In_Base;		
	
	dsBoca          := idl_header.files.DS_BOCA_HEADER_BASE; 
	dsBocaNonBlank  := dsBoca(not(fname = '' and lname = ''and prim_name = '' and city_name = ''));
	dsBocaBlank     := dsBoca(fname = '' and lname = ''and prim_name = '' and city_name = '');
// apply suppression to input data 	
	Suppress_DS     := InsuranceHeader_Salt_T46.ManualSuppression.data_file;
	
	Inds   		       :=  Add_Update_BocaData(dsBocaNonBlank).getRecords +
                     Add_Update_InsuranceData(ds).getRecords 
										           :PERSIST(Filenames.Persist_IngestInput, EXPIRE(30));			
										 
	dsIngest := JOIN(Inds,
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
														 TRANSFORM({inds}, SELF:=LEFT) ,LEFT ONLY , LOOKUP):INDEPENDENT;
														 
			// As header all from incremental build as delta to Full  
	dsDelta 			:= PROJECT(InsuranceHeader_Incremental.Files.AsHeaderAll_Current_DS(BuildDate >= (UNSIGNED)InsuranceHeader_Incremental.Build_Date.AlphaKeyFull), TRANSFORM(Layout_Base ,
	                              SELF.src_orig := LEFT.src ; 
																SELF.src := MAP(LEFT.src[1..3] = 'IVS' => 'IVS', 
																                 LEFT.src[1..3] = 'ICA' => 'ICA',
																								 LEFT.src[1..3] = 'ICP' => 'ICP' , LEFT.src);													 
																SELF := LEFT)); 
																
	Mod_Ingest      := Ingest(FALSE,dsDelta,dsFullNonBlank,dsIngest);
	
	dsBasePlusIngest 	   := mod_Ingest.AllRecords;
	IngestInputStats	   := mod_Ingest.InputSourceCounts;
	IngestUpdateStatsSrc := mod_Ingest.UpdateStatsXtab; 

	// Assign __type and add blank records 
	dsBaseType  := PROJECT(dsBasePlusIngest,
															TRANSFORM(Layout_Header_Plus,
															SELF.SRC := LEFT.SRC_ORIG, 
															SELF.RecChangeType := LEFT.__Tpe,
															SELF := LEFT));
		
	  dsStats := Stats_Ingest( dsBaseType , dsIngest , ds,IngestInputStats, IngestUpdateStatsSrc , versionIn); 

		// Move old records to archive file and blank them in the base
    		
		OldRecords := dsBaseType ( RecChangeType = Constants.RecordChangeType.Old);
		
		// filter out latest blank we are not allowed to keep these in Archive file 
		
		FilterblankFromOld := JOIN (OldRecords(src[1..3]= 'ADL') , dsBocaBlank , 
		                                LEFT.source_rid = RIGHT.rid ,
																		TRANSFORM(LEFT),LEFT ONLY ,HASH) + OldRecords(src[1..3]<> 'ADL') ; 
																
		ArchiveRecords    := PROJECT( FilterblankFromOld, TRANSFORM (Layout_Archive , 
		                        	SELF.ArchiveDate := (unsigned)thorlib.wuid()[2..9];  
															SELF := LEFT 
															)) + Files.Base_Archive_Current_DS; 
		 
		Archive     := DEDUP(ArchiveRecords,ALL);
    // match archive file with bocablank and filterout old records became blank      
		
		ArchiveFile := JOIN(ArchiveRecords(src[1..3]= 'ADL'), dsBocaBlank ,
		                        LEFT.source_rid = RIGHT.rid ,
														TRANSFORM(LEFT),LEFT ONLY ,HASH) + ArchiveRecords(src[1..3]<> 'ADL');
		
		// Blank old records in base to avoid ID shift and map date 
		
		BlankOld  := PROJECT(FilterblankFromOld , TRANSFORM (Layout_Header_Plus , 
		                          SELF.DID := LEFT.DID ,
															SELF.RID := LEFT.RID , 
															SELF.Source_rid := LEFT.Source_rid ,
															SELF.SRC := LEFT.SRC,
															SELF.BOCA_DID	:= LEFT.DID,
															SELF.DT_VENDOR_LAST_REPORTED := (unsigned)thorlib.wuid()[2..9]; 
															SELF := []; 
													)); 		
												
		// store Boca blank base rid's ,did's in a separate file no other info saved 	
		
		blankrids   := DEDUP(PROJECT( OldRecords(src[1..3]= 'ADL'), TRANSFORM (InsuranceHeader_Ingest.Layout_Archive , 
		                        	SELF.ArchiveDate := (unsigned)thorlib.wuid()[2..9]; 
															SELF.DID := LEFT.DID ,
															SELF.RID := LEFT.RID , 
															SELF.Source_rid := LEFT.Source_rid ,
															SELF.SRC := LEFT.SRC,
															SELF.BOCA_DID	:= LEFT.DID,
															SELF := []; //blank everything  
 														)) + InsuranceHeader_Ingest.Files.Base_Bocablankrid_Current_DS,ALL); 
														
		//keep salt rid on blank records instead of input boca rid as this boca rid creating duplicates in the as_header_all 		
		
		BocaBlank  := JOIN ( dsBocaBlank , blankrids, 
		                          LEFT.rid = RIGHT.source_rid ,
															TRANSFORM(InsuranceHeader_Ingest.Layout_Header_Plus,
															SELF.src := idl_header.Constants.Boca_Header_Records + LEFT.SRC;
															SELF.Source_rid := LEFT.rid,
															SELF.RID := IF ( RIGHT.SOURCE_RID <>0 , RIGHT.RID,LEFT.RID),
															SELF.DID := IF ( RIGHT.SOURCE_RID <>0 ,RIGHT.DID , LEFT.DID), 
															SELF := LEFT; 
															SELF := []; 
															),LEFT OUTER , HASH) ; 													

		AlphaBlank  := PROJECT (dsAlphaBlank , 
		                          TRANSFORM(Layout_Header_Plus,
															SELF := LEFT , 
															SELF.RecChangeType := 0 ;
															)) ;
															
		dsBaseTypeNoOld :=   dsBaseType(RecChangeType <> Constants.RecordChangeType.Old);  
		NewRecords      :=   dsBaseTypeNoOld(RecChangeType = Constants.RecordChangeType.New) ; 
		
		// Append did to new records 
		
    MVRIQ             := IDL_Header.SourceTools.src_ins_mvrinq;
		NewRecs_80_15     := NewRecords(src != MVRIQ);
		NewRecs_70_15     := NewRecords(src = MVRIQ);		
		NewRecs_wdid      := InsuranceHeader_PreProcess.fn_appendDID(NewRecs_80_15).result + InsuranceHeader_PreProcess.fn_appendDID(NewRecs_70_15, 70).result;
    AllTypes          := NewRecs_wdid + dsBaseTypeNoOld(RecChangeType <> Constants.RecordChangeType.New) + BocaBlank + BlankOld + AlphaBlank;
  

   // Assign gender
		hdrWithUpdatedGender 			:= InsuranceHeader_PreProcess.UpdateGender(AllTypes);

		// Patch DIDs 
		patchDIDs									:= fn_updateDID(hdrWithUpdatedGender);
		
	// output result to logical file and promote to superfile
	
	outLogicalFile 	:= Filenames.AsHeaderAll_LF(versionIn, WORKUNIT);
	outputFile 			:= OUTPUT(patchDIDs,, outLogicalFile, COMPRESSED);
	promoteSF  			:= Superfiles.updateSF(outLogicalFile, Filenames.AsHeaderAll_SF);
	
	// Archive File 
	outArchiveLogicalFile := Filenames.Base_Archive_LF(versionIn,WORKUNIT);
	outputArchiveFile 		:= OUTPUT(ArchiveFile,,outArchiveLogicalFile, COMPRESSED);
	promoteArchiveSF 			:= Superfiles.updateSF(outArchiveLogicalFile,Filenames.Base_Archive_SF);
	
	// Stats File 
	outStatsLogicalFile := Filenames.StatsIngest_LF(versionIn,WORKUNIT);
	outputStatsFile 		:= OUTPUT(dsStats,,outStatsLogicalFile, COMPRESSED);
	promoteStatsSF 			:= Superfiles.updateSF(outStatsLogicalFile,Filenames.StatsIngest_SF);
	
	// Boca blank rid file 
	
	outblankridLogicalFile    := Filenames.Bocablankrid_LF(versionIn,WORKUNIT);
	outputblankridFile 		    := OUTPUT(blankrids,,outblankridLogicalFile, COMPRESSED);
	promoteblankridSF 			  := Superfiles.updateSF(outblankridLogicalFile,Filenames.Bocablankrid_SF);
	
	sequentialSteps := SEQUENTIAL(
	                    Insurance_Header_Auto.fBuild_CLUEAutoHeader(versionIn), 
                      Insurance_Header_Property.fBuild_CLUEPropertyHeader(versionIn),  
											STD.File.StartSuperFileTransaction(),
											OUTPUT(IngestUpdateStatsSrc,, NAMED('IngestUpdateStatsXtab'), ALL),
											OUTPUT(IngestInputStats, NAMED('IngestInputSourceCounts'), ALL),
											outputFile,
											outputArchiveFile,
											outputStatsFile,
											outputblankridFile,
											promoteSF,
											promoteArchiveSF,
											promoteStatsSF,
											promoteblankridSF,
											STD.File.FinishSuperFileTransaction()); 
											
	RETURN SequentialSteps ; 
	
END;
