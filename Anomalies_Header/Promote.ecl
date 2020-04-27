

Import tools;

lay_builds 	:= tools.Layout_FilenameVersions.builds;

Export Promote(
	String	pversion    = '',
	Boolean	pUseProd    = False,
	String	pFilter     = '',
	Boolean	pDelete	    = False,
	Boolean	pisTesting	= False,

	Dataset(lay_builds)	pBuildFilenames = 	Filenames(pversion,pUseProd).base.dAll_filenames ) := Module

	Export buildfiles	:= tools.mod_PromoteBuild(pversion, pBuildFilenames, pFilter, pDelete, pisTesting );
	
End;
