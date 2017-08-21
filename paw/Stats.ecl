import versioncontrol, paw, corp2, business_header;

export Stats(

	 string														pversion
	,dataset(layout.Employment_Out	) pPaw				= files().base.built
	,dataset(layout.Employment_Out	)	pPaw_Father	= files().base.qa			//during a build, this will house the previous base file
	,boolean													pOverwrite	= false								

) :=
function

	paw_stats		:= fStatistics(pPaw,pPaw_Father,pversion);

	names := filenames(pversion).stat;
	
	VersionControl.macBuildNewLogicalFile( names.new	,paw_stats,BuildPawStats			,,,pOverwrite);
	
	return
	sequential(
		 BuildPawStats			
		,promote(pversion, '::stats::',pClearSuperFirst := false).new2qa
	);

end;