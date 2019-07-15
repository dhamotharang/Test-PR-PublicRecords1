IMPORT tools, ut;

layout_builds := tools.Layout_FilenameVersions.builds;

EXPORT Promote
(
    string                  pversion				  = 	'',
    boolean                 pUseProd			    =   false,
    boolean                 pIsFull           =   false,
    string                  pFilter					  = 	'',
    boolean                 pDelete					  = 	true,
    boolean                 pIsTesting			  = 	false,
    dataset(layout_builds)	pBuildFilenames   =   (Filenames(pversion, pUseProd, pIsFull).base.dAll_filenames
                                                  + keynames(pversion, pUseProd, pIsFull).dAll_filenames)
) := MODULE

	EXPORT buildfiles	:= tools.mod_PromoteBuild
                       (
                          pversion := pversion,
                          pFilenames := pBuildFilenames,
                          pFilter := pFilter,
                          pDelete := pDelete,
                          pIsTesting := pIsTesting,
                          pnGenerations := 2
                       );
                       
END;