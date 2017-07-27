import doxie, VersionControl, RoxieKeyBuild, ut, standard;

export Build_Keys := module

	export Build_Keys_facility_sanctions(string pversion, boolean pUseProd = false) := module

				VersionControl.macBuildNewLogicalKey(Enclarity_Facility_sanctions.Keys(pversion,pUseProd).facility_sanctions_lnfid.New		,BuildFacilitySanctionlnfid	);
															  
				shared full_build :=
					sequential(
						BuildFacilitySanctionlnfid,
						Promote.promote_facility_sanctions(pversion,pUseProd).buildfiles.New2Built
					);
		
				export facility_sanctions_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping facility sanctions keys atribute')
					);
	end;
end;