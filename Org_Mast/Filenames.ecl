import versioncontrol,tools;

export Filenames(string pversion = '', boolean pUseProd = false) := module

  export affiliations_lBaseTemplate_built :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Org_Master_affiliations::built';
  export affiliations_lBaseTemplate_qa 		:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Org_Master_affiliations::QA';
  export affiliations_lBaseTemplate_Delete	:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Org_Master_affiliations::Delete';
	export affiliations_lBaseTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Org_Master_affiliations::@version@';
	export affiliations_lKeyTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::Org_Master_affiliations::@version@';	
	export affiliations_lInputTemplate      :=_Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Org_Master_affiliations'/*::@version@*/;
	export affiliations_lInputHistTemplate  :=_Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Org_Master_affiliations::history';
	export affiliations_Base		            := tools.mod_FilenamesBuild(affiliations_lBaseTemplate, pversion);  

  export aha_lBaseTemplate_built  				:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::Org_Master_aha::built';
  export aha_lBaseTemplate_qa  						:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::Org_Master_aha::qa';
  export aha_lBaseTemplate_Delete  				:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::Org_Master_aha::Delete';
	export aha_lBaseTemplate	      				:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::Org_Master_aha::@version@';
	export aha_lKeyTemplate	        				:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::Org_Master_aha::@version@';	
	export aha_lInputTemplate       				:=_Dataset(pUseProd).thor_cluster_files + 'in::' 	 + _Dataset().name + '::Org_Master_aha';//::'/*+pversion*/;
	export aha_lInputHistTemplate   				:=_Dataset(pUseProd).thor_cluster_files + 'in::' 	 + _Dataset().name + '::Org_Master_aha::history';
	export aha_Base		              				:= tools.mod_FilenamesBuild(aha_lBaseTemplate, pversion);  
	
	export dea_lBaseTemplate_built 					:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::Org_Master_dea::built';
	export dea_lBaseTemplate_qa 					:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::Org_Master_dea::qa';
	export dea_lBaseTemplate_Delete 					:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::Org_Master_dea::Delete';
	export dea_lBaseTemplate	     					:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::Org_Master_dea::@version@';
	export dea_lKeyTemplate	       					:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::Org_Master_dea::@version@';	
	export dea_lInputTemplate      					:=_Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Org_Master_dea'/*::@version@*/;
	export dea_lInputHistTemplate  					:=_Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Org_Master_dea::history';
	export dea_Base		             					:= tools.mod_FilenamesBuild(dea_lBaseTemplate, pversion);  
	
  export npi_lBaseTemplate_built  				:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::Org_Master_npi::built';
  export npi_lBaseTemplate_qa 				:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::Org_Master_npi::qa';
  export npi_lBaseTemplate_Delete 				:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::Org_Master_npi::Delete';
	export npi_lBaseTemplate	      				:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::Org_Master_npi::@version@';
	export npi_lKeyTemplate	        				:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::Org_Master_npi::@version@';	
	export npi_lInputTemplate       				:=_Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Org_Master_npi'/*::@version@*/;
	export npi_lInputHistTemplate   				:=_Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Org_Master_npi::history';
	export npi_Base		              				:= tools.mod_FilenamesBuild(npi_lBaseTemplate, pversion);  
	
  export organization_lBaseTemplate_built :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::Org_Master_organization::built';
  export organization_lBaseTemplate_qa :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::Org_Master_organization::qa';
  export organization_lBaseTemplate_Delete :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::Org_Master_organization::Delete';
	export organization_lBaseTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::Org_Master_organization::@version@';
	export organization_lKeyTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::Org_Master_organization::@version@';	
	export organization_lInputTemplate      :=_Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Org_Master_organization'/*::@version@*/;
	export organization_lInputHistTemplate  :=_Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Org_Master_organization::history';
	export organization_Base		            := tools.mod_FilenamesBuild(organization_lBaseTemplate, pversion);  

  export Relationship_lBaseTemplate_built :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::Org_Master_Relationship::built';
  export Relationship_lBaseTemplate_qa :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::Org_Master_Relationship::qa';
  export Relationship_lBaseTemplate_Delete :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::Org_Master_Relationship::Delete';
	export Relationship_lBaseTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::Org_Master_Relationship::@version@';
	export Relationship_lKeyTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::Org_Master_Relationship::@version@';	
	export Relationship_lInputTemplate      :=_Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Org_Master_Relationship'/*::@version@*/;
	export Relationship_lInputHistTemplate  :=_Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Org_Master_Relationship::history';
	export Relationship_Base		            := tools.mod_FilenamesBuild(Relationship_lBaseTemplate, pversion);  

	// export Relationship_lBaseTemplate	      :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::Org_Master_Relationship::@version@';
	// export Relationship_Base		            := tools.mod_FilenamesBuild(Relationship_lBaseTemplate, pversion);  
	// export Relationship_Base		            := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::Org_Master_Relationship::@version@';  


  export pos_lBaseTemplate_built  				:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::Org_Master_pos::built';
  export pos_lBaseTemplate_qa  				:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::Org_Master_pos::qa';
  export pos_lBaseTemplate_Delete  				:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::Org_Master_pos::Delete';
	export pos_lBaseTemplate	      				:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::Org_Master_pos::@version@';
	export pos_lKeyTemplate	        				:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::Org_Master_pos::@version@';	
	export pos_lInputTemplate       				:=_Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Org_Master_pos'/*::@version@*/;
	export pos_lInputHistTemplate   				:=_Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Org_Master_pos::history';
	export pos_Base		              				:= tools.mod_FilenamesBuild(pos_lBaseTemplate, pversion);  

  export crosswalk_lBaseTemplate_built  	:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::Org_Master_crosswalk::built';
  export crosswalk_lBaseTemplate_qa  			:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::Org_Master_crosswalk::qa';
  export crosswalk_lBaseTemplate_Delete  	:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::Org_Master_crosswalk::Delete';
	export crosswalk_lBaseTemplate	      	:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::Org_Master_crosswalk::@version@';
	export crosswalk_lKeyTemplate	        	:=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::Org_Master_crosswalk::@version@';	
	export crosswalk_lInputTemplate       	:=_Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Org_Master_crosswalk'/*::@version@*/;
	export crosswalk_lInputHistTemplate   	:=_Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Org_Master_crosswalk::history';
	export crosswalk_Base		              	:= tools.mod_FilenamesBuild(crosswalk_lBaseTemplate, pversion);  

end;
