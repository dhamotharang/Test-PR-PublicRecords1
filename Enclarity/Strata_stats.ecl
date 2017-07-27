import strata,Statistics;

export Strata_Stats	:= module

	export address(
			dataset(layouts.address_base)	pInput		= Files().address_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;
	
	export associate(
			dataset(layouts.associate_base)	pInput		= Files().associate_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;
	
	export dea(
			dataset(layouts.dea_base)	pInput		= Files().dea_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;
	
	export facility(
			dataset(layouts.facility_base)	pInput		= Files().facility_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;
	
	export individual(
			dataset(layouts.individual_base)	pInput		= Files().individual_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;
	
	export license(
			dataset(layouts.license_base)	pInput		= Files().license_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;
	
	export medschool(
			dataset(layouts.medschool_base)	pInput		= Files().medschool_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;
	
	export npi(
			dataset(layouts.npi_base)	pInput		= Files().npi_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;
	
	export prov_birthdate(
			dataset(layouts.prov_birthdate_base)	pInput		= Files().prov_birthdate_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;
	
	export prov_ssn(
			dataset(layouts.prov_ssn_base)	pInput		= Files().prov_ssn_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;
	
	export sanc_codes(
			dataset(layouts.sanc_codes_base)	pInput		= Files().sanc_codes_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;
	
	export sanc_prov_type(
			dataset(layouts.sanc_prov_type_base)	pInput		= Files().sanc_prov_type_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;
	
	export sanction(
			dataset(layouts.sanction_base)	pInput		= Files().sanction_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;
	
	export specialty(
			dataset(layouts.specialty_base)	pInput		= Files().specialty_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;
	
	export tax_codes(
			dataset(layouts.tax_codes_base)	pInput		= Files().tax_codes_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;
	
	export taxonomy(
			dataset(layouts.taxonomy_base)	pInput		= Files().taxonomy_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;

	export collapse(
			dataset(layouts.collapse_base)	pInput		= Files().collapse_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;

	export split(
			dataset(layouts.split_base)	pInput		= Files().split_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;

	export drop(
			dataset(layouts.drop_base)	pInput		= Files().drop_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;
end;
	
	