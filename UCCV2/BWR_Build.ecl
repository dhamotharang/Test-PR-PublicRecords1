import UCCV2, Lib_FileServices,RoxieKeybuild,orbit_report,Scrubs_UCCV2,Orbit3;

export BWR_Build(string filedate) := FUNCTION

//#workunit('name','UCC Rewrite Build CA,DnB, IL,TD,TH, NYC,TX, MA' );

leMailTarget      := 'Abednego.Escobal@lexisnexisrisk.com,Manuel.Tarectecan@lexisnexisrisk.com,zhuang@seisint.com,christopher.brodeur@lexisnexisrisk.com,randy.reyes@lexisnexisrisk.com,intel357@bellsouth.net';
SuperfileParty    :=UCCv2.Cluster.Cluster_out+'base::UCC::Party';
SuperFIleMain     :=UCCv2.Cluster.Cluster_out+'base::UCC::main';

fSendMail(string pSubject, string pBody)
      := lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);

BuildBase    := sequential(FileServices.ClearSuperFile('~thor_data400::base::ucc::party_name' ),
							uCCV2.Make_Main_Base,
							UCCV2.Make_party_Base);

orbit_report.UCC_Stats(getretval);

buildprocess := sequential(
							// Run preprocess
							Call_Manage_InSuperfiles(true,true),
							UCCV2.procPreProcess_CA(filedate),
							UCCV2.ProcPreProcess_DNB(filedate),
							UCCV2.ProcPreProcess_IL(filedate),
							UCCV2.ProcPreProcess_MA(filedate),
							UCCV2.ProcPreProcess_NYC(filedate),
							UCCV2.ProcPreProcess_TX(filedate),
							
							// Will move logical files from in superfiles to using
							Call_Manage_InSuperfiles(true),
							BuildBase,
							Scrubs_UCCV2.fn_RunScrubs(filedate,leMailTarget),
							fSendMail('UCC Build 1 of 2','Base files complete, Key is building'),							
			        		parallel(	
									   UCCV2.proc_autokeybuild(filedate),
										 										 
									   UCCV2.Proc_Build_UCC_Keys(filedate)),
									   UCCV2.Proc_Build_Boolean_Keys(fileDate),
										 RoxieKeyBuild.updateversion('UCCV2Keys',filedate,'Abednego.Escobal@lexisnexisrisk.com,Manuel.Tarectecan@lexisnexisrisk.com,christopher.brodeur@lexisnexisrisk.com,Randy.Reyes@lexisnexisrisk.com',,'N|B'),
										 //RoxieKeyBuild.updateversion('FCRA_UCCKeys',filedate,'randy.reyes@lexisnexisrisk.com, Abednego.Escobal@lexisnexisrisk.com, Manuel.Tarectecan@lexisnexisrisk.com',,'F'),
									   UCCV2.Strata_Pop_Base(fileDate),
							fSendMail('UCC Build 2 of 2 ' + filedate,'Key Finishing last keys. \r\n \r\n ' ),
							// Will clean using superfiles and remove the corresponding files from in 
							// superfiles
							Call_Manage_InSuperfiles(false),
							getretval,
							Orbit3.proc_Orbit3_CreateBuild ('UCC Filings',filedate,'N|B'),
							//Orbit3.proc_Orbit3_CreateBuild ('FCRA UCC Filings',filedate,'F'),
							
					)		: Success(FileServices.SendEmail('christopher.brodeur@lexisnexisrisk.com, intel357@bellsouth.net, randy.reyes@lexisnexisrisk.com, Abednego.Escobal@lexisnexisrisk.com, Manuel.Tarectecan@lexisnexisrisk.com', 'UCC - Build Complete', thorlib.wuid())),
	              Failure(FileServices.SendEmail('christopher.brodeur@lexisnexisrisk.com, intel357@bellsouth.net, randy.reyes@lexisnexisrisk.com, Abednego.Escobal@lexisnexisrisk.com, Manuel.Tarectecan@lexisnexisrisk.com', 'UCC - Build Failure', thorlib.wuid() + '\n' + FAILMESSAGE));
 return buildprocess;
 
 end;