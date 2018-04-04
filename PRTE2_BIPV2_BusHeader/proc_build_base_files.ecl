import BIPV2, VersionControl;

export proc_build_base_files (

	 string																														pversion
	,dataset(PRTE2_BIPV2_BusHeader.Layouts.Base.Layout_CommonBase		)	pBH_Init_Final				= BH_Init_Final()
	,dataset(PRTE2_BIPV2_BusHeader.Layouts.Base.Layout_License			)	pBH_License						= BH_License()
	,dataset(PRTE2_BIPV2_BusHeader.Layouts.Base.Layout_Industry			)	pBH_Industry					= BH_Industry()

) := 
module

	shared names := filenames(pversion).base;
	
	shared dBH_Linkingbase  := pBH_Init_Final;
	shared dBH_Licensebase  := pBH_License;
	shared dBH_Industrybase := pBH_Industry;
	
	VersionControl.macBuildNewLogicalFile(names.LinkingBase.new, 	dBH_Linkingbase, 	BuildLinkingBase);
	VersionControl.macBuildNewLogicalFile(names.LicenseBase.new, 	dBH_Licensebase, 	BuildLicenseBase);
	VersionControl.macBuildNewLogicalFile(names.IndustryBase.new, dBH_Industrybase, BuildIndustryBase);
	
	export all := sequential(
										 BuildLinkingBase
										,BuildLicenseBase
										,BuildIndustryBase
										,promote(pversion,'^.*base::bipv2_business_header.*?(internal_linking|license_linkids|industry_linkids).*$').new2built
								); 

end;