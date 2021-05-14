import tools,BIPV2_Files,Business_DOT; 

export Files(

	 string   pversion              = ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

  shared fnames   := filenames(pversion,pUseOtherEnvironment);
  
	export ProxidSegs   := tools.macf_FilesBase	(fnames.ProxidSegs  ,layouts.laysegmentation);
	export PowidSegs    := tools.macf_FilesBase	(fnames.PowidSegs   ,layouts.laysegmentation);
	export SeleidSegs   := tools.macf_FilesBase	(fnames.SeleidSegs	,layouts.laysegmentation);
	export OrgidSegs    := tools.macf_FilesBase	(fnames.OrgidSegs 	,layouts.laysegmentation);
	export UltidSegs    := tools.macf_FilesBase	(fnames.UltidSegs 	,layouts.laysegmentation);
	
	export EntityReportData := dataset(filenames().EntityStatsSuperFilename, layout_Entity_Report.file_layout, thor);
  
end;