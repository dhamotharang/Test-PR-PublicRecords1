IMPORT doxie, VersionControl, AutoKeyB2, RoxieKeyBuild, ut, standard;

EXPORT Build_Keys
				// (string pversion, boolean pUseProd = false) 
			:= MODULE

	EXPORT Build_Keys_koptrgtharv(string pversion, boolean pUseProd = false) := module

			// state license keys - ln_key...
				// VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).statelicense_lnk_key.New		,BuildStateLicenseLnKey	);
				// VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).statelicense_lic_key.New		,BuildStateLicenseLic	);
				// VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).statelicense_dea_key.New		,BuildStateLicenseDea	);
				// VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).statelicense_npi_key.New		,BuildStateLicenseNpi	);
				// VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).statelicense_zip_key.New		,BuildStateLicenseZip	);
				VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).koptrgtharv_lnpid_key.New		,BuildkoptrgtharvLnpid	);
				// VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).statelicense_sourcerid_key.New		,BuildStateLicenseSourcerid	);
				
				SHARED full_build :=
					sequential(
						// BuildStateLicenseLnKey,
						// BuildStateLicenseLic,
						// BuildStateLicenseDea,
						// BuildStateLicenseNpi,
						// BuildStateLicenseZip,
						BuildkoptrgtharvLnpid,
						// BuildStateLicenseSourcerid,
						Promote.Promote_koptrgtharv(pversion,pUseProd).buildfiles.New2Built
					);
		
				EXPORT koptrgtharv_all :=
					if(VersionControl.IsValidVersion(pversion) 
					,full_build
					,output('No Valid version parameter passed, skipping KOP TRGT HARV Key atribute')
					);
	END;
	
	
/* 	EXPORT Build_autokeys_koptrgtharv(string pversion)	:= function
   		//c := autokey_constants(pversion).autokey_indiv_constants; 
   		
   		c := autokey_constants(pversion).autokey_koptrgtharv_constants;
   		
   		ak_keyname  := c.str_autokeyname;
   		ak_logical  := c.ak_logical;
   
   		
   		base_koptrgtharv	:= project(Files().koptrgtharv_Base.built
   																,transform(Layouts.autokey_common
   																	,self:=left
   																	,self:=[]
   																	));
   
   		ak_dataset  := base_koptrgtharv;
   
   		ak_skipSet  := c.ak_skipSet;
   		ak_typeStr  := c.ak_typeStr;
   
   		AutoKeyB2.MAC_Build (ak_dataset,first,middle,last,
                        '',//best_ssn,
                        (integer)date_born,// best_dob,
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
                        did, // did,
                        '', // clean_company_name, // compname which is string thus "blank"
                        '', // best_ssn,
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
*/


END;