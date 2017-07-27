IMPORT doxie, VersionControl, AutoKeyB2, RoxieKeyBuild, ut, standard, HMS;

EXPORT Build_Keys
			:= MODULE

	EXPORT Build_Keys_Provider(string pversion, boolean pUseProd = false) := module

				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).Provider_PIID.New		,BuildProvider_PIIDLnKey);
				
				SHARED full_build :=
					sequential(
						BuildProvider_PIIDLnKey,
						Promote.Promote_Providerkeys(pversion,pUseProd).buildfiles.New2Built
					);
		
				EXPORT ProviderKey :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping State License atribute')
					);
	END;

END;