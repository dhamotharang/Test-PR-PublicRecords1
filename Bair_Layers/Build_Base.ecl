import _control, versioncontrol, std, lib_stringlib;

export Build_Base(string version, boolean pUseProd = false, boolean pDelta = false) := module
		
	shared promote_base_modname := Bair_layers.Promote(version, pUseProd, pDelta, true); //promote base
	
	export build_Layers := module
		Layers_Base		:= Update_Base(version,pUseProd).Layers;
	
		VersionControl.macBuildNewLogicalFile( 
			 Bair_layers.Filenames(version,pUseProd,pDelta).AgencyLayers_Base.new	
			,Layers_Base
			,bld
		 );		 
	end;
	
	export build_LayersPayload := module
		Payload_Base		:= Update_Base(version,pUseProd).Payload_Layers;
	
		VersionControl.macBuildNewLogicalFile( 
			 Bair_layers.Filenames(version,pUseProd,pDelta).LayersPayload_Base.new	
			,Payload_Base
			,bld
			,pCompress := false
		 );
	end;
																			 
	export all := sequential( 
			build_Layers.bld,
			promote_base_modname.Promote_agencylayer.buildfiles.New2Built,
			promote_base_modname.Promote_agencylayer.buildfiles.Built2QA,
			build_LayersPayload.bld,
			promote_base_modname.Promote_agencylayer_payload.buildfiles.New2Built,
			promote_base_modname.Promote_agencylayer_payload.buildfiles.Built2QA,			
	);
	
END;
