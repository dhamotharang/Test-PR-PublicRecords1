//change crimSrch.Version.Development and hygnics_search.Version.Development


import CrimSrch, Lib_FileServices, doxie_build, hygenics_search;

		#workunit('name','Securint Criminal Build ' + CrimSrch.Version.Development);
		
		//Modify to Include Your Email
		leMailTarget := 'charles.pettola@lexisnexis.com';

		fSendMail(string pSubject, string pBody)
		 := lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);

		//Populates Crim Strata Reports
		Hygenics_Search.Out_Population_Stats(Hygenics_Search.File_Moxie_Offender_Dev,
							  Hygenics_Search.File_Moxie_Offenses_Dev,
							  Hygenics_Search.File_Moxie_Punishment_Dev,
							  CrimSrch.Version.Development,
							  zRunStrataPopulationStats
					           )
		sequential
		 (//Hygenics_Search.Out_Version_Attribute_Values,
			//Hygenics_Search.Out_Vendor_Select_Attribute_Values,
			
			parallel(
				Hygenics_Search.Out_Offender,
				Hygenics_Search.Out_Offenses,
				Hygenics_Search.Out_Punishment,
				Hygenics_Search.Out_Activity
			 	),
			
			fSendMail('Securint Build 1 of 2','Securint Build ' + 					
			CrimSrch.Version.Development + ':  OUT files complete, stats running'),
			
			parallel(zRunStrataPopulationStats,
				CrimSrch.Out_Stats,
				CrimSrch.Out_Flagged_Files,
					Hygenics_Search.proc_build_DOC_FCRA_keys
					(CrimSrch.Version.Development),
				Hygenics_Search.Life_EIR_proc_build_fcra_keys 				
					(CrimSrch.Version.Development)
				 ),
			
			fSendMail('Securint Build 2 of 2','Securint Build' + 
			CrimSrch.Version.Development + ':  Finishing last keys. \r\n \r\n ' +
			'Results and stats:  http://10.150.28.12:8010/WsWorkunits/WUInfo?Wuid=' + 				workunit + '\r\n'),
			
			//Modify to Include Your Email
			lib_fileservices.fileservices.sendemail('vani.chikte@lexisnexis.com',
				'Securint Crim Build: ' + CrimSrch.Version.Development,
				'Securint Crim Build: ' + CrimSrch.Version.Development + '\r\n' +
				'Accurint Crim Version Used: ' + CrimSrch.Version.CrimOffender + 
				'\r\n' +
				'Accurint SexPred Version Used: ' + CrimSrch.Version.SexPred + '\r\n' 
				+'\r\n' +
				'Note:  This is Dev only at this point!'
		 			    		     )
		 );
