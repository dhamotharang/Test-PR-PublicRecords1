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
			
			tools.mac_FilesBase(basenames.LinkingBase					,PRTE2_BIPV2_BusHeader.Layouts.Base.Layout_CommonBase			,Linking					,built);
			tools.mac_FilesBase(basenames.IndustryBase				,PRTE2_BIPV2_BusHeader.Layouts.Base.Layout_Industry				,Industry					,built);
			tools.mac_FilesBase(basenames.LicenseBase					,PRTE2_BIPV2_BusHeader.Layouts.Base.Layout_License				,License					,built);
			tools.mac_FilesBase(basenames.ContactBase					,PRTE2_BIPV2_BusHeader.Layouts.Base.Layout_Contacts				,Contacts					,built);
			tools.mac_FilesBase(basenames.BestBase						,PRTE2_BIPV2_BusHeader.Layouts.Base.Layout_Best						,BestFile					,built);
			tools.mac_FilesBase(basenames.RelativesBase				,PRTE2_BIPV2_BusHeader.Layouts.Base.Layout_sele_relative	,Relatives				,built);
			
		end;

end;