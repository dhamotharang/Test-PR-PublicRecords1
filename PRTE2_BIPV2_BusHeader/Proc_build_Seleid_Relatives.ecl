import tools, VersionControl;

export Proc_build_Seleid_Relatives (

	 string																																pversion
	,dataset(PRTE2_BIPV2_BusHeader.Layouts.Base.layout_sele_relative		)	pBH_Sele_Rel				= BH_Seleid_Relatives()
	,boolean  puseotherenvironment	= false

) := 
module

	shared names := filenames(pversion).base;
	shared knames := keynames(pversion, puseotherenvironment);
	
	shared dBH_SeleidRelbase  := pBH_Sele_Rel;
	
	VersionControl.macBuildNewLogicalFile(names.RelativesBase.new, 	dBH_SeleidRelbase, 	BuildRelativesBase);
	
	bldSeleid_Relatives_key   := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Key_Seleid_Relatives 		,knames.assoc_seleid.new' );
	
	export all := sequential(
										 BuildRelativesBase
										,promote(pversion,'^.*base::bipv2_business_header.*?(Seleid_Relatives).*$').new2built
										,bldSeleid_Relatives_key
										,promote(pversion,'^.*key::*?(seleid::rel::assoc).*$').new2built
								); 
	
end;