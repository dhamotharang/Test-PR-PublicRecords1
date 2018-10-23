/*2018-02-01T01:11:27Z (HABBU, JAIDEEP (RIS-BCT))
checkin changes as per RR-12063
*/
Import Enclarity,ut,doxie_files,codes,Ingenix_NatlProf,Enclarity_Facility_Sanctions;
/*Changes for RR11959*/
 EXPORT Datasource_SelectFile := MODULE
	Export get_providers_base (dataset(Healthcare_Header_Services.Layouts.searchKeyResults_plus_input) input):= function
			// rawdataIndividual:= join(dedup(sort(input(lnpid>0),record),record), Enclarity.Keys(,true).individual_lnpid.qa,
											// keyed(left.lnpid = right.lnpid),
											// transform(Layouts.selectfile_providers_base_with_input, 
																		// SELF.clean_prim_range:=right.prim_range;
																		// SELF.clean_predir:=right.predir;
																		// SELF.clean_prim_name:=right.prim_name;
																		// SELF.clean_addr_suffix:=right.addr_suffix;
																		// SELF.clean_postdir:=right.postdir;
																		// SELF.clean_unit_desig:=right.unit_desig;
																		// SELF.clean_sec_range:=right.sec_range;
																		// SELF.clean_p_city_name:=right.p_city_name;
																		// SELF.clean_st:=right.st;
																		// SELF.clean_z5:=right.zip;
																		// self.vendorid:=right.group_key;
																		// self:=left,
																		// self:=right),
											// keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0)); 
			// noHits := join(input,rawdataIndividual,left.acctno=right.acctno,transform(Layouts.searchKeyResults_plus_input, self:=left),left only);
			noHits := dedup(sort(input(vendorid<>''),acctno,vendorid),acctno,vendorid);
			rawdataIndividualbyVendorid:= join(noHits, Enclarity.Keys(,true).individual_group_key.qa,
											keyed(left.vendorid = right.group_key) and left.src = Healthcare_Header_Services.Constants.SRC_SELECTFILE and right.record_type = 'C',
											transform(Healthcare_Header_Services.Layouts.selectfile_providers_base_with_input,
																		self.lnpid := left.lnpid;
																		SELF.clean_prim_range:=right.prim_range;
																		SELF.clean_predir:=right.predir;
																		SELF.clean_prim_name:=right.prim_name;
																		SELF.clean_addr_suffix:=right.addr_suffix;
																		SELF.clean_postdir:=right.postdir;
																		SELF.clean_unit_desig:=right.unit_desig;
																		SELF.clean_sec_range:=right.sec_range;
																		SELF.clean_p_city_name:=right.p_city_name;
																		SELF.clean_st:=right.st;
																		SELF.clean_z5:=right.zip;
																		self.vendorid:=right.group_key;
																		self.source_rid := 0;
																		self.lic_state := '';
																		self.lic_num := '';
																		self.lic_type := '';
																		self.lic_num_in := '';
																		self.lic_begin_date := '';
																		self.lic_end_date := '';//Blanking Lic filds so I can dedup and get all addresses as the lic information will get collected later
																		self:=right,
																		self:=left),
											keep(Healthcare_Header_Services.Constants.IDS_PER_DID), limit(0));
			//Detect no hit, filter input dataset for no hits. join noHits,rawdataIndividualbyVendorid /acctno left only
			nohitcheckHistory:= join(noHits,rawdataIndividualbyVendorid, left.acctno = right.acctno,transform(left),left only);
			rawdataIndividualbyVendorid2:= dedup(sort(join(nohitcheckHistory, Enclarity.Keys(,true).individual_group_key.qa,
											keyed(left.vendorid = right.group_key) and left.src = Healthcare_Header_Services.Constants.SRC_SELECTFILE,
											transform(Healthcare_Header_Services.Layouts.selectfile_providers_base_with_input,
																		self.lnpid := left.lnpid;
																		SELF.clean_prim_range:=right.prim_range;
																		SELF.clean_predir:=right.predir;
																		SELF.clean_prim_name:=right.prim_name;
																		SELF.clean_addr_suffix:=right.addr_suffix;
																		SELF.clean_postdir:=right.postdir;
																		SELF.clean_unit_desig:=right.unit_desig;
																		SELF.clean_sec_range:=right.sec_range;
																		SELF.clean_p_city_name:=right.p_city_name;
																		SELF.clean_st:=right.st;
																		SELF.clean_z5:=right.zip;
																		self.vendorid:=right.group_key;
																		self.source_rid := 0;
																		self.lic_state := '';
																		self.lic_num := '';
																		self.lic_type := '';
																		self.lic_num_in := '';
																		self.lic_begin_date := '';
																		self.lic_end_date := '';//Blanking Lic filds so I can dedup and get all addresses as the lic information will get collected later
																		self:=right,
																		self:=left),
											keep(Healthcare_Header_Services.Constants.IDS_PER_DID), limit(0)),acctno,LNPID,-dt_vendor_last_reported),acctno,LNPID);
			rawdataIndividualwithAddrScores := join(rawdataIndividualbyVendorid+rawdataIndividualbyVendorid2, Enclarity.Keys(,true).associate_group_key.qa,
											keyed(left.vendorid = right.group_key) and right.normed_name_rec_type ='1' and
											right.record_type='C' and left.addr_key = right.addr_key,
											transform(Healthcare_Header_Services.Layouts.selectfile_providers_base_with_input,
																		self.addr_conf_score := (integer)right.prac_addr_confidence_score;
																		self:=left), left outer,
											keep(Healthcare_Header_Services.Constants.IDS_PER_DID), limit(0)); 
			// baseRecs := project(sort(rawdataIndividual+rawdataIndividualbyVendorid,acctno,-addr_conf_score,-clean_last_verify_date),Transforms.build_selectfile_Provider_base(left));
			rawdataDeduped:=dedup(sort(rawdataIndividualwithAddrScores,acctno,lnpid,addr_conf_score,addr_rectype,bdid,best_dob,best_ssn,bill_addr_ind,bill1_fax_ind,bill1_phone_ind,birth_year,addr_suffix,clean_company_name,clean_last_verify_date,p_city_name,postdir,predir,prim_name,prim_range,sec_range,st,unit_desig,zip,date_of_death,dea_bus_act_ind,dea_num,dea_num_exp,did,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,fax1,fips_county,fips_st,first_name,gender,geo_lat,geo_long,group_key,last_name,lic_begin_date,lic_end_date,lic_num,lic_state,lic_status,lic_type,lnpid,middle_name,normed_addr_rec_type,npi_num,oig_flag,opm_flag,orig_fullname,phone1,prac_addr_ind,prac1_fax_ind,prac1_phone_ind,primary_location,provider_status,state_restrict_flag,suffix_name,suffix_other,title,upin,v_city_name,zip4),
														acctno,lnpid,addr_conf_score,addr_rectype,bdid,best_dob,best_ssn,bill_addr_ind,bill1_fax_ind,bill1_phone_ind,birth_year,addr_suffix,clean_company_name,clean_last_verify_date,p_city_name,postdir,predir,prim_name,prim_range,sec_range,st,unit_desig,zip,date_of_death,dea_bus_act_ind,dea_num,dea_num_exp,did,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,fax1,fips_county,fips_st,first_name,gender,geo_lat,geo_long,group_key,last_name,lic_begin_date,lic_end_date,lic_num,lic_state,lic_status,lic_type,lnpid,middle_name,normed_addr_rec_type,npi_num,oig_flag,opm_flag,orig_fullname,phone1,prac_addr_ind,prac1_fax_ind,prac1_phone_ind,primary_location,provider_status,state_restrict_flag,suffix_name,suffix_other,title,upin,v_city_name,zip4);
			// rawdataDeduped:=dedup(sort(rawdataIndividualbyVendorid,record),record);
			baseRecs := project(sort(rawdataDeduped,acctno,-addr_conf_score,-clean_last_verify_date),Healthcare_Header_Services.Transforms.build_selectfile_Provider_base(left));
			// rejoinLNPID := join(dedup(sort(input(vendorid<>''),acctno,lnpid,vendorid),acctno,lnpid,vendorid),providers_rolled,left.acctno=right.acctno and left.vendorid = right.vendorid,transform(Layouts.CombinedHeaderResults,self:=left;self:=right),keep(Healthcare_Header_Services.Constants.IDS_PER_DID), limit(0));
			// output(noHits,named('noHits'),extend);
			// output(nohitcheckHistory,named('nohitcheckHistory'),extend);
			// output(rawdataIndividualbyVendorid,named('rawdataIndividualbyVendorid'),extend);
			// output(rawdataIndividualbyVendorid2,named('rawdataIndividualbyVendorid2'),extend);
			// output(rawdataDeduped,named('rawdataDeduped'));
			// output(baseRecs);






			// output(providers_rolled,named('providers_rolled'));
			// output(rejoinLNPID,named('rejoinLNPID'));
		return baseRecs;
	end;

	Export appendLicense(dataset(Healthcare_Header_Services.Layouts.CombinedHeaderResults) input, dataset(Layouts.GroupKey) searchby):= function
			rawdata := join(searchby, Enclarity.Keys(,true).license_group_key.qa,
											keyed(left.group_key = right.group_key),
											transform(Healthcare_Header_Services.Layouts.layout_licenseinfo, 
																		self.licenseAcctno:=left.acctno;
																		self.group_key:=left.group_key;
																		self.providerid := left.providerid;
																		SELF.licenseSeq:=0;
																		SELF.LicenseState:=right.lic_state;
																		SELF.LicenseNumber:=right.lic_num;
																		SELF.LicenseNumberFmt:=right.lic_num_in;
																		SELF.LicenseType:=right.lic_type;
																		SELF.LicenseStatus:=right.lic_status;
																		SELF.Effective_Date:=if((integer)right.lic_begin_date>0,right.lic_begin_date,'');
																		SELF.Termination_Date:=if((integer)right.lic_end_date>0,right.lic_end_date,'');
																		self:=[]),
											keep(Healthcare_Header_Services.Constants.MAX_SEARCH_RECS), limit(0)); 
			Layouts.layout_child_licenseinfo doRollup(Healthcare_Header_Services.Layouts.layout_licenseinfo l, dataset(Healthcare_Header_Services.Layouts.layout_licenseinfo) r) := TRANSFORM
				SELF.acctno := l.licenseAcctno;
				self.group_key := l.group_key;
				self.ProviderID := l.ProviderID;
				self.childinfo := r;
			END;
			licenseinfo_rollup := rollup(group(sort(rawdata,licenseAcctno,ProviderID,group_key),licenseAcctno,ProviderID,group_key),group,doRollup(left,rows(left)));
			results := join(input,licenseinfo_rollup, left.acctno=right.acctno and left.srcid = right.ProviderID and left.vendorid=right.group_key,
																			transform(Healthcare_Header_Services.Layouts.CombinedHeaderResults,
																								self.StateLicenses := right.childinfo;
																								self := left),left outer);
			return results;
	end;
	Export appendSpecialty(dataset(Healthcare_Header_Services.Layouts.CombinedHeaderResults) input, dataset(Healthcare_Header_Services.Layouts.GroupKey) searchby):= function
			rawdata := join(searchby, Enclarity.Keys(,true).specialty_group_key_spec_code.qa,
											keyed(left.group_key = right.group_key),
											transform(Healthcare_Header_Services.Layouts.layout_specialty, 
																		self.acctno:=left.acctno;
																		self.group_key:=left.group_key;
																		self.providerid := left.providerid;
																		SELF.SpecialtyID:=(integer)right.spec_code;
																		SELF.SpecialtyName:=right.spec_desc;
																		self:=[]),
											keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0)); 
			Layouts.layout_child_specialty doRollup(Healthcare_Header_Services.Layouts.layout_specialty l, dataset(Healthcare_Header_Services.Layouts.layout_specialty) r) := TRANSFORM
				SELF.acctno := l.acctno;
				self.group_key := l.group_key;
				self.ProviderID := l.ProviderID;
				self.childinfo := r;
			END;
			specialties_rollup := rollup(group(sort(rawdata,acctno,ProviderID,group_key),acctno,ProviderID,group_key),group,doRollup(left,rows(left)));
			results := join(input,specialties_rollup, left.acctno=right.acctno and left.srcid = right.ProviderID and left.vendorid=right.group_key,
																			transform(Healthcare_Header_Services.Layouts.CombinedHeaderResults,
																								self.Specialties := right.childinfo;
																								self := left),left outer);
			return results;
	end;
	Export appendMedSchool(dataset(Healthcare_Header_Services.Layouts.CombinedHeaderResults) input, dataset(Healthcare_Header_Services.Layouts.GroupKey) searchby):= function
			rawdata := join(searchby, Enclarity.Keys(,true).medschool_group_key.qa,
											keyed(left.group_key = right.group_key),
											transform(Healthcare_Header_Services.Layouts.layout_medschool, 
																		self.acctno:=left.acctno;
																		self.group_key:=left.group_key;
																		self.providerid := left.providerid;
																		SELF.MedSchoolName:=right.medschool;
																		SELF.GraduationYear:=right.medschool_year;
																		self:=[]),
											keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0))(MedSchoolName<>''); 
			Layouts.layout_child_medschool doRollup(Healthcare_Header_Services.Layouts.layout_medschool l, dataset(Healthcare_Header_Services.Layouts.layout_medschool) r) := TRANSFORM
				SELF.acctno := l.acctno;
				self.group_key := l.group_key;
				self.ProviderID := l.ProviderID;
				self.childinfo := r;
			END;
			medschool_rollup := rollup(group(sort(rawdata,acctno,ProviderID,group_key),acctno,ProviderID,group_key),group,doRollup(left,rows(left)));
			results := join(input,medschool_rollup, left.acctno=right.acctno and left.srcid = right.ProviderID and left.vendorid=right.group_key,
																			transform(Healthcare_Header_Services.Layouts.CombinedHeaderResults,
																								self.MedSchools := right.childinfo;
																								self := left),left outer);
			return results;
	end;

	Export appendHospitals(dataset(Healthcare_Header_Services.Layouts.CombinedHeaderResults) input, dataset(Healthcare_Header_Services.Layouts.GroupKey) searchby):= function
			rawdata := join(searchby, Enclarity.Keys(,true).associate_group_key.qa,
											keyed(left.group_key = right.group_key) and right.nametype='B' and (right.sloc_type = 'HOSPITALS' or right.billing_type = 'HOSPITALS'),
											transform(Healthcare_Header_Services.Layouts.layout_affiliateHospital, 
																		self.acctno:=left.acctno;
																		self.group_key:=left.group_key;
																		self.providerid := left.providerid;
																		self.bdid := right.bdid;
																		self.tin := right.bill_tin;
																		self.name := right.clean_company_name;
																		self.addrPenalty := 0;
																		self.address1 := right.prepped_addr1;
																		self.prim_range := right.prim_range;
																		self.predir := right.predir;
																		self.prim_name := right.prim_name;
																		self.addr_suffix := right.addr_suffix;
																		self.postdir := right.postdir;
																		self.unit_desig := right.unit_desig;
																		self.sec_range := right.sec_range;
																		self.p_city_name := right.v_city_name;
																		self.st := right.st;
																		self.z5 := right.zip;
																		self.zip4 := right.zip4;
																		self.loc_group_key := right.sloc_group_key;
																		self.bill_group_key := right.billing_group_key;
																		self.bill_NPI := right.bill_npi;
																		self.worksfor := right.pgk_works_for='Y';
																		self:=[]),
											keep(Healthcare_Header_Services.Constants.MAX_SEARCH_RECS), limit(0)); 
			Layouts.layout_Child_affiliateHospital doRollup(Healthcare_Header_Services.Layouts.layout_affiliateHospital l, dataset(Healthcare_Header_Services.Layouts.layout_affiliateHospital) r) := TRANSFORM
				SELF.acctno := l.acctno;
				self.group_key := l.group_key;
				self.ProviderID := l.ProviderID;
				self.childinfo := r;
			END;
			hospital_rollup := rollup(group(sort(dedup(rawdata,all,hash),acctno,ProviderID,group_key),acctno,ProviderID,group_key),group,doRollup(left,rows(left)));
			results := join(input,hospital_rollup, left.acctno=right.acctno and left.srcid = right.ProviderID and left.vendorid=right.group_key,
																			transform(Healthcare_Header_Services.Layouts.CombinedHeaderResults,
																								self.hospitals := right.childinfo;
																								self := left),left outer);
			return results;
	end;
	Export appendAssociation(dataset(Healthcare_Header_Services.Layouts.CombinedHeaderResults) input, dataset(Healthcare_Header_Services.Layouts.GroupKey) searchby):= function
			rawdata := join(searchby, Enclarity.Keys(,true).associate_group_key.qa,
											keyed(left.group_key = right.group_key) and right.nametype='B' and right.sloc_type <> 'HOSPITALS',
											transform(Healthcare_Header_Services.Layouts.layout_affiliateHospital, 
																		self.acctno:=left.acctno;
																		self.group_key:=left.group_key;
																		self.providerid := left.providerid;
																		self.bdid := right.bdid;
																		self.tin := right.bill_tin;
																		self.name := right.clean_company_name;
																		self.addrPenalty := 0;
																		self.address1 := right.prepped_addr1;
																		self.prim_range := right.prim_range;
																		self.predir := right.predir;
																		self.prim_name := right.prim_name;
																		self.addr_suffix := right.addr_suffix;
																		self.postdir := right.postdir;
																		self.unit_desig := right.unit_desig;
																		self.sec_range := right.sec_range;
																		self.p_city_name := right.v_city_name;
																		self.st := right.st;
																		self.z5 := right.zip;
																		self.zip4 := right.zip4;
																		self.loc_group_key := right.sloc_group_key;
																		self.bill_group_key := right.billing_group_key;
																		self.bill_NPI := right.bill_npi;
																		self.worksfor := right.pgk_works_for='Y';
																		self:=[]),
											keep(Healthcare_Header_Services.Constants.MAX_SEARCH_RECS), limit(0)); 
			Healthcare_Header_Services.Layouts.layout_Child_affiliateHospital doRollup(Healthcare_Header_Services.Layouts.layout_affiliateHospital l, dataset(Healthcare_Header_Services.Layouts.layout_affiliateHospital) r) := TRANSFORM
				SELF.acctno := l.acctno;
				self.group_key := l.group_key;
				self.ProviderID := l.ProviderID;
				self.childinfo := r;
			END;
			assoc_rollup := rollup(group(sort(dedup(rawdata,all,hash),acctno,ProviderID,group_key),acctno,ProviderID,group_key),group,doRollup(left,rows(left)));
			results := join(input,assoc_rollup, left.acctno=right.acctno and left.srcid = right.ProviderID and left.vendorid=right.group_key,
																			transform(Healthcare_Header_Services.Layouts.CombinedHeaderResults,
																								self.affiliates := right.childinfo;
																								self := left),left outer);
			return results;
	end;

	Export appendTaxonomy(dataset(Healthcare_Header_Services.layouts.CombinedHeaderResults) input, dataset(Healthcare_Header_Services.layouts.GroupKey) searchby):= function
			rawdata := join(searchby, Enclarity.Keys(,true).taxonomy_group_key.qa,
											keyed(left.group_key = right.group_key),
											transform(Healthcare_Header_Services.layouts.layout_taxonomy, 
																		self.acctno:=left.acctno;
																		self.group_key:=left.group_key;
																		self.providerid := left.providerid;
																		SELF.TaxonomyCode:=right.taxonomy;
																		SELF.PrimaryIndicator:=right.taxonomy_primary_ind;
																		SELF.TaxonomyType:=right.type1;
																		SELF.Classification:=right.classification;
																		self:=[]),
											keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0)); 
			Healthcare_Header_Services.layouts.layout_child_taxonomy doRollup(Healthcare_Header_Services.layouts.layout_taxonomy l, dataset(Healthcare_Header_Services.layouts.layout_taxonomy) r) := TRANSFORM
				SELF.acctno := l.acctno;
				self.group_key := l.group_key;
				self.ProviderID := l.ProviderID;
				self.childinfo := r;
			END;
			Taxonomy_rollup := rollup(group(sort(rawdata,acctno,ProviderID,group_key),acctno,ProviderID,group_key),group,doRollup(left,rows(left)));
			results := join(input,Taxonomy_rollup, left.acctno=right.acctno and left.srcid = right.ProviderID and left.vendorid=right.group_key,
																			transform(Healthcare_Header_Services.layouts.CombinedHeaderResults,
																								self.Taxonomy := right.childinfo;
																								self := left),left outer);
			return results;
	end;

	Shared appendSanctionGroup(dataset(Healthcare_Header_Services.layouts.layout_sanctions) input):= function
			grpDate := dedup(sort(input,acctno,ProviderID,sanc1_state,sanc1_lic_num,-clean_sanc1_date),acctno,ProviderID,sanc1_state,sanc1_lic_num,clean_sanc1_date);
			sanctions_final := join(input,grpDate, left.acctno=right.acctno and left.ProviderID = right.ProviderID and
																	left.sanc1_state=right.sanc1_state and left.sanc1_lic_num=right.sanc1_lic_num and left.clean_sanc1_date=right.clean_sanc1_date,
																	transform(Healthcare_Header_Services.layouts.layout_sanctions, self.GroupSancDate:=right.clean_sanc1_date;self:=left;),keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0));
			//Set Sancid
			finalSort := dedup(sort(group(sort(sanctions_final,acctno,ProviderID,group_key,-GroupSancDate,sanc1_state,sanc1_lic_num,-sanc1_date,sanc1_code),acctno,ProviderID),acctno,ProviderID,group_key,-GroupSancDate,sanc1_state,sanc1_lic_num,-sanc1_date,sanc1_code),acctno,ProviderID,group_key,GroupSancDate,sanc1_state,sanc1_lic_num,sanc1_date,sanc1_code);
			Healthcare_Header_Services.layouts.layout_sanctions addSeq(Healthcare_Header_Services.layouts.layout_sanctions inp,integer C) := transform
				self.GroupSortOrder := C;
				self := inp;
			end;
			setGrpSortOrder := project(finalSort,addSeq(left,counter));
			final:=ungroup(sort(setGrpSortOrder,acctno,ProviderID,group_key,GroupSortOrder));
		return final;
	end;

	Shared appendSanctionLookupStep1(dataset(Healthcare_Header_Services.layouts.layout_sanctions) input):= function
			rawdatalookup1 := join(input, Enclarity.Keys(,true).sanc_codes_sanc_codes.qa,
											keyed(left.sanc1_code = right.sanc_code),
											transform(Healthcare_Header_Services.layouts.layout_sanctions, 
																		self.sanc_desc := right.sanc_desc;
																		self:=left;
																		self:=[]),
											keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0),left outer); 
			rawdatalookup2 := join(rawdatalookup1, Enclarity.Keys(,true).sanc_prov_type_sanc_prov_type_code.qa,
											keyed(left.sanc1_prof_type = right.prov_type_code),
											transform(Healthcare_Header_Services.layouts.layout_sanctions, 
																		self.prov_type_desc := if(left.sanc1_prof_type='MD','DOCTOR OF MEDICINE',right.prov_type_desc);
																		self:=left;
																		self:=[]),
											keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0), left outer); 
			rawdatalookup3 := join(rawdatalookup2, Enclarity.LookupTables.dsSancLookup,
											left.sanc1_code = right.Code,
											transform(Healthcare_Header_Services.layouts.layout_sanctions, 
																		self.SancCategory := right.Cat;
																		self.SancLegacyType := map(left.LicenseStatus='T' and left.sanc1_code = '112DS' => right.LegacyType,
																															 left.sanc1_code = '112DS' => 'HISTORICAL CONDITIONS',
																															 right.LegacyType);
																		self.FullDesc := if(trim(left.sanc1_desc,right)<>'',left.sanc1_desc,right.desc);//Support new granular field data
																		self.SancLevel := if(RIGHT.level='STATE','',RIGHT.level);
																		self.StateOrFederal := if(left.level='STATE','STATE','FEDERAL');
																		self.SancLossOfLic := if((integer)left.ln_derived_rein_date>0,'FALSE',right.LossOfLicense);
																		self:=left;
																		self:=[]),
											keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0), left outer); 
			rawdatalookup4 := join(rawdatalookup3, Enclarity.LookupTables.dsBoardInfo,
											left.sanc1_state = right.State and left.prov_type_desc = right.ProviderType,
											transform(Healthcare_Header_Services.layouts.layout_sanctions, 
																		self.RegulatingBoard := if(RIGHT.RegulatingBoard <> '',RIGHT.RegulatingBoard,left.RegulatingBoard);
																		self:=left;
																		self:=[]),
											keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0), left outer);
			return rawdatalookup4;
	end;

	Shared appendSanctionLookup(dataset(Healthcare_Header_Services.layouts.layout_sanctions) input):= function
			Step1:=appendSanctionLookupStep1(input);
			final:=appendSanctionGroup(Step1);
			return final;
	end;
	Export appendSanction(dataset(Healthcare_Header_Services.layouts.CombinedHeaderResults) input, dataset(Healthcare_Header_Services.layouts.GroupKey) searchby):= function
			rawdata := join(searchby, Enclarity.Keys(,true).sanction_group_key.qa,
											keyed(left.group_key = right.group_key) and right.record_type = 'C',
											transform(Healthcare_Header_Services.layouts.layout_sanctions, 
																		self.acctno:=left.acctno;
																		self.group_key:=left.group_key;
																		self.providerid := left.providerid;
																		cleanCode := trim(right.sanc1_code,left,right);
																		lastCharacter := cleanCode[length(cleanCode)];
																		isReinstate := if(lastCharacter='R',true,false);
																		self.isReinstatement := isReinstate;
																		SELF:=right;
																		self:=[]),
											keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0)); 
			UpdateLicenseStatus := dedup(sort(join(rawdata,input, left.acctno=right.acctno and left.ProviderID = right.LNPID and left.group_key=right.vendorid,
																									transform(Healthcare_Header_Services.layouts.layout_sanctions,
																										LicenseInfo := right.StateLicenses(LicenseState = left.sanc1_state and 
																																									(LicenseNumber = left.sanc1_lic_num or LicenseNumberFmt = left.sanc1_lic_num));
																										self.LicenseStatus := if(exists(LicenseInfo),LicenseInfo[1].LicenseStatus,'');
																										self := left),left outer),record),record);
			appendLookups := appendSanctionLookup(UpdateLicenseStatus);
					
			Healthcare_Header_Services.layouts.layout_child_sanctions doRollup(Healthcare_Header_Services.layouts.layout_sanctions l, dataset(Healthcare_Header_Services.layouts.layout_sanctions) r) := TRANSFORM
				SELF.acctno := l.acctno;
				self.group_key := l.group_key;
				self.ProviderID := l.ProviderID;
				self.childinfo := r;
			END;
			//Group them by State and Lic, then group so they stay together, then sort to get the most recent record first.
			// grpSanc := group(sort(appendLookups,acctno,ProviderID,group_key,GroupSortOrder,sanc1_state,sanc1_lic_num,-sanc1_date),acctno,ProviderID,group_key,GroupSancDate,sanc1_state,sanc1_lic_num);
			grpSanc := group(sort(appendLookups,acctno,ProviderID,group_key,GroupSortOrder,sanc1_state,sanc1_lic_num,-sanc1_date),acctno,ProviderID,group_key);
			sanctions_rollup := rollup(grpSanc,group,doRollup(left,rows(left)));
			results := join(input,sanctions_rollup, left.acctno=right.acctno and left.srcid = right.ProviderID and left.vendorid=right.group_key,
																			transform(Healthcare_Header_Services.layouts.CombinedHeaderResults,
																								SancRecs := sort(right.childinfo,acctno,GroupSortOrder,sanc1_state,sanc1_lic_num,-sanc1_date);
																								self.Sanctions := SancRecs;
																								self.LegacySanctions := Functions.buildLegacySanctionRecord(left,SancRecs);
																								self.hasStateRestrict := exists(SancRecs(stateorfederal='STATE'));
																								self.hasOIG := exists(SancRecs(stateorfederal='FEDERAL' and SancLevel = 'OIG'));
																								self.hasOPM := exists(SancRecs(stateorfederal='FEDERAL' and SancLevel = 'OPM'));
																								self := left),left outer);
			 //output(rawdata,named('encsancrawdata'),extend);
			// output(UpdateLicenseStatus);
			// output(appendLookups);
			// output(grpSanc);
			// output(sanctions_rollup);
			// output(results,named('encsancresults'),extend);
			return results;
	end;

	Shared get_facilities_base (dataset(Healthcare_Header_Services.layouts.searchKeyResults_plus_input) input):= function
			// rawdataFacilities:= join(dedup(sort(input(lnpid>0),record),record), Enclarity.Keys(,true).facility_lnpid.qa,
											// keyed(left.lnpid = right.lnpid),
											// transform(Healthcare_Header_Services.layouts.selectfile_facilities_base_with_input, 
																		// SELF.clean_prim_range:=right.prim_range;
																		// SELF.clean_predir:=right.predir;
																		// SELF.clean_prim_name:=right.prim_name;
																		// SELF.clean_addr_suffix:=right.addr_suffix;
																		// SELF.clean_postdir:=right.postdir;
																		// SELF.clean_unit_desig:=right.unit_desig;
																		// SELF.clean_sec_range:=right.sec_range;
																		// SELF.clean_p_city_name:=right.p_city_name;
																		// SELF.clean_st:=right.st;
																		// SELF.clean_z5:=right.zip;
																		// self:=left,
																		// self:=right),
											// keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0)); 
			// noHits := join(input,rawdataFacilities,left.acctno=right.acctno,transform(Healthcare_Header_Services.layouts.searchKeyResults_plus_input, self:=left),left only);
			noHits := input;
			rawdataFacilitiesbyVendorid:= join(dedup(sort(noHits(vendorid<>''),record),record), Enclarity.Keys(,true).facility_group_key.qa,
											keyed(left.vendorid = right.group_key)  and right.record_type = 'C',
											transform(Healthcare_Header_Services.layouts.selectfile_facilities_base_with_input,
																		SELF.clean_prim_range:=right.prim_range;
																		SELF.clean_predir:=right.predir;
																		SELF.clean_prim_name:=right.prim_name;
																		SELF.clean_addr_suffix:=right.addr_suffix;
																		SELF.clean_postdir:=right.postdir;
																		SELF.clean_unit_desig:=right.unit_desig;
																		SELF.clean_sec_range:=right.sec_range;
																		SELF.clean_p_city_name:=right.p_city_name;
																		SELF.clean_st:=right.st;
																		SELF.clean_z5:=right.zip;
																		self:=left,
																		self:=right,
																		self:=[]),
											keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0)); 
			rawdataFacilitieswithAddrScores := join(rawdataFacilitiesbyVendorid, Enclarity.Keys(,true).associate_group_key.qa,
											keyed(left.vendorid = right.group_key) and right.normed_name_rec_type ='1' and
											right.record_type='C' and left.addr_key = right.addr_key,
											transform(Healthcare_Header_Services.layouts.selectfile_facilities_base_with_input,
																		self.addr_conf_score := (integer)right.prac_addr_confidence_score;
																		self:=left), left outer,
											keep(Healthcare_Header_Services.Constants.IDS_PER_DID), limit(0)); 
			getFEIN := dedup(sort(join(input(vendorid<>''),enclarity.Keys(,true).associate_bgk.qa,
													keyed(left.vendorid = right.billing_group_key),
													transform(Healthcare_Header_Services.layouts.layout_acct_fein, self.acctno:=left.acctno;self.providerid:=left.lnpid;self.fein:=right.bill_tin),
													keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0)),record),record); 
			Healthcare_Header_Services.layouts.layout_child_fein doRollup(Healthcare_Header_Services.layouts.layout_acct_fein l, dataset(Healthcare_Header_Services.layouts.layout_acct_fein) r) := TRANSFORM
				SELF.acctno := l.acctno;
				SELF.ProviderID := l.providerid;
				self.childinfo := project(r,Healthcare_Header_Services.layouts.layout_fein);
			END;
			fein_rolled := rollup(group(getFEIN,acctno,providerid),group,doRollup(left,rows(left)));
			// baseRecs := project(sort(rawdataFacilities+rawdataFacilitiesbyVendorid,acctno,-addr_conf_score,-clean_last_verify_date),Transforms.build_selectfile_Facility_base(left));
			baseRecs := project(sort(rawdataFacilitieswithAddrScores,acctno,-clean_last_verify_date),Transforms.build_selectfile_Facility_base(left));
			//Get Sanctions.....
			getSanctionRecords := join(dedup(sort(noHits,record),record), Enclarity_facility_sanctions.Keys(,false).facility_sanctions_lnfid.qa,
											keyed(left.lnpid = right.lnfid),
											// left.lnpid = right.lnfid and right.record_type='C',
											Transforms.build_selectfile_Facility_sanctions(left,right),
											keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0));
			// output(getSanctionRecords,named('getSanctionRecords'),extend);
			merge_facilities_sorted := sort(getSanctionRecords, acctno, SrcId, Src);
			merge_facilities_grouped := group(merge_facilities_sorted, acctno, SrcId, Src);
			merge_facilities_rolled := rollup(merge_facilities_grouped, group, Transforms.doSelectFileFacilitiesBaseRecordSrcIdRollup(left,rows(left)));			
			// output(baseRecs,named('baseRecs'),extend);
			// output(merge_facilities_rolled,named('merge_facilities_rolled'),extend);
			mergewithBase := join(baseRecs,merge_facilities_rolled,left.acctno=right.acctno and left.lnpid = right.lnpid,transform(Healthcare_Header_Services.layouts.CombinedHeaderResults,
														self.names := dedup(sort(left.names+right.names,record),record);
														self.Addresses := dedup(sort(left.Addresses+right.Addresses,record),record);
														self.phones := dedup(sort(left.phones+right.phones,record),record);
														self.bdids := dedup(sort(left.bdids+right.bdids,record),record);
														self.bipkeys := dedup(sort(left.bipkeys+right.bipkeys,record),record);
														self.npis := dedup(sort(left.npis+right.npis,record),record);
														self.StateLicenses := dedup(sort(left.StateLicenses+right.StateLicenses,record),record);
														self.Taxonomy := dedup(sort(left.Taxonomy+right.Taxonomy,record),record);
														self.sanctions :=dedup(sort(left.sanctions+right.sanctions,record),record);
														self:=left;
														self:=right;), keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0));
			leftonlyRecs := join(baseRecs,mergewithBase,left.acctno=right.acctno and left.lnpid = right.lnpid,transform(Healthcare_Header_Services.layouts.CombinedHeaderResults,self:=left),left only);
			rightonlyRecs := join(merge_facilities_rolled,mergewithBase,left.acctno=right.acctno and left.lnpid = right.lnpid,transform(Healthcare_Header_Services.layouts.CombinedHeaderResults,self:=left),left only);
			mergedRecs := leftonlyRecs+mergewithBase+rightonlyRecs;
			// output(mergedRecs,named('mergewithBase'),overwrite);
			// updateFEIN := join(baseRecs(min(names,namepenalty) < Healthcare_Header_Services.Constants.BUS_NAME_MATCH_THRESHOLD),fein_rolled,left.acctno=right.acctno,transform(Layouts.CombinedHeaderResults, self.feins:=dedup(sort(left.feins+right.childinfo,record),record);self:=left;self:=[];),left outer,keep(Constants.MAX_RECS_ON_JOIN), limit(0));
			updateFEIN := join(mergedRecs,fein_rolled,left.acctno=right.acctno and left.lnpid=right.providerid,transform(Healthcare_Header_Services.layouts.CombinedHeaderResults, self.feins:=dedup(sort(left.feins+right.childinfo,record),record);self:=left;self:=[];),left outer,keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0));
			updateSanctions := project(updateFEIN+getSanctionRecords,transform(Healthcare_Header_Services.layouts.CombinedHeaderResults,
																		               // sanctionLookup := appendSanctionLookup(left.Sanctions);
																										//FinalSanctions := appendSanctionGroup(sanctionLookup);
																										//self.Sanctions := left.Sanctions;
																										self.LegacySanctions := Functions.buildLegacySanctionRecord(left,left.sanctions);
																										self := Left));
			getInput:= project(input,transform(Healthcare_Header_Services.layouts.autokeyInput,self.license_state:=left.UserLicenseState;self.license_number:=left.UserLicenseNumber;
																															self.TaxID:=left.userTaxID; self.UPIN:=left.userUPIN;self.NPI:=left.userNPI;
																															self.DEA:=left.userDEA;self.fein:=left.userfein;self:=left));

			filterRec := Functions.doPenalty(updateSanctions,dedup(sort(getInput,acctno),acctno),10);
			facilities_final_sorted := sort(filterRec, acctno, SrcId, Src,vendorid);
			facilities_final_grouped := group(facilities_final_sorted, acctno, SrcId, Src,vendorid);
			facilities_rolled := rollup(facilities_final_grouped, group, Transforms.doSelectFileFacilitiesBaseRecordSrcIdRollup(left,rows(left)));			
      return facilities_rolled;
	end;

	Export get_selectfile_entity (dataset(Healthcare_Header_Services.layouts.searchKeyResults_plus_input) input,dataset(Healthcare_Header_Services.layouts.common_runtime_config) cfg):= function
			providers_base := get_providers_base(input);
			getkeys := dedup(project(providers_base,transform(Healthcare_Header_Services.layouts.GroupKey, self.acctno := left.acctno;self.ProviderID:=left.srcid;self.group_key :=left.Vendorid;)),all,hash);
			// Append Other data
			appendLicenseData := appendLicense(providers_base,getkeys);
			appendSpecialtyData := appendSpecialty(appendLicenseData,getkeys);
			appendMedSchoolData := appendMedSchool(appendSpecialtyData,getkeys);
			appendHospitalData := appendHospitals(appendMedSchoolData,getkeys);
			appendAssociationData := appendAssociation(appendHospitalData,getkeys);
			appendTaxonomyData := appendTaxonomy(appendAssociationData,getkeys);
			appendSanctionData := appendSanction(appendTaxonomyData,getkeys);
			// output(input,named('EnclarityInput'));
			// output(providers_base,named('providers_base'));
			// output(getkeys,named('getkeys'));
			// output(appendSpecialtyData,named('appendSpecialtyData'));
			// output(appendMedSchoolData,named('appendMedSchoolData'));
			// output(appendHospitalData,named('appendHospitalData'));
			// output(appendAssociationData,named('appendAssociationData'));
			// output(appendTaxonomyData,named('appendTaxonomyData'));
			// output(appendSanctionData,named('appendSanctionData'));
			facilities_base := get_facilities_base(input);
			// output(facilities_base,named('facilities_base'));
			providers_final_sorted := sort(appendSanctionData+facilities_base, acctno, SrcId, Src);
			providers_final_grouped := group(providers_final_sorted, acctno, SrcId, Src);
			// output(providers_final_grouped);
			providers_rolled := rollup(providers_final_grouped, group, Transforms.doSelectFileProvidersBaseRecordSrcIdRollup(left,rows(left)));			
			// output(providers_rolled);
		
			 
			return providers_rolled;//Only one should ever get populated
	end;

	Export get_selectfile_byBusReEntry (dataset(Healthcare_Header_Services.layouts.autokeyInput) input):= function
		// This is used for reenter into the code.  The previous step should have returned the fakeid and the source id
		// This could also be an FEIN...
		ak:=AutoKey_for_Batch(input).SelectFileBus_autokeys;
		akFmt:=dedup(sort(project(ak,transform(Healthcare_Header_Services.layouts.searchKeyResults, self.vendorid:=(string)left.group_key; self.acctno:=left.acctno;self.src:=Healthcare_Header_Services.Constants.SRC_SELECTFILE;self.prov_id:=left.fakeid;self.isAutokeysResult:=true;self:=[];)),record),record);
		searchKeyResults_w_input := join(input,akFmt,left.acctno=right.acctno,transform(Healthcare_Header_Services.layouts.searchKeyResults_plus_input,
																																						self.isAutokeysResult := true;
																																						self.src:=Healthcare_Header_Services.Constants.SRC_SELECTFILE;
																																						self.prov_id := left.providerid;
																																						self.UserLicenseNumber:=left.license_number;
																																						self.UserLicenseState:=left.license_state;
																																						self.UserUPIN:=left.UPIN;
																																						self.UserNPI:=left.NPI;
																																						self.UserDEA:=left.DEA;
																																						self.UserCLIANumber:=left.CLIANumber;
																																						self:=right;self:=left),keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN),limit(0));
		possibleFEIN_input := dedup(sort(join(input,enclarity.Keys(,true).associate_bill_tin.qa,keyed((string)left.providerid=right.bill_tin),transform(Healthcare_Header_Services.layouts.searchKeyResults_plus_input,
																																						self.isAutokeysResult := true;
																																						self.src:=Healthcare_Header_Services.Constants.SRC_SELECTFILE;
																																						self.prov_id:=(integer)left.providerid;
																																						self.UserLicenseNumber:=left.license_number;
																																						self.UserLicenseState:=left.license_state;
																																						self.UserUPIN:=left.UPIN;
																																						self.UserNPI:=left.NPI;
																																						self.UserDEA:=left.DEA;
																																						self.UserCLIANumber:=left.CLIANumber;
																																						self.UserFEIN:=left.FEIN;
																																						self.vendorid:=(string)right.billing_group_key;
																																						self:=right;self:=left),keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN),limit(0))(vendorid<>''),record),record);
		rawdata := get_facilities_base(dedup(sort(searchKeyResults_w_input+possibleFEIN_input,record),record));
		// output(ak,named('ak'));
		// output(akFmt,named('akFmt'));
		// output(searchKeyResults_w_input,named('searchKeyResults_w_input'));
		// output(rawdata,named('rawdata'));
		return rawdata;
	end;

	Export get_selectfile_byBusAutokeys (dataset(Healthcare_Header_Services.layouts.autokeyInput) input):= function
		//This is intended for Business seaches only until the business data gets into the header.....
		ak:=AutoKey_for_Batch(input).SelectFile_autokeys(prac_company_name<>'');
		//There really is no match on Name only since the businesses are in with the individuals so apply a filter to reduce to only the closest matches
		akScore:=join(input,ak,left.acctno=right.acctno,transform(recordof(ak), 
															BestAddr := if(left.prim_name<> '',left.prim_name=right.prim_name,True);
															BestNPI := if(left.npi <> '', left.npi = right.npi_num,True);
															self.bdid_score := ut.CompanySimilar100(right.prac_company_name,left.comp_name);
															self.isDid := BestAddr;
															self.isBdid := BestNpi;
															self:=right),keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0));
		//Format the closest matches
		akCheckBestNpi := akScore(isBdid=true);
		keepOnlyBestNpi := join(akScore,akCheckBestNpi,left.acctno=right.acctno,transform(recordof(ak),self:=left),left only)+akCheckBestNpi;
		akCheckBestAddr := keepOnlyBestNpi(isdid=true);
		keepOnlyBestAddr := join(keepOnlyBestNpi,akCheckBestAddr,left.acctno=right.acctno,transform(recordof(ak),self:=left),left only)+akCheckBestAddr;
		limitTest := Min(keepOnlyBestAddr,bdid_score)+5;
		limitBest := if(limitTest > Healthcare_Header_Services.Constants.BUS_NAME_MATCH_THRESHOLD,Healthcare_Header_Services.Constants.BUS_NAME_MATCH_THRESHOLD,limitTest);//If we are not truely a close match this will remove the records otherwise it will narrow down the result to the closest matches
		akFilter := akScore(bdid_score<=limitBest);
		akFmt:=dedup(sort(project(akFilter,transform(Healthcare_Header_Services.layouts.searchKeyResults, self.vendorid:=(string)left.group_key; self.acctno:=left.acctno;self.src:=Healthcare_Header_Services.Constants.SRC_SELECTFILE;self.prov_id:=left.fakeid;self.isAutokeysResult:=true;self:=[];)),record),record);
		searchKeyResults_w_input := join(input,akFmt,left.acctno=right.acctno,transform(Healthcare_Header_Services.layouts.searchKeyResults_plus_input,
																																						self.isAutokeysResult := true;
																																						self.UserLicenseNumber:=left.license_number;
																																						self.UserLicenseState:=left.license_state;
																																						self.UserUPIN:=left.UPIN;
																																						self.UserNPI:=left.NPI;
																																						self.UserDEA:=left.DEA;
																																						self.UserCLIANumber:=left.CLIANumber;
																																						self:=right;self:=left),keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN),limit(0));
		//Add code to lookup by FEIN.
		searchByFEIN := input(FEIN<>'');
		//Add code to filter prospect list to close matches.
		searchByFEIN_w_input := dedup(sort(join(searchByFEIN,enclarity.Keys(,true).associate_bill_tin.qa,keyed(left.FEIN=right.bill_tin),transform(Healthcare_Header_Services.layouts.searchKeyResults_plus_input,
																																						self.src:=Healthcare_Header_Services.Constants.SRC_SELECTFILE;
																																						self.isAutokeysResult := true;
																																						self.prov_id:=(integer)left.FEIN;
																																						self.UserLicenseNumber:=left.license_number;
																																						self.UserLicenseState:=left.license_state;
																																						self.UserUPIN:=left.UPIN;
																																						self.UserNPI:=left.NPI;
																																						self.UserDEA:=left.DEA;
																																						self.UserCLIANumber:=left.CLIANumber;
																																						self.UserFEIN:=left.FEIN;
																																						self.vendorid:=(string)right.billing_group_key;
																																						self:=right;self:=left),keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN),limit(0))(vendorid<>''),record),record);
		//Get the raw data for the closest matches
		rawdata := get_facilities_base(searchKeyResults_w_input+searchByFEIN_w_input);
		// output(ak,named('get_selectfile_byBusAutokeys_ak'));
		// output(akScore,named('get_selectfile_byBusAutokeys_akScore'));
		// output(akCheckBestNpi,named('get_selectfile_byBusAutokeys_akCheckBestNpi'));
		// output(keepOnlyBestNpi,named('get_selectfile_byBusAutokeys_keepOnlyBestNpi'));
		// output(akCheckBestAddr,named('get_selectfile_byBusAutokeys_akCheckBestAddr'));
		// output(keepOnlyBestAddr,named('get_selectfile_byBusAutokeys_keepOnlyBestAddr'));
		// output(limitBest,named('get_selectfile_byBusAutokeys_limitBest'));
		// output(akFilter,named('get_selectfile_byBusAutokeys_akFilter'));
		// output(akFmt,named('get_selectfile_byBusAutokeys_akFmt'));
		// output(searchKeyResults_w_input,named('get_selectfile_byBusAutokeys_searchKeyResults_w_input'));
		// output(searchByFEIN,named('get_selectfile_byBusAutokeys_searchByFEIN'));
		// output(searchByFEIN_w_input,named('get_selectfile_byBusAutokeys_searchByFEIN_w_input'));
		// output(rawdata,named('rawdata'));
		return rawdata;
	end;
	//Support Gap Sanctions common routine
	Export getSanctionsCommon (dataset(Healthcare_Header_Services.layouts.autokeyInput) input, dataset(Healthcare_Header_Services.layouts.sanc_lookup_rec) sanc_keyRec, dataset(Healthcare_Header_Services.layouts.common_runtime_config) cfg):= function
		string federalBoard := 'FEDERAL BOARDS';
		string typeOIG := 'DEBARRED/EXCLUDED';
		string typeGSA1 := 'EXCLUDED';
		string typeGSA2 := 'EXCLUDED/DELETED';

		Healthcare_Header_Services.layouts.layout_LegacySanctions get_sanctions_by_sancid(Healthcare_Header_Services.layouts.sanc_lookup_rec l, doxie_files.key_sanctions_sancid r) := transform
			sancType := stringlib.StringToUpperCase(r.sanc_type);
			isFederal := stringlib.StringToUpperCase(r.sanc_brdtype) = federalBoard;
			isOIG := sancType = typeOIG;
			isGSA := sancType = typeGSA1 or sancType = typeGSA2;
			v3codes_Sanc_Cond := choosen(codes.key_codes_v3 (keyed(file_name='INGENIX_SANCTIONS'), keyed(field_name='SANC_CODE'), keyed(field_name2=''), keyed(code=r.SANC_COND)),10);
			self.SANC_COND := if(v3codes_Sanc_Cond[1].long_desc<>'',r.SANC_COND + ': ' + v3codes_Sanc_Cond[1].long_desc,r.SANC_COND);
			self.sanc_grouptype := map(isFederal => 'FEDERAL', 
																 'STATE');
			self.sanc_subgrouptype := map(isFederal and isGSA => 'OPM', 
																 isFederal and isOIG => 'OIG', 
																 '');
			self.sanc_priority := map(sancType = 'DEBARRED/EXCLUDED' => 1,
																sancType = 'DEBARRED/SUSPENDED' => 2,
																sancType = 'EXCLUDED' => 3,
																sancType = 'EXCLUSION' => 4,
																sancType = 'EXCLUDED/DELETED' => 5,
																sancType = 'LICENSURE DENIED' => 6,
																sancType = 'CANCELLED' => 7,
																sancType = 'REVOCATION' => 8,
																sancType = 'CEASE AND DESIST' => 9,
																sancType = 'SURRENDER' => 10,
																sancType = 'VOLUNTARY SURRENDER' => 11,
																sancType = 'SUSPENSION' => 12,
																sancType = 'RETIRED' => 13,
																sancType = 'LIMITED LICENSE' => 14,
																sancType = 'PROBATION' => 15,
																sancType = 'REPRIMAND' => 16,
																sancType = 'CONSENT ORDER' => 17,
																sancType = 'FINE' => 18,
																sancType = 'STATEMENT OF CHARGES' => 19,
																sancType = 'LETTER OF CONCERN' => 20,
																sancType = 'MODIFICATION OF PREVIOUS ORDER' => 21,
																sancType = 'ACCUSATION' => 22,
																sancType = 'OTHER' => 23,
																sancType = 'NONE GIVEN' => 25,
																sancType = '' => 25,99);
			self.SANC_SRC_DESC := map(isFederal and isOIG =>'OFFICE OF INSPECTOR GENERAL',
																	isFederal and isGSA =>'OFFICE OF PERSONNEL MANAGEMENT',r.SANC_SRC_DESC);
			self.SANC_FAB := if(r.SANC_FAB = 'Y','TRUE','FALSE');
			self.SANC_UNAMB_IND := if(r.SANC_UNAMB_IND = 'Y','TRUE','FALSE');
			self.groupsortorder := 99;
			self := l;
			self := r;
		end;
		sancs_by_sid := join(sanc_keyRec((integer)SANC_ID>0 and (integer)SANC_ID<10000000), doxie_files.key_sanctions_sancid,
												keyed((unsigned6)left.SANC_ID = right.l_sancid), 
												get_sanctions_by_sancid(left,right),
												keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0));
		//Ensure Sanctions belong to subject
		sancs_by_sid_filter1:=join(input(cfg[1].excludeLegacySanctions=false),sancs_by_sid,left.acctno=right.acctno and 
														 ((left.name_first <> '' and Functions.cleanOnlyCharacters(left.name_first)[1..5] = Functions.cleanOnlyCharacters(right.prov_clean_fname)[1..5]) or 
														 (left.name_last <> '' and Functions.cleanOnlyCharacters(left.name_last)[1..4] = Functions.cleanOnlyCharacters(right.prov_clean_lname)[1..4]) or 
														 ((left.p_city_name = right.ProvCo_Address_Clean_p_city_name and left.st = right.ProvCo_Address_Clean_st) or left.z5 = right.ProvCo_Address_Clean_zip) or
														 left.providersrc = Healthcare_Header_Services.Constants.SRC_SANC or right.src ='NH' or right.src = 'LN'),
															transform(Healthcare_Header_Services.layouts.layout_LegacySanctions, 
																AddrRange := trim(left.prim_range,left,right) = trim(right.ProvCo_Address_Clean_prim_range,left,right);
																AddrName := trim(left.prim_name,left,right) = trim(right.ProvCo_Address_Clean_prim_name,left,right);
																AddrBlank := trim(left.prim_range,all)='' and trim(left.prim_name,all)='';
																AddrMatchorBlank := AddrRange or AddrName or AddrBlank;
																cityMatch := trim(left.p_city_name,all) = '' or left.p_city_name = right.ProvCo_Address_Clean_p_city_name;
																StateMatch := left.st = right.ProvCo_Address_Clean_st;
																cityStateMatch := AddrMatchorBlank and cityMatch and StateMatch;
																bestmatch := if(left.comp_name<>'' and right.SANC_BUSNME<>'',Functions.CompareBusinessNameConfidence(left.comp_name,right.SANC_BUSNME),0);
																isBusSearch := left.comp_name <> '';
																isIndvSearch := left.comp_name = '' and left.name_last <> '' or left.providersrc = Healthcare_Header_Services.Constants.SRC_SANC;
																self.SANC_ID:=if((isBusSearch and ((bestmatch>=Healthcare_Header_Services.Constants.BUS_NAME_BIPMATCH_THRESHOLD and cityStateMatch) or (right.src ='NH' or right.src = 'LN'))) or 
																									isIndvSearch,(integer)right.SANC_ID,skip);
																self:=right),keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0));
		//Handle Jr/Sr problems
		sancs_by_sid_filtered:=join(input,dedup(sancs_by_sid_filter1,record,all),left.acctno=right.acctno,transform(Healthcare_Header_Services.layouts.layout_LegacySanctions,
																										skipRec := (integer)left.dob > 0 and (integer)right.SANC_DOB > 0 and
																																			(Max((integer)left.DOB[1..4],(integer)right.SANC_DOB[1..4]) - 
																																			ut.EarliestDate((integer)left.DOB[1..4],(integer)right.SANC_DOB[1..4])) > 13;
																										self.providerid:=if(skipRec or 
																																				(left.providersrc = Healthcare_Header_Services.Constants.SRC_SANC and (integer)left.providerid <> (integer)right.sanc_id),
																																					skip,if(left.providerid<>0,left.providerid,right.providerid)); 
																										self:=right),keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0));
		f_sancs_srt := sort(sancs_by_sid_filtered, acctno,providerid,sanc_grouptype, sanc_priority, -sanc_sancdte_form, -sanc_updte_form, (unsigned6)SANC_ID);
		f_sancs_dep := group(dedup(f_sancs_srt, acctno,providerid,sanc_grouptype, sanc_priority, sanc_sancdte_form, sanc_updte_form, (unsigned6)SANC_ID),acctno,ProviderID);
		Healthcare_Header_Services.layouts.layout_child_LegacySanctions doRollup(Healthcare_Header_Services.layouts.layout_LegacySanctions l, dataset(Healthcare_Header_Services.layouts.layout_LegacySanctions) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.ProviderID := l.ProviderID;
			self.childinfo := r;
		END;
		results_rolled := rollup(f_sancs_dep,group,doRollup(left,rows(left)));
		fullRec := project(dedup(sort(f_sancs_dep,acctno,providerid),acctno,providerid), transform(Healthcare_Header_Services.layouts.CombinedHeaderResults,
																self.acctno := left.acctno;
																self.LNPID := left.providerid;
																self.srcID := left.SANC_ID;
																self.src := Healthcare_Header_Services.Constants.SRC_SANC;
																self.names := dataset([{1,0,'',
																											left.prov_clean_fname,
																											left.prov_clean_mname,
																											left.prov_clean_lname,
																											left.prov_clean_name_suffix,
																											left.prov_clean_title,'',
																											left.sanc_busnme}],Healthcare_Header_Services.layouts.layout_nameinfo);
																self.Addresses := dataset([{1,0,
																											'',
																											'',
																											'',
																											'',
																											'',
																											'',
																											0,
																											'',
																											'',
																											left.provco_address_clean_prim_range,
																											left.provco_address_clean_predir,
																											left.provco_address_clean_prim_name,
																											left.provco_address_clean_addr_suffix,
																											left.provco_address_clean_postdir,
																											left.provco_address_clean_unit_desig,
																											left.provco_address_clean_sec_range,
																											left.provco_address_clean_p_city_name,
																											'',
																											left.provco_address_clean_st,
																											left.provco_address_clean_zip,
																											'','','','',
																											left.date_last_seen,
																											left.date_first_seen,
																											left.date_last_reported,
																											left.date_first_reported,
																											left.provco_address_clean_geo_lat,
																											left.provco_address_clean_geo_long,
																											'','','',''}],Healthcare_Header_Services.layouts.layout_addressinfo);
																self.dobs := dataset([{left.sanc_dob}],Healthcare_Header_Services.layouts.layout_dob)(dob<>'');
																self.dids := dataset([{(integer)left.did}],Healthcare_Header_Services.layouts.layout_did)(did>0);
																self.taxids := dataset([{left.sanc_tin}],Healthcare_Header_Services.layouts.layout_taxid)(taxid<>'');
																self.upins := dataset([{left.acctno,left.SANC_ID,left.sanc_upin}],Healthcare_Header_Services.layouts.layout_upin)(upin<>'');
																self.StateLicenses := dataset([{left.acctno,left.SANC_ID,0,left.sanc_sancst,left.sanc_licnbr,'',''}],Healthcare_Header_Services.layouts.layout_licenseinfo)(LicenseNumber<>'');
																self:=left;self:=[];));
		fullRecFinal := join(fullRec,results_rolled, left.acctno=right.acctno and left.LNPID=right.ProviderID, transform(Healthcare_Header_Services.layouts.CombinedHeaderResults,self.LegacySanctions:=right.childinfo;self:=left),keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0));
		// output(sanc_keyRec);
		// output(input);
		// output(sancs_by_sid);
		// output(sancs_by_sid_filter1);
		// output(sancs_by_sid_filtered);
		// output(f_sancs_dep);
		// output(fullRec);
		// output(results_rolled);
		return fullRecFinal;
	end;
	//Support Gap Sanctions via Input Criteria
	Export getSanctions (dataset(Healthcare_Header_Services.layouts.autokeyInput) input,dataset(Healthcare_Header_Services.layouts.common_runtime_config) cfg):= function
		//Hit by License Number or UPIN
		sanc_byUpin := join(input(cfg[1].excludeLegacySanctions=false), doxie_files.key_upin_sancid, keyed(left.upin = right.l_upin),transform(Healthcare_Header_Services.layouts.sanc_lookup_rec, self.acctno:=left.acctno;self.providerid:=left.providerid;self.SANC_ID:=right.sanc_id;self.src:='U'),keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0));
		sanc_byStLic := join(input(cfg[1].excludeLegacySanctions=false), doxie_files.key_license_sancid, keyed(left.license_state = right.SANC_SANCST) and left.license_number = right.SANC_LICNBR,transform(Healthcare_Header_Services.layouts.sanc_lookup_rec, self.acctno:=left.acctno;self.providerid:=left.providerid;self.SANC_ID:=right.sanc_id;self.src:='L'),keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0));
		sanc_keyRec := dedup(sort(sanc_byUpin+sanc_byStLic,acctno,ProviderID,SANC_ID),acctno,ProviderID,SANC_ID);//Filter out the records that don't have a provider ID to link back too or are too high to be gap records
		NoHitsforAK := join(input(cfg[1].excludeLegacySanctions=false),sanc_keyRec,left.acctno=right.acctno,transform(Healthcare_Header_Services.layouts.autokeyInput,self:=left),left only);
		//Hit autokeys
		//Remove bad input records before sending to autokeys
		removeBadRecs := Project(NoHitsforAK, transform(Healthcare_Header_Services.layouts.autokeyInput,
																		bad:=length(trim(left.name_first,all))>0 and length(trim(left.name_last,all))=0;
																		self.name_last := if(bad or cfg[1].isReport,skip,left.name_last);
																		self := left;));
		//Skip Name only matches for Sanctions.
		removeBadRecsSanc := Project(removeBadRecs, transform(Healthcare_Header_Services.layouts.autokeyInput,
																		noAddress:=left.prim_name='' and left.p_city_name='' and left.st ='' and left.z5 = '';;
																		self.name_last := if(noAddress,skip,left.name_last);
																		self := left;));

		sanc_ids_byak := project(AutoKey_for_Batch(removeBadRecsSanc).sanc_autokeys,transform(Healthcare_Header_Services.layouts.sanc_lookup_rec, self.acctno:=left.acctno;self.providerid:=(integer)left.sanc_id;self.SANC_ID:=(integer)left.sanc_id;self.src:='AK'));
		//Only return Sanction ID < 1000000 as those above that number are backfill keys Enclarity data not Gap data
		recs := (sanc_keyRec+sanc_ids_byak)((integer)SANC_ID>0 and (integer)SANC_ID<10000000);
		rawdata := getSanctionsCommon(input,recs,cfg);
		// output(sanc_byUpin,named('getSanctions_sanc_byUpin'));
		// output(sanc_byStLic,named('getSanctions_sanc_byStLic'));
		// output(sanc_keyRec,named('getSanctions_sanc_keyRec'));
		// output(NoHitsforAK,named('getSanctions_NoHitsforAK'));
		// output(sanc_ids_byak,named('getSanctions_sanc_ids_byak'));
		// output(recs,named('getSanctions_recs'));
		// output(rawdata,named('getSanctions_rawdata'));
		return rawdata;
	end;
	//Support Gap Bus Sanctions via Input Criteria
	Export getBusSanctions (dataset(Healthcare_Header_Services.layouts.autokeyInput) input,dataset(Healthcare_Header_Services.layouts.common_runtime_config) cfg):= function
		//Hit by Busness Name
		bussanc_by_Bus_name := join(dedup(sort(input(cfg[1].excludeLegacySanctions=false and comp_name <>''),acctno,comp_name),acctno,comp_name), doxie_files.key_sanctions_busname,keyed(left.comp_name[1..7] = right.s_sanc_busnme[1..7]),
												transform(Healthcare_Header_Services.layouts.sanc_lookup_rec, 
																	keepit := (integer)right.SANC_ID>0 and (integer)right.SANC_ID<10000000;
																	bestmatch := if(keepit and left.comp_name<>'' and right.s_sanc_busnme<>'',Functions.CompareBusinessNameConfidence(left.comp_name,right.s_sanc_busnme),1);
																	self.acctno:=if(keepit,left.acctno,skip);
																	self.src:='BUS';
																	self.SANC_ID:=if(bestmatch>=Healthcare_Header_Services.Constants.BUS_NAME_BIPMATCH_THRESHOLD,(integer)right.SANC_ID,skip);
																	self:=left;),keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0));
		//Hit by FEIN and match on Business Name TaxID FEIN
		Bussanc_bytaxid := join(dedup(sort(input(cfg[1].excludeLegacySanctions=false and TaxID <>''),acctno,TaxID),acctno,TaxID), doxie_files.key_sanctions_tin, keyed((string)INTFORMAT((integer)left.TaxID,9,1) = right.s_SANC_tin and left.taxid <>''),transform(Healthcare_Header_Services.layouts.sanc_lookup_rec,keepit := (integer)right.SANC_ID>0 and (integer)right.SANC_ID<10000000;self.acctno:=if(keepit,left.acctno,skip);self.providerid:=left.providerid;self.SANC_ID:=(integer)right.sanc_id;self.src:='F'),keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0));
		Bussanc_byfein := join(dedup(sort(input(cfg[1].excludeLegacySanctions=false and fein <> ''),acctno,fein),acctno,fein), doxie_files.key_sanctions_tin, keyed((string)INTFORMAT((integer)left.fein,9,1) = right.s_SANC_tin and left.fein <>''),transform(Healthcare_Header_Services.layouts.sanc_lookup_rec, keepit := (integer)right.SANC_ID>0 and (integer)right.SANC_ID<10000000;self.acctno:=if(keepit,left.acctno,skip);self.providerid:=left.providerid;self.SANC_ID:=(integer)right.sanc_id;self.src:='F'),keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0));
		NoHitsforAK := join(input(cfg[1].excludeLegacySanctions=false),bussanc_by_Bus_name+Bussanc_byfein+Bussanc_bytaxid,left.acctno=right.acctno,transform(Healthcare_Header_Services.layouts.autokeyInput,self:=left),left only);
		//Hit autokeys (Address search)

		sanc_ids_byak := project(AutoKey_for_Batch(NoHitsforAK).sanc_autokeys,transform(Healthcare_Header_Services.layouts.sanc_lookup_rec, self.acctno:=left.acctno;self.SANC_ID:=(integer)left.sanc_id;self.src:='AK'));
		//Only return Sanction ID < 1000000 as those above that number are backfill keys Enclarity data not Gap data
		recscombined := (bussanc_by_Bus_name+Bussanc_byfein+Bussanc_bytaxid);
		recs := if (exists(recscombined),recscombined,sanc_ids_byak)(SANC_ID>0 and SANC_ID<10000000);
		rawdata := getSanctionsCommon(input,recs,cfg);
		// output(input);
		// output(bussanc_by_Bus_name);
		// output(Bussanc_bytaxid);
		// output(Bussanc_byfein);
		// output(NoHitsforAK,named('NoHitsforAK'),overwrite);
		// output(sanc_ids_byak,named('sanc_ids_byak'),overwrite);
		// output(recscombined,named('recscombined'),overwrite);
		// output(recs);
		// output(rawdata);
		return rawdata;
	end;
