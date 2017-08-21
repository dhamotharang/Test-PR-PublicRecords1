import VersionControl;

export Promote(

	 string		pversion	= ''
	,string		pFilter		= ''
	,boolean	pDelete		= false

) :=
module
	
	export Input := 
	module
	
		shared dfilenames		:= Filenames().Input.dAll_filenames;
		shared filter				:= if(pFilter = ''	,true
																						,regexfind(pFilter,dfilenames.templatename,nocase)
													);
		
		shared inputpromote 	:= VersionControl.mPromote.InputFiles2(dFilenames(filter));
		
		export Root2Sprayed		:= inputpromote.Root2Sprayed	();
		export Sprayed2Using	:= inputpromote.Sprayed2Using		;
		export Using2Used			:= inputpromote.Using2Used		();

	end;

	export Base := 
	module

		shared dfilenames		:=	Filenames	(pversion).base.dAll_filenames
													;
													
		shared filter				:= if(pFilter = ''	,true
																						,regexfind(pFilter,dfilenames.templatename,nocase)
													);
													
		shared buildpromote 	:= VersionControl.mPromote.BuildFiles2(dfilenames(filter),,pDelete	);
		
		export New2Building						:= buildpromote.New2Building		(pversion)	;
		export New2Built							:= buildpromote.New2Built				(pversion)	;
		export Building2Built					:= buildpromote.Building2Built							;
		export Built2QA								:= buildpromote.Built2QA										;
		export QA2Prod								:= buildpromote.QA2Prod											;
		export QA2Prod2Father					:= buildpromote.QA2Prod2Father							;
		export VersionIntegrityCheck	:= buildpromote.VersionIntegrityCheck				;
		
	end;

	export RoxieKeys := 
	module

		shared dfilenames		:=	Keynames	(pversion).dAll_filenames
													;
													
		shared filter				:= if(pFilter = ''	,true
																						,regexfind(pFilter,dfilenames.templatename,nocase)
													);
													
		shared buildpromote 	:= VersionControl.mPromote_old.BuildFiles2(dfilenames(filter),,pDelete	);
		
		export New2Building						:= buildpromote.New2Building		(pversion)	;
		export New2Built							:= buildpromote.New2Built				(pversion)	;
		export Building2Built					:= buildpromote.Building2Built							;
		export Built2QA								:= buildpromote.Built2QA										;
		export QA2Prod								:= buildpromote.QA2Prod											;
		export QA2Prod2Father					:= buildpromote.QA2Prod2Father							;
		export VersionIntegrityCheck	:= buildpromote.VersionIntegrityCheck				;
		
	end;

	export Built2QA :=
	parallel(
		 Base.Built2QA
		,RoxieKeys.Built2QA

	);

	export QA2Prod :=
	parallel(
		 Base.QA2Prod
		,RoxieKeys.QA2Prod

	);
	export QA2Prod2Father :=
	parallel(
		 Base.QA2Prod2Father
		,RoxieKeys.QA2Prod2Father

	);

	export VersionIntegrityCheck :=
	parallel(
		 Base.VersionIntegrityCheck
		,RoxieKeys.VersionIntegrityCheck

	);

end;
