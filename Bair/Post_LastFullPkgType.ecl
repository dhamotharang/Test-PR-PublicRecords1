import PromoteSupers;
EXPORT Post_LastFullPkgType(boolean BooleanPkg = false) := module
	
	ds := dataset([{BooleanPkg}], bair.layouts.rLastFullPkgType);
	PromoteSupers.MAC_SF_BuildProcess(ds, bair.Superfile_List().LastFullPkgType, PostLastFullPkg ,2,,true);
	EXPORT all := PostLastFullPkg;

End;