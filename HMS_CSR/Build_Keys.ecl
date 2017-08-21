IMPORT doxie, VersionControl, AutoKeyB2, RoxieKeyBuild, ut, standard;

EXPORT Build_Keys
				// (string pversion, boolean pUseProd = false) 
			:= MODULE

	EXPORT Build_Keys_csrcredential(string pversion, boolean pUseProd = false) := module

			// state license keys - ln_key...
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).csrcredential_lnk_key.New		,BuildCsrCredentialLnKey	);
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).csrcredential_lic_key.New		,BuildCsrCredentialLic	);
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).csrcredential_dea_key.New		,BuildCsrCredentialDea	);
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).csrcredential_npi_key.New		,BuildCsrCredentialNpi	);
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).csrcredential_zip_key.New		,BuildCsrCredentialZip	);
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).csrcredential_lnpid_key.New		,BuildCsrCredentialLnpid	);
				
				SHARED full_build :=
					sequential(
						BuildCsrCredentialLnKey,
						BuildCsrCredentialLic,
						BuildCsrCredentialDea,
						BuildCsrCredentialNpi,
						BuildCsrCredentialZip,
						BuildCsrCredentialLnpid,
						Promote.Promote_csrcredential(pversion,pUseProd).buildfiles.New2Built
					);
		
				EXPORT CsrCredential_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping State License atribute')
					);
	END;
	
	
	EXPORT Build_autokeys_csrcredential(string pversion)	:= function
		//c := autokey_constants(pversion).autokey_indiv_constants; 
		
		c := autokey_constants(pversion).autokey_csr_constants;
		
		ak_keyname  := c.str_autokeyname;
		ak_logical  := c.ak_logical;

		
		base_csr	:= project(HMS_CSR.Files().csrcredential_Base.built
																,transform(HMS_CSR.Layouts.autokey_common
																	,self:=left
																	,self:=[]
																	));

		ak_dataset  := base_csr;

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