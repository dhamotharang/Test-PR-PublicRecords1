import iesp,AutoStandardI,Healthcare_Header_Services;
EXPORT CLIA_Records(Healthcare_Header_Services.IParams.ReportParams inputData) := module
	//Build single records dataset to pass into records
	CLIA_input := dataset([{1,inputData.CompanyName,inputData.prim_range,inputData.predir,inputData.prim_name,
													inputData.suffix,inputData.postdir,'',inputData.sec_range,inputData.city,inputData.state,
													inputData.zip,'',(unsigned6) inputData.Bdid}],Healthcare_Provider_Services.CLIA_Layouts.batch_in);
	clia_mod := module (Healthcare_Provider_Services.CLIA_Interfaces.clia_config)
		export unsigned4 MaxRecordsPerRow := 2000; //Really intended for limiting output as part of batch so set very high
		export unsigned4 penalty_threshold := inputData.penalty_threshold;
		export string applicationType				:= AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
	end;
	
	clia_results := Healthcare_Provider_Services.CLIA_SearchService_Records(CLIA_input,clia_mod).records;
	clia_formatted_results := project(clia_results,Healthcare_Provider_Services.CLIA_Transforms.esdlRecords(left)); 
	export dsCLIA := choosen(clia_formatted_results,iesp.Constants.HPR.MaxCLIA);
end;
