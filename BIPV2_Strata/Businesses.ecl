IMPORT STRATA, OrbitSOA, BIPV2_Strata;

EXPORT Businesses (dataset(BIPV2_Strata.layouts.layout_Businesses) input_recs, String8 version_date = stringlib.getDateYYYYMMDD()) := FUNCTION
		
	formatted_data := RECORD
		input_recs;
		CountGroup 	:= input_recs.Build_Value;		
	END;	

	report_data := table(input_recs,formatted_data,US_Businesses,FEW);	
	output(report_data,ALL);
	  
	STRATA.createXMLStats(report_data,'BIPV2','Data',version_date,
	 BIPV2_Strata.SampleData.emailList,strata_result,'stats','USBusiness');

	return strata_result;

end;