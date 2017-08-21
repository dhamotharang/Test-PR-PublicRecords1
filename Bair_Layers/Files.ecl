IMPORT tools;

EXPORT Files(string version = '', boolean pUseProd = false, boolean pUseDelta = false) := MODULE

   /* Input File Versions */
   export input 			:= dataset(Bair_Layers.Filenames(,pUseProd).layers_lInputTemplate, Bair_Layers.Layouts.AgencyLayers_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])));
   export input_hist 	:= dataset(Bair_Layers.Filenames(,pUseProd).layers_lInputHistTemplate, Bair_Layers.Layouts.AgencyLayers_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])));

	 /* Base File Versions */
	 tools.mac_FilesBase(Bair_Layers.Filenames(version,pUseProd,pUseDelta).AgencyLayers_Base,  Bair_layers.layouts.Layers_Base,  Layers_Base);
	 tools.mac_FilesBase(Bair_Layers.Filenames(version,pUseProd,pUseDelta).LayersPayload_Base, Bair_layers.layouts.Layers_Payload_Base, Layers_Payload_Base,pMaxLength:=150032,pUseMaxLength:=true,pOpt	:= 'true');
	 
END;

