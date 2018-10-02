import ut, VersionControl, tools, _control, Orbit3, Scrubs, std, Scrubs_Experian_CRDB;

export Build_All(  string													fileDate
                  ,string													pversion
									,boolean												pIsTesting	 = false
									,boolean												pOverwrite	 = false																															
									,dataset(Layouts.Input.sprayed)	pSprayedFile = Files().Input.sprayed
									,dataset(Layouts.Base					)	pBaseFile		 = Files().base.qa	
								 ):= function

	full_build :=	sequential(Create_SuperFiles
													 ,VersionControl.fSprayInputFiles(Spray_Raw_file(fileDate).Input)
													 ,Build_Base		(pversion,pIsTesting,pSprayedFile,pBaseFile)
													 ,Build_Keys		(pversion).all
													 ,Build_Strata	(pversion,pOverwrite,,,pIsTesting)
													 ,Promote().Inputfiles.using2used
													 ,Promote().Buildfiles.Built2QA
													 ,QA_Record_Samples()
													 ,Orbit3.proc_Orbit3_CreateBuild ('Experian_CRDB',pversion,'N')
													 ,Scrubs.ScrubsPlus('Experian_CRDB','Scrubs_Experian_CRDB','Scrubs_Experian_CRDB_Base', 'Base', pVersion,Experian_CRDB.Email_Notification_Lists().Stats,false)
												  ) : success(Send_Emails(pversion,,not pIsTesting).Roxie),
														  failure(send_emails(pversion,,not pIsTesting).buildfailure);
													
	return if(tools.fun_IsValidVersion(pversion)
						,full_build
						,output('No Valid version parameter passed, skipping Experian_CRDB.Build_All')
					  );

end;