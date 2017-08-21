import versioncontrol,tools;

export Filenames(string version = '', boolean pUseProd = false, boolean pUseDelta = false ) := module

	shared suffixBaseVersion
		:= if(pUseDelta, '::delta::@version@', '::@version@');
	shared suffixBaseBuilt
		:= if(pUseDelta, '::delta', '');
	shared thor_cluster
		:= _Dataset(pUseProd).thor_cluster_files;
	shared dsName
		:= _Dataset().name;
	
	export agency_layers_search_lBaseTemplate							
			:= thor_cluster + 'base::' + dsName+ '::agency_layers::search' + suffixBaseVersion;
			
	export Layers_Search_Base		  									
			:= tools.mod_FilenamesBuild(agency_layers_search_lBaseTemplate, version);	
	
	export AgencyLayers_lBaseTemplate							
			:= thor_cluster + 'base::' + dsName+ '::layers' + suffixBaseVersion;
	export AgencyLayers_Base		  									
			:= tools.mod_FilenamesBuild(AgencyLayers_lBaseTemplate, version);
			
	export LayersPayload_Base_lBaseTemplate							
			:= thor_cluster + 'base::' + dsName+ '::agency_layers' + suffixBaseVersion;			
	export LayersPayload_Base		  									
			:= tools.mod_FilenamesBuild(LayersPayload_Base_lBaseTemplate, version);	
					
	export layers_lInputTemplate 							
			:= thor_cluster + 'in::'   + dsName + '::agency_layers' ;
	export layers_lInputHistTemplate 					
			:= thor_cluster + 'in::'   + dsName + '::agency_layers::history';	

end;
