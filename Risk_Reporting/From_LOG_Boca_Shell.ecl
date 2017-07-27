IMPORT Risk_Indicators, ut;

EXPORT Risk_Reporting.Layout_Boca_Shell From_LOG_Boca_Shell(DATASET(Risk_Reporting.Layouts.LOG_Boca_Shell_Record) logs) := FUNCTION
	// In order to TOXML and FROMXML to work correctly for child datasets they must be placed in a wrapper.
	XMLWrapper := RECORD
		DATASET(Risk_Reporting.Layout_Boca_Shell) wrapper;
	END;
	
	Risk_Reporting.Layout_Boca_Shell getDataset(logs le) := TRANSFORM
		datasetWrapped := FROMXML(XMLWrapper, le.content_data, TRIM);
		
		back := datasetWrapped.wrapper[1];
		
		SELF := back;
		
		SELF := [];
	END;
	
	result := PROJECT(logs, getDataset(LEFT));
	
	return result;
END;