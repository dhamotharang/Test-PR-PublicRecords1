import tools,std,BIPV2_LGID3,bipv2_build;
fbuildlayout := tools.Layout_FilenameVersions.builds;

export proc_rename_BIPV2FullKeys(

	 pversion
	,pFilter					  = '\'bipv2_proxid|strnbrname|bipv2_relative|biz_preferred\''
	,pIsTesting				  = 'true'	                                    // set to false to actually rename the keys
	,pFilesToRename		  = 'bipv2_build.keynames	(pversion).BIPV2FullKeys'
	,pSuperfileVersion	= '\'qa\''
  
) :=
functionmacro

  eclsample		:=  '#workunit(\'name\',\'BIPV2_Build.Rename_BIPV2FullKeys @version@\');\n#workunit(\'priority\',\'high\');\n' 
                + 'BIPV2_Build.Rename_BIPV2FullKeys(\'@version@\',\'' + pFilter + '\',' + #TEXT(pIsTesting)+ ',' + regexreplace('pversion',#TEXT(pFilesToRename),'\'' + pversion + '\'',nocase) + ',\'' + pSuperfileVersion + '\');';
  cluster     := wk_ut._constants.LocalHthor;
  
  kickBuild	  := wk_ut.mac_ChainWuids(eclsample,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'Rename_BIPV2FullKeys',pNotifyEmails := BIPV2_Build.mod_email.emailList,pPollingFrequency := '1'
  ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::Rename_BIPV2FullKeys'
  ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );
  
  return sequential(kickBuild);

endmacro;
