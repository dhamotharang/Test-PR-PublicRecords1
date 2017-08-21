import VersionControl;

export Rollback(

	 string		pFilter			= ''
	,string		pNewFilter	= ''
	,boolean	pIsTesting 	= false

) :=
module
	
	shared dfilenames		:=  Filenames				().dAll_filenames
												+ Keynames				().dAll_filenames
												+ Moxie_Keynames	().dAll_filenames
												;
	
	;
	shared filter				:= if(pFilter 		= ''	,true
																							,regexfind(pFilter		,dfilenames.templatename		,nocase)
												);
	shared newfilter		:= if(pNewFilter	= ''	,true
																							,regexfind(pNewFilter	,dfilenames.templatenameNew	,nocase)
												);
	
	export dfilestorollback := dfilenames(filter,newfilter);
												
	shared baserollback := VersionControl.mRollback.BuildFiles2	(dfilestorollback);

	export Father2Prod		(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)	:= if(pIsTesting = false, baserollback.Father2Prod		(pDelete,pCheckVersionIntegrity	),output(dfilestorollback,all));
	export Prod2QA				(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)	:= if(pIsTesting = false, baserollback.Prod2QA				(pDelete,pCheckVersionIntegrity	),output(dfilestorollback,all));
	export Father2QA			(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)	:= if(pIsTesting = false, baserollback.Father2QA			(pDelete,pCheckVersionIntegrity	),output(dfilestorollback,all));
	export QA2Built				(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)	:= if(pIsTesting = false, baserollback.QA2Built				(pDelete,pCheckVersionIntegrity	),output(dfilestorollback,all));
	export Built2Building	(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)	:= if(pIsTesting = false, baserollback.Built2Building	(pDelete,pCheckVersionIntegrity	),output(dfilestorollback,all));
		                                                                                                    
end;