import iesp, codes, NPPES;
export NPI_Transforms := MODULE
	shared report_rec := iesp.npireport.t_NPIReport;
	shared prov_tax_rec := iesp.npireport.t_ProviderTaxonomies;
	shared prov_ident_rec := iesp.npireport.t_ProviderIdentifiers;
		
	export cleanAlphaNumCharacters (string inStr) := function
		return stringlib.stringfilter(inStr,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	end;

	export prov_tax_rec getTaxonomy(layouts.NPPES_Layouts.temp_layout L, integer C) := transform	
		TaxonomySwitch := choose(C, L.healthcare_provider_primary_taxonomy_switch_1, L.healthcare_provider_primary_taxonomy_switch_2, L.healthcare_provider_primary_taxonomy_switch_3, L.healthcare_provider_primary_taxonomy_switch_4, L.healthcare_provider_primary_taxonomy_switch_5, L.healthcare_provider_primary_taxonomy_switch_6, L.healthcare_provider_primary_taxonomy_switch_7, L.healthcare_provider_primary_taxonomy_switch_8, L.healthcare_provider_primary_taxonomy_switch_9, L.healthcare_provider_primary_taxonomy_switch_10, L.healthcare_provider_primary_taxonomy_switch_11, L.healthcare_provider_primary_taxonomy_switch_12, L.healthcare_provider_primary_taxonomy_switch_13, L.healthcare_provider_primary_taxonomy_switch_14, L.healthcare_provider_primary_taxonomy_switch_15);
		TaxonomyCode := choose(C, L.healthcare_provider_taxonomy_code_1, L.healthcare_provider_taxonomy_code_2, L.healthcare_provider_taxonomy_code_3, L.healthcare_provider_taxonomy_code_4, L.healthcare_provider_taxonomy_code_5, L.healthcare_provider_taxonomy_code_6, L.healthcare_provider_taxonomy_code_7, L.healthcare_provider_taxonomy_code_8, L.healthcare_provider_taxonomy_code_9, L.healthcare_provider_taxonomy_code_10, L.healthcare_provider_taxonomy_code_11, L.healthcare_provider_taxonomy_code_12, L.healthcare_provider_taxonomy_code_13, L.healthcare_provider_taxonomy_code_14, L.healthcare_provider_taxonomy_code_15); 
		TaxonomyDesc := choose(C, L.taxonomy_desc1, L.taxonomy_desc2, L.taxonomy_desc3, L.taxonomy_desc4, L.taxonomy_desc5, L.taxonomy_desc6, L.taxonomy_desc7, L.taxonomy_desc8, L.taxonomy_desc9, L.taxonomy_desc10, L.taxonomy_desc11, L.taxonomy_desc12, L.taxonomy_desc13, L.taxonomy_desc14, L.taxonomy_desc15);
		StateCode := choose(C, L.provider_license_number_state_code_1, L.provider_license_number_state_code_2, L.provider_license_number_state_code_3, L.provider_license_number_state_code_4, L.provider_license_number_state_code_5, L.provider_license_number_state_code_6, L.provider_license_number_state_code_7, L.provider_license_number_state_code_8, L.provider_license_number_state_code_9, L.provider_license_number_state_code_10, L.provider_license_number_state_code_11, L.provider_license_number_state_code_12, L.provider_license_number_state_code_13, L.provider_license_number_state_code_14, L.provider_license_number_state_code_15);
		LicenseNumber := choose(C, L.provider_license_number_1, L.provider_license_number_2, L.provider_license_number_3, L.provider_license_number_4, L.provider_license_number_5, L.provider_license_number_6, L.provider_license_number_7, L.provider_license_number_8, L.provider_license_number_9, L.provider_license_number_10, L.provider_license_number_11, L.provider_license_number_12, L.provider_license_number_13, L.provider_license_number_14, L.provider_license_number_15);
		boolean shouldSkip := TaxonomySwitch = '' and TaxonomyCode = '' and TaxonomyDesc =  '' and StateCode = '' and LicenseNumber = '';
		self.PrimaryTaxonomy := if(~shouldSkip, TaxonomySwitch, skip);
		self.SelectedTaxonomyCode := if(~shouldSkip, TaxonomyCode, skip);
		self.SelectedTaxonomyDesc := if(~shouldSkip, TaxonomyDesc, skip);
		self.State := if(~shouldSkip, StateCode, skip);
		self.LicenseNumber := if(~shouldSkip, LicenseNumber, skip);
	end;

	export prov_ident_rec getOtherIdentifiers(layouts.NPPES_Layouts.temp_layout L, integer C) := transform
		TypeCode := choose(C, L.other_provider_identifier_type_code_1, L.other_provider_identifier_type_code_2,L.other_provider_identifier_type_code_3, L.other_provider_identifier_type_code_4, L.other_provider_identifier_type_code_5, L.other_provider_identifier_type_code_6, L.other_provider_identifier_type_code_7, L.other_provider_identifier_type_code_8, L.other_provider_identifier_type_code_9, L.other_provider_identifier_type_code_10,
													L.other_provider_identifier_type_code_11, L.other_provider_identifier_type_code_12, L.other_provider_identifier_type_code_13, L.other_provider_identifier_type_code_14, L.other_provider_identifier_type_code_15, L.other_provider_identifier_type_code_16, L.other_provider_identifier_type_code_17, L.other_provider_identifier_type_code_18, L.other_provider_identifier_type_code_19, L.other_provider_identifier_type_code_20, 
													L.other_provider_identifier_type_code_21, L.other_provider_identifier_type_code_22, L.other_provider_identifier_type_code_23, L.other_provider_identifier_type_code_24, L.other_provider_identifier_type_code_25, L.other_provider_identifier_type_code_26, L.other_provider_identifier_type_code_27, L.other_provider_identifier_type_code_28, L.other_provider_identifier_type_code_29, L.other_provider_identifier_type_code_30,
													L.other_provider_identifier_type_code_31, L.other_provider_identifier_type_code_32, L.other_provider_identifier_type_code_33, L.other_provider_identifier_type_code_34, L.other_provider_identifier_type_code_35, L.other_provider_identifier_type_code_36, L.other_provider_identifier_type_code_37, L.other_provider_identifier_type_code_38, L.other_provider_identifier_type_code_39, L.other_provider_identifier_type_code_40,
													L.other_provider_identifier_type_code_41, L.other_provider_identifier_type_code_42, L.other_provider_identifier_type_code_43, L.other_provider_identifier_type_code_44, L.other_provider_identifier_type_code_45, L.other_provider_identifier_type_code_46, L.other_provider_identifier_type_code_47, L.other_provider_identifier_type_code_48, L.other_provider_identifier_type_code_49, L.other_provider_identifier_type_code_50);
		TypeDesc := choose(C, L.other_pid_issuer_desc_1, L.other_pid_issuer_desc_2, L.other_pid_issuer_desc_3, L.other_pid_issuer_desc_4, L.other_pid_issuer_desc_5, L.other_pid_issuer_desc_6, L.other_pid_issuer_desc_7, L.other_pid_issuer_desc_8, L.other_pid_issuer_desc_9, L.other_pid_issuer_desc_10,
													L.other_pid_issuer_desc_11, L.other_pid_issuer_desc_12, L.other_pid_issuer_desc_13, L.other_pid_issuer_desc_14, L.other_pid_issuer_desc_15, L.other_pid_issuer_desc_16, L.other_pid_issuer_desc_17, L.other_pid_issuer_desc_18, L.other_pid_issuer_desc_19, L.other_pid_issuer_desc_20,
													L.other_pid_issuer_desc_21, L.other_pid_issuer_desc_22, L.other_pid_issuer_desc_23, L.other_pid_issuer_desc_24, L.other_pid_issuer_desc_25, L.other_pid_issuer_desc_26, L.other_pid_issuer_desc_27, L.other_pid_issuer_desc_28, L.other_pid_issuer_desc_29, L.other_pid_issuer_desc_30,
													L.other_pid_issuer_desc_31, L.other_pid_issuer_desc_32, L.other_pid_issuer_desc_33, L.other_pid_issuer_desc_34, L.other_pid_issuer_desc_35, L.other_pid_issuer_desc_36, L.other_pid_issuer_desc_37, L.other_pid_issuer_desc_38, L.other_pid_issuer_desc_39, L.other_pid_issuer_desc_40,
													L.other_pid_issuer_desc_41, L.other_pid_issuer_desc_42, L.other_pid_issuer_desc_43, L.other_pid_issuer_desc_44, L.other_pid_issuer_desc_45, L.other_pid_issuer_desc_46, L.other_pid_issuer_desc_47, L.other_pid_issuer_desc_48, L.other_pid_issuer_desc_49, L.other_pid_issuer_desc_50);
		Issuer := choose(C, L.other_provider_identifier_issuer_1, L.other_provider_identifier_issuer_2, L.other_provider_identifier_issuer_3, L.other_provider_identifier_issuer_4, L.other_provider_identifier_issuer_5, L.other_provider_identifier_issuer_6, L.other_provider_identifier_issuer_7, L.other_provider_identifier_issuer_8, L.other_provider_identifier_issuer_9, L.other_provider_identifier_issuer_10,
												L.other_provider_identifier_issuer_11, L.other_provider_identifier_issuer_12, L.other_provider_identifier_issuer_13, L.other_provider_identifier_issuer_14, L.other_provider_identifier_issuer_15, L.other_provider_identifier_issuer_16, L.other_provider_identifier_issuer_17, L.other_provider_identifier_issuer_18, L.other_provider_identifier_issuer_19, L.other_provider_identifier_issuer_20,
												L.other_provider_identifier_issuer_21, L.other_provider_identifier_issuer_22, L.other_provider_identifier_issuer_23, L.other_provider_identifier_issuer_24, L.other_provider_identifier_issuer_25, L.other_provider_identifier_issuer_26, L.other_provider_identifier_issuer_27, L.other_provider_identifier_issuer_28, L.other_provider_identifier_issuer_29, L.other_provider_identifier_issuer_30,
												L.other_provider_identifier_issuer_31, L.other_provider_identifier_issuer_32, L.other_provider_identifier_issuer_33, L.other_provider_identifier_issuer_34, L.other_provider_identifier_issuer_35, L.other_provider_identifier_issuer_36, L.other_provider_identifier_issuer_37, L.other_provider_identifier_issuer_38, L.other_provider_identifier_issuer_39, L.other_provider_identifier_issuer_40,
												L.other_provider_identifier_issuer_41, L.other_provider_identifier_issuer_42, L.other_provider_identifier_issuer_43,L.other_provider_identifier_issuer_44, L.other_provider_identifier_issuer_45, L.other_provider_identifier_issuer_46, L.other_provider_identifier_issuer_47, L.other_provider_identifier_issuer_48, L.other_provider_identifier_issuer_49, L.other_provider_identifier_issuer_50);
		Identifier := choose(C, L.other_provider_identifier_1, L.other_provider_identifier_2, L.other_provider_identifier_3, L.other_provider_identifier_4, L.other_provider_identifier_5, L.other_provider_identifier_6, L.other_provider_identifier_7, L.other_provider_identifier_8, L.other_provider_identifier_9, L.other_provider_identifier_10,
														L.other_provider_identifier_11, L.other_provider_identifier_12, L.other_provider_identifier_13, L.other_provider_identifier_14, L.other_provider_identifier_15, L.other_provider_identifier_16, L.other_provider_identifier_17, L.other_provider_identifier_18, L.other_provider_identifier_19, L.other_provider_identifier_20,
														L.other_provider_identifier_21, L.other_provider_identifier_22, L.other_provider_identifier_23, L.other_provider_identifier_24, L.other_provider_identifier_25, L.other_provider_identifier_26, L.other_provider_identifier_27, L.other_provider_identifier_28, L.other_provider_identifier_29, L.other_provider_identifier_30,
														L.other_provider_identifier_31, L.other_provider_identifier_32, L.other_provider_identifier_33, L.other_provider_identifier_34, L.other_provider_identifier_35, L.other_provider_identifier_36, L.other_provider_identifier_37, L.other_provider_identifier_38, L.other_provider_identifier_39, L.other_provider_identifier_40,
														L.other_provider_identifier_41, L.other_provider_identifier_42, L.other_provider_identifier_43, L.other_provider_identifier_44, L.other_provider_identifier_45, L.other_provider_identifier_46, L.other_provider_identifier_47, L.other_provider_identifier_48, L.other_provider_identifier_49, L.other_provider_identifier_50);
		State := choose(C, L.other_provider_identifier_state_1, L.other_provider_identifier_state_2, L.other_provider_identifier_state_3, L.other_provider_identifier_state_4, L.other_provider_identifier_state_5, L.other_provider_identifier_state_6, L.other_provider_identifier_state_7, L.other_provider_identifier_state_8, L.other_provider_identifier_state_9, L.other_provider_identifier_state_10,
											 L.other_provider_identifier_state_11, L.other_provider_identifier_state_12, L.other_provider_identifier_state_13, L.other_provider_identifier_state_14, L.other_provider_identifier_state_15, L.other_provider_identifier_state_16, L.other_provider_identifier_state_17, L.other_provider_identifier_state_18, L.other_provider_identifier_state_19, L.other_provider_identifier_state_20,
											 L.other_provider_identifier_state_21, L.other_provider_identifier_state_22, L.other_provider_identifier_state_23, L.other_provider_identifier_state_24, L.other_provider_identifier_state_25, L.other_provider_identifier_state_26, L.other_provider_identifier_state_27, L.other_provider_identifier_state_28, L.other_provider_identifier_state_29, L.other_provider_identifier_state_30,
											 L.other_provider_identifier_state_31, L.other_provider_identifier_state_32, L.other_provider_identifier_state_33, L.other_provider_identifier_state_34, L.other_provider_identifier_state_35, L.other_provider_identifier_state_36, L.other_provider_identifier_state_37, L.other_provider_identifier_state_38, L.other_provider_identifier_state_39, L.other_provider_identifier_state_40,
											 L.other_provider_identifier_state_41, L.other_provider_identifier_state_42, L.other_provider_identifier_state_43, L.other_provider_identifier_state_44, L.other_provider_identifier_state_45, L.other_provider_identifier_state_46, L.other_provider_identifier_state_47, L.other_provider_identifier_state_48, L.other_provider_identifier_state_49, L.other_provider_identifier_state_50);
		boolean shouldSkip := TypeCode = '' and Issuer = '' and Identifier = '' and State = '';
		self.TypeCode := if(~shouldSkip, TypeCode, skip);
		self.TypeDescription := if(~shouldSkip, TypeDesc, skip);
		self.Issuer := if(~shouldSkip, Issuer, skip);
		self.Number := if(~shouldSkip, Identifier, skip);
		self.State := if(~shouldSkip, State, skip);
	end;

	export report_rec formatRecords(Layouts.NPPES_Layouts.nppes_penalty_recs L) := transform
		prov_clean_name := L.clean_name_provider;
		self.EntityInformation.EntityName := iesp.ECL2ESP.SetName(prov_clean_name.fname, prov_clean_name.mname, prov_clean_name.lname, prov_clean_name.name_suffix,prov_clean_name.title,'');
		self.EntityInformation.CompanyName := L.provider_organization_name;
		self.EntityInformation.CompanyNameAKA := L.provider_other_organization_name;
		self.EntityInformation.ParentOrganization := L.parent_organization_lbn;
		self.EntityInformation.TIN := cleanAlphaNumCharacters(L.parent_organization_tin);
		self.EntityInformation.ChildOrganization := L.is_organization_subpart;
		self.EntityInformation.AuthorizedName.Full := '';
		self.EntityInformation.AuthorizedName.First := L.authorized_official_first_name;
		self.EntityInformation.AuthorizedName.Last := L.authorized_official_last_name;
		self.EntityInformation.AuthorizedName.Middle := L.authorized_official_middle_name;
		self.EntityInformation.AuthorizedTitle := L.authorized_official_title_or_position;
		self.EntityInformation.AuthorizedName.Prefix := L.authorized_official_name_prefix;
		self.EntityInformation.AuthorizedName.Suffix := L.authorized_official_name_suffix;
		self.EntityInformation.AuthorizedCredentials := L.authorized_official_credential;			
		self.EntityInformation.Sex := Codes.GENERAL.Gender(L.provider_gender_code);
		self.EntityInformation.SoleProprietor := L.is_sole_proprietor = 'Y';
		
		self.NPIInformation.NPINumber := L.npi;
		self.NPIInformation.EntityType := L.entity_type_code;
		self.NPIInformation.EnumDate := iesp.ECL2ESP.toDatestring8(L.provider_enumeration_date);
		self.NPIInformation.LastUpdateDate := iesp.ECL2ESP.toDatestring8(L.last_update_date);
		self.NPIInformation.ReplacementNPI := L.replacement_npi;
		self.NPIInformation.DeactivationDate := iesp.ECL2ESP.toDatestring8(L.npi_deactivation_date);
		self.NPIInformation.DeactivationReason := L.deactivation_reason_desc;
		self.NPIInformation.ReactivationDate := iesp.ECL2ESP.toDatestring8(L.npi_reactivation_date);
		
		self.ProviderMailingAddress := iesp.ECL2ESP.SetAddress(L.clean_mailing_address.prim_name, L.clean_mailing_address.prim_range,L.clean_mailing_address.predir, L.clean_mailing_address.postdir,L.clean_mailing_address.addr_suffix, L.clean_mailing_address.unit_desig, L.clean_mailing_address.sec_range, 
				 L.provider_business_mailing_address_city_name, 
				 L.provider_business_mailing_address_state_name, L.provider_business_mailing_address_postal_code[1..5], L.provider_business_mailing_address_postal_code[6..10], '', '', 
				 L.provider_first_line_business_mailing_address, 
				 L.provider_second_line_business_mailing_address, '');
		self.ProviderMailingAddress.Phone10 := l.cleanmailingphone;
		self.ProviderMailingAddress.FaxNumber := L.provider_business_mailing_address_fax_number;
		
		self.ProviderPracticeAddress := iesp.ECL2ESP.SetAddress(L.clean_location_address.prim_name, L.clean_location_address.prim_range,L.clean_location_address.predir, L.clean_location_address.postdir,L.clean_mailing_address.addr_suffix, L.clean_location_address.unit_desig, L.clean_location_address.sec_range, 
				 L.provider_business_practice_location_address_city_name, 
				 L.provider_business_practice_location_address_state_name, L.provider_business_practice_location_address_postal_code[1..5], L.provider_business_practice_location_address_postal_code[6..10], '', '', 
				 L.provider_first_line_business_practice_location_address, 
				 L.provider_second_line_business_practice_location_address, '');
		self.ProviderPracticeAddress.Phone10 := L.cleanlocationphone;
		self.ProviderPracticeAddress.FaxNumber := L.provider_business_practice_location_address_fax_number;
		
		l_ds := dataset(row(L, layouts.NPPES_Layouts.temp_layout));
		
		ds_taxo := normalize(l_ds, 15, getTaxonomy(left, counter));
		self.ProviderTaxonomies := ds_taxo;
		
		ds_ident := normalize(l_ds, 50, getOtherIdentifiers(left, counter));
		self.OtherProviderIdentifiers := ds_ident;
		self := [];
	end;
		
	export layouts.layout_full_npi formatRecordsSearch(Healthcare_Provider_Services.Layouts.layout_npi input, recordof(NPPES.Key_NPPES_npi) recs, boolean verifiedbynpi) := transform
			tmp:=project(recs,transform(Layouts.NPPES_Layouts.nppes_penalty_recs, self:=left));
			self.acctno := input.acctno;
			self.providerid := input.providerid;
			self.NPPESVerified := map(input.usersupplied and verifiedbynpi => 'YES',
																input.usersupplied => 'CORRECTED',
																'YES'); 
			self := project(tmp,formatRecords(left));
	end;
	export layouts.layout_full_npi formatRecordsSearchAK(Healthcare_Provider_Services.Layouts.layout_npi input, Healthcare_Provider_Services.Layouts.Layout_Autokeys_NPI recs, boolean verifiedbynpi) := transform
			tmp:=project(recs,transform(Layouts.NPPES_Layouts.nppes_penalty_recs, self:=left));
			self.acctno := input.acctno;
			self.providerid := input.providerid;
			self.NPPESVerified :=  map(input.usersupplied and verifiedbynpi => 'YES',
																input.usersupplied => 'CORRECTED',
																'YES');  
			self := project(tmp,formatRecords(left));
	end;
end;
