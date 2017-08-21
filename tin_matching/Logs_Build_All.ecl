import tools, Inquiry_AccLogs;

export Logs_Build_All(

	 string																pversion
	,boolean															pIsTesting			= _Constants().IsDataland
	,dataset(layouts.input.sprayed			)	pInputfile			= Files().input.logs_thor.using
	,dataset(Inquiry_Acclogs.Layout_MBS	)	pMBSFile				= Inquiry_AccLogs.File_MBS.File

) :=
function

	full_build :=
	sequential(
		 Create_Supers
		,Logs_FindFile(false)
		,Logs_Build_Base			(pversion,pIsTesting,,pInputfile,pMBSFile	)
		,Promote(,'logs').Inputfiles.using2used
		,Promote(,'logs').Buildfiles.Built2QA
		,Logs_Copy		(pversion)
		,Logs_Trigger	(pversion)

	) : success(Send_Emails(pversion,,not pIsTesting).buildsuccess), failure(send_emails(pversion,,not pIsTesting).buildfailure);
	
	return
		if(tools.fun_IsValidVersion(pversion)
			,full_build
			,output('No Valid version parameter passed, skipping tin_matching.Logs_Build_All')
		);

end;