import VersionControl;

export Rollback :=
module
	
	export Input := 
	module
		shared dfilenames		:= Filenames().Input.dAll_filenames;
	
		

		shared inputrollbacks := VersionControl.mRollback.InputFiles2(dFilenames);
		
		export Sprayed2Root														:= inputrollbacks.Sprayed2Root						;
		export Using2Sprayed													:= inputrollbacks.Using2Sprayed						;
		export Used2Sprayed(boolean pDelete = false)	:= inputrollbacks.Used2Sprayed	(pDelete)	;
		export Delete2Used														:= inputrollbacks.Delete2Used							;
                                                                                                
	end;

	shared dfilenames		:= Filenames().base.dAll_filenames;
	

	shared baserollback := VersionControl.mRollback.BuildFiles2(dFilenames);

	export Father2Prod		(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)	:= baserollback.Father2Prod		(pDelete,pCheckVersionIntegrity	);
	export Prod2QA				(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)	:= baserollback.Prod2QA				(pDelete,pCheckVersionIntegrity	);
	export Father2QA			(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)	:= baserollback.Father2QA			(pDelete,pCheckVersionIntegrity	);
	export QA2Built				(boolean pDelete = false,boolean pCheckVersionIntegrity	= false)	:= baserollback.QA2Built			(pDelete,pCheckVersionIntegrity	);

end;