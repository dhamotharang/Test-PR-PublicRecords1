import Versioncontrol, _control;

export fSprayInputFiles(
	 string		pSourceIP
	,string		pSourcefile
	,string		pThorFilename
	,string		pCorpType
	,string		pGroupName		= if(	_Control.ThisEnvironment.name	= 'Dataland','thor_dataland_linux','thor400_92')
	,boolean	pOverwrite		= false
	,string		pEmailAddress	= ''
) :=
function

	lFile				:= regexreplace('^.*?/([^/]*)$', pSourcefile, '$1');
	lDirectory	:= regexreplace('^(.*?/)[^/]*$', pSourcefile, '$1');

	FilesToSpray := DATASET([

	 	{pSourceIP
	 	,lDirectory
	 	,lFile
	 	,fGetInputRecordLength(pCorpType)
	 	,pThorFilename
	 	,[{mGetInputSuperfile(pCorpType).sprayed}
		 ,{mGetInputSuperfile(pCorpType).root}]
	 	,pGroupName
	 	}
	], VersionControl.Layout_Sprays.Info);

	return VersionControl.fSprayInputFiles(FilesToSpray
				,//'~thor_data400::sprayinfo::corp2::new'
				,//'~thor_data400::sprayinfo::corp2::new::20070426'
				,pOverwrite,,,
				,corp2.Email_Notification_Lists.spray + ';' + pEmailAddress
				,'CorpV2 ' + lFile);

end;
