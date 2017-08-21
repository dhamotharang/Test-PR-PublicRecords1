import Versioncontrol, _control;

export fn_SprayInputFiles(
	 string		pSourceIP
	,string		pSourcefile
	,string		pThorFilename
	,string		updatetype
	,string   state
	,string		pGroupName		= 'thor400_44'
	,boolean	pOverwrite		= true
	,string		pEmailAddress	= ''
) :=
function

	lFile				:= regexreplace('^.*?/([^/]*)$', pSourcefile, '$1');
	lDirectory	:= regexreplace('^(.*?/)[^/]*$', pSourcefile, '$1');
   
	 
Integer record_size:=marriage_divorce_v2.fn_GetInputRecLength(updatetype,state);
string 	pEmailNotificationList := _control.MyInfo.EmailAddressNotify;
	FilesToSpray := DATASET([

	 	{pSourceIP
	 	,lDirectory
	 	,lFile
	 	,marriage_divorce_v2.fn_GetInputRecLength(updatetype,state)
	 	,pThorFilename
	 	,[{marriage_divorce_v2.mGetInputSuperfile(updatetype,state)}]
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
				,pEmailNotificationList + ';'+ pEmailAddress
				,'Mar_Div_V2 ' + lFile
				
				);

end;
