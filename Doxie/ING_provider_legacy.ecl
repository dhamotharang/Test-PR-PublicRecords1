import AutoStandardI, codes, dea, DeathV2_Services, ingenix_natlprof, doxie, doxie_crs, doxie_files, 
       dx_death_master, Prof_LicenseV2_Services, STD, suppress, watchdog;

// ********************************************************************************
// #125437: adding this module so we can rollback some of the changes for health care provider.
// this is meant to be used by Doxie.HeaderSource_Service only.
// ********************************************************************************

EXPORT ING_provider_legacy := module

	SHARED pid_npi_rec := record
     unsigned6 providerid;
		doxie.ingenix_provider_module.ingenix_npi_rec;
	end;

	// same as previously commented out code in Healthcare_Provider_Services.Functions.getNPIthruNPPES_Prov
	EXPORT getNPIthruNPPES_Prov(dataset(pid_npi_rec) pid_npi_in, 
															dataset(recordof(doxie_files.key_provider_id)) prov_id_in) := FUNCTION 
			
		int_rec := record
			unsigned seq;
			doxie_files.key_provider_id;
			pid_npi_rec - [providerid];
		end;
		
		pid_npi_seq := project(pid_npi_in, transform(int_rec, self.seq := counter, 
																													self.providerid := (string)left.providerid, 
																													self := left, 
																													self := []));
		
		int_rec xform_wnpi(prov_id_in L, int_rec R) := transform
			self := L;
			self := R;
		end;
		
		prov_npi := join(prov_id_in, pid_npi_seq, 
										left.providerid = (string)right.providerid, 
										xform_wnpi(left, right));
										
		// Healthcare_Provider_Services.MAC_VerifyNPIthruNPPES(prov_npi, verified_prov_npi,
															// prov_clean_lname,
															// prov_clean_fname,
															// prov_clean_mname,
															// prov_clean_prim_range,
															// prov_clean_prim_name,
															// prov_clean_predir,
															// prov_clean_postdir,
															// prov_clean_addr_suffix,
															// prov_clean_sec_range,
															// prov_clean_p_city_name,
															// prov_clean_st,
															// prov_clean_zip,
															// providerid,
															// LastName);
															
		return dedup(sort(prov_npi, seq, npi), seq, npi);
	END; // end getNPIthruNPPES_Prov

	// same as doxie.ING_provider_report_records, version 2012-09-19.
	export report_records(dataset(Prof_LicenseV2_Services.Layout_Search_Ids_Prov) provs, boolean Include_Sanc=false) := FUNCTION
		death_params := DeathV2_Services.IParam.GetDeathRestrictions(AutoStandardI.GlobalModule());

		doxie.MAC_Header_Field_Declare();

		provider_id_key := doxie_files.key_provider_id;
		language_key := ingenix_natlprof.key_language_providerid;
		upin_key := ingenix_natlprof.key_UPIN_providerid;
		npi_key := ingenix_natlprof.key_NPI_providerid;
		provider_lic_rpt_key := ingenix_natlprof.key_license_providerid;
		dea_key := ingenix_natlprof.key_DEA_providerid;
		degree_key := ingenix_natlprof.key_degree_providerid;
		specialty_key := ingenix_natlprof.key_speciality_providerid;
		group_key := ingenix_natlprof.key_group_providerid;
		hospital_key := ingenix_natlprof.key_hospital_providerid;
		residency_key := ingenix_natlprof.key_residency_providerid;
		medschool_key := ingenix_natlprof.key_medschool_providerid;

		sanctions_did_key := doxie_files.key_sanctions_did;
		sanctions_upin_key := doxie_files.key_upin_sancid;
		sanctions_license_key := doxie_files.key_license_sancid;
		sanctions_taxid_name_key := doxie_files.key_sanctions_taxid_name;
		sanctions_sancid_key := doxie_files.key_sanctions_sancid;

		best_ssn_key := watchdog.key_best_ssn;

		taxonomy_key := Ingenix_NatlProf.key_NPI_providerid;

		prov_match_recs :=join(provs, provider_id_key,keyed(left.providerid=right.l_providerid),
			transform(recordof(provider_id_key),self:=right),keep(100));

		//get dids
		pid_did_rec := record
				 unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_did_rec;
		end;

		pid_did_rec get_provider_dids(provider_id_key r) := transform
				 self.providerid := r.l_providerid;
			self := r;
		end;

		f_dids := project(prov_match_recs,get_provider_dids(left));
		f_dids_srt := sort(f_dids((unsigned6)did<>0), record);
		f_dids_dep := dedup(f_dids_srt, record);

		// Get Dids
		boolean checkDeath(dataset(pid_did_rec) l) := FUNCTION
    death_recs_raw := dx_death_master.Get.byDid(l, did, death_params);
    
		return if(count(death_recs_raw(death.state_death_id <> '')) > 0,true,false);
		end;

		//get SSN's
		pid_ssn_rec := record
				unsigned6 providerid;
				string9 SSN;
		end;

		pid_ssn_rec get_provider_ssns(pid_did_rec l, watchdog.KeyType_Best_SSN r) := transform
			self.providerid := l.providerid;
			self.ssn := r.ssn;
		end;

		f_ssns := join(f_dids_dep, best_ssn_key, 
										keyed((unsigned6)left.did=right.did),get_provider_ssns(left, right),keep(10),limit(0),left outer);
		//Masking for SSN
		doxie.MAC_PruneOldSSNs(f_ssns, out_ssn_pruned, ssn, providerid);
		suppress.MAC_Mask(out_ssn_pruned, f_ssns_masked, ssn, blank, true, false);

		//get name
		pid_name_rec := record
				 unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_name_rec;
		end;

		pid_name_rec get_names(provider_id_key r) := transform
				 self.providerid := r.l_providerid;
			self.ProviderNameTierID := (unsigned2) r.ProviderNameTierID;
			self := r;
		end;
		f_names := project(prov_match_recs,get_names(left));

		f_names_srt := sort(f_names(Prov_Clean_fname<>'' or Prov_Clean_lname<>''), record);
		f_names_dep := dedup(f_names_srt, record, except ProviderNameTierID);

		//get medicare
		pid_medicare_rec := record
				 unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_medicare_optout_rec;
		end;
		pid_medicare_rec get_medicare(provider_id_key r) := transform
				 self.providerid := r.l_providerid;
				 // self.OptOutSiteDescription;
				 // self.AffidavitReceivedDate;
				 // self.OptOutEffectiveDate;
				 self.OptOutTerminationDate := r.DateOptOutTerminationDate;
				 // self.OptOutStatus;
				 // self.LastUpdate;
			self := r;
		end;
		f_medicare := project(prov_match_recs,get_medicare(left));
		f_medicare_srt := sort(f_medicare, -OptOutEffectiveDate);
		f_medicare_dep := dedup(f_medicare_srt(OptOutEffectiveDate<>''), record);

		//get ing death
		pid_death_rec := record
				 unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_dod_rec;
		end;
		pid_death_rec get_death(provider_id_key r) := transform
				 self.providerid := r.l_providerid;
				 // self.DeceasedIndicator; 
				 // self.DeceasedDate;
			self := r;
		end;
		f_death := project(prov_match_recs,get_death(left));
		f_death_srt := sort(f_death, -DeceasedDate);
		f_death_dep := dedup(f_death_srt, record)(DeceasedDate<>'');

		//get taxid
		pid_taxid_rec := record
				 unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_taxid_rec;
		end;

		pid_taxid_rec get_taxids(provider_id_key r) := transform
				 self.providerid := r.l_providerid;
			self.TaxIDTierTypeID := (unsigned2) r.TaxIDTierTypeID;
			self := r;
		end;

		f_taxids := project(prov_match_recs, get_taxids(left));

		f_taxids_srt := sort(f_taxids(TaxID<>''), record);
		f_taxids_dep := dedup(f_taxids_srt, record, except TaxIDTierTypeID);

		//get dob
		pid_dob_rec := record
				 unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_dob_rec;
		end;

		pid_dob_rec get_dobs(provider_id_key r) := transform
				 self.providerid := r.l_providerid;
			self.BirthDateTierTypeID := (unsigned2) r.BirthDateTierTypeID;
			self := r;
		end;

		f_dobs := project(prov_match_recs,get_dobs(left));

		f_dobs_srt := sort(f_dobs(BirthDate<>''), record);
		f_dobs_dep := dedup(f_dobs_srt, record, except BirthDateTierTypeID);

		//get language
		pid_language_rec := record
				 unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_language_rec;
		end;

		pid_language_rec get_languages(language_key r) := transform
				 self.providerid := r.l_providerid;
			self.LanguageTierTypeID := (unsigned2) r.LanguageTierTypeID;
			self := r;
		end;

		f_languages := join(provs,language_key,keyed(left.providerid=right.l_providerid),get_languages(right),
			keep(100));

		f_languages_srt := sort(f_languages(Language<>''), record);
		f_languages_dep := dedup(f_languages_srt, record, except LanguageTierTypeID);

		//get upin
		pid_upin_rec := record
				 unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_upin_rec;
		end;

		pid_upin_rec get_upins(upin_key r) := transform
				 self.providerid := r.l_providerid;
			self.UPINTierTypeID := (unsigned2) r.UPINTierTypeID;
			self := r;
		end;

		f_upins := join(provs,upin_key,keyed(left.providerid =right.l_providerid),get_upins(right),
			keep(100));

		f_upins_srt := sort(f_upins(upin<>''), record);
		f_upins_dep := dedup(f_upins_srt, record, except UPINTierTypeID);

		//get npi
		pid_npi_rec get_npis(npi_key r) := transform
				 self.providerid := r.l_providerid;
			self.NPITierTypeID := (unsigned2) r.NPITierTypeID;
			self := r;
		end;

		f_npis := join(provs,npi_key,keyed(left.providerid =right.l_providerid),get_npis(right),
			keep(100));

		f_npis_srt := sort(f_npis(npi<>''), record);
		f_npis_dep := dedup(f_npis_srt, record, except NPITierTypeID);
		f_npis_verified := getNPIthruNPPES_Prov(f_npis_dep, prov_match_recs);

		//get license
		pid_license_rec := record
				 unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_license_rpt_rec;
		end;

		pid_license_rec get_licenses(provider_lic_rpt_key r) := transform
				 self.providerid := r.l_providerid;
			self.LicenseNumberTierTypeID := (unsigned2) r.LicenseNumberTierTypeID;
			self := r;
		end;

		f_licenses := join(provs,provider_lic_rpt_key,keyed(left.providerid = right.l_providerid),
													get_licenses(right),keep(100));

		f_licenses_srt := sort(f_licenses(LicenseNumber<>'' or LicenseState<>''), record);
		f_licenses_dep := dedup(f_licenses_srt, record, except LicenseNumberTierTypeID);

		pid_license_rec doRemoveBadLicense(pid_license_rec l) := TRANSFORM
			SELF.providerid := l.providerid;
			self.licensestate := l.licensestate;
			self.licensenumber := l.licensenumber;
			self.effective_date := l.effective_date;
			self.termination_date := if(l.termination_date <>'',
																	l.termination_date,
																	if(exists(f_licenses_dep(licensenumber=l.licensenumber,
																							licensestate=l.licensestate,
																							termination_date<>'')
																						),skip,l.termination_date));
			self.licensenumberTierTypeID := l.licensenumberTierTypeID;
		END;
		f_licenses_clean:=project(f_licenses_dep,doRemoveBadLicense(left));

		//rollup License
		pid_license_rec doRollLicense(pid_license_rec l, pid_license_rec r) := TRANSFORM
			SELF.providerid := l.providerid;
			self.licensestate := l.licensestate;
			self.licensenumber := l.licensenumber;
			self.effective_date := if(l.effective_date <>'',l.effective_date,r.effective_date);
			self.termination_date := if(l.termination_date <>'',l.termination_date,r.termination_date);
			self.licensenumberTierTypeID := if(l.licensenumberTierTypeID<r.licensenumberTierTypeID,l.licensenumberTierTypeID,r.licensenumberTierTypeID);
		END;

		f_licenses_rollup := rollup(f_licenses_clean,doRollLicense(left,right),licensenumber, licensestate, termination_date);
		f_licenses_rollup_sorted := sort(f_licenses_rollup,licensestate, licensenumber, -termination_date);

		//get dea
		pid_dea_rec := record
				 unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_dea_rec;
		end;

		pid_dea_rec get_deas(dea_key r) := transform
				 self.providerid := r.l_providerid;
			self.DEANumberTierTypeID := (unsigned2) r.DEANumberTierTypeID;
			self.expiration_date := CHOOSEN(SORT(dea.Key_dea_reg_num(dea_registration_number=r.DEANumber),-Expiration_Date),1)[1].Expiration_Date;
			self := r;
		end;

		f_deas := join(provs,dea_key,keyed(left.providerid = right.l_providerid),get_deas(right),
			keep(100));

		f_deas_srt := sort(f_deas(DEANumber<>''), record);
		f_deas_dep := dedup(f_deas_srt, record, except DEANumberTierTypeID);

		//rollup DEA
		pid_dea_rec doRollDea(pid_dea_rec l, pid_dea_rec r) := TRANSFORM
			SELF.providerid := l.providerid;
			self.deanumber := l.deanumber;
			self.deanumberTierTypeID := if(l.deanumberTierTypeID<r.deanumberTierTypeID,l.deanumberTierTypeID,r.deanumberTierTypeID);
			self.expiration_date := if(l.expiration_date <>'',l.expiration_date,r.expiration_date);
		END;
		f_dea_rollup := rollup(f_deas_dep,doRollDea(left,right),deanumber);

		//get degree
		pid_degree_rec := record
				 unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_degree_rec;
		end;

		pid_degree_rec get_degrees(degree_key r) := transform
				 self.providerid := r.l_providerid;
			self.DegreeTierTypeID := (unsigned2) r.DegreeTierTypeID;
			self := r;
		end;

		f_degrees := join(provs,degree_key,keyed(left.providerid =right.l_providerid),get_degrees(right),
			keep(100));

		f_degrees_srt := sort(f_degrees(degree<>''), record);
		f_degrees_dep := dedup(f_degrees_srt, record, except DegreeTierTypeID);

		//get specialty
		pid_specialty_rec := record
				 unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_specialty_rec;
		end;

		pid_specialty_rec get_specialties(specialty_key r) := transform
				 self.providerid := r.l_providerid;
			self.SpecialtyID := (unsigned4)r.SpecialityID;
			self.SpecialtyName := r.SpecialityName;
				 self.SpecialtyGroupID := (unsigned4)r.SpecialityGroupID; 
			self.SpecialtyGroupName := r.SpecialityGroupName;
			self.SpecialtyTierTypeID := (unsigned2) r.SpecialtyTierTypeID;
			self := r;
		end;

		f_specialties := join(provs,specialty_key,keyed(left.providerid =right.l_providerid),
		get_specialties(right),keep(100));

		f_specialties_srt := sort(f_specialties(SpecialtyID<>0 or SpecialtyName<>''), record);
		f_specialties_dep := dedup(f_specialties_srt, record, except SpecialtyTierTypeID);

		pid_specialty_rec doRemoveBadSpecialties(pid_specialty_rec l) := TRANSFORM
			SELF.providerid := l.providerid;
			self.specialtyid := l.specialtyid;
			self.specialtyGroupID := l.specialtyGroupID;
			self.specialtyname := l.specialtyname;
			self.specialtyGroupName := if(exists(f_specialties_dep(STD.STR.ToUpperCase(specialtyname)=STD.STR.ToUpperCase(l.specialtyGroupName))),'',l.specialtyGroupName);
			self.specialtyTierTypeID := l.specialtyTierTypeID;
		END;
		f_specialties_cleaned:=project(f_specialties_dep,doRemoveBadSpecialties(left));
		pid_specialty_rec doRemoveSpecialtiesOther(pid_specialty_rec l) := TRANSFORM
			SELF.specialtyname := if(STD.STR.ToUpperCase(l.specialtyname)='OTHER' and l.specialtyGroupName='',Skip,l.specialtyname);
			self := l;
		END;
		f_specialties_clean:=project(f_specialties_cleaned,doRemoveSpecialtiesOther(left));


		//rollup Specialties
		pid_specialty_rec doRollSpecialties(pid_specialty_rec l, pid_specialty_rec r) := TRANSFORM
			SELF.providerid := l.providerid;
			self.specialtyid := l.specialtyid;
			self.specialtyGroupID := l.specialtyGroupID;
			self.specialtyname := l.specialtyname;
			self.specialtyGroupName := if(l.specialtyGroupName <>'',l.specialtyGroupName,r.specialtyGroupName);
			self.specialtyTierTypeID := if(l.specialtyTierTypeID<r.specialtyTierTypeID,l.specialtyTierTypeID,r.specialtyTierTypeID);
		END;
		f_specialties_rollup := rollup(f_specialties_clean,doRollSpecialties(left,right),STD.STR.ToUpperCase(specialtyname),specialtyid,specialtyGroupID);

		//get business address
		pid_bus_addr_rec := record
				 unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_addr_rpt_rec;
		end;

		pid_bus_addr_rec get_bus_addrs(provider_id_key r) := transform
				 self.providerid := r.l_providerid;
			self.ProviderAddressTierTypeID := (unsigned2) r.ProviderAddressTierTypeID;
			self := r;
			self := [];
		end;

		f_bus_addrs := project(prov_match_recs,get_bus_addrs(left));

		f_bus_addrs_srt := sort(f_bus_addrs(Prov_Clean_prim_name<>''), record);
		f_bus_addrs_dep := dedup(f_bus_addrs_srt, record, except ProviderAddressTierTypeID);

		pid_bus_addr_rec_clean := record
				 unsigned6 providerid;
				 doxie.ingenix_provider_module.ingenix_addr_rpt_rec;
				string120 Address1;
				string120 Address2;
				unsigned4 len;
		end;
		f_bus_addrs_prepclean := project(f_bus_addrs_dep,transform(pid_bus_addr_rec_clean,
																																tmpaddr:=left.prov_clean_prim_range+left.Prov_Clean_predir+left.Prov_Clean_prim_name+left.Prov_Clean_addr_suffix+left.Prov_Clean_postdir+left.Prov_Clean_unit_desig+left.Prov_Clean_sec_range;
																																self.address1:=tmpaddr,
																																self.address2:=trim(tmpaddr,all),
																																self.len:=length(trim(tmpaddr,all)),
																																self := left));
		pid_bus_addr_rec doRemoveBadAddresses(f_bus_addrs_prepclean l) := TRANSFORM
			tmpaddr:=l.prov_clean_prim_range+l.Prov_Clean_predir+l.Prov_Clean_prim_name+l.Prov_Clean_addr_suffix+l.Prov_Clean_postdir+l.Prov_Clean_unit_desig+l.Prov_Clean_sec_range;
			tmp:=f_bus_addrs_prepclean(address1<>tmpaddr);
			ds_tmp := tmp(address2[1..l.len]=l.address2,Prov_Clean_p_city_name=l.Prov_Clean_p_city_name,Prov_Clean_st=l.Prov_Clean_st,Prov_Clean_zip=l.Prov_Clean_zip,len>l.len);
			SELF.providerid := l.providerid;
			self.Prov_Clean_p_city_name := if(exists(ds_tmp),skip,l.Prov_Clean_p_city_name);
			self := l;
		END;
		f_bus_addrs_clean:=project(f_bus_addrs_prepclean,doRemoveBadAddresses(left));

		//get phone
		pid_phone_rec := record
				 unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_phone_rec;
		end;

		pid_phone_rec get_phones(prov_match_recs l) := transform
				 self.providerid := (unsigned6)l.providerid;
			self.PhoneNumberTierTypeID := (unsigned2) l.PhoneNumberTierTypeID;
			self := l;
		end;

		f_phones := project(prov_match_recs, get_phones(left));

		f_phones_srt1 := sort(f_phones(phonenumber<>''), record);
		f_phones_dep := dedup(f_phones_srt1, record, except PhoneNumberTierTypeID);

		f_phones_srt2 := sort(f_phones_dep,  providerid,
																				 Prov_Clean_prim_name,
										Prov_Clean_st,
										Prov_Clean_zip,
										Prov_Clean_prim_range,
										Prov_Clean_sec_range,
										PhoneNumber,
										-PhoneType);

		f_phones_srt2 roll_phone_type(f_phones_srt2 l, f_phones_srt2 r) := transform
			self.PhoneType := trim(l.PhoneType) + ',' + 
												if(STD.STR.Find(trim(l.PhoneType),'Office',1)>0,
									STD.STR.FindReplace(trim(r.PhoneType),'Office',''),
							 trim(r.PhoneType));
			self := l;
		end;

		f_phones_rol_ready := rollup(f_phones_srt2, roll_phone_type(left,right), 
																 record, except PhoneType, PhoneNumberTierTypeID);


		f_phones_rol_final := sort(f_phones_rol_ready, providerid, Prov_Clean_prim_name,
															Prov_Clean_st, Prov_Clean_zip,
															Prov_Clean_prim_range, Prov_Clean_sec_range);   
							 
		f_phones_rol := group(TOPN(group(f_phones_rol_final, providerid, Prov_Clean_prim_name,
																		Prov_Clean_st, Prov_Clean_zip,
																		Prov_Clean_prim_range, Prov_Clean_sec_range), 10, 
										 PhoneNumberTierTypeID));

		//append phones to address
		f_bus_addrs_clean app_phones(f_bus_addrs_clean l,  f_phones_rol r) := transform
			self.phone := l.phone + dataset([{r.PhoneNumber,
											r.PhoneType,
											r.PhoneNumberTierTypeID}], 
											doxie.ingenix_provider_module.ingenix_phone_slim_rec);
				self := l;						                     
		end;
									 

		f_addrs_ready := denormalize(f_bus_addrs_clean, f_phones_rol, 
																 left.providerid = right.providerid and
															left.Prov_Clean_prim_name = right.Prov_Clean_prim_name and
													 left.Prov_Clean_st = right.Prov_Clean_st and
									left.Prov_Clean_zip = right.Prov_Clean_zip and
															left.Prov_Clean_prim_range = right.Prov_Clean_prim_range and
													 left.Prov_Clean_sec_range = right.Prov_Clean_sec_range,
											app_phones(left, right));								 


		//get group affiliation
		pid_group_rec := record
				 unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_group_rec;
		end;

		pid_group_rec get_groups(group_key r) := transform
				 self.providerid := r.l_providerid;
				 self.GroupNameTierTypeID := (unsigned2) r.GroupNameTierTypeID;
			self := r;
		end;

		f_groups := join(provs,group_key,keyed(left.providerid =right.l_providerid),get_groups(right),
			keep(100));

		f_groups_srt := sort(f_groups(GroupName<>''), record);
		f_groups_dep := dedup(f_groups_srt, record, except GroupNameTierTypeID);

		pid_group_rec_clean := record
				 unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_group_rec;
				string120 GroupName2;
				unsigned4 len;
		end;
		f_groups_prepclean := project(f_groups_dep,transform(pid_group_rec_clean,
																													str1:= STD.STR.FindReplace(STD.STR.ToUpperCase(left.Groupname),'GROUP','');
																													str2:= STD.STR.FindReplace(STD.STR.ToUpperCase(str1),'GRP','');
																													str3:= STD.STR.FindReplace(STD.STR.ToUpperCase(str2),'INC','');
																													str4:= STD.STR.FindReplace(STD.STR.ToUpperCase(str3),'ASSOCIATES','');
																													str5:= STD.STR.FindReplace(STD.STR.ToUpperCase(str4),'ASSOC','');
																													str6:= STD.STR.FindReplace(STD.STR.ToUpperCase(str5),'CORPORATION','');
																													str7:= STD.STR.FindReplace(STD.STR.ToUpperCase(str6),'CORP','');
																													str8:= STD.STR.FindReplace(STD.STR.ToUpperCase(str7),'CENTER','');
																													str9:= STD.STR.FindReplace(STD.STR.ToUpperCase(str8),'OF','');
																													str10:= STD.STR.FindReplace(STD.STR.ToUpperCase(str9),'AND','');
																													strfinal:= STD.STR.FindReplace(STD.STR.ToUpperCase(str10),'THE','');
																													self.GroupName2:=trim(strfinal,all),
																													self.len:=length(trim(strfinal,all)),
																													self := left));
		//rollup Groups
		pid_group_rec_clean doCleanGroups(pid_group_rec_clean l) := TRANSFORM
			tmp:=f_groups_prepclean(GroupName<>l.GroupName);
			ds_tmp := tmp(GroupName2[1..l.len]=l.GroupName2,len>l.len);
			SELF.providerid := l.providerid;
			self.BDID := l.bdid;
			self.groupname := if(exists(ds_tmp),skip,l.groupname);
			self.GroupNameTierTypeID := l.GroupNameTierTypeID;
			self.Address := l.address;
			self.City := l.City;
			self.State := l.State;
			self.Zip := l.Zip;
			self := l;
		END;
		f_groups_clean := project(f_groups_prepclean,doCleanGroups(left));
		pid_group_rec doRollGroups(pid_group_rec l, pid_group_rec r) := TRANSFORM
			SELF.providerid := l.providerid;
			self.BDID := l.bdid;
			self.groupname := l.groupname;
			self.GroupNameTierTypeID := if(l.GroupNameTierTypeID<r.GroupNameTierTypeID,l.GroupNameTierTypeID,r.GroupNameTierTypeID);
			self.Address := if(l.address <>'',l.address,r.address);
			self.City := if(l.City <>'',l.City,r.city);
			self.State := if(l.State <>'',l.State,r.state);
			self.Zip := if(l.Zip <>'',l.Zip,r.zip);
		END;
		f_groups_rollup := rollup(project(f_groups_clean,pid_group_rec),doRollGroups(left,right),STD.STR.ToUpperCase(groupname));

		//get hospital affiliation
		pid_hospital_rec := record
				 unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_hospital_rec;
		end;

		pid_hospital_rec get_hospitals(hospital_key r) := transform
				 self.providerid := r.l_providerid;
				 self.HospitalNameTierTypeID := (unsigned2) r.HospitalNameTierTypeID;
			self := r;
		end;

		f_hospitals := join(provs,hospital_key,keyed(left.providerid= right.l_providerid),get_hospitals(right),
			keep(100));

		f_hospitals_srt := sort(f_hospitals(HospitalName<>''), record);
		f_hospitals_dep := dedup(f_hospitals_srt, record, except HospitalNameTierTypeID);

		pid_hospital_rec_clean := record
				 unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_hospital_rec;
				string120 HospitalName2;
				unsigned4 len;
		end;
		f_hospitals_prepclean := project(f_hospitals_dep,transform(pid_hospital_rec_clean,
																			str1:= STD.STR.FindReplace(STD.STR.ToUpperCase(left.hospitalname),'HOSPITAL','');
																			str2:= STD.STR.FindReplace(STD.STR.ToUpperCase(str1),'COMMUNITY','');
																			str3:= STD.STR.FindReplace(STD.STR.ToUpperCase(str2),'CENTER','');
																			str4:= STD.STR.FindReplace(STD.STR.ToUpperCase(str3),'CLINIC','');
																			strfinal:= STD.STR.FindReplace(STD.STR.ToUpperCase(str4),'HEALTH','');
																			self.hospitalname2:=trim(strfinal,all),
																			self.len:=length(trim(strfinal,all)),
																			self := left));
		//Clean Hospitals
		pid_hospital_rec doCleanHospital(pid_hospital_rec_clean l) := TRANSFORM
			tmp:=f_hospitals_prepclean(HospitalName<>l.HospitalName);
			ds_tmp := tmp(trim(HospitalName2,right)=trim(l.HospitalName2,right),address[1..10]=l.address[1..10],len>l.len);
			SELF.providerid := l.providerid;
			self.BDID := l.bdid;
			self.HospitalName := if(exists(ds_tmp),skip,l.HospitalName);
			self.HospitalNameTierTypeID := l.HospitalNameTierTypeID;
			self.Address := l.address;
			self.City := l.City;
			self.State := l.State;
			self.Zip := l.Zip;
		END;
		f_hospitals_clean := project(f_hospitals_prepclean,doCleanHospital(left));
		//rollup Hospital
		pid_hospital_rec doRollHospital(pid_hospital_rec l, pid_hospital_rec r) := TRANSFORM
			SELF.providerid := l.providerid;
			self.BDID := l.bdid;
			self.HospitalName := l.HospitalName;
			self.HospitalNameTierTypeID := if(l.HospitalNameTierTypeID<r.HospitalNameTierTypeID,l.HospitalNameTierTypeID,r.HospitalNameTierTypeID);
			self.Address := if(l.address <>'',l.address,r.address);
			self.City := if(l.City <>'',l.City,r.city);
			self.State := if(l.State <>'',l.State,r.state);
			self.Zip := if(l.Zip <>'',l.Zip,r.zip);
		END;
		f_hospitals_rollup := rollup(f_hospitals_clean,doRollHospital(left,right),hospitalname);

		//get residency
		pid_residency_rec := record
				 unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_residency_rec;
		end;

		pid_residency_rec get_residencies(residency_key r) := transform
				 self.providerid := r.l_providerid;
				 self.ResidencyTierTypeID := (unsigned2) r.ResidencyTierTypeID;
			self := r;
		end;

		f_residencies := join(provs,residency_key,keyed(left.providerid =right.l_providerid),get_residencies(right),
			keep(100));

		f_residencies_srt := sort(f_residencies(Residency<>''), record);
		f_residencies_dep := dedup(f_residencies_srt, providerid,trim(residency,all));


		pid_residency_rec_clean := record
				 unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_residency_rec;
				 string120 Residency2;
				 unsigned4 len;
		end;
		f_residencies_prepclean := project(f_residencies_dep,transform(pid_residency_rec_clean,
																																		str1:= STD.STR.FindReplace(STD.STR.ToUpperCase(left.Residency),'HOSPITAL','');
																																		str2:= STD.STR.FindReplace(STD.STR.ToUpperCase(str1),'UNIVERSITY','');
																																		str3:= STD.STR.FindReplace(STD.STR.ToUpperCase(str2),'MEDICAL','');
																																		str4:= STD.STR.FindReplace(STD.STR.ToUpperCase(str3),'CLINIC','');
																																		str5:= STD.STR.FindReplace(STD.STR.ToUpperCase(str4),'OF','');
																																		str6:= STD.STR.FindReplace(STD.STR.ToUpperCase(str5),'AND','');
																																		strfinal:= STD.STR.FindReplace(STD.STR.ToUpperCase(str6),'THE','');
																																		self.Residency2:=trim(strfinal,all),
																																		self.len:=length(trim(strfinal,all)),
																																		self := left));
		pid_residency_rec doRemoveBadResidencies(pid_residency_rec_clean l) := TRANSFORM
			tmp:=f_residencies_prepclean(Residency<>l.Residency);
			ds_tmp := tmp(Residency2[1..l.len]=l.Residency2,len>l.len);
			SELF.providerid := l.providerid;
			self.BDID := l.bdid;
			self.Residency := if(exists(ds_tmp),skip,l.Residency);
			self.ResidencyTierTypeID := l.ResidencyTierTypeID;
		END;
		f_residencies_clean:=project(f_residencies_prepclean,doRemoveBadResidencies(left));
		f_residencies_final:=dedup(f_residencies_clean,STD.STR.ToUpperCase(Residency));

		//get medschool
		pid_medschool_rec := record
				 unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_medschool_rec;
		end;

		pid_medschool_rec get_medschools(medschool_key r) := transform
				 self.providerid := r.l_providerid;
				 self.MedSchoolTierTypeID := (unsigned2) r.MedSchoolTierTypeID;
			self := r;
		end;

		f_medschools := join(provs,medschool_key,keyed(left.providerid =right.l_providerid),get_medschools(right),
			keep(100));

		f_medschools_srt := sort(f_medschools(MedSchoolName<>''), record);
		f_medschools_dep := dedup(f_medschools_srt, record, except MedSchoolTierTypeID);

		pid_medschool_rec_clean := record
				 unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_medschool_rec;
				string120 MedSchoolName2;
				unsigned4 len;
		end;
		f_medschools_prepclean := project(f_medschools_dep,transform(pid_medschool_rec_clean,
																			str1:= STD.STR.FindReplace(STD.STR.ToUpperCase(left.medschoolname),'SCHOOL','');
																			str2:= STD.STR.FindReplace(STD.STR.ToUpperCase(str1),'MEDICAL','');
																			str3:= STD.STR.FindReplace(STD.STR.ToUpperCase(str2),'OF','');
																			str4:= STD.STR.FindReplace(STD.STR.ToUpperCase(str3),'AND','');
																			strfinal:= STD.STR.FindReplace(STD.STR.ToUpperCase(str4),'THE','');
																			self.Medschoolname2:=trim(strfinal,all),
																			self.len:=length(trim(strfinal,all)),
																			self := left));
		pid_medschool_rec doRemoveBadMedSchool(f_medschools_prepclean l) := TRANSFORM
			tmp:=f_medschools_prepclean(MedSchoolName<>l.medschoolname);
			ds_tmp := tmp(medschoolname2[1..l.len]=l.medschoolname2,graduationyear=l.graduationyear,len>l.len);
			SELF.providerid := l.providerid;
			self.BDID := l.bdid;
			self.medschoolname := if(exists(ds_tmp),skip,l.medschoolname);
			self.graduationyear := l.graduationyear;
			self.medschoolTierTypeID := l.medschoolTierTypeID;
		END;
		f_medschools_clean:=project(f_medschools_prepclean,doRemoveBadMedSchool(left));

		//get sanction ids
		sanc_rec := record
				 unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_sanc_child_rec;
		end;

		sanc_rec get_sids_by_did(f_dids_dep l, sanctions_did_key r) := transform
			self.sanc_id := (integer)r.sanc_id;
			self := l;
			self := r;
		end;

		sids_by_did := join(f_dids_dep, sanctions_did_key,
												(unsigned6)left.did = right.l_did, 
						get_sids_by_did(left,right));
						
		sanc_rec get_sids_by_upin(f_upins_dep l, sanctions_upin_key r) := transform
			self := l;
			self := r;
		end;

		sids_by_upin := join(f_upins_dep, sanctions_upin_key,
												 left.upin = right.l_upin,
						 get_sids_by_upin(left, right));
						
		sanc_rec get_sids_by_lic(f_licenses_dep l, sanctions_license_key r) := transform
			self := l;
			self := r;
		end;

		sids_by_lic := join(f_licenses_dep, sanctions_license_key,
												left.LicenseState = right.SANC_SANCST and
									left.LicenseNumber = right.SANC_LICNBR, 
						get_sids_by_lic(left, right));

		/*				
		sanc_rec get_sids_by_taxid_name(prov_match_recs l, sanctions_taxid_name_key r) := transform
			self.providerid := l.l_providerid;
			self := r;
		end;
										
		sids_by_taxid_fname := join(prov_match_recs, sanctions_taxid_name_key,
																keyed((string10)left.TaxID = right.l_taxid) and
													keyed(left.Prov_Clean_fname = right.l_fname) and
								 length(trim(left.Prov_Clean_fname))>=3, 
											 get_sids_by_taxid_name(left, right));
		*/

		f_sids := sids_by_did + sids_by_upin + sids_by_lic/*+ sids_by_taxid_fname*/;
		f_sids_srt := sort(join(f_sids,provs,left.providerid = right.providerid,transform(
			recordof(f_sids),self:=left),keep(1)), record);
		f_sids_dep := dedup(f_sids_srt, record);

		//Get full Sanctions
		sanc_rec_full := record
				 unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_sanc_child_rec_full;
		end;
		string federalBoard := 'FEDERAL BOARDS';
		string typeOIG := 'DEBARRED/EXCLUDED';
		string typeGSA1 := 'EXCLUDED';
		string typeGSA2 := 'EXCLUDED/DELETED';

		sanc_rec_full get_sanctions_by_sancid(sanc_rec l, sanctions_sancid_key r) := transform
			isFederal := STD.STR.ToUpperCase(r.sanc_brdtype) = federalBoard;
			isOIG := STD.STR.ToUpperCase(r.sanc_type)= typeOIG;
			isGSA := STD.STR.ToUpperCase(r.sanc_type)= typeGSA1 or STD.STR.ToUpperCase(r.sanc_type)= typeGSA2;
			self.sanc_grouptype := map(isFederal => 'FEDERAL', 
																 'STATE');
			self.sanc_subgrouptype := map(isFederal and isGSA => 'GSA', 
																 isFederal and isOIG => 'OIG', 
																 '');
			self := l;
			self := r;
		end;

		sancs_by_sid := join(f_sids_dep, sanctions_sancid_key,
												keyed((unsigned6)left.SANC_ID = right.l_sancid), 
						get_sanctions_by_sancid(left,right));

		f_sancs_srt := sort(join(sancs_by_sid,provs,left.providerid = right.providerid,transform(
			recordof(sancs_by_sid),self:=left),keep(100)), sanc_grouptype, -sanc_sancdte_form, -sanc_updte_form, (unsigned6)SANC_ID);
		f_sancs_dep := dedup(f_sancs_srt, record);

		pid_taxonomy_rec := record
			unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_taxonomy_rec;
		end;

		pid_taxonomy_rec get_taxonomy(taxonomy_key r) := transform
				self.providerid := r.l_providerid;
			self := r;
		end;

		f_taxonomy := join(provs,taxonomy_key,keyed(left.providerid =right.l_providerid),get_taxonomy(right),
			keep(doxie_crs.constants.max_taxonomy));

		f_taxonomy_srt := sort(f_taxonomy(TaxonomyCode<>''), record);
		f_taxonomy_dep := dedup(f_taxonomy_srt, record);

		//initialize the out records
		report_rec := doxie.ingenix_provider_module.layout_ingenix_provider_report;

		init_unique := dedup(sort(prov_match_recs,l_providerid,-gender),l_providerid);

		report_rec init_out(init_unique l) := transform
			self.providerid := (string10)l.providerid;
			self.gender := l.gender;
			self.Gender_Name := CODES.GENERAL.GENDER(l.gender);
			self.sanc_flag := if(count(f_sids_dep)>0,true,false);
			self.sanction_id := [];
			self.providerdid := [];
			self.taxid := [];
			self.name := [];
			self.dob := [];
			self.language := [];
			self.upin := [];
			self.npi := [];
			self.license := [];
			self.dea := [];
			self.degree := [];
			self.specialty := [];
			self.business_address := [];
			self.group_affiliation := [];
			self.hospital_affiliation := [];
			self.residency := [];
			self.medschool := [];
			self.taxonomy := [];
			self.sanction_data := [];
			self.ssn := [];
			self.medicareoptout := [];
			self.dod := [];
		end;


		out_init := project(init_unique, init_out(left));

		//append sanction ids to output
		doxie.ingenix_provider_module.ingenix_sanc_child_rec app_sanc_ids(f_sids_dep l) := transform
				self := l;						                     
		end;

		//append sanction data to output
		doxie.ingenix_provider_module.ingenix_sanc_child_rec_full app_sanc_data(f_sancs_dep l) := transform
				self := l;						                     
		end;

		//append dids to output
		doxie.ingenix_provider_module.ingenix_did_rec app_provider_dids(f_dids_dep l) := transform
			 self := l;						                     
		end;

		//append taxids to output
		doxie.ingenix_provider_module.ingenix_taxid_rec app_taxids(f_taxids_dep l) := transform
				self := l;						                     
		end;

		//append names to output
		doxie.ingenix_provider_module.ingenix_name_rec app_names(f_names_dep l) := transform
			 self := l;						                     
		end;

		//append medicare to output
		doxie.ingenix_provider_module.ingenix_medicare_optout_rec app_medicare(f_medicare_dep l) := transform
			 self := l;						                     
		end;

		//append death to output
		doxie.ingenix_provider_module.ingenix_dod_rec app_death(f_death_dep l) := transform
			 self := l;						                     
		end;

		//append dobs to output
		doxie.ingenix_provider_module.ingenix_dob_rec app_dobs(f_dobs_dep l) := transform
			self := l;						                     
		end;

		//append languages to output
		doxie.ingenix_provider_module.ingenix_language_rec app_languages(f_languages_dep l) := transform
			 self := l;						                     
		end;

		//append upins to output
		doxie.ingenix_provider_module.ingenix_upin_rec app_upins(f_upins_dep l) := transform
					self := l;						                     
		end;

		//append npis to output
		doxie.ingenix_provider_module.ingenix_npi_rec app_npis(f_npis_verified l) := transform
					self := l;						                     
		end;

		//append licenses to output
		doxie.ingenix_provider_module.ingenix_license_rpt_rec app_licenses(f_licenses_rollup_sorted l) := transform
					self := l;						                     
		end;

		//append deas to output
		doxie.ingenix_provider_module.ingenix_dea_rec app_deas(f_dea_rollup l) := transform
					self := l;						                     
		end;

		//append degree to output
		doxie.ingenix_provider_module.ingenix_degree_rec app_degrees(f_degrees_dep l) := transform
				self := l;						                     
		end;

		//append specialty to output
		doxie.ingenix_provider_module.ingenix_specialty_rec app_specialties(f_specialties_rollup l) := transform
				self := l;						                     
		end;

		//append business address to output
		doxie.ingenix_provider_module.ingenix_addr_rpt_rec app_bus_addrs(f_bus_addrs_clean l) := transform
				self := l;						                     
		end;

		//append group affiliation to output
		doxie.ingenix_provider_module.ingenix_group_rec app_groups(f_groups_rollup l) := transform
				self := l;						                     
		end;

		//append hospital affiliation to output
		doxie.ingenix_provider_module.ingenix_hospital_rec app_hospitals(f_hospitals_rollup l) := transform
				self := l;						                     
		end;

		//append residency to output
		doxie.ingenix_provider_module.ingenix_residency_rec app_residencies(f_residencies_final l) := transform
				self := l;						                     
		end;

		//append medical school to output
		doxie.ingenix_provider_module.ingenix_medschool_rec app_medschools(f_medschools_clean l) := transform
				self := l;						                     
		end;

		//append taxonomy to provider
		doxie.ingenix_provider_module.ingenix_taxonomy_rec app_taxonomy(f_taxonomy_dep l) := transform
				self := l;						                     
		end;

		//Append best SSN to output
		doxie.ingenix_provider_module.ingenix_ssn_rec app_provider_ssns(f_ssns_masked l) := transform
			 self := l;						                     
		end;


		report_rec get_child(out_init l) := transform
				 unsigned6 prv_id := (unsigned6)(l.providerid);
			self.Gender_Name := CODES.GENERAL.GENDER(l.gender);
			self.sanction_id := project(f_sids_dep(providerid =(unsigned6)l.providerid), app_sanc_ids(left));
			self.providerdid := project(f_dids_dep(providerid =(unsigned6)l.providerid), app_provider_dids(left));
			self.taxid := project(f_taxids_dep(providerid =(unsigned6)l.providerid), app_taxids(left));
			self.name := project(f_names_dep(providerid =(unsigned6)l.providerid), app_names(left)); 
			self.dob := project(f_dobs_dep(providerid =(unsigned6)l.providerid), app_dobs(left));
			self.language := project(f_languages_dep(providerid =(unsigned6)l.providerid), app_languages(left)); 
			self.upin := project(f_upins_dep(providerid =(unsigned6)l.providerid), app_upins(left));  
			self.npi := project(f_npis_verified(providerid = l.providerid), app_npis(left));
			self.license := project(f_licenses_rollup_sorted(providerid =(unsigned6)l.providerid), app_licenses(left));    
			self.dea := project(f_dea_rollup(providerid =(unsigned6)l.providerid), app_deas(left)); 
			self.degree := project(f_degrees_dep(providerid =(unsigned6)l.providerid), app_degrees(left));    
			self.specialty := project(f_specialties_rollup(providerid =(unsigned6)l.providerid), app_specialties(left));   
			self.business_address := project(f_addrs_ready(providerid =(unsigned6)l.providerid), app_bus_addrs(left));  
			self.group_affiliation := project(f_groups_rollup(providerid =(unsigned6)l.providerid), app_groups(left));  
			self.hospital_affiliation := project(f_hospitals_rollup(providerid =(unsigned6)l.providerid), app_hospitals(left));  
			self.residency := project(f_residencies_final(providerid =(unsigned6)l.providerid), app_residencies(left));   
			self.medschool := project(f_medschools_clean(providerid =(unsigned6)l.providerid),  app_medschools(left));
			self.taxonomy := project(f_taxonomy_dep(providerid =(unsigned6)l.providerid), app_taxonomy(left));
			self.sanction_data := if(Include_Sanc,project(f_sancs_dep(providerid =(unsigned6)l.providerid), app_sanc_data(left)));
			self.ssn := project(f_ssns_masked(providerid =(unsigned6)l.providerid), app_provider_ssns(left));
			self.MedicareOptOut := project(f_medicare_dep(providerid =(unsigned6)l.providerid), app_medicare(left)); 
			self.DOD := project(f_death_dep(providerid =(unsigned6)l.providerid), app_death(left)); 
			self.Deceased := checkDeath(f_dids_dep(providerid =(unsigned6)l.providerid)) or exists(f_death_dep(DeceasedDate<>''));
			self := l;
		end;

		out_with_child := project(out_init, get_child(left));

		//sort child datasets							
		report_rec sort_child(out_with_child l) := transform
				 self.sanction_id := sort(l.sanction_id, (unsigned6) SANC_ID);
			self.providerdid := sort(l.providerdid, (unsigned6)did);
			self.name := sort(l.name,providernametierid);
			self.taxid := sort(l.taxid, taxidtiertypeid);
			self.dob := sort(l.dob, birthdatetiertypeid);
			self.language := sort(l.language, languagetiertypeid);
			self.upin := sort(l.upin, upintiertypeid);
			self.license := sort(l.license, licensenumbertiertypeid);
			self.dea := sort(l.dea, deanumbertiertypeid);
			self.degree := sort(l.degree, degreetiertypeid);
			self.specialty := sort(l.specialty, specialtytiertypeid); 
			self.business_address := sort(l.business_address, ProviderAddressTierTypeID);
			self.group_affiliation := sort(l.group_affiliation, groupnametiertypeid);
			self.hospital_affiliation := sort(l.hospital_affiliation, hospitalnametiertypeid);
			self.residency := sort(l.residency, residencytiertypeid);
			self.medschool := sort(l.medschool, -graduationyear, medschooltiertypeid);
			self.sanction_data := sort(l.sanction_data, (unsigned6) SANC_ID);
			self := l;
		end;						 
				 
		out_final := project(out_with_child, sort_child(left));				 
  
		return out_final;

	END; //report_records
		
END;