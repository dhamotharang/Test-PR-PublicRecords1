import VersionControl;

export Promote(

	 string		pversion					= ''
	,string		pFilter						= ''
	,boolean	pDelete						= false
	,boolean	pIsTesting 				= false
	,boolean	pClearSuperFirst	= true

) :=
module

	// Promote Input files
	shared dInputfilenames	:= Filenames().Input.dAll_templates;
	shared inputpromote 		:= VersionControl.mPromote.InputFiles(dInputfilenames);
	export Root2Sprayed			:= inputpromote.Root2Sprayed	();
	export Sprayed2Using		:= inputpromote.Sprayed2Using		;
	export Using2Used				:= inputpromote.Using2Used		();
	export New2Sprayed			:= inputpromote.New2Sprayed		(pversion);


	// Promote Base files
	shared dfilenames		:=  Filenames(pversion).dAll_filenames
												;
												
	shared filter				:= if(pFilter = ''	,true
																					,		regexfind(pFilter,dfilenames.templatename		,nocase)
																					or	regexfind(pFilter,dfilenames.templatenamenew,nocase)
												);

	shared dfilestopromote := dfilenames(filter);
												
	shared basepromote 	:= VersionControl.mPromote.BuildFiles2(dfilestopromote(filter),,pDelete,,pClearSuperFirst);

	export New2Built							:= if(pIsTesting = false, basepromote.New2Built				(pversion)	,output(dfilestopromote,all));
	export New2Root								:= if(pIsTesting = false, basepromote.New2Root				(pversion)	,output(dfilestopromote,all));
	export New2QA									:= if(pIsTesting = false, basepromote.New2QA					(pversion)	,output(dfilestopromote,all));
	export Built2QA								:= if(pIsTesting = false, basepromote.Built2QA										,output(dfilestopromote,all));
	export QA2Prod								:= if(pIsTesting = false, basepromote.QA2Prod											,output(dfilestopromote,all));
	export VersionIntegrityCheck	:= if(pIsTesting = false, basepromote.VersionIntegrityCheck				,output(dfilestopromote,all));

end;
