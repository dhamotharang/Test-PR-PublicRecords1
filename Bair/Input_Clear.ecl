EXPORT Input_Clear (boolean IsUpdates = true) := function

	FS:=fileservices;
	d:=FS.LogicalFileList('*::base::*'+if(IsUpdates,'nightly_building','weekly_building'),false,true);

	ret:=Sequential(
									 FS.StartSuperFileTransaction()
									,nothor(apply(d,FS.RemoveOwnedSubFiles('~'+trim(name),true)))
									,nothor(apply(d,FS.ClearSuperfile     ('~'+trim(name))))
									,FS.FinishSuperFileTransaction()
									);

	return ret;

End;
