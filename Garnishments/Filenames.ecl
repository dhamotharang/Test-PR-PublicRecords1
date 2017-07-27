import tools;

export Filenames(

	 string		pversion = ''
	,boolean	pUseOtherEnvironment = false

) :=
module


	export ftemplate(string pFiletype)	:= _Dataset(pUseOtherEnvironment).thor_cluster_files + pFiletype + '::' + _Dataset().name + '::@version@';

	export inputliensv2		:= tools.mod_FilenamesInput('~thor400_92::in::liensv2::@version@::hgn::okclien',pFileDate := pversion);
	export input 					:= tools.mod_FilenamesInput(ftemplate('in'		) + '::Data',pFileDate := pversion);
	export base 					:= tools.mod_FilenamesBuild(ftemplate('base'	) + '::Data',pversion);

	export dAll_filenames :=
			Base.dAll_filenames
	;

end;