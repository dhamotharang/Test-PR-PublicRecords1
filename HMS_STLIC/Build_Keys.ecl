IMPORT doxie, VersionControl, AutoKeyB2, RoxieKeyBuild, ut, standard;

EXPORT Build_Keys
				// (string pversion, boolean pUseProd = false) 
			:= MODULE

	EXPORT Build_Keys_statelicense(string pversion, boolean pUseProd = false) := module

			// state license keys - ln_key...
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).statelicense_lnk_key.New		,BuildStateLicenseLnKey	);
				// VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).statelicense_lic_key.New		,BuildStateLicenseLic	);
				// VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).statelicense_dea_key.New		,BuildStateLicenseDea	);
				// VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).statelicense_npi_key.New		,BuildStateLicenseNpi	);
				// VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).statelicense_zip_key.New		,BuildStateLicenseZip	);
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).statelicense_lnpid_key.New		,BuildStateLicenseLnpid	);
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).statelicense_sourcerid_key.New		,BuildStateLicenseSourcerid	);
					
				SHARED full_build :=
					sequential(
						BuildStateLicenseLnKey,
						// BuildStateLicenseLic,
						// BuildStateLicenseDea,
						// BuildStateLicenseNpi,
						// BuildStateLicenseZip,
						BuildStateLicenseLnpid,
						BuildStateLicenseSourcerid,
						Promote.Promote_statelicense(pversion,pUseProd).buildfiles.New2Built
					);
		
				EXPORT StateLicense_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping State License atribute')
					);
	END;
	
	EXPORT Build_Keys_stlicrollup(string pversion, boolean pUseProd = false) := module

			// state license keys - ln_key...
							
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).stlicrollup_sourcerid_key.New		,BuildstlicrollupSourcerid	);
				
				SHARED full_build :=
					sequential(
						BuildstlicrollupSourcerid,
						Promote.Promote_stlicrollup(pversion,pUseProd).buildfiles.New2Built
					);
		
				EXPORT Stlicrollup_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping State License Roll-Up Key Build Atribute')
					);
	END;
	
	
	EXPORT Build_autokeys_statelicense(string pversion)	:= function
		//c := autokey_constants(pversion).autokey_indiv_constants; 
		
		c := autokey_constants(pversion).autokey_stlic_constants;
		
		ak_keyname  := c.str_autokeyname;
		ak_logical  := c.ak_logical;

		
		base_stl	:= project(HMS_STLIC.Files().statelicense_Base.built
																,transform(HMS_STLIC.Layouts.autokey_common
																	,self:=left
																	,self:=[]
																	));

		ak_dataset  := base_stl;

		ak_skipSet  := c.ak_skipSet;
		ak_typeStr  := c.ak_typeStr;

		AutoKeyB2.MAC_Build (ak_dataset,first,middle,last,
                     best_ssn,
                     best_dob,
                     blank,
                     prim_name,
                     prim_range,
                     st,
                     v_city_name,
                     zip,
                     sec_range,
                     zero,
                     zero,zero,zero,
                     zero,zero,zero,
                     zero,zero,zero,
                     zero,
                     did,
                     clean_company_name, // compname which is string thus "blank"
                     best_ssn,
                     zero,
                     prim_name,prim_range,st,v_city_name,zip,sec_range,
                     bdid, // bdid_out
                     ak_keyname,
                     ak_logical,
                     BAK,false,
                     ak_skipSet,true,ak_typeStr,
                     true,,,zero);

		AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, MAK,, ak_skipSet);

		return sequential(
									BAK,
									MAK
									);
	END;


END;