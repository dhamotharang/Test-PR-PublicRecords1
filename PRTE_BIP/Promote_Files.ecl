export Promote_Files (string pversion = '') := module

	export Input_Sprayed2Using	:=	function
							
		Sprayed2Using := sequential(
		/*
			,prte_bip.Promote('bankruptcyv2_main').inputfiles.sprayed2using
			,prte_bip.Promote('bankruptcyv2_search').inputfiles.sprayed2using
			,prte_bip.Promote('busreg_companies').inputfiles.sprayed2using
			,prte_bip.Promote('busreg_contacts').inputfiles.sprayed2using
			,prte_bip.Promote('corp2_contacts').inputfiles.sprayed2using
			,prte_bip.Promote('corp2_corporations').inputfiles.sprayed2using
			,prte_bip.Promote('corp2_events').inputfiles.sprayed2using
			,prte_bip.Promote('dcav2_companies').inputfiles.sprayed2using
			,prte_bip.Promote('dcav2_contacts').inputfiles.sprayed2using
			,prte_bip.Promote('dea').inputfiles.sprayed2using
			,prte_bip.Promote('dnb_dmi_companies').inputfiles.sprayed2using
			,prte_bip.Promote('dnb_dmi_contacts').inputfiles.sprayed2using														
			,prte_bip.Promote('ebr_0010_header').inputfiles.sprayed2using
			,prte_bip.Promote('ebr_5600_demographic_data').inputfiles.sprayed2using
			,prte_bip.Promote('ebr_5610_demographic_data').inputfiles.sprayed2using
			*/
			 prte_bip.Promote('faa_aircraft_reg').inputfiles.sprayed2using
			//,prte_bip.Promote('faa_airmen').inputfiles.sprayed2using
			//,prte_bip.Promote('faa_airmen_certs').inputfiles.sprayed2using								
			//,prte_bip.Promote('faa_aircraft_registration').inputfiles.sprayed2using
			/*
			,prte_bip.Promote('gongv2_history').inputfiles.sprayed2using
			,prte_bip.Promote('header_santander').inputfiles.sprayed2using							
			,prte_bip.Promote('irs5500').inputfiles.sprayed2using
			,prte_bip.Promote('liensv2_party').inputfiles.sprayed2using
			,prte_bip.Promote('ln_propertyv2_search').inputfiles.sprayed2using
			,prte_bip.Promote('ln_propertyv2_deed').inputfiles.sprayed2using
			,prte_bip.Promote('ln_propertyv2_assessment').inputfiles.sprayed2using
			,prte_bip.Promote('ln_propertyv2_addl_fares_tax').inputfiles.sprayed2using
			,prte_bip.Promote('ln_propertyv2_addl_fares_deed').inputfiles.sprayed2using
			,prte_bip.Promote('prof_licensev2').inputfiles.sprayed2using
			,prte_bip.Promote('uccv2_party').inputfiles.sprayed2using
			,prte_bip.Promote('vehiclev2_party').inputfiles.sprayed2using
			,prte_bip.Promote('watercraft_search').inputfiles.sprayed2using
		*/
		);

		return Sprayed2Using;
		
	end;

	export Input_Using2Used	:=	function
							
		Using2Used := sequential(
		/*
			,prte_bip.Promote('bankruptcyv2_main').inputfiles.using2used
			,prte_bip.Promote('bankruptcyv2_search').inputfiles.using2used
			,prte_bip.Promote('busreg_companies').inputfiles.using2used
			,prte_bip.Promote('busreg_contacts').inputfiles.using2used
			,prte_bip.Promote('corp2_contacts').inputfiles.using2used
			,prte_bip.Promote('corp2_corporations').inputfiles.using2used
			,prte_bip.Promote('corp2_events').inputfiles.using2used
			,prte_bip.Promote('dcav2_companies').inputfiles.using2used
			,prte_bip.Promote('dcav2_contacts').inputfiles.using2used
			,prte_bip.Promote('dea').inputfiles.using2used
			,prte_bip.Promote('dnb_dmi_companies').inputfiles.using2used
			,prte_bip.Promote('dnb_dmi_contacts').inputfiles.using2used														
			,prte_bip.Promote('ebr_0010_header').inputfiles.using2used
			,prte_bip.Promote('ebr_5600_demographic_data').inputfiles.using2used
			,prte_bip.Promote('ebr_5610_demographic_data').inputfiles.using2used
			*/	
			 prte_bip.Promote('faa_aircraft_reg').inputfiles.using2used
			//,prte_bip.Promote('faa_airmen').inputfiles.using2used
			//,prte_bip.Promote('faa_airmen_certs').inputfiles.using2used								
			//,prte_bip.Promote('faa_aircraft_registration').inputfiles.using2used
			/*
			,prte_bip.Promote('gongv2_history').inputfiles.using2used
			,prte_bip.Promote('header_santander').inputfiles.using2used							
			,prte_bip.Promote('irs5500').inputfiles.using2used
			,prte_bip.Promote('liensv2_party').inputfiles.using2used
			,prte_bip.Promote('ln_propertyv2_search').inputfiles.using2used
			,prte_bip.Promote('ln_propertyv2_deed').inputfiles.using2used
			,prte_bip.Promote('ln_propertyv2_assessment').inputfiles.using2used
			,prte_bip.Promote('ln_propertyv2_addl_fares_tax').inputfiles.using2used
			,prte_bip.Promote('ln_propertyv2_addl_fares_deed').inputfiles.using2used
			,prte_bip.Promote('prof_licensev2').inputfiles.using2used
			,prte_bip.Promote('uccv2_party').inputfiles.using2used
			,prte_bip.Promote('vehiclev2_party').inputfiles.using2used
			,prte_bip.Promote('watercraft_search').inputfiles.using2used
		*/
		);

		return Using2Used;
		
	end;

end;