import VersionControl;

export Rollback(

	 string		pFilter			= ''
	,boolean	pIsTesting 	= false

) :=
module
	
	export Input := 
	module
	
		shared dfilenames			:= Filenames().Input.dAll_filenames;
		shared inputrollbacks := VersionControl.mRollback.InputFiles2(dFilenames);
		
		export Sprayed2Root														:= inputrollbacks.Sprayed2Root						;
		export Using2Sprayed													:= inputrollbacks.Using2Sprayed						;
		export Used2Sprayed(boolean pDelete = false)	:= inputrollbacks.Used2Sprayed	(pDelete)	;
		export Delete2Used														:= inputrollbacks.Delete2Used							;
                                                                                                
	end;



	shared dfilenames		:=  Filenames				().dAll_filenames
												+ Keynames				().dAll_filenames
												;
	
	;
	shared filter				:= if(pFilter 		= ''	,true
																							,regexfind(pFilter		,dfilenames.templatename		,nocase)
												);
	
	export dfilestorollback := dfilenames(filter);
												
	shared baserollback := VersionControl.mRollback.BuildFiles2	(dfilestorollback);

	export Father2Prod		(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)	:= if(pIsTesting = false, baserollback.Father2Prod		(pDelete,pCheckVersionIntegrity	),output(dfilestorollback));
	export Prod2QA				(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)	:= if(pIsTesting = false, baserollback.Prod2QA				(pDelete,pCheckVersionIntegrity	),output(dfilestorollback));
	export Father2QA			(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)	:= if(pIsTesting = false, baserollback.Father2QA			(pDelete,pCheckVersionIntegrity	),output(dfilestorollback));
	export QA2Built				(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)	:= if(pIsTesting = false, baserollback.QA2Built				(pDelete,pCheckVersionIntegrity	),output(dfilestorollback));
	export Built2Building	(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)	:= if(pIsTesting = false, baserollback.Built2Building	(pDelete,pCheckVersionIntegrity	),output(dfilestorollback));
		                                                                                                    
end;