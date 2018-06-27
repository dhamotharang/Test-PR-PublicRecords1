EXPORT ScrubsPlus_PassFile(inputFile,DatasetName,ScrubsModule,ScrubsProfileName,ScopeName='',filedate,emailList='', UseOnFail=false)	:=	FUNCTIONMACRO 
IMPORT tools,std,ut,SALT311;

	folder						:=	#EXPAND(ScrubsModule);
	inFile						:=	inputFile;
	scrubs_name				:=	IF(TRIM(scopename,ALL)<>'',TRIM(scopename,ALL)+'_Scrubs','Scrubs');
	scope_datasetName	:=	IF(TRIM(scopename,ALL)<>'',scopename+'_'+DatasetName,ScrubsProfileName);
	profilename				:=	ScrubsProfileName;
	Prefix						:=	IF(TRIM(scopename,ALL)<>'',scopename,ScrubsProfileName+'_'+filedate);
	
	
	
	
	F	:=	inFile;																				//	Records to scrub
	S	:=	folder.#EXPAND(scrubs_name);									//	My scrubs module
	N	:=	S.FromNone(F);																//	Generate the error flags
	U :=	S.FromExpanded(N.ExpandedInFile);							//	Pass the expanded error flags into the Expanded module
	ErrorSummary			:=	OUTPUT(U.SummaryStats, NAMED(Prefix+'_ErrorSummary'));										//	Show errors by field and type
	EyeballSomeErrors	:=	OUTPUT(CHOOSEN(U.AllErrors, 1000), NAMED(Prefix+'_EyeballSomeErrors'));		//	Just eyeball some errors
	SomeErrorValues		:=	OUTPUT(CHOOSEN(U.BadValues, 1000), NAMED(Prefix+'_SomeErrorValues'));			//	See my error field values
	
	if(count(infile)=0,sequential(output('No Records Found in '+Prefix,named('No_Record_Alert_'+Prefix)),
																if(EmailList<>'',fileservices.sendEmail(emailList,'No Records Found in '+Prefix,'No Records Found in '+Prefix))));
	
	
	LoadStats					:=	U.OrbitStats(); 
	Orbit_stats			:=project(LoadStats,transform(Salt311.ScrubsOrbitLayout,self.RulePcnt := (decimal5_2) (((real)left.Rulecnt/(real)left.RecordsTotal) * 100.00);self:=left;));
	OrbitReport					:=	output(Orbit_stats,,'~thor_data400::'+ScrubsProfileName+'_orbit_stats',all,thor,overwrite,expire(10),NAMED(Prefix+'_OrbitReport'));
	OrbitReportSummary	:=	output(Scrubs.OrbitProfileStatsPost310(,,Orbit_stats).SummaryStats,,'~thor_data400::'+ScrubsProfileName+'_orbit_stats_summary',all,thor,overwrite,expire(10),NAMED(Prefix+'_OrbitReportSummary'));
	NumRules						:=	Count(Orbit_stats);
	NumFailedRules			:=	Count(Orbit_Stats(rulecnt>0));
	TotalRecs						:=	Count(N.ExpandedInFile);
	#if(UseOnFail)
		TotalProcRecs				:=	Count(N.ProcessedInfile);
		TotalRemovedRecs		:=	TotalRecs-TotalProcRecs;
	#else
		TotalProcRecs				:=	0;
		TotalRemovedRecs		:=	0;
	#end
	
	rMyDataset					:=	recordof(N.BitmapInfile);
	
		
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
	
	rWithScrubsResults	tWithScrubsResults(rMyDataset	pInput)	:=	TRANSFORM
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
			SELF								:=	pInput
	END;
	dWithScrubs	:=	PROJECT(N.BitmapInfile,tWithScrubsResults(LEFT));
	ErroredRecords					:= count(dWithScrubs(bFailedScrubs));
	PcntErroredRec					:= (String)((decimal5_2)((((real)ErroredRecords)/((real)TotalRecs))*100));
	//This will output a file with bitmap(s) and a processed file with all on fail flags activated for the rules
	
	LoadProfile:=dataset('~thor_data400::Scrubs::'+ScrubsProfileName+'::ProfileStorage',Scrubs.Layouts.ProfileRule_Rec,thor,opt);
	
	MergeScrubsBase:= join(Orbit_stats, LoadProfile, trim(left.RuleDesc, left, right) = trim(right.Name, left, right),
                                         transform( Scrubs.layouts.StatsOutLayout, 
																				 self.RulePcnt := (decimal5_2) (((real)left.Rulecnt/(real)left.RecordsTotal) * 100.00);
																				 self.RejectWarning := if(self.RulePcnt > (decimal5_2) right.passpercentagetop, 'Y', 'N'),
																				 self.RuleName := trim(left.RuleDesc, left),
																				 self.ruledesc :=  trim(stringlib.stringfindreplace(left.errormessage[..100], ',', ' '),left, right),
																				 self.FieldName := trim(Ut.Word(left.ruledesc,1,':'), left),
																				 self.InvalidValue := (string)(string100)left.rawcodemissing,
																				 self.InvalidValueCnt := left.rawcodemissingcnt,
																				 self.RuleThreshold := (decimal5_2) right.passpercentagetop;
																				 self := left,
																				 self := right));
																				 
	IdentifyExceedThreshold	:= 	MergeScrubsBase(RejectWarning='Y');
	IdentifyExceedSevere			:=	IdentifyExceedThreshold(Severity='1');
	
	NumExceedThreshold:=count(IdentifyExceedThreshold);
	NumExceedSevere:=count(IdentifyExceedSevere);	
	
	bitfile_name		:=	'~thor_data::'+scope_datasetName+'::Scrubs_Bits';
	processedfile_name		:=	'~thor_data::'+scope_datasetName+'::Processed_File';
	CreateBitmaps		:=	OUTPUT( N.BitmapInfile,,bitfile_name, OVERWRITE, compressed, named(scope_datasetName+'_BitFile_')); // long term storage
	#if(UseOnFail)
	CreateProcessed		:=	OUTPUT( N.ProcessedInfile,,processedfile_name, OVERWRITE, compressed, named(scope_datasetName+'_ProcessedInfile_')); // long term storage	
	#end
	DS := DATASET(bitfile_name,S.Bitmap_Layout,FLAT); // Read in my data (which has bitmap appended
	//This will translate the bitmap(s)
	T := S.FromBits(DS);	// Use the FromBits module; makes my bitmap datafile easier to get to read
	TranslateBitmap	:=	OUTPUT(T);
	
	new_entry:=dataset([{DatasetName,ProfileName,scopename,filedate,TotalRecs,NumRules,NumFailedRules,NumExceedThreshold,NumExceedSevere,ErroredRecords,TotalRemovedRecs,PcntErroredRec,workunit}],Scrubs.Layouts.LogRecord);
	outnew:=output(new_entry);

	EmailReport:=if(emailList <>'' , fileservices.sendEmail(emailList,
																			'Scrubs Plus Reporting '+ProfileName,
																			'Scrubs Plus Reporting\n\n'+
																			'DatasetName:'+DatasetName+'\n'+
																			'ProfileName:'+ProfileName+'\n'+
																			'ScopeName:'+scopename+'\n'+
																			'FileDate:'+filedate+'\n'+
																			'Total Number of Records:'+TotalRecs+'\n'+
																			'Total Number of Rules:'+NumRules+'\n'+
																			'Total Number of Failed Rules:'+NumFailedRules+'\n'+
																			'Total Number of Rules That Exceed Threshold:'+NumExceedThreshold+'\n'+
																			'Total Number of Severe Rules That Exceed Threshold:'+NumExceedSevere+'\n'+
																			'Total Number of Errored Records:'+ErroredRecords+'\n'+
																			'Percent Errored Records:'+PcntErroredRec+'\n'+
																			'Total Number of Removed Recs:'+TotalRemovedRecs+'\n'+
																			'Workunit:'+tools.fun_GetWUBrowserString()+'\n'));
																			
	SubmitStats						:=	Scrubs.OrbitProfileStatsPost310(profilename,'ScrubsAlerts',Orbit_stats,filedate,profilename).SubmitStats;
	
	SuperFile:='~thor_data400::ScrubsPlus::log';
	Super_Log_File:='~thor_data400::ScrubsPlus::'+ScrubsModule+'::Log::'+workunit+'::'+Prefix;
	
	Create_New_File	:=	output(new_entry,,Super_Log_File,thor,overwrite,named(Prefix+'_LogEntryFull'));



	publish:=sequential(
										Create_New_File,
										nothor(global(sequential(
										STD.File.StartSuperFileTransaction(),
										STD.File.AddSuperFile(SuperFile,Super_Log_File),
										STD.File.FinishSuperFileTransaction()))));





	return	ORDERED(
		parallel(ErrorSummary,
		EyeballSomeErrors,
		SomeErrorValues,
		OrbitReport,
		OrbitReportSummary,
		CreateBitmaps),
		#if(UseOnFail)
		CreateProcessed,
		#end
		outnew,
		SubmitStats,
		EmailReport,
		publish
	);
ENDMACRO;

