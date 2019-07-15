
import crim_common, CrimSrch, Lib_FileServices, doxie_build, hygenics_search,hygenics_images,Lib_date,scrubs,scrubs_crim;
      #OPTION('multiplePersistInstances',FALSE);
			#workunit('name','Accurint-Securint Criminal Build ' + CrimSrch.Version.Development);
			
			// Modify to Include Your Email
			leMailTarget := 'vani.chikte@lexisnexis.com';

			fSendMail(string pSubject, string pBody)
			:= lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);

			// Populates NonFCRA Crim Strata Reports
			Hygenics_crim.Out_STRATA_Population_Stats(
																											Hygenics_crim.File_Moxie_DOC_Punishment_Dev
																											, Hygenics_crim.File_Moxie_Crim_Offender2_Dev
																											, Hygenics_crim.File_Moxie_Court_Offenses_Dev
																											, Hygenics_crim.File_Moxie_DOC_Offenses_Dev
																											, Hygenics_images.File_Images
																											, Hygenics_crim.File_Moxie_Crim_Offender2_Dev
																											, CrimSrch.Version.Development
																											, DoTheStats);
                                
                                //Populates FCRA Crim Strata Reports
			Hygenics_Search.Out_Population_Stats(Hygenics_Search.File_Moxie_Offender_Dev,
																					 Hygenics_Search.File_Moxie_Offenses_Dev,
																					 Hygenics_Search.File_Moxie_CourtOffenses_Dev,
																					 Hygenics_Search.File_Moxie_Punishment_Dev,
																					 CrimSrch.Version.Development,
																					 zRunStrataPopulationStats);

					sequential
					(
													Scrubs_Crim.fn_RunScrubsRaw(CrimSrch.Version.Development,'Charles.Pettola@lexisnexis.com,vani.chikte@lexisnexis.com'),
													// Hygenics_Search.Out_Version_Attribute_Values,
													// Hygenics_Search.Out_Vendor_Select_Attribute_Values,
													
													 hygenics_crim.proc_build_DOC_bases,
													
													fSendMail('Accurint-Securint Build 1 of 2','Accurint-Securint Build ' +                                                                   
													CrimSrch.Version.Development + ':  OUT files complete, stats running'),
													
													parallel(
																		CrimSrch.Out_Stats,
																		CrimSrch.Out_Flagged_Files,
																		Hygenics_crim.proc_build_DOC_keys(CrimSrch.Version.Development)
																	),
													
													Hygenics_crim.proc_AcceptSK_DOC_To_QA,
													hygenics_crim.Proc_FCRA_Field_Deprecation_Stats,				//DF-21868
													
													DoTheStats,
													zRunStrataPopulationStats,
													
													fSendMail('Accurint-Securint Build 2 of 2','Accurint-Securint Build' + 
													CrimSrch.Version.Development + ':  Finishing last keys. \r\n \r\n ' +
													'Results and stats:  http://10.150.28.12:8010/WsWorkunits/WUInfo?Wuid=' + workunit + '\r\n'),
													
													//Modify to Include Your Email
													lib_fileservices.fileservices.sendemail('vani.chikte@lexisnexis.com',
																					'Securint Crim Build: ' + CrimSrch.Version.Development,
																					'Securint Crim Build: ' + CrimSrch.Version.Development + '\r\n' +
																					'Accurint Crim Version Used: ' + CrimSrch.Version.CrimOffender + 
																					'\r\n' +
																					'Note:  This is Dev only at this point!'
																																															),
													Scrubs_Crim.fn_RunScrubsBase(CrimSrch.Version.Development,'Charles.Pettola@lexisnexis.com,vani.chikte@lexisnexis.com')
					);
