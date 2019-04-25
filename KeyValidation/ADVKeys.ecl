EXPORT ADVKeys := MODULE

	EXPORT ValidateKey(keyData,datasetName, keyRuleName, keyName, buildVersionNew) := FUNCTIONMACRO
	
	  IMPORT STD, ADV2_0, public_records_enhancements; 
		
		SuperFileLogicalNameSummary := '~adv::keyvalidaton::summary::'+ datasetName + '::' + keyName;
		
		SuperFileLogicalNameDetailed := '~adv::keyvalidaton::detailed::'+ datasetName + '::' + keyName;
		
		dailyLogicalNameSummary := '~adv::keyvalidaton::summary::'+ datasetName + '::'+ keyName + buildVersionNew;
		
		dailyLogicalNameDetailed := '~adv::keyvalidaton::detailed::'+ datasetName + '::' + keyName + buildVersionNew;
		
		rulesData := DATASET('~adv::keyvalidation::'+keyRuleName, ADV2_0.MOD_Layouts.Rules, XML('dataset/record'));
		
		public_records_enhancements.Generalized_Macro(keyData, rulesData, summary, detailed);	
		
		outputSummaryfile := OUTPUT(summary,, dailyLogicalNameSummary ,CSV(HEADING(SINGLE)), OVERWRITE);
		
		despraySummary := STD.FILE.DESPRAY(dailyLogicalNameSummary, '10.48.72.34', 'C:\\Key\\' + datasetName + '_' + keyName+ 'summary' + buildVersionNew + '.csv',,,,true); 

		outputDetailedfile := OUTPUT(detailed,, dailyLogicalNameDetailed ,CSV(HEADING(SINGLE)), OVERWRITE);
		
		desprayDetailed := STD.FILE.DESPRAY(dailyLogicalNameDetailed, '10.48.72.34', 'C:\\Key\\' + datasetName + '_' + keyName +  'detailed' + buildVersionNew + '.csv',,,,true); 

		SEQUENTIAL(
			 outputSummaryfile,
			 despraySummary,
			 outputDetailedfile,
			 desprayDetailed,
			 STD.FILE.StartSuperFileTransaction(),
			 STD.FILE.AddSuperFile(SuperFileLogicalNameSummary, dailyLogicalNameSummary),
			 STD.FILE.AddSuperFile(SuperFileLogicalNameDetailed, dailyLogicalNameDetailed),
			 STD.FILE.FinishSuperFileTransaction()
		 );
		
		RETURN(1);

	ENDMACRO;

	EXPORT GetSample(keyDataforSample,enthValue) := FUNCTIONMACRO

		RETURN ENTH(DISTRIBUtE(keyDataforSample),1,enthValue, LOCAL);

	ENDMACRO;

END;