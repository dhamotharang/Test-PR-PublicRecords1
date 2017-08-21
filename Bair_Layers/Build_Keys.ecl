import VersionControl;

export Build_Keys(string pversion, boolean pUseProd = false, boolean pUseDelta = false) := module

	shared promote_modname := promote(pversion, pUseProd, pUseDelta, false); //Promote keys
	
	export Build_Keys_AgencyLayers_Search := module

				VersionControl.macBuildNewLogicalKey(
					Bair_layers.Keys(pversion,pUseProd,pUseDelta).AgencyLayers_Search.New, 
					BuildAgencyLayers_Search
				);
																			  
				shared full_build :=
					sequential(
						BuildAgencyLayers_Search,
						promote_modname.Promote_agencylayer_search.buildfiles.New2Built,
						promote_modname.Promote_agencylayer_search.buildfiles.Built2QA,
					);
		
				export layers_All := full_build;
	end;	
	
	export Build_Keys_AgencyLayers_Payload := module

				VersionControl.macBuildNewLogicalKey(
					Bair_layers.Keys(pversion,pUseProd,pUseDelta).AgencyLayers_Payload.New, 
					BuildAgencyLayers_Payload);
																			  
				shared full_build :=
					sequential(
						BuildAgencyLayers_Payload,
						promote_modname.Promote_agencylayer_payload.buildfiles.New2Built,
						promote_modname.Promote_agencylayer_payload.buildfiles.Built2QA,
					);
		
				export layers_All := full_build;
	end;	
	
	export all := sequential (
		Build_Keys_AgencyLayers_Search.layers_All,
		Build_Keys_AgencyLayers_Payload.layers_All
	);
END;


