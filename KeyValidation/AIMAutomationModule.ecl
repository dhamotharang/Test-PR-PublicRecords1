Export AIMAutomationModule :=module

Export checkCounts(datasetName3, buildVersion1) := FUNCTIONMACRO

Import ut,advfiles, STD, bankruptcyv3;

	Layout_Mapping := RECORD
	
		String fileName;
		String logicalFile;
		string pDataset;
		boolean isKey;
		string coefficients;
		string nextBuildValue;
	END;
	
	SHARED Layout_Mapping_Count := RECORD
	
		String fileName;
		String logicalFile;
		string pDataset;
		boolean isKey;
		string coefficients;
		string nextBuildValue;
		string buildcount;
		string buildVersion;
	END;


mappingdata := DATASET('~AIM::Counts:Mapping:' + datasetName3,Layout_Mapping, CSV(HEADING(1)));

getdata := mappingdata(logicalFile <> 'NA');

Layout_Mapping_Count updatecount1Tr(Layout_Mapping  L) := Transform 

		SELF.buildVersion := buildVersion1;
		SELF.buildcount := (string)STD.File.LogicalFileList((string)L.logicalfile,0,1,0,'10.241.20.205:7070')[1].rowcount;
  	SELF := L;
END;


 dataCount := PROJECT(getdata, updatecount1Tr(LEFT));

tabledataCount := table(datacount,{fileName,buildVersion, buildCount});


OutputFiles :=	Sequential
	(
	 Output(tabledataCount,,'~AIM::Counts:'+(string)ut.GetDate + datasetName3, csv(heading(single))),
	 Std.File.StartSuperFileTransaction(),
	 Std.File.AddSuperFile('~AIM::Counts:' + datasetName3,'~AIM::Counts:'+(string)ut.GetDate + datasetName3),
	 Std.File.FinishSuperFileTransaction()
	);

emptyData := output(dataset([],Layout_Mapping_Count),,'~AIM::Counts::dummy', csv(heading(single)),OVERWRITE);
bankruptcyData_all := DATASET('~aim::counts:bankruptcy', { string filename, string buildversion, string buildcount },CSV(HEADING(SINGLE)));
bankruptcyData := dedup(sort(bankruptcyData_all(buildVersion != 'buildversion'),record));
maxbuild := max(bankruptcyData,buildVersion1);
ret := if(buildVersion > maxbuild, OutputFiles, emptyData);
return ret;

ENDMACRO;

end;