/* Need good test case to finish up
	Export getBusSanctionsForResults (dataset(Healthcare_Header_Services.layouts.CombinedHeaderResults) recs,dataset(Healthcare_Header_Services.layouts.common_runtime_config) cfg):= function
		normName := NORMALIZE(recs,left.Names,transform(Layouts.CombinedHeaderResults, self.Names:= right,self:=left,self:=[]));
		normAddr := NORMALIZE(normName(),left.Addresses,transform(Layouts.CombinedHeaderResults,self.Addresses:= right,self:=left,self:=[]));
		normFEIN := NORMALIZE(normAddr(),left.feins,transform(Layouts.CombinedHeaderResults,self.feins:= right,self:=left,self:=[]));
		normFilterNoName := normFEIN(Names[1].CompanyName <> '');
		normFilterNoAddress := normFilterNoName(Addresses[1].prim_range <> '' and Addresses[1].prim_name <> '');
		input := dedup(project(normFilterNoAddress,transform(Layouts.autokeyInput, self.acctno:=(string)left.lnpid; self.seq:=(integer)left.acctno; 
																											self.comp_name:=left.Names[1].CompanyName; 
																											self.prim_range:=left.Addresses[1].prim_range;
																											self.predir:=left.Addresses[1].predir;
																											self.prim_name:=left.Addresses[1].prim_name;
																											self.addr_suffix:=left.Addresses[1].addr_suffix;
																											self.postdir:=left.Addresses[1].postdir;
																											self.unit_desig:=left.Addresses[1].unit_desig;
																											self.sec_range:=left.Addresses[1].sec_range;
																											self.p_city_name:=left.Addresses[1].p_city_name;
																											self.st:=left.Addresses[1].st;
																											self.z5:=left.Addresses[1].z5;
																											self.fein :=left.feins[1].fein;
																											self:=[])),all,hash);
		hits := getBusSanctions(input,cfg);
		//Relink the sanction to the correct Record and filter out anything that does not match before gettign the full record.
		// rejoin := dedup(join(input,hits,left.acctno=right.acctno,transform(Layouts.sanc_lookup_rec,
										// AddressMatch:= left.prim_range=right.addr.prim_range and left.prim_name=right.addr.prim_name;
										// NameMatch:= Healthcare_Header_Services.Functions.CompareBusinessNameConfidence(right.sanc_busnme,left.comp_name)>=Healthcare_Header_Services.Constants.BUS_NAME_BIPMATCH_THRESHOLD;
										// GoodMatch := NameMatch and AddressMatch;
										// self.acctno:=if(GoodMatch,left.seq,skip);
										// self.ProviderID:=left.acctno;self.SANC_ID:=(integer)left.sanc_id;self.src:='AK')),all,hash);
		// rawdata := getSanctionsCommon(input,rejoin,cfg);
		//Link RawData to the actual associated record
		//TODO
		output(recs);
		output(input);
		output(hits,all);
		// output(rejoin,all);
		// output(bussanc_by_Bus_name);
		// output(Bussanc_byfein);
		// output(NoHitsforAK,named('NoHitsforAK'),overwrite);
		// output(sanc_ids_byak,named('sanc_ids_byak'),overwrite);
		// output(recscombined,named('recscombined'),overwrite);getAppendBusSanctions
		// output(recs,named('getBusSanctions_recs'),overwrite);
		// output(rawdata);
		return hits;
	end;
*/
	//Support Gap Sanctions via Reentry Input Criteria
	Export getSanctionsReentry (dataset(Healthcare_Header_Services.layouts.autokeyInput) input,dataset(Healthcare_Header_Services.layouts.common_runtime_config) cfg):= function
		//Provider ID should be the Sanc ID
		recs := project(input,transform(Healthcare_Header_Services.layouts.sanc_lookup_rec, self.acctno:=left.acctno;self.SANC_ID:=left.ProviderID;self.src:='S'));
		rawdata := getSanctionsCommon(input,recs,cfg);
		return rawdata;
	end;
	//Support Gap Sanctions via found business records and Input Criteria
	Export getAppendBusSanctions (dataset(Healthcare_Header_Services.layouts.CombinedHeaderResults) Recs,dataset(Healthcare_Header_Services.layouts.autokeyInput) input,dataset(Healthcare_Header_Services.layouts.common_runtime_config) cfg):= function
			//We got a sanction is there an lnpid it might be assigned too?
			checklnpidkey := join(recs,Ingenix_NatlProf.key_lnpid,keyed(left.lnpid=right.lnpid) and right.sanc_id <10000000,
																			transform(Healthcare_Header_Services.layouts.sanc_lookup_rec,
																									self.acctno := left.acctno;
																									self.ProviderID:=left.lnpid;
																									self.SANC_ID:=right.sanc_id;
																									self.src:='LN';),
																									keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0));			
			//Check Found Records for Sanction linking
			// rawRecsLinking := getBusSanctionsForResults(recs,cfg);
			//We found a sanction get the full data and append
			getLinkedSanctions := getSanctionsCommon(input,checklnpidkey,cfg);
			prefill := join(recs,getLinkedSanctions,left.acctno=right.acctno and left.lnpid=right.lnpid, 
																								transform(Healthcare_Header_Services.layouts.CombinedHeaderResults,
																														self.legacysanctions := right.legacysanctions;
																														self := left),
																														keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0));
			//Remaining Sanctions
			remainingRecs := join(recs,checklnpidkey,left.acctno=right.acctno,transform(Healthcare_Header_Services.layouts.CombinedHeaderResults, self:=left),left only);
			remainingInputs := join(input,checklnpidkey,left.acctno=right.acctno,transform(Healthcare_Header_Services.layouts.autokeyInput, self:=left),left only);
			getSanc := getBusSanctions(remainingInputs,cfg);
			//CName has to be very close or License has to exist and be an exact match or TIN/FEIN has to match exactly to be appended
			appendRecs:=join(remainingRecs,getSanc,left.acctno=right.acctno, transform(Healthcare_Header_Services.layouts.CombinedHeaderResults,
																														bestmatch := Functions.CompareBusinessNameConfidence(left.names[1].companyname,right.legacysanctions[1].sanc_busnme);
																														VerifyBusinessName:=if(bestmatch >= Healthcare_Header_Services.Constants.BUS_NAME_BIPMATCH_THRESHOLD, true, false);
																														inputCleanLic := functions.cleanOnlyNumbers(right.legacysanctions[1].sanc_licnbr);
																														fileCleanLic := functions.cleanOnlyNumbers(left.statelicenses[1].licensenumber);
																														VerifyLicense:=if(inputCleanLic <> '' and fileCleanLic <> '' and inputCleanLic=fileCleanLic, true, false);
																														VerifyTIN:=if(right.legacysanctions[1].sanc_tin <> '' and left.taxids[1].taxid <> '' and right.legacysanctions[1].sanc_tin=left.taxids[1].taxid, true, false);
																														VerifyFEIN:=if(right.legacysanctions[1].sanc_tin <> '' and left.feins[1].fein <> '' and right.legacysanctions[1].sanc_tin=left.feins[1].fein, true, false);
																														self.acctno := if(VerifyBusinessName or VerifyLicense or VerifyTIN or VerifyFEIN,left.acctno,skip);
																														self.legacysanctions := right.legacysanctions;
																														self := left;),
																														keep(Healthcare_Header_Services.Constants.IDS_PER_DID), limit(0));
			linkedRecs := prefill+appendRecs;
			unlinkedRecs := join(recs,linkedRecs,left.acctno=right.acctno,transform(Healthcare_Header_Services.layouts.CombinedHeaderResults, self:=left),left only);
			final := linkedRecs+unlinkedRecs;
			// output(Recs,named('Recs'));
			// output(checklnpidkey,named('checklnpidkey'));
			// output(rawRecsLinking,named('rawRecsLinking'));
			// output(getLinkedSanctions,named('getLinkedSanctions'));
			// output(prefill,named('prefill'));
			// output(remainingRecs,named('remainingRecs'));
			// output(getSanc,named('getSanc'));
			// output(appendRecs,named('appendRecs'));
			// output(final,named('final'));
		return final;
	end;
end;