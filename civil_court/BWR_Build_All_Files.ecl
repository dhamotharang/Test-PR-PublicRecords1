import Civil_Court, Lib_FileServices;

#OPTION('multiplePersistInstances',FALSE);
#workunit('name','Civil Court ' + Civil_Court.Version_Development);
//RUN FIRST
leMailTarget := 'cpettola@seisint.com';

fSendMail(string pSubject,string pBody)
 := lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);

civil_court.Out_Population_Stats(civil_court.File_Moxie_Party_Dev,
                                 civil_court.File_Moxie_Matter_Dev,
								 civil_court.File_Moxie_Case_Activity_Dev,
								 civil_court.Version_Development,
								 DoPopulationStats);

sequential
 (
	//Civil_Court.Out_Missing_Datasets,
	parallel(
			   Civil_Court.Out_Moxie_Party
			  ,Civil_Court.Out_Moxie_Matter
			  ,Civil_Court.Out_Moxie_Case_Activity
			 ),
	fSendMail('Civil Court 1 of 2','Civil Court Moxie files complete'),
	parallel(  
			   Civil_Court.Out_Moxie_Party_Dev_Stats
			  ,Civil_Court.Out_Moxie_Matter_Dev_Stats
			  ,Civil_Court.Out_Moxie_Case_Activity_Dev_Stats
			  ,civil_court.proc_build_key(civil_court.Version_Development)
			  ,civil_court.filterCivilBase_MarriageDivorces
			  ,DoPopulationStats
			 ),
	fSendMail('Civil Court 2 of 2','Civil Court job complete')
 );