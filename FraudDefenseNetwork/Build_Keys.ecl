import doxie, tools, versioncontrol;

export Build_Keys(
	 string pversion = ''
  ,dataset(Layouts.Base.Main)         pBaseMainBuilt			=	Files(pversion).Base.Main.Built  
) := module
  

	shared TheKeys := Keys(
		 pversion
		,pBaseMainBuilt
	);

	tools.mac_WriteIndex('TheKeys.Main.ID.New'								  ,BuildMainIdKey				     );
	tools.mac_WriteIndex('TheKeys.Main.DID.New'									,BuildDidKey							 );
	tools.mac_WriteIndex('TheKeys.Main.BDID.New'								,BuildBdidKey							 );
	tools.mac_WriteIndex('TheKeys.Main.email.New'								,BuildemailKey						 );
	tools.mac_WriteIndex('TheKeys.Main.IP.New'								  ,BuildIPKey							   );
	tools.mac_WriteIndex('TheKeys.Main.ProfessionalID.New' 	    ,BuildProfessionalIDKey	   );
	tools.mac_WriteIndex('TheKeys.Main.DeviceID.New'            ,BuildDeviceIDKey		  	   );
	tools.mac_WriteIndex('TheKeys.Main.TIN.New'								  ,BuildTINKey						   );
	tools.mac_WriteIndex('TheKeys.Main.NPI.New'								  ,BuildNPIKey						   );
	tools.mac_WriteIndex('TheKeys.Main.AppProviderID.New'       ,BuildAppProviderIDKey	   );
	tools.mac_WriteIndex('TheKeys.Main.LNPID.New'               ,BuildLNPIDKey	         );
	tools.mac_WriteIndex('TheKeys.Main.MBS.New'								  ,BuildMbsKey							 );
	tools.mac_WriteIndex('TheKeys.Main.MbsGcIdExclusion.New'							,BuildMbsGcIdExclusionKey					 );
  tools.mac_WriteIndex('TheKeys.Main.MbsIndTypeExclusion.New'					,BuildMbsIndTypeExclusionKey				 );
  tools.mac_WriteIndex('TheKeys.Main.MbsProductInclude.New'					,BuildMbsProductIncludeKey				 );
  tools.mac_WriteIndex('TheKeys.Main.MbsFDNMasterIDKey.New'					,BuildMbsFDNMasterIDKey				 );
  tools.mac_WriteIndex('TheKeys.Main.MbsFDNMasterIDExclKey.New'					,BuildMbsFDNMasterIDExclKey				 );
	VersionControl.macBuildNewLogicalKeyWithName(FraudDefenseNetwork.Key_LinkIds.Key,	FraudDefenseNetwork.keynames(pversion,false).Main.LinkIds.new, BuildLinkIdsKey);
													  
	export full_build :=
	sequential(
		 parallel(
			 BuildMainIdKey	
			,BuildDidKey
			,BuildBdidKey	
			,BuildemailKey
			,BuildIPKey
			,BuildProfessionalIDKey
			,BuildDeviceIDKey
			,BuildTINKey
			,BuildNPIKey
			,BuildAppProviderIDKey
			,BuildLNPIDKey
			,BuildMbsKey
			,BuildMbsGcIdExclusionKey
			,BuildMbsIndTypeExclusionKey
			,BuildMbsProductIncludeKey
			,BuildMbsFDNMasterIDKey
			,BuildMbsFDNMasterIDExclKey
			,BuildLinkIdsKey
			
		 )
		,Promote(pversion).buildfiles.New2Built
	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping FDN.Build_Keys atribute')
	);

end;