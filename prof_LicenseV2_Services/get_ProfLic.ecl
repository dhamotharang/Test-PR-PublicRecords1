IMPORT STD, Prof_LicenseV2, doxie_files, doxie, Ingenix_NatlProf, suppress, codes, ut;

doxie.MAC_Header_Field_Declare()
mod_access := doxie.compliance.GetGlobalDataAccessModule();

search_layout := RECORD (prof_LicenseV2_Services.Assorted_Layouts.Layout_Search_w_pen)
                   unsigned4 global_sid;
                   unsigned8 record_sid;
                 END;

Search_layout_plus:= RECORD (prof_LicenseV2_Services.Assorted_Layouts.Layout_Search_w_pen_and_license_number)
                       unsigned4 global_sid;
                       unsigned8 record_sid;
                     END;

report_layout:= prof_LicenseV2_Services.Assorted_Layouts.Layout_report;	

Search_layout_x := RECORD(Search_layout)
	STRING6	SANC_UPIN;	// sanc_key.SANC_UPIN
END;

prof_key := Prof_LicenseV2.Key_ProfLic_Id;
sanc_key := doxie_files.key_sanctions_sancid;
provider_key := doxie_files.key_provider_id;
provider_license_key := Ingenix_NatlProf.key_license_providerid;

// fill npi
key_npi := Ingenix_NatlProf.key_NPI_providerid;
key_prvId_upin := Ingenix_NatlProf.key_ProviderID_UPIN;


