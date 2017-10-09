import tools, Business_header;

export Files(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	// -- Base Files
	export Base :=
		module
					
			shared basenames	:= Filenames(pversion,pUseOtherEnvironment).Base;
			
			tools.mac_FilesBase(basenames.LinkingBase					,PRTE2_BIPV2_BusHeader.Layouts.Base.Layout_CommonBase		,Linking					,built);
			tools.mac_FilesBase(basenames.IndustryBase				,PRTE2_BIPV2_BusHeader.Layouts.Base.Layout_Industry			,Industry					,built);
			tools.mac_FilesBase(basenames.LicenseBase					,PRTE2_BIPV2_BusHeader.Layouts.Base.Layout_License			,License					,built);
			tools.mac_FilesBase(basenames.ContactBase					,PRTE2_BIPV2_BusHeader.Layouts.Base.Layout_Contacts			,Contacts					,built);
			tools.mac_FilesBase(basenames.BestBase						,PRTE2_BIPV2_BusHeader.Layouts.Base.Layout_Best					,BestFile					,built);
			//tools.mac_FilesBase(basenames.HeaderBest							,Business_header.Layout_BH_Best											,Business_Header_Best			, built);
			//tools.mac_FilesBase(basenames.Relatives								,Business_header.Layout_Business_Relative						,Business_Relatives				, built);
			//tools.mac_FilesBase(basenames.RelativesGroup					,Business_header.Layout_Business_Relative_Group			,Business_Relatives_Group	, built);
			//tools.mac_FilesBase(basenames.SuperGroup							,Business_header.Layout_BH_Super_Group							,Super_Group							, built);			
			
			
		end;

end;