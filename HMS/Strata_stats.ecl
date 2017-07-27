import strata,Statistics;

export Strata_Stats := module

	export Individual(
			dataset(layouts.Individual_base)	pInput		= Files().Individual_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;

	export Individual_Addresses(
			dataset(layouts.Individual_Addresses_base)	pInput		= Files().Individual_Addresses_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;

	export Individual_State_Licenses(
			dataset(layouts.Individual_State_Licenses_base)	pInput		= Files().Individual_State_Licenses_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;

	export Individual_Dea(
			dataset(layouts.Individual_Dea_base)	pInput		= Files().Individual_Dea_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;

	export Individual_State_Csr(
			dataset(layouts.Individual_State_Csr_base)	pInput		= Files().Individual_State_Csr_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;

	export Individual_Sanctions(
			dataset(layouts.Individual_Sanctions_base)	pInput		= Files().Individual_Sanctions_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;

	export Individual_Gsa_Sanctions(
			dataset(layouts.Individual_Gsa_Sanctions_base)	pInput		= Files().Individual_Gsa_Sanctions_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;

	export State_License_Types(
			dataset(layouts.State_License_Types_base)	pInput		= Files().State_License_Types_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;

	export Individual_Address_Faxes(
			dataset(layouts.individual_address_faxes_base)	pInput		= Files().individual_address_faxes_Base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;

	export Individual_Address_Phones(
			dataset(layouts.individual_address_phones_base)	pInput		= Files().individual_address_phones_Base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;

	export Individual_Certifications(
			dataset(layouts.individual_certifications_base)	pInput		= Files().individual_certifications_Base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;

	export Inidividual_Covered_Recipients(
			dataset(layouts.individual_covered_recipients_base)	pInput		= Files().individual_covered_recipients_Base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;

	export Individual_Education(
			dataset(layouts.individual_education_base)	pInput		= Files().individual_education_Base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;

	export Individual_Languages(
			dataset(layouts.individual_languages_base)	pInput		= Files().individual_languages_Base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;

	export Individual_Specialty(
			dataset(layouts.individual_specialty_base)	pInput		= Files().individual_specialty_Base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;
	
	export Piid_Migration(
			dataset(layouts.piid_migration_base)	pInput		      = Files().piid_migration_base.Built) := module
					Statistics.mac_Strata_Pops(pInput,dNoGrouping													);
	end;

end;