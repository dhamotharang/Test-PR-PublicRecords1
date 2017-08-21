import VersionControl;

export Promote(

	 string		pversion		= ''
	,string		pFilter			= ''
	,boolean	pDelete			= false
	,boolean	pIsTesting	= false

) :=
module
	
	export Input := 
	module
		shared dfilenames			:= Filenames().Input.dAll_filenames;
		
		shared filter				:= if( pFilter = ''	
																,true
																,regexfind('::' + pFilter + '$',dfilenames.templatename)
														);
		
		shared inputpromote 	:= VersionControl.mPromote.InputFiles2(dFilenames(filter));
		
		export Root2Sprayed		:= if(pIsTesting = false ,inputpromote.Root2Sprayed	()	,output(dfilenames(filter),all));
		export Sprayed2Using	:= if(pIsTesting = false ,inputpromote.Sprayed2Using		,output(dfilenames(filter),all));
		export Using2Used			:= if(pIsTesting = false ,inputpromote.Using2Used		()	,output(dfilenames(filter),all));

	end;


	shared dfilenames		:= 		Filenames	(pversion).dAll_filenames
													;

	shared filter				:= if(pFilter = ''	,true
																					,regexfind(pFilter,dfilenames.templatename,nocase)
												);
												
	shared basepromote 	:= VersionControl.mPromote.BuildFiles2(dfilenames(filter),,pDelete);

	export New2Built							:= if(pIsTesting = false ,basepromote.New2Built			(pversion)						,output(dfilenames(filter),all));
	export Built2QA								:= if(pIsTesting = false ,basepromote.Built2QA														,output(dfilenames(filter),all));
	export QA2Prod								:= if(pIsTesting = false ,basepromote.QA2Prod															,output(dfilenames(filter),all));
	export LockForPOE							:= if(pIsTesting = false ,basepromote.Super2SuperLock('Using_In_POE','QA'),output(dfilenames(filter),all));

end;
