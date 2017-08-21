import ut,VersionControl,_control;

export MAC_Spray_Input_Files(

	 string		pSourceIP
	,string		pSourcefile
	,string		pThorFilename
	,string		pUpdatetype
	,string		pGroupName							=	if(	_Control.ThisEnvironment.name		 = 'Dataland'	,'thor_dataland_linux'
																																						,'thor_dell400'
																			)
	,boolean	pOverwrite							= false
	,string		pEmailNotificationList	= ''

) :=
function

	lFile				:= regexreplace('^.*?/([^/]*)$'											,pSourcefile	, '$1');
	lDirectory	:= regexreplace('^(.*?/)[^/]*$'											,pSourcefile	, '$1');
	lState			:= regexreplace('^.*?::[0-9]{8}::([a-zA-Z]{2})::.*$',pThorFilename, '$1');

	FilesToSpray := DATASET([

	 	{pSourceIP
	 	,lDirectory
	 	,lFile
	 	,GetUpdateRecordLength(pUpdatetype)
	 	,pThorFilename
	 	,[{GetUpdateSuperFilename(pUpdatetype)}]
	 	,pGroupName
		,''						
		,''		
		,'FIXED'			
		,''						
		,8192					
		,''				
		,''	
		,''					
		,false					
	 	}
	], VersionControl.Layout_Sprays.Info);

	return VersionControl.fSprayInputFiles(FilesToSpray
				,
				,
				,pOverwrite,,,
				,Email_Notification_List_Spray + ';' + pEmailNotificationList
				,'CorpV1 ' + lState + ' ' + pUpdatetype);

end;