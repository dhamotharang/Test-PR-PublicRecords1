import tools;

export KeynamesDaily(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lversiondate	:= pversion														;
	
  shared ftemplate(string pFiletype, string pCategory, string pSubset)	:=
		tools.mod_FilenamesBuild(_Constants(pUseOtherEnvironment).thor_cluster_files + pFiletype + '::' + _Dataset().name + 'daily::' + pCategory + '::@version@::' + pSubset,lversiondate);

	export Bankruptcy := module
		export Main := ftemplate('key','bankruptcy','main');
		export Party := ftemplate('key','bankruptcy','party');
		export dAll_filenames :=
			Main.dAll_filenames +
			Party.dAll_filenames;
	end;
	export Source := ftemplate('key','source','main');

	export dAll_filenames := 
		  Bankruptcy.dAll_filenames
		 +Source.dAll_filenames;
		;

end;
