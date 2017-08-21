import VersionControl;

export Rollback(

	string pFilter = ''

) :=
module
	
	export Input := 
	module
		shared dfilenames			:= Filenames().Input.dAll_filenames;
		shared filter				:= if(pFilter = ''	,true
																						,regexfind(pFilter,dfilenames.templatename,nocase)
													);
		shared inputrollbacks := VersionControl.mRollback.InputFiles2(dFilenames);
		
		export Sprayed2Root														:= inputrollbacks.Sprayed2Root						;
		export Using2Sprayed													:= inputrollbacks.Using2Sprayed						;
		export Used2Sprayed                         	:= inputrollbacks.Used2Sprayed	        	;
		export Delete2Used														:= inputrollbacks.Delete2Used							;
                                                                                                
	end;
	
	export Base := 
	module
		shared dfilenames		:=	Filenames().base.dAll_filenames
													;
													
		shared filter				:= if(pFilter = ''	,true
																						,regexfind(pFilter,dfilenames.templatename,nocase)
													);
		shared buildrollback := VersionControl.mRollback.BuildFiles2	(dfilenames(filter)			);

		export Father2Prod		(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)	:= buildrollback.Father2Prod		(pDelete,pCheckVersionIntegrity	);
		export Prod2QA				(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)	:= buildrollback.Prod2QA				(pDelete,pCheckVersionIntegrity	);
		export Father2QA			(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)	:= buildrollback.Father2QA			(pDelete,pCheckVersionIntegrity	);
		export QA2Built				(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)	:= buildrollback.QA2Built				(pDelete,pCheckVersionIntegrity	);
		export Built2Building	(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)	:= buildrollback.Built2Building	(pDelete,pCheckVersionIntegrity	);
		                                                                                                    
	end;

	export RoxieKeys := 
	module
		shared dfilenames		:=	Keynames().dAll_filenames
													;
													
		shared filter				:= if(pFilter = ''	,true
																						,regexfind(pFilter,dfilenames.templatename,nocase)
													);
		shared buildrollback := VersionControl.mRollback_old.BuildFiles2	(dfilenames(filter)			);

		export Father2Prod		(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)	:= buildrollback.Father2Prod		(pDelete,pCheckVersionIntegrity	);
		export Prod2QA				(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)	:= buildrollback.Prod2QA				(pDelete,pCheckVersionIntegrity	);
		export Father2QA			(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)	:= buildrollback.Father2QA			(pDelete,pCheckVersionIntegrity	);
		export QA2Built				(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)	:= buildrollback.QA2Built				(pDelete,pCheckVersionIntegrity	);
		export Built2Building	(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)	:= buildrollback.Built2Building	(pDelete,pCheckVersionIntegrity	);
		                                                                                                    
	end;

	export Father2Prod		(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)		:= 
	parallel(
		 base.Father2Prod			(pDelete,pCheckVersionIntegrity	)
		,roxiekeys.Father2Prod(pDelete,pCheckVersionIntegrity	)
	);                    

	export Prod2QA				(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)		:= 
	parallel(
		 base.Prod2QA			(pDelete,pCheckVersionIntegrity	)
		,roxiekeys.Prod2QA(pDelete,pCheckVersionIntegrity	)
	);                

	export Father2QA			(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)		:= 
	parallel(
		 base.Father2QA			(pDelete,pCheckVersionIntegrity	)
		,roxiekeys.Father2QA(pDelete,pCheckVersionIntegrity	)
	);                  

	export QA2Built				(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)		:= 
	parallel(
		 base.QA2Built			(pDelete,pCheckVersionIntegrity	)
		,roxiekeys.QA2Built (pDelete,pCheckVersionIntegrity	)
	);                  

	export Built2Building	(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)		:= 
	parallel(
		 base.Built2Building			(pDelete,pCheckVersionIntegrity	)
		,roxiekeys.Built2Building (pDelete,pCheckVersionIntegrity	)
	);                        

end;