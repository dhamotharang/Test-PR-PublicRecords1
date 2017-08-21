export Proc_Build_All(

	string pVersion

) := 
module
	export Spray_files				:= DNB.Proc_Spray_DNB(pVersion)	: success(output('Input Files Spray Completed.'));
	export Update_bases			:= DNB.Make_DNB_Updated_Base	: success(output('Base Files Updated.'));
	export Build_Roxie_Keys	:= DNB.proc_build(pVersion)		: success(output('Roxie Keys built'));
	export company_counts		:= DNB.Query_DNB_Company_Counts	: success(output('Company counts finished'));
	export contacts_counts	:= DNB.Query_DNB_Contact_Counts	: success(output('Contact counts finished'));
	export company_sample		:= Output(choosen(sort(DNB.File_DNB_Base(bdid > 0), -date_last_seen),1000)) : success(output('Company Samples Created'));
	export contacts_sample	:= Output(choosen(sort(DNB.File_DNB_Contacts_Base(bdid > 0), -date_last_seen),1000)) : success(output('Contacts Samples Created'));

	export All := 
	sequential(
		
		Spray_files
		,Update_bases		
		,Build_Roxie_Keys	
		,company_counts
		,contacts_counts
		,company_sample
		,contacts_sample
		,DNB.Out_Population_Stats(pversion)
    ,DNB.Strata_Grid_Stats(pversion).all
		
	)  : success(Send_Email(pVersion).BuildSuccess), failure(Send_Email(pVersion).BuildFailure);

end;