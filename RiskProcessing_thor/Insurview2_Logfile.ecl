IMPORT UT, STD, RiskProcessing_thor;
 
EXPORT Insurview2_Logfile(BuildPeriod, inputFileName, OutputFileName, historyDate, 
													inputFileCount, outputFileCount, errorCount) := FUNCTIONMACRO

		STRING LogFile_Logical_Name		:= '~thor::base::ar::' + workunit + '::InsurView20Attributes::auditlog';
			
		LogDS := DATASET([{
											(unsigned4)BuildPeriod,
											inputFileName,
											OutputFileName,
											historyDate,
											inputFileCount,
											outputFileCount,		
											WORKUNIT,
											errorCount
											}],
											RiskProcessing_thor.Layouts.Layout_AuditLog);
		
		SFLogDS := SORT(DATASET(LogFile_Superfile_Name,RiskProcessing_thor.Layouts.Layout_AuditLog,THOR,OPT),wuid);
		AppendLogDS 		:= SFLogDS + LogDS;
		OUTPUT(AppendLogDS);
		logFileDS				:= OUTPUT(AppendLogDS,,	LogFile_Logical_Name, OVERWRITE,__COMPRESSED__);
		
		AddLogSF				:= SEQUENTIAL (logFileDS, STD.File.StartSuperFileTransaction(),
																	 STD.File.ClearSuperFile(LogFile_Superfile_Name,TRUE),
																	 STD.File.AddSuperFile(LogFile_Superfile_Name,LogFile_Logical_Name),
																	 STD.File.FinishSuperFileTransaction());
    
		RETURN AddLogSF;
		
ENDMACRO;



