pversion := '';

#workunit('name','BIPV2_Build.Rename_All_BIPV2FullKeys ' + pversion);
BIPV2_Build.Rename_All_BIPV2FullKeys(
	 pversion			          := pversion
	,pFilter			          := ''
	,pIsTesting		          := true
  ,pSuperfileVersion	    := 'qa'
  ,pFilesToRename		      := BIPV2_Build.keynames	(pversion).BIPV2FullKeys
  ,pShouldUpdateRoxiePage := false
);
