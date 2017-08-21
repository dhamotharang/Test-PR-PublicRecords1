EXPORT Input_Set (boolean IsUpdates = true) := function

	LastBuiltVersion:=dataset(bair.Superfile_List().LastBuilt,{string25 Ver},flat,opt)[1].Ver;
	AllBaseFileCount:=if(regexfind('w|W', LastBuiltVersion) = true
											,39
											,25
											);
	FS:=fileservices;
	d:=nothor(FS.LogicalFileList('*::base::bair::*',true,false)
							(regexfind(trim(LastBuiltVersion),name,nocase)));
	s:='(.*)(qa$)';
	t:=table(FS.LogicalFileList('*::base::bair::*',true,false)
							(regexfind(trim(LastBuiltVersion),name,nocase))
					,{
					 sf:=regexreplace('qa',FS.LogicalFileSuperOwners('~'+name)(regexfind('qa',name))[1].name,if(IsUpdates,'nightly_building','weekly_building'))
					,lf:=name
					});

	ret:=Sequential(
									 if(count(d)<>AllBaseFileCount,FAIL('ERROR: SOME BASE FILES FROM PREVIOUS DELTA BUILD ARE MISSING'))
									,FS.StartSuperFileTransaction()
									,nothor(apply(t,FS.AddSuperfile('~'+trim(sf),'~'+trim(lf))))
									,FS.FinishSuperFileTransaction()
									);

	return ret;

End;
