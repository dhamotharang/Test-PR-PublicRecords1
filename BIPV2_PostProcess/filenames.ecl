import tools;
EXPORT filenames(

   string   pversion              = ''
	,boolean	pUseOtherEnvironment	= false
  
) :=
module

	shared lfileprefix		  := _Constants(pUseOtherEnvironment).GenericTemplate	;

	export ProxidSegs  := tools.mod_FilenamesBuild(lfileprefix + 'stats::Proxid.Segmentation'   ,pversion);
	export PowidSegs   := tools.mod_FilenamesBuild(lfileprefix + 'stats::Powid.Segmentation'    ,pversion);
	export SeleidSegs  := tools.mod_FilenamesBuild(lfileprefix + 'stats::Seleid.Segmentation'   ,pversion);
	export OrgidSegs   := tools.mod_FilenamesBuild(lfileprefix + 'stats::Orgid.Segmentation'	  ,pversion);
	export UltidSegs   := tools.mod_FilenamesBuild(lfileprefix + 'stats::Ultid.Segmentation'	  ,pversion);
	export Patched     := tools.mod_FilenamesBuild(lfileprefix + 'stats::patched'	              ,pversion);

	export dall_filenames := 
      ProxidSegs .dall_filenames
    + PowidSegs  .dall_filenames
    + SeleidSegs .dall_filenames
    + OrgidSegs  .dall_filenames
    + UltidSegs  .dall_filenames
    + Patched    .dall_filenames
    ;
 
	export EntityStatsSuperFilename   := '~thor_data400::base::business_header::entity_report_sf';
	export EntityStatsLogicalBaseFilename := '~thor_data400::base::business_header::entity_report_' + pVersion + '_';

end;