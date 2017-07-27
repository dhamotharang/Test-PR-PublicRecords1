import versioncontrol;
export Files(string pversion = '') := module

   //////////////////////////////////////////////////////////////////
   // -- Input File Versions
   //////////////////////////////////////////////////////////////////
      versioncontrol.macInputFileVersions(Filenames(pversion).prov_info_input, layouts.Input.prov_information, prov_info_Input);
			versioncontrol.macInputFileVersions(Filenames(pversion).prov_relat_input,layouts.Input.prov_relationship, prov_relat_Input);
			versioncontrol.macInputFileVersions(Filenames(pversion).medicaid_input,layouts.input.medicaid_information, medicaid_Input);
			versioncontrol.macInputFileVersions(Filenames(pversion).taxonomy_input,layouts.input.taxonomy_information, taxonomy_input);
			versioncontrol.macInputFileVersions(Filenames(pversion).demographic_input,layouts.input.relationship_demographic, demographic_input);
			versioncontrol.macInputFileVersions(Filenames(pversion).pay_center_input, layouts.input.payment_center_information, pay_center_input);
			versioncontrol.macInputFileVersions(Filenames(pversion).parent_org_input, layouts.input.parent_organization_information, parent_org_input);
			versioncontrol.macInputFileVersions(Filenames(pversion).eprescribe_input, layouts.input.eprescribe_information, eprescribe_input);
			versioncontrol.macInputFileVersions(Filenames(pversion).remit_info_input, layouts.input.remit_information, remit_info_input);
      versioncontrol.macInputFileVersions(Filenames(pversion).state_lic_input, layouts.Input.state_license_information, state_license_Input);
			versioncontrol.macInputFileVersions(Filenames(pversion).services_info_input, layouts.Input.services_information, services_info_input);
			versioncontrol.macInputFileVersions(Filenames(pversion).change_owner_input, layouts.Input.change_ownership_information, change_owner_input);

   //////////////////////////////////////////////////////////////////
   // -- Base File Versions
   //////////////////////////////////////////////////////////////////
	    versioncontrol.macBuildFileVersions(Filenames(pversion).prov_info_Base, layouts.Base.prov_information, prov_info_Base);
			versioncontrol.macBuildFileVersions(Filenames(pversion).prov_relat_base, layouts.base.prov_relationship, prov_relat_base);
			versioncontrol.macBuildFileVersions(Filenames(pversion).medicaid_base, layouts.base.medicaid_information, medicaid_base);
			versioncontrol.macBuildFileVersions(Filenames(pversion).taxonomy_base, layouts.base.taxonomy_information, taxonomy_base);
			versioncontrol.macBuildFileVersions(Filenames(pversion).demographic_base, layouts.base.relationship_demographic, demographic_base);
			versioncontrol.macBuildFileVersions(Filenames(pversion).pay_center_base, layouts.base.payment_center_information, pay_center_base);
			versioncontrol.macBuildFileVersions(Filenames(pversion).parent_org_base, layouts.base.parent_organization_information, parent_org_base);
			versioncontrol.macBuildFileVersions(Filenames(pversion).eprescribe_base, layouts.base.eprescribe_information, eprescribe_base);
			versioncontrol.macBuildFileVersions(Filenames(pversion).remit_info_base, layouts.base.remit_information, remit_info_base);
	    versioncontrol.macBuildFileVersions(Filenames(pversion).state_lic_Base, layouts.Base.state_license_information, state_license_Base);
			versioncontrol.macBuildFileVersions(Filenames(pversion).services_info_base, layouts.base.services_information, services_info_base);
			versioncontrol.macBuildFileVersions(Filenames(pversion).change_owner_base, layouts.base.change_ownership_information, change_owner_base);
			versioncontrol.macBuildFileVersions(Filenames(pversion).final_base, layouts.base.combined_file, final_base);
			versioncontrol.macBuildFileVersions(Filenames(pversion).keybuild_base, layouts.keybuild, keybuild_base);

   //////////////////////////////////////////////////////////////////
   // -- KeyBuild File
   //////////////////////////////////////////////////////////////////
   // versioncontrol.macBuildFileVersions(Filenames(pversion).keybuild, layouts.keybuild, keybuild);
	 
	 end;