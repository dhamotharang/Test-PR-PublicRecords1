import doxie, VersionControl, strata;

export Build_Keys(string pversion, boolean pUseProd = false) :=
module

	VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).Bdid.New	,BuildBdidKey	);
	VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).Did.New		,BuildDidKey	);
	VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).Did_fcra.New		,BuildDidFcraKey	);	
	VersionControl.macBuildNewLogicalKeyWithName(Thrive.Key_LinkIds.Key,thrive.keynames(pversion,false).LinkIds.New,BuildLinkIDKey           );			
	
	export full_build :=
	sequential(
		 parallel(
			 BuildBdidKey
			,BuildDidKey
			,BuildDidFcraKey
			,BuildLinkIDKey
		 )
     // DF-21492 - Show counts of blanked out fields in thor_data400::key::thrive::fcra::qa::did
     ,OUTPUT(strata.macf_pops(thrive.Keys(pversion,pUseProd).Did_fcra.New,,,,,,FALSE,['phone_work','phone_home','phone_cell',
                              'monthsemployed','own_home','is_military','drvlic_state','monthsatbank','ip','yrsthere','besttime',
                              'credit','loanamt','loantype','ratetype','mortrate','ltv','propertytype','datecollected','title',
                              'fips_st','fips_county','clean_phone_work','clean_phone_home','clean_phone_cell']))
		,Promote(pversion,pUseProd).buildfiles.New2Built
	);
		
	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Thrive.Build_Keys atribute')
	);

end;