import _Control, ut, tools;

EXPORT RemoteCopyInfile(	string	pInSuperFile						= '~foreign::' + _control.IPAddress.aprod_thor_dali + '::'+'thor::base::cclue::qa::search::output' // ~foreign::10.194.12.1::
												,	string	pCluster								= _Constants().groupname							 // 'thor400_sta01'
												, string	pRemoteIp								= _control.IPAddress.aprod_thor_dali   // insurance prod 
												//, string	pRemoteIp								= _control.IPAddress.adataland_dali   // insurance dataland 
												, boolean	pCompressed							= true
												, string	pEmailNotificationList	= _control.MyInfo.EmailAddressNotify
												, boolean pIsTesting							= false
											 )
 := function
 
		subfile_cnt 		:= FileServices.GetSuperFileSubCount(pInSuperFile);
		LogicalFileName := if (subfile_cnt > 0, FileServices.GetSuperFileSubName(pInSuperFile, subfile_cnt), 'Super file empty');
		
		rundate  := if (stringlib.stringfind(LogicalFileName, 'foreign',1) > 0,
										stringlib.stringfilter(LogicalFileName[stringlib.stringfind(LogicalFileName, 'thor',1)..],'0123456789')[1..8],
										stringlib.stringfilter(LogicalFileName,'0123456789')[1..8]);
		
		InLogicalFile_Name	:= '~'+LogicalFileName[stringlib.stringfind(LogicalFileName, 'thor',1)..];
		OutLogicalFile_Name := '~thor_data400::in::cclue::'+ rundate + '::search::output';
		
		email_subject_header := CClue._Dataset().Name + ':- Remote Copy Insurance file to ' + _Control.ThisEnvironment.Name + if(pIsTesting ,'(TESTING)','') + ': ';
		
		email_subject_success :=	'Success';
		
		email_body_success :=  'Remote Copied CClue file from Insurance Thor - '+ pRemoteIp +' to '+ _Control.ThisEnvironment.Name +'\n\n Input Superfile Name :- ' + pInSuperFile + '\n Input logicalfile Name:- ' + InLogicalFile_Name + '\n Remote Copied logicalfile Name:- ' + OutLogicalFile_Name;
		
		email_subject_Skipped :=	'SKIPPED';
		
		email_body_skipped :=  'The CClue input remote Copy file already exist on '+ _Control.ThisEnvironment.Name +' cluster, skipped the process. \n\n Input Superfile Name :- ' + pInSuperFile + '\n Input logicalfile Name:- ' + InLogicalFile_Name + '\n Remote Copied logicalfile Name:- ' + OutLogicalFile_Name;
										
										
		fail_email := if(pEmailNotificationList != '', tools.fun_SendEmail(pEmailNotificationList	,email_subject_header + ' Failed'	,workunit + '\n' + failmessage));		
		
		// '10.241.20.205:7070' - Boca Prod
		// '10.194.12.1:7070' - Alpharatte insurance Prod		
		remotecopy := if(LogicalFileName <> 'Super file empty', 
										 if (not FileServices.FileExists(OutLogicalFile_Name),
												 sequential(FileServices.copy(InLogicalFile_Name, pCluster, OutLogicalFile_Name, pRemoteIp, , , , true, true, , pCompressed),
																		FileServices.StartSuperFileTransaction(),
																		FileServices.ClearSuperFile(CClue.FileNames().Input.delete, true),
																		FileServices.ClearSuperFile(CClue.FileNames().Input.Sprayed),
																		FileServices.ClearSuperFile(CClue.FileNames().Input.using),
																		FileServices.AddSuperFile(CClue.FileNames().Input.delete, CClue.FileNames().Input.used,,true),
																		FileServices.AddSuperFile(CClue.FileNames().Input.Sprayed, OutLogicalFile_Name), 
																		FileServices.FinishSuperFileTransaction(),
																		tools.fun_SendEmail(pEmailNotificationList,email_subject_header + email_subject_success,email_body_success)),
												 sequential(output('Input logical file ' + pInSuperFile + ' already exist, skipping the remote copy process.'),
																		tools.fun_SendEmail(pEmailNotificationList,email_subject_header + email_subject_Skipped,email_body_skipped))
												),
										 output('Superfile ' + pInSuperFile + ' is empty, check with Insurance team')
										): failure(fail_email);
		
		return remotecopy;
end;