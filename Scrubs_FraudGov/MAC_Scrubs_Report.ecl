EXPORT MAC_Scrubs_Report(BuildDate,myFolder,scopename,inputFile,MemailList)	:=	FUNCTIONMACRO
	import FraudShared,FraudGovPlatform,Salt35,Scrubs,tools,STD,ut;
	folder := #EXPAND(myFolder);
	inFile := inputFile;
	datasetName	:= 'FraudGov';
	scrubs_name :=TRIM(scopename,ALL)+'_SCRUBS';
	scope_datasetName := TRIM(scopename,ALL)+'_' + DatasetName	;
	profilename := 'Scrubs_FraudGov_'+scopename;

	Filename := '~'+map(
			scopename = 'InquiryLogs' => STD.File.GetSuperFileSubName(FraudGovPlatform.Filenames(BuildDate).Sprayed.InquiryLogs,1),
			scopename = 'NAC' => STD.File.GetSuperFileSubName(FraudGovPlatform.Filenames(BuildDate).Sprayed.NAC,1),
			scopename = 'RDP' => STD.File.GetSuperFileSubName(FraudGovPlatform.Filenames(BuildDate).Sprayed.RDP,1),
			scopename = 'Deltabase' => STD.File.GetSuperFileSubName(FraudGovPlatform.Filenames(BuildDate).Sprayed.Deltabase,1),
			scopename = 'DEDI' => STD.File.GetSuperFileSubName(FraudGovPlatform.Filenames(BuildDate).Sprayed.DisposableEmailDomains,1),
			''
			);
	process_date := BuildDate;
	file_date := map(
			scopename = 'InquiryLogs' => '',
			scopename = 'NAC' => STD.Str.SplitWords(Filename, '_', FALSE)[6],
			scopename = 'RDP' => STD.Str.SplitWords(Filename, '_', FALSE)[6],
			scopename = 'Deltabase' => (STD.Str.SplitWords(Filename, '_', FALSE)[2])[1..8],
			scopename = 'DEDI' => (STD.Str.SplitWords(Filename, '_', FALSE)[2])[1..8],
			STD.Str.SplitWords(Filename, '::', FALSE)[3]
		);

		// F := inFile(process_date=filedate); //	Records to scrub
	F := inFile; //	Records to scrub
	S := folder.#EXPAND(scrubs_name); //	My scrubs module
	N := S.FromNone(F); //	Generate the error flags
	U := S.FromExpanded(N.ExpandedInFile); //	Pass the expanded error flags into the Expanded module
	ErrorSummary :=	OUTPUT(U.SummaryStats, NAMED(scopename+'_ErrorSummary'));										//	Show errors by field and type
	EyeballSomeErrors := OUTPUT(CHOOSEN(U.AllErrors, 1000), NAMED(scopename+'_EyeballSomeErrors'));		//	Just eyeball some errors
	SomeErrorValues := OUTPUT(CHOOSEN(U.BadValues, 1000), NAMED(scopename+'_SomeErrorValues'));			//	See my error field values
		
	persist_name :=	FraudGovPlatform._Dataset().thor_cluster_Files +'persist::'+
		IF(TRIM(scopename,ALL)<>'',TRIM(scopename,ALL)+'_','')+
		myFolder+'_orbit_stats';

	Orbit_stats :=	U.OrbitStats():PERSIST(persist_name);
	OrbitReport :=	OUTPUT(Orbit_stats,ALL,NAMED(scopename+'_OrbitReport'));
	prj_Orbit_stats := project(Orbit_stats, transform(Salt35.ScrubsOrbitLayout, self:=left));

	OrbitReportSummary	:=	OUTPUT(Scrubs.OrbitProfileStats(,,prj_Orbit_stats).SummaryStats,ALL,NAMED(scopename+'_OrbitReportSummary'));
	
	NumRules :=	Count(Orbit_stats);
	NumFailedRules := Count(Orbit_Stats(rulecnt>0));
	TotalRecs := Count(N.ExpandedInFile);

	TotalProcRecs := 0;
	TotalRemovedRecs :=	0;
	
	rMyDataset := recordof(N.BitmapInfile);
	ut.hasField(rMyDataset,ScrubsBits2,bHasScrubsBits2);
	ut.hasField(rMyDataset,ScrubsBits3,bHasScrubsBits3);
	ut.hasField(rMyDataset,ScrubsBits4,bHasScrubsBits4);
	ut.hasField(rMyDataset,ScrubsBits5,bHasScrubsBits5);
	ut.hasField(rMyDataset,ScrubsBits6,bHasScrubsBits6);
	ut.hasField(rMyDataset,ScrubsBits7,bHasScrubsBits7);
	ut.hasField(rMyDataset,ScrubsBits8,bHasScrubsBits8);

	rWithScrubsResults	:=	RECORD
		rMyDataset;
		BOOLEAN	bFailedScrubs	:=	FALSE;
	END;	
	
	rWithScrubsResults	tWithScrubsResults(rMyDataset pInput) := TRANSFORM
		SELF.bFailedScrubs	:=	pInput.ScrubsBits1>0
			#IF	(bHasScrubsBits2)
				OR	pInput.ScrubsBits2>0
			#END
			#IF	(bHasScrubsBits3)
				OR	pInput.ScrubsBits3>0
			#END
			#IF	(bHasScrubsBits4)
				OR	pInput.ScrubsBits4>0
			#END
			#IF	(bHasScrubsBits5)
				OR	pInput.ScrubsBits5>0
			#END
			#IF	(bHasScrubsBits6)
				OR	pInput.ScrubsBits6>0
			#END
			#IF	(bHasScrubsBits7)
				OR	pInput.ScrubsBits7>0
			#END
			#IF	(bHasScrubsBits8)
				OR	pInput.ScrubsBits8>0
			#END
			;
		SELF :=	pInput
	END;
	dWithScrubs	:=	PROJECT(N.BitmapInfile,tWithScrubsResults(LEFT));
	ErroredRecords := count(dWithScrubs(bFailedScrubs));
	
	PcntErroredRec := (String)((decimal5_2)((((real)ErroredRecords)/((real)TotalRecs))*100));
	//This will output a file with bitmap(s) and a processed file with all on fail flags activated for the rules
	bitfile_name :=	FraudGovPlatform._Dataset().thor_cluster_Files+scope_datasetName + '_Scrubs_Bits';
	processedfile_name := FraudGovPlatform._Dataset().thor_cluster_Files + scope_datasetName+'_Processed_File';
	CreateBitmaps := OUTPUT( N.BitmapInfile,,bitfile_name, OVERWRITE, compressed, named(scope_datasetName+'_BitFile')); // long term storage
	DS  := DATASET(bitfile_name,S.Bitmap_Layout,FLAT); // Read in my data (which has bitmap appended
	//This will translate the bitmap(s)
	T := S.FromBits(DS); // Use the FromBits module; makes my bitmap datafile easier to get to read
	TranslateBitmap	:=	OUTPUT(T);
	NumRemovedRecs := '';
	WU := '';
	new_entry:=dataset([{DatasetName,ProfileName,scopename,BuildDate,TotalRecs,NumRules,NumFailedRules,ErroredRecords,TotalRemovedRecs,PcntErroredRec,NumRemovedRecs,WU,workunit}],Scrubs.Layouts.LogRecord);
	outnew:=output(new_entry,named(scope_datasetName+'_LogEntry'));

	EmailReport:=if(MemailList <>'', fileservices.sendEmail(MemailList,
		'Scrubs Plus Reporting '+ProfileName,
		'Scrubs Plus Reporting\n\n'+
		'DatasetName: '+DatasetName+'\n'+
		'ProfileName :'+ProfileName+'\n'+
		'ScopeName: '+scopename+'\n'+
		'Process Date : '+process_date+'\n'+
		'FileDate : '+file_date+'\n'+
		'Filename : '+TRIM(STD.Str.ToLowerCase(Filename),ALL )+'\n'+
		'\n'+
		'Total Number of Records :'+TotalRecs+'\n'+
		'Total Number of Rules :'+NumRules+'\n'+
		'Total Number of Failed Rules :'+NumFailedRules+'\n'+
		'Total Number of Errored Records :'+ErroredRecords+'\n'+
		'Percent Errored Records :'+PcntErroredRec+'\n'+
		'Total Number of Removed Recs :'+TotalRemovedRecs+'\n'+
		'Workunit:'+tools.fun_GetWUBrowserString()+'\n'));

	SubmitStats :=	Scrubs.OrbitProfileStats(profilename,'ScrubsAlerts',prj_Orbit_stats,BuildDate,profilename).SubmitStats;
	//Submits Profile's stats to Orbit
	
	SuperFile :=FraudGovPlatform.Filenames().OutputF.Scrubs_FraudGov + '::log';
	Super_Log_File := SuperFile + '::' + scopename;
	SuperFile_Entries := dataset(Super_Log_File,Scrubs.Layouts.LogRecord,thor,opt);
	
	Create_New_File	:=	sequential(output(SuperFile_Entries+new_entry,,Super_Log_File+'_temp_'+scopename,thor,overwrite,named(scope_datasetName+'_LogEntryFull')),
		STD.File.StartSuperFileTransaction(),
		STD.File.RemoveSuperFile(SuperFile,Super_Log_File,true),
		STD.File.FinishSuperFileTransaction());
		// output(old_entries+new_entry,,Super_Log_File+'_temp',thor,overwrite));

	publish:=sequential(
		Create_New_File,
		nothor(global(sequential(fileservices.deleteLogicalFile(Super_Log_File),
		fileservices.renameLogicalFile(Super_Log_File+'_temp_'+scopename,Super_Log_File),
		STD.File.StartSuperFileTransaction(),
		STD.File.AddSuperFile(SuperFile,Super_Log_File),
		STD.File.FinishSuperFileTransaction()))));

	return SEQUENTIAL(
		ErrorSummary,
		EyeballSomeErrors,
		SomeErrorValues,
		OrbitReport,
		OrbitReportSummary,
		CreateBitmaps,
		outnew,
		SubmitStats,
		EmailReport,
		publish
	);
ENDMACRO;