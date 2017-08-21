import VersionControl;

export Promote(

	 string		pversion					= ''
	,string		pFilter						= ''
	,boolean	pDelete						= false
	,boolean	pClearSuperFirst	= true

) :=
module
	
	shared dfilenames		:=  	filenames	().dAll_filenames
													+ Keynames	().dAll_filenames
													+ Keynames	().fcra.dAll_filenames
													;
												
	shared filter				:= if(pFilter = ''	,true
																					,regexfind(pFilter,dfilenames.templatename,nocase)
												);
												
	shared basepromote 	:= VersionControl.mPromote.BuildFiles2(dfilenames(filter),,pDelete,,pClearSuperFirst);

	export New2Built							:= basepromote.New2Built			(pversion)	;
	export New2QA									:= basepromote.New2QA					(pversion)	;
	export New2Root								:= basepromote.New2Root				(pversion)	;
	export Built2QA								:= basepromote.Built2QA										;
	export QA2Prod								:= basepromote.QA2Prod										;
	export VersionIntegrityCheck	:= basepromote.VersionIntegrityCheck			;

end;
