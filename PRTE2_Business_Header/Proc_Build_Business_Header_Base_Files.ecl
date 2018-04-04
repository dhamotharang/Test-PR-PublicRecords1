import Business_Header, VersionControl;

export Proc_Build_Business_Header_Base_Files(

	 string																										pversion
	,dataset(Business_Header.Layout_Business_Header_Base		)	pBH_Init_Final				= BH_Init_Final()
	,dataset(Business_Header.Layout_Business_Relative				)	pBH_Relatives					= BH_Relatives()
	,dataset(Business_Header.Layout_Business_Relative_Group	)	pBH_Rels_Group_Rollup	= BH_Rels_Group_Rollup()
	,dataset(Business_Header.Layout_Business_Header_Stat		)	pBH_Stat							= BH_Stat										()

) := 
module

	shared names := filenames(pversion).base;
	
	shared dBH_base      := pBH_Init_Final;
	shared dBH_Rel       := pBH_Relatives;
	shared dBH_Rel_Group := pBH_Rels_Group_Rollup;
	shared dBH_Stat      := pBH_Stat;
	
	VersionControl.macBuildNewLogicalFile(names.Search.new, dBH_Base, BuildSearch);
	VersionControl.macBuildNewLogicalFile(names.Relatives.new, dBH_Rel, BuildRelatives);
	VersionControl.macBuildNewLogicalFile(names.RelativesGroup.new, dBH_Rel_Group, BuildRelativesGroup);
	VersionControl.macBuildNewLogicalFile(names.Stat.new, dBH_Stat, BuildStat);
	
	export all := sequential(
										 BuildSearch
										,BuildRelatives
										,BuildRelativesGroup
										,promote(pversion,'^.*prte::base::business_header.*?(search|relatives).*$').new2built
										,BuildStat
										,promote(pversion,'^.*prte::base::business_header.*?(stat).*$').new2built
								); 

end;