EXPORT get_ProfLic(dataset(prof_LicenseV2_Services.Layout_Search_Ids_Prolic) Prolic_Ids,
			dataset(prof_LicenseV2_Services.Layout_Search_Ids_Sanc) Sanc_Ids = dataset([],prof_LicenseV2_Services.Layout_Search_Ids_Sanc),
			dataset(prof_LicenseV2_Services.Layout_Search_Ids_Prov) Prov_Ids = dataset([],prof_LicenseV2_Services.Layout_Search_Ids_Prov),
			string20 in_licnum = '') := MODULE
			

	Search_layout get_base_fields_prov(Prov_Ids l,provider_key r):=transform
		self.isdeepdive := l.isdeepdive;
		self.providerid := r.l_providerid;
		self.uniqueid := (string17) ('PR' + trim((string15) r.l_providerid) );
		self.orig_license_number := '';
		self.orig_name :=r.Prov_Clean_fname	+ r.Prov_Clean_mname + r.Prov_Clean_lname + r.Prov_Clean_name_suffix; 
		self.orig_addr_1 :=r.prov_Clean_prim_range	+ r.prov_Clean_predir	+ r.prov_Clean_prim_name +r.prov_Clean_addr_suffix
			+r.prov_Clean_postdir;
		self.orig_addr_2 := r.prov_clean_unit_desig + r.prov_clean_sec_range;
		self.orig_city := r.prov_clean_v_city_name;
		self.orig_st := r.prov_clean_st;
		self.orig_zip := r.prov_clean_zip + r.prov_clean_zip4;
		self.did := r.did;
		self.phone := r.PhoneNumber;
		self.phonetype := r.phonetype;
		self.sex := '';
		self.taxid := r.taxid;
		self.best_ssn := '';
		self.issue_date := '';
		self.expiration_date := '';
		self.action_status := '';
		self.date_last_seen := r.dt_last_seen;
		self.last_renewal_date :='';
		self.profession_or_board :='';
		self.license_type :='';
		self.license_obtained_by :='';
		self.source_st := '';		
		self.penalt := doxie.FN_Tra_Penalty_Name(r.Prov_Clean_fname,r.Prov_Clean_mname,r.Prov_Clean_lname) +
				doxie.FN_Tra_Penalty_Addr(r.prov_Clean_predir,r.prov_Clean_prim_range,r.prov_Clean_prim_name,r.prov_Clean_addr_suffix,
				r.prov_Clean_postdir,r.prov_clean_sec_range,r.prov_clean_v_city_name,
				r.prov_clean_st,r.prov_clean_zip) +
				doxie.FN_Tra_Penalty_DID(r.did);
		self.fname := r.prov_clean_fname;
		self.mname := r.prov_clean_mname;
		self.lname := r.prov_clean_lname;
		self.name_suffix := r.prov_clean_name_suffix;
		self.title := r.prov_clean_title;
		self.prim_range := r.prov_clean_prim_range;
		self.predir := r.prov_clean_predir;
		self.prim_name := r.prov_clean_prim_name;
		self.suffix := r.prov_clean_addr_suffix;
		self.postdir := r.prov_clean_postdir;
		self.unit_desig := r.prov_clean_unit_desig;
		self.sec_range := r.prov_clean_sec_range;
		self.p_city_name := r.prov_clean_p_city_name;
		self.v_city_name := r.prov_clean_v_city_name;
		self.st := r.prov_clean_st;
		self.zip := r.prov_clean_zip;
		self.zip4 := r.prov_clean_zip4;
		self.cart := r.prov_clean_cart;
		self.cr_sort_sz := r.prov_clean_cr_sort_sz;
		self.lot := r.prov_clean_lot;
		self.lot_order := r.prov_clean_lot_order;
		self.dpbc := r.prov_clean_dpbc;
		self.chk_digit := r.prov_clean_chk_digit;
		self.record_type := r.prov_clean_record_type;
		self.ace_fips_st := r.prov_clean_ace_fips_st;
		self.county := r.prov_clean_fipscounty;
		self.geo_lat := r.prov_clean_geo_lat;
		self.geo_long := r.prov_clean_geo_long;
		self.msa := r.prov_clean_msa;
		self.geo_match := r.prov_clean_geo_match;
		self.err_stat := r.prov_clean_err_stat;
		self := r;
		self := [];
	END;
	_pre_providers := join(Prov_Ids,provider_key,keyed(left.ProviderId = right.l_ProviderId),
		get_base_fields_prov(left,right),limit(1000,skip),keep(100));
  // fabricate source and record ids
  pre_providers := PROJECT (_pre_providers, TRANSFORM (Search_layout,
                                                       SELF.global_sid := COUNTER % 4;
                                                       SELF.record_sid := 330000 + COUNTER;
                                                       SELF := LEFT));
	

  Search_Layout get_license_info(Search_Layout L, provider_license_key R):=transform
		self.orig_license_number := R.licensenumber;
		self.source_st := R.licenseState;
		self.Source_st_decoded := codes.GENERAL.state_long(R.licenseState);
		self := L;
	END;

	providers0 :=if(in_licnum ='', join(pre_providers,provider_license_key,keyed(left.ProviderId=right.l_ProviderId),
	get_license_info(left,right),limit(1000,skip),keep(1),left outer),
		join(pre_providers,provider_license_key,keyed(left.ProviderId=right.l_ProviderId)
		and (right.licensenumber=in_licnum and (right.licensestate = state_value or 
		left.orig_st=state_value or state_value='')),
			get_license_info(left,right),limit(1000,skip),keep(1)));
			
	providers1 := dedup(sort(providers0,providerid,if(orig_license_number <> '',0,1),if(taxid <> '',0,1),
		map(length(trim(fname)) > 1 and length(trim(mname)) > 1 and length(trim(lname)) > 1=>0,
				length(trim(fname)) > 1 and length(trim(mname)) > 0 and length(trim(lname)) > 1=>1,
				length(trim(fname)) > 1 and length(trim(lname)) > 1=> 2,
				length(trim(fname)) > 0 and length(trim(mname)) > 0 and length(trim(lname)) > 1 =>3,
				length(trim(fname)) > 0 and length(trim(lname)) > 1 => 4,
				5),if((unsigned) did <> 0,0,1),if((unsigned) bdid <> 0,0,1),if(orig_addr_1 <> '',0,1),
				if(phone <> '',0,1),record),providerid);

	providers := JOIN(providers1, key_npi,
													 KEYED(RIGHT.l_providerid = LEFT.ProviderId),
													 TRANSFORM(Search_layout, SELF.npi := (UNSIGNED6) RIGHT.npi, SELF := LEFT),
													 LEFT OUTER, KEEP(1));
	//Sanc_Id
	Search_layout_x get_base_fields_sanc(Sanc_Ids l,sanc_key r):=transform
		self.orig_license_number := if(in_licnum='' or
				(in_licnum = r.sanc_licnbr and (state_value = r.Provco_Address_clean_st or state_value= r.sanc_sancst or state_value='')),
				r.sanc_licnbr,skip);
		self.isdeepdive := l.isdeepdive;
		self.sanc_id := r.l_sancid;
		self.uniqueid := (string17) ('PS' + trim((string15)r.l_sancid) );
		self.orig_name :=r.Prov_Clean_fname	+ r.Prov_Clean_mname + r.Prov_Clean_lname + r.Prov_Clean_name_suffix; 
		self.orig_addr_1 :=r.Provco_Address_Clean_prim_range	+ r.Provco_Address_Clean_predir	+ r.Provco_Address_Clean_prim_name +r.Provco_Address_Clean_addr_suffix
			+r.Provco_Address_Clean_postdir;
		self.orig_addr_2 := r.Provco_Address_clean_unit_desig + r.Provco_Address_clean_sec_range;
		self.orig_city := r.Provco_Address_clean_v_city_name;
		self.orig_st := r.Provco_Address_clean_st;		
		self.orig_zip :=  r.Provco_Address_clean_zip + r.Provco_Address_clean_zip4;
		self.did := r.did;
		self.phone :='';
		self.sex :='';
		self.taxid := r.sanc_tin;
		self.best_ssn :='';
		self.issue_date := r.SANC_SANCDTE_form;
		self.expiration_date :='';
		self.action_status := r.sanc_type+ r.sanc_terms;
		self.date_last_seen := r.date_last_seen;
		self.last_renewal_date :='';
		self.profession_or_board :='';
		self.license_type := r.sanc_provtype;
		self.license_obtained_by :='';
		self.source_st := r.sanc_sancst;
		self.source_st_decoded := codes.GENERAL.state_long(r.sanc_sancst);
		self.penalt := doxie.FN_Tra_Penalty_Name(r.Prov_Clean_fname,r.Prov_Clean_mname,r.Prov_Clean_lname) +
				doxie.FN_Tra_Penalty_Addr(r.Provco_Address_Clean_predir,r.Provco_Address_Clean_prim_range,r.Provco_Address_Clean_prim_name,r.Provco_Address_Clean_addr_suffix,
				r.Provco_Address_Clean_postdir,r.Provco_Address_clean_sec_range,r.Provco_Address_clean_v_city_name,r.Provco_Address_clean_st,r.Provco_Address_clean_zip) +
				doxie.FN_Tra_Penalty_DID(r.did);
		self.fname := r.prov_clean_fname;
		self.mname := r.prov_clean_mname;
		self.lname := r.prov_clean_lname;
		self.name_suffix := r.prov_clean_name_suffix;
		self.title := r.prov_clean_title;
		self.prim_range := r.provco_address_clean_prim_range;
		self.predir := r.provco_address_clean_predir;
		self.prim_name := r.provco_address_clean_prim_name;
		self.suffix := r.provco_address_clean_addr_suffix;
		self.postdir := r.provco_address_clean_postdir;
		self.unit_desig := r.provco_address_clean_unit_desig;
		self.sec_range := r.provco_address_clean_sec_range;
		self.p_city_name := r.provco_address_clean_p_city_name;
		self.v_city_name := r.provco_address_clean_v_city_name;
		self.st := r.provco_address_clean_st;
		self.zip := r.provco_address_clean_zip;
		self.zip4 := r.provco_address_clean_zip4;
		self.cart := r.provco_address_clean_cart;
		self.cr_sort_sz := r.provco_address_clean_cr_sort_sz;
		self.lot := r.provco_address_clean_lot;
		self.lot_order := r.provco_address_clean_lot_order;
		self.dpbc := r.provco_address_clean_dpbc;
		self.chk_digit := r.provco_address_clean_chk_digit;
		self.record_type := r.provco_address_clean_record_type;
		self.ace_fips_st := r.provco_address_clean_ace_fips_st;
		self.county := r.provco_address_clean_fipscounty;
		self.geo_lat := r.provco_address_clean_geo_lat;
		self.geo_long := r.provco_address_clean_geo_long;
		self.msa := r.provco_address_clean_msa;
		self.geo_match := r.provco_address_clean_geo_match;
		self.err_stat := r.provco_address_clean_err_stat;
		self.company_Name := r.sanc_busnme;
		self := r;
		self := [];
	END;
	_sancs0 := join(Sanc_Ids,Sanc_Key,keyed(left.sanc_id = right.l_sancid),
		get_base_fields_sanc(left,right),limit(1000,skip),keep(100));

  // fabricate source and record ids
  sancs0 := PROJECT (_sancs0, TRANSFORM (Search_layout_x,
                                         SELF.global_sid := COUNTER % 4;
                                         SELF.record_sid := 220000 + COUNTER;
                                         SELF := LEFT));

	KeyTmpRec := RECORD
		Search_layout.npi;
		Search_layout.ProviderId;
		Search_layout.sanc_id;
		Search_layout_x.SANC_UPIN;
	END;

	KeyTmpRec updtPrvId(KeyTmpRec l, key_prvId_upin r) := TRANSFORM
		SELF.ProviderId := r.l_providerid;
		SELF := l;
	END;
	sancId_upin := JOIN(PROJECT(sancs0, KeyTmpRec), key_prvId_upin,
											KEYED(LEFT.SANC_UPIN = RIGHT.l_UPIN),
											updtPrvId(LEFT, RIGHT));
	KeyTmpRec updtNPI(KeyTmpRec l, key_npi r) := TRANSFORM
		SELF.npi := (UNSIGNED6) r.npi;
		SELF := l;
	END;
	sancId_npi := JOIN(sancId_upin, key_npi,
										 KEYED(RIGHT.l_providerid = LEFT.ProviderId),
										 updtNPI(LEFT, RIGHT));

	sancs := JOIN(sancs0, sancId_npi,
											 LEFT.sanc_id = RIGHT.sanc_id,
											 TRANSFORM(Search_layout, SELF.npi := RIGHT.npi, SELF := LEFT),
											 LEFT OUTER, KEEP(1));

  Search_layout_plus get_base_fields_prolic_search(prolic_Ids l, Prof_key r):=transform
    self.orig_license_number := if(in_licnum='' or
				(in_licnum = r.orig_license_number and (state_value = r.orig_st or state_value= r.source_st or state_value='')),			
				r.orig_license_number,skip);
				
    self.license_number := r.license_number;
		self.isdeepdive := l.isdeepdive;
		self.uniqueid := (string17) ('PL' + trim((string15)r.prolic_seq_id));
		self.source_st_decoded := codes.GENERAL.state_long(r.source_st);
		self := r;
		self.penalt :=doxie.FN_Tra_Penalty_Name(r.fname,r.mname,r.lname) +
				doxie.FN_Tra_Penalty_Addr(r.predir,r.prim_range,r.prim_name,r.suffix,
				r.postdir,r.sec_range,r.v_city_name,
				if( ut.stringsimilar(r.st,state_value)< ut.stringsimilar(r.source_st,state_value) or r.source_st='',r.st,
				r.source_st),r.zip) +
				doxie.FN_Tra_Penalty_CName(r.Company_Name) + doxie.FN_Tra_Penalty_SSN(r.best_ssn) 
				+ doxie.FN_Tra_Penalty_DID(r.did) + doxie.FN_Tra_Penalty_BDID(r.bdid);
		self := [];
	END;
	_prolics_search_xtra_fields := join(prolic_Ids, prof_key
						,keyed(left.prolic_seq_id = right.prolic_seq_id)
						,get_base_fields_prolic_search(left,right),limit(1000,skip),keep(100));

  // fabricate source and record ids
  prolics_search_xtra_fields := PROJECT (_prolics_search_xtra_fields, TRANSFORM (Search_layout_plus,
                                                                                 SELF.global_sid := COUNTER % 4;
                                                                                 SELF.record_sid := 110000 + COUNTER;
                                                                                 SELF := LEFT));


	with_orig_tmp := prolics_search_xtra_fields(orig_license_number <> '');
	
	with_orig := project(with_orig_tmp, transform(search_layout, self := left));
	
	with_orig_ddp := dedup(sort(with_orig,orig_license_number,source_st,license_type,-expiration_date,-status_effective_dt,-date_last_seen,uniqueid),	
												orig_license_number,source_st,license_type, expiration_date,status_effective_dt);
												
	without_orig_tmp := prolics_search_xtra_fields(orig_license_number = '');
	
  without_orig := project(without_orig_tmp, transform(search_layout,
	                  self.orig_license_number := if (left.license_number <> '',left.license_number, ''),
										self := left
									));
	without_orig_ddp := dedup(sort(without_orig, record),record);

	prolics_search := with_orig_ddp + without_orig_ddp;
	
	pre_search_res := dedup(sort(providers + sancs +	prolics_search,record),record);

	
	Suppress.MAC_Suppress(pre_search_res,mid1,application_type_value,Suppress.Constants.LinkTypes.DID,did);
	Suppress.MAC_Suppress(mid1,search_pulled,application_type_value,Suppress.Constants.LinkTypes.SSN,best_ssn);
	doxie.MAC_PruneOldSSNs(search_pulled, search_prunned, best_ssn, did);
	suppress.mac_mask(search_prunned, search_masked, best_ssn, blank, true, false);
  search_res := suppress.MAC_SuppressSource (search_masked, mod_access);
  doxie.compliance.logSoldToSources (search_res, mod_access);

