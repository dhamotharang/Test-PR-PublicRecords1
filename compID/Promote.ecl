export Promote(
				string pVersion = Version
				,string pTarget = 'thor_data400::in::alpharetta::compid'
				)	:=	module

	purge_SF:= FileServices.DeleteSuperFile('~'+pTarget+'_delete',true);
	createSF_del:= FileServices.CreateSuperFile('~'+pTarget+'_delete');
	export _delete:=sequential(purge_SF, createSF_del);

	list:=FileServices.SuperFileContents('~'+pTarget+'_father');
	clearSF:= FileServices.ClearSuperfile('~'+pTarget+'_father');
	add2SF:= nothor(apply(list, fileServices.AddSuperFile('~'+pTarget+'_delete', '~'+name)));
	export _father:=sequential(add2SF, clearSF);

	list:=FileServices.SuperFileContents('~'+pTarget);
	clearSF:= FileServices.ClearSuperfile('~'+pTarget);
	add2SF:= nothor(apply(list, fileServices.AddSuperFile('~'+pTarget+'_father', '~'+name)));
	export _prod:=sequential( add2SF, clearSF);

	list:=FileServices.LogicalFileList(pTarget+'*'+pVersion,,false);
	add2SF:= nothor(apply(list, fileServices.AddSuperFile('~'+pTarget, '~'+name)));
	export _new:=sequential(add2SF);

end;