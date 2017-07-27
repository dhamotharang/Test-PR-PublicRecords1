import iesp,AutoStandardI,GSA_Services,Healthcare_Header_Services;
export GSA_Records(Healthcare_Header_Services.IParams.ReportParams inputData) := module
	tmpGSASearchMod := module(project(AutoStandardI.GlobalModule(),GSA_Services.Functions.params,opt))
		export did := inputData.did;
		export bdid := inputData.Bdid;
		EXPORT LastName := inputData.LastName;      			
		EXPORT FirstName := inputData.FirstName;      			
		EXPORT MiddleName := inputData.MiddleName;      			
		EXPORT CompanyName := inputData.CompanyName;
		export Addr := inputData.Addr;
		export prim_range := inputData.prim_range;
		export sec_range := inputData.sec_range;
		export predir := inputData.predir;
		export prim_name := inputData.prim_name;
		export suffix := inputData.suffix;
		export postdir := inputData.postdir;
		export City := inputData.city;
		export State := inputData.state;
		export zip := inputData.zip;
    export string5 name_suffix := '' : stored ('NameSuffix');
	end;	
	gsaInput := GSA_Services.Functions.fn_getInputData(tmpGSASearchMod);
	gsaResults := GSA_Services.BatchService_Records(gsaInput,15).ds_outRecs;	
	gsaResultsfmt := project(sort(gsaResults(_penalty<=10),_penalty),iesp.gsaverification.t_GSAVerificationRecord);	

	gsaFNameFilter := [inputData.FirstName[Healthcare_Provider_Services.Constants.GSA_STRICT_MATCH_NAME_CHARACTERS],''];
	gsaMNameFilter := [inputData.MiddleName[Healthcare_Provider_Services.Constants.GSA_STRICT_MATCH_NAME_CHARACTERS],''];

	gsaResultsFinal := if(inputdata.StrictMatchGSASanctions,
										 map(inputData.FirstName <> '' and inputData.MiddleName != '' => 
													gsaResultsfmt(Name.First[Healthcare_Provider_Services.Constants.GSA_STRICT_MATCH_NAME_CHARACTERS] in gsaFNameFilter, 
																			  Name.Middle[Healthcare_Provider_Services.Constants.GSA_STRICT_MATCH_NAME_CHARACTERS] in gsaMNameFilter),
												 inputData.FirstName <> '' => 
													gsaResultsfmt(Name.First[Healthcare_Provider_Services.Constants.GSA_STRICT_MATCH_NAME_CHARACTERS] in gsaFNameFilter),
												 gsaResultsfmt),
										gsaResultsfmt);

	export dsGSA := choosen(gsaResultsFinal,iesp.constants.MAX_GSA_VERIFICATION_RESPONSE_RECORDS);
end;