//OUTPUT (providers, NAMED ('providers'));
//OUTPUT (sancs, NAMED ('sancs'));
//OUTPUT (prolics_search, NAMED ('prolics_search'));

//OUTPUT (search_masked, NAMED ('search_masked'));
//OUTPUT (search_res, NAMED ('search_res'));
	EXPORT search := search_res;


	Report_layout get_base_fields_prolic_report(Prof_key r):= transform
		self.source_st_decoded := codes.GENERAL.state_long(r.source_st);
		self.uniqueid := (string17) ('PL' + trim((string15)r.prolic_seq_id));
		self.other_license_number := r.previous_license_number;
		self.other_license_type := r.previous_license_type;
    race := STD.Str.ToUpperCase(r.personal_race_cd)[1];
		self.personal_race_desc := if(r.personal_race_desc <> '',r.personal_race_desc,
			MAP(race = 'W' => 'White',
				race = 'B' => 'African American',
				race = 'H' => 'Hispanic',
				'Unknown'));
		self := r;
		self := [];
	END;
	prolics_report := dedup(sort(join(prolic_Ids, prof_key
							,keyed(left.prolic_seq_id = right.prolic_seq_id)
							,get_base_fields_prolic_report(right),limit(1000,skip),keep(100)),record, -date_last_seen),record, except 
							date_last_seen,uniqueid,prolic_seq_id);
	Suppress.MAC_Suppress(prolics_report,pull_dids,application_type_value,Suppress.Constants.LinkTypes.DID,DID);
	Suppress.MAC_Suppress(pull_dids,pull_ssns,application_type_value,Suppress.Constants.LinkTypes.SSN,best_ssn);
	doxie.MAC_PruneOldSSNs(pull_ssns, prolics_report_pruned, best_ssn, did);
	suppress.mac_mask(prolics_report_pruned, report_res, best_ssn, blank, true, false);
	 
	
	EXPORT report := report_res;
	

END;			
