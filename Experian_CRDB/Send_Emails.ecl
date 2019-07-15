import tools;

lay_builds 	:= tools.Layout_FilenameVersions.builds;

Export Send_Emails(  string								pversion
										,boolean							pUseOtherEnvironment 		= false
										,boolean							pShouldUpdateRoxiePage	= true
										,dataset(lay_builds)	pBuildFilenames					= keynames(pversion,pUseOtherEnvironment).dAll_filenames
										,string								pEmailList							= Email_Notification_Lists(not pShouldUpdateRoxiePage).BuildSuccess
										,string								pRoxieEmailList					= Email_Notification_Lists(not pShouldUpdateRoxiePage).Roxie
										,string								pBuildName							= _Constants().Name
										,string								pPackageName						= 'ExperianCRDBKeys'
										,string								pBuildMessage						= 'Base file has finished'
										,string							  pUseVersion							= 'qa'
										,string							  pEnvironment						= 'N'		//	'B' - OSS Roxie, 'N' - nonfcra, 'F' - FCRA
								  ) := tools.mod_SendEmails( pversion
																						,pBuildFilenames					
																						,pEmailList							
																						,pRoxieEmailList					
																						,pBuildName							
																						,pPackageName			
																						,pBuildMessage
																						,pShouldUpdateRoxiePage
																						,pUseVersion
																						,pEnvironment
																					);
