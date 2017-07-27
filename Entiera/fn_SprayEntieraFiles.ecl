import Versioncontrol, _control;

export fn_SprayEntieraFiles(
	 string		pSourceIP
	,string		pSourcefile
	,string		pThorFilename
	,string		updatetype
	,string   state
	,string		pGroupName		= 'thor_200'
	,boolean	pOverwrite		= false
	,string		pEmailAddress	= ''
) :=
function

	lFile				:= regexreplace('^.*?/([^/]*)$', pSourcefile, '$1');
	lDirectory	:= regexreplace('^(.*?/)[^/]*$', pSourcefile, '$1');
   
	 
Integer record_size:= 0;
string 	pEmailNotificationList := _control.MyInfo.EmailAddressNotify;
	FilesToSpray := DATASET([

	 	{pSourceIP
	 	,lDirectory
	 	,lFile
	 	,0
	 	,pThorFilename
	 	,[{''}]
	 	,pGroupName
	 	,''
		,'[0-9]{8}'	
		,if(record_size=0,'VARIABLE','FIXED')
		}
	], VersionControl.Layout_Sprays.Info);

	return VersionControl.fSprayInputFiles(FilesToSpray
				,
				,
				,pOverwrite,,,
				,pEmailNotificationList + ';'+  pEmailAddress
				,'Entiera ' + lFile);

end;


