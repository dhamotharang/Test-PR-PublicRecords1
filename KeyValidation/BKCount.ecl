Import KeyValidation,advfiles, STD;

	Layout_Mapping_Count_BKCount := RECORD
	
		String fileName;
		String logicalFile;
		string pDataset;
		boolean isKey;
		string coefficients;
		string nextBuildValue;
		string buildcount;
		string buildVersion;
	END;
	
buildVersion := advfiles.CurrentBuildVersions.File(datasetname='BankruptcyV2Keys' and envment='P' and location = 'B' and cluster = 'N')[1].buildversion;
bankruptcyData_all := DATASET('~aim::counts:bankruptcy', { string filename, string buildversion, string buildcount },CSV(HEADING(SINGLE)));

bankruptcyData := dedup(sort(bankruptcyData_all(buildVersion != 'buildversion'),record));

maxbuild := max(bankruptcyData,buildversion);

If((integer)buildVersion > (integer)maxbuild,KeyValidation.AIMAutomationModule.checkCounts('bankruptcy', buildVersion),dataset([],Layout_Mapping_Count_BKCount));
