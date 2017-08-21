EXPORT CheckPrevBaseSet () := function

	LastBuiltVersion:=dataset(bair.Superfile_List().LastBuilt,{string25 Ver},flat,opt)[1].Ver;
	AllBaseFileCount:=if(regexfind('w|W', LastBuiltVersion) = true
											,39
											,25
											);
	FS:=fileservices;
	d:=nothor(FS.LogicalFileList('*::base::bair::*',true,false)
							(regexfind(trim(LastBuiltVersion),name,nocase)));

	ret:=Sequential(
									 if(count(d)<>AllBaseFileCount,FAIL('ERROR: SOME BASE FILES FROM PREVIOUS DELTA BUILD ARE MISSING'))
									);

	return ret;

End;
