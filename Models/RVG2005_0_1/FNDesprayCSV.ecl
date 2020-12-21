EXPORT FNDesprayCSV(ExportDS,TempCSV,LandingZoneIP,lzFilePathBaseFile,SeparatorChar='') := FUNCTIONMACRO
	outputBaseAsCSV := OUTPUT(ExportDS,,TempCSV,CSV(HEADING(SINGLE),QUOTE('"'),
							#IF(#TEXT(SeparatorChar)='') SEPARATOR(',')
							#ELSE SEPARATOR(SeparatorChar) #END,NOTRIM));
	deSprayCSV := NOTHOR(STD.File.DeSpray(TempCSV,LandingZoneIP,lzFilePathBaseFile,-1,,,TRUE));
	// deleteCSVThorFile := NOTHOR(FileServices.DeleteLogicalFile(TempCSV));
	// sequentialSteps := SEQUENTIAL(outputBaseAsCSV, deSprayCSV, deleteCSVThorFile);
	sequentialSteps := SEQUENTIAL(outputBaseAsCSV,deSprayCSV);
	return sequentialSteps;
ENDMACRO;
