import VersionControl, tools;

export Promote(

	 string		pversion					= ''
	,string		pFilter						= ''
	,boolean	pDelete						= false
	,boolean	pIsTesting 				= false
	,boolean	pClearSuperFirst	= true

) :=
module
	
	shared dInputFilenames := 	Filenames(pversion).input.dAll_filenames;
	
	shared dfilenames		:=  Filenames(pversion).base.dAll_filenames
												+ Keynames(pversion).dAll_filenames
												;
												
	shared filter				:= if(pFilter = ''	,true
																					,		regexfind(pFilter,dfilenames.templatename		,nocase)
																					or	regexfind(pFilter,dfilenames.templatenamenew,nocase)
												);

	shared dfilestopromote := dfilenames(filter);
	
	export inputfiles	:= tools.mod_PromoteInput(pversion,dInputFilenames,pFilter,pDelete,pIsTesting);
												
	shared basepromote 	:= VersionControl.mPromote.BuildFiles2(dfilestopromote(filter),,pDelete,,pClearSuperFirst);

	export New2Built							:= if(pIsTesting = false, basepromote.New2Built				(pversion)	,output(dfilestopromote,all));
	export New2Root								:= if(pIsTesting = false, basepromote.New2Root				(pversion)	,output(dfilestopromote,all));
	export New2QA									:= if(pIsTesting = false, basepromote.New2QA					(pversion)	,output(dfilestopromote,all));
	export Built2QA								:= if(pIsTesting = false, basepromote.Built2QA										,output(dfilestopromote,all));
	export QA2Prod								:= if(pIsTesting = false, basepromote.QA2Prod											,output(dfilestopromote,all));
	export VersionIntegrityCheck	:= if(pIsTesting = false, basepromote.VersionIntegrityCheck				,output(dfilestopromote,all));
	export Old2NewLogicals				:= if(pIsTesting = false, basepromote.Old2NewLogicals							,output(dfilestopromote,all));
	export New2OldSupers					:= if(pIsTesting = false, basepromote.New2OldSupers								,output(dfilestopromote,all));

end;
