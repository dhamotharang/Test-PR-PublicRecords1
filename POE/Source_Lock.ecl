import tools;

export Source_Lock(

	 boolean																				pIsTesting	= false
	,dataset(tools.Layout_FilenameVersions.builds)	pFilenames	= Source_filenames

) :=
	if(pIsTesting = false	
			,tools.mod_PromoteBuild('',pFilenames).LockSuper('Using_In_POE','QA')
			,output(pFilenames,all)
	);
