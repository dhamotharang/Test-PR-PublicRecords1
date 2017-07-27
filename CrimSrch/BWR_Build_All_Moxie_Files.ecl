import CrimSrch, Lib_FileServices,doxie_build, Life_EIR;

#workunit('name','Securint Criminal Build ' + CrimSrch.Version.Development);

leMailTarget := 'cpettola@seisint.com';

fSendMail(string pSubject, string pBody)
 := lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);

CrimSrch.Out_Population_Stats(crimsrch.File_Moxie_Offender_Dev,
							  CrimSrch.File_Moxie_Offenses_Dev,
							  CrimSrch.File_Moxie_Punishment_Dev,
							  CrimSrch.Version.Development,
							  zRunStrataPopulationStats
							 )

sequential
 (
	CrimSrch.Out_Version_Attribute_Values,
	CrimSrch.Out_Vendor_Select_Attribute_Values,
	parallel(
				CrimSrch.Out_Offender,
				CrimSrch.Out_Offenses,
				CrimSrch.Out_Punishment,
				CrimSrch.Out_Activity
			 ),
	fSendMail('Securint Build 1 of 2','Securint Build ' + CrimSrch.Version.Development + ':  OUT files complete, stats running'),
	parallel(
				CrimSrch.Out_Stats,
				zRunStrataPopulationStats,

				CrimSrch.Out_Flagged_Files,
				doxie_build.proc_build_DOC_FCRA_keys(CrimSrch.Version.Development),
				Life_EIR.proc_build_fcra_keys(CrimSrch.Version.Development)
			 ),
	fSendMail('Securint Build 2 of 2','Securint Build' + CrimSrch.Version.Development + ':  Finishing last keys. \r\n \r\n ' +
			  'Results and stats:  http://10.150.28.12:8010/WsWorkunits/WUInfo?Wuid=' + workunit + '\r\n'),
	lib_fileservices.fileservices.sendemail('aabell@seisint.com,nmartinez@seisint.com',
											'Securint Crim Build ' + CrimSrch.Version.Development,
											'          Securint Crim Build: '	+ CrimSrch.Version.Development	+ '\r\n' +
											'   Accurint Crim Version Used: '	+ CrimSrch.Version.CrimOffender	+ '\r\n' +
											'Accurint SexPred Version Used: '	+ CrimSrch.Version.SexPred		+ '\r\n' +
											'\r\n'	+
											'Note:  This is Dev only at this point!'
										   )

 );