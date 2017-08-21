import tools, std;

lay_builds 	:= tools.Layout_FilenameVersions.builds;

export Promote(string     pversion      =  ''
							,boolean    pUseProd      = false
							,boolean		pDelta				= false
							,boolean		pBaseFileType	= false
							,string     pFilter       = ''
							,boolean    pDelete       = true
							,boolean    pisTesting    = false
							,unsigned1  pnGenerations = 3
				):= module
		
		export Promote_agencylayer := module
				
						dataset(lay_builds)  pBuildFilenames := Bair_Layers.Filenames(pversion, pUseProd, pDelta).AgencyLayers_Base.dAll_filenames;
																												
            export buildfiles := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);
    
    end;
		
		export Promote_agencylayer_search := module
				
						dataset(lay_builds)  pBuildFilenames := Bair_Layers.keynames(pversion, pUseProd, pDelta).agencylayer_search_key.dAll_filenames;
						
            export buildfiles := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);
    
    end;
		
		export Promote_agencylayer_payload := module
				
						dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
																												,Bair_Layers.Filenames(pversion, pUseProd, pDelta).LayersPayload_Base.dAll_filenames
																												,Bair_Layers.keynames(pversion, pUseProd, pDelta).agencylayer_payload_key.dAll_filenames
																												);
            export buildfiles := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);
    
    end;	
		
end;
