import VersionControl;

export Source_Rollback(

	string pFilter = ''

) :=
module

	shared lfilenames		:= 		Source_Filenames.New
													+ Source_Filenames.NewProd
													+ Source_Filenames.Old
													+ Source_Filenames.OldProd
//													+ Source_Filenames.logical
													;
													
	shared filter				:= if(pFilter = ''	,true
																					,regexfind(pFilter,lfilenames.templatename,nocase)
												);
												
	export all	:= VersionControl.mRollback.BuildFiles2(lfilenames(filter)).BusinessHeader;

end;