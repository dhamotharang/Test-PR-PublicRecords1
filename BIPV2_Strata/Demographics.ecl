IMPORT STRATA, OrbitSOA, BIPV2_Strata;

EXPORT Demographics (dataset(BIPV2_Strata.layouts.layout_Demographics) input_recs, String8 version_date = stringlib.getDateYYYYMMDD()) := FUNCTION
		
	BIPV2_Strata.layouts.layout_Demographics_Strata strataFormat( input_recs L) := TRANSFORM
		SELF.Header_Element		:= L.Header_Element;
		SELF.Active_Percent		:= (INTEGER)Round(L.Active * 100);
		SELF.InActive_Percent	:= (INTEGER)Round(L.InActive * 100);
	END;
	input_recs1 := PROJECT(input_recs, strataFormat(LEFT));	
	
	formatted_data := RECORD
		input_recs1;
		CountGroup 	:= input_recs1.Active_Percent + input_recs1.InActive_Percent;		
	END;	

	report_data := table(input_recs1,formatted_data,Header_Element,FEW);	
	output(report_data,ALL);

	STRATA.createXMLStats(report_data,'BIPV2','Data',version_date,
	 BIPV2_Strata.SampleData.emailList,strata_result,'stats','Demographics');

	return strata_result;

end;