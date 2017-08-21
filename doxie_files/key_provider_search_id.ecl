import doxie, ingenix_natlprof;

file_in := ingenix_natlprof.Basefile_Provider_Did_keybuild;
dedup_prov_base := distribute(file_in, hash(providerid));

license_in := ingenix_natlprof.Basefile_ProviderLicense;
license_in_dep := distribute(license_in, hash(providerid));

//get provider id
pid_rec := record
     unsigned6 providerid;
end;

pid_rec get_pids(dedup_prov_base l) := transform
	self.providerid := (unsigned6)l.providerid;
end;

pids := project(dedup_prov_base, get_pids(left));
pids_srt := sort(pids, providerid, local);
pids_dep := dedup(pids_srt, providerid, local) : persist('per_pids_dep');

//get name
pid_name_rec := record
     unsigned6 providerid;
	doxie.ingenix_provider_module.ingenix_name_rec;
end;

pid_name_rec get_names(dedup_prov_base l) := transform
     self.providerid := (unsigned6)l.providerid;
	self.ProviderNameTierID := (unsigned2) l.ProviderNameTierID;
	self := l;
end;

f_names := project(dedup_prov_base, get_names(left));

f_names_srt := sort(f_names(Prov_Clean_fname<>'' or Prov_Clean_lname<>''), record, local);
f_names_dep := dedup(f_names_srt, record, except ProviderNameTierID, local);

//get address
pid_addr_rec := record
     unsigned6 providerid;
	doxie.ingenix_provider_module.ingenix_addr_rec;
	integer addr_date;
end;

pid_addr_rec get_addrs(dedup_prov_base l) := transform
     self.providerid := (unsigned6)l.providerid;
	self.ProviderAddressTierTypeID := (unsigned2) l.ProviderAddressTierTypeID;
	self.addr_date := (integer)l.dt_vendor_last_reported;
	self.phone := [];
	self := l;
end;

f_addrs := project(dedup_prov_base, get_addrs(left));

f_addrs_srt := sort(f_addrs(Prov_Clean_prim_name<>''), 
                              providerid,
						Prov_Clean_prim_range,
						Prov_Clean_prim_name,
						Prov_Clean_sec_range,
						Prov_Clean_zip,
						-addr_date, provideraddresstiertypeid, local);

f_addrs_dep_ready := dedup(f_addrs_srt, providerid,
                                  prov_clean_prim_range,
                                  prov_clean_prim_name,
						    Prov_Clean_sec_range,
						    prov_clean_zip,local);

f_addrs_dep_final := group(TOPN(group(f_addrs_dep_ready,providerid), 40,   /* was 80 */
				       -addr_date, provideraddresstiertypeid));
					 
f_addrs_dep := project(f_addrs_dep_final, transform({unsigned6 providerid;
	                                                doxie.ingenix_provider_module.ingenix_addr_rec},
										   self := left));					 

//get phone
pid_phone_rec := record
     unsigned6 providerid;
	doxie.ingenix_provider_module.ingenix_phone_rec;
end;

pid_phone_rec get_phones(dedup_prov_base l) := transform
     self.providerid := (unsigned6)l.providerid;
	self.PhoneNumberTierTypeID := (unsigned2) l.PhoneNumberTierTypeID;
	self := l;
end;

f_phones := project(dedup_prov_base, get_phones(left));

f_phones_srt1 := sort(f_phones(phonenumber<>''), record, local);
f_phones_dep := dedup(f_phones_srt1, record, except PhoneNumberTierTypeID, local);

f_phones_srt2 := sort(f_phones_dep,  providerid,
                                     Prov_Clean_prim_name,
							  Prov_Clean_st,
							  Prov_Clean_zip,
							  Prov_Clean_prim_range,
							  Prov_Clean_sec_range,
							  PhoneNumber,
							  -PhoneType, local);

f_phones_srt2 roll_phone_type(f_phones_srt2 l, f_phones_srt2 r) := transform
	self.PhoneType := trim(l.PhoneType) + ',' + 
	                  if(stringlib.StringFind(trim(l.PhoneType),'Office',1)>0,
				      stringlib.StringFindReplace(trim(r.PhoneType),'Office',''),
					 trim(r.PhoneType));
	self := l;
end;

f_phones_rol_ready := rollup(f_phones_srt2, roll_phone_type(left,right), 
                             record, except PhoneType, PhoneNumberTierTypeID, local);
					    
f_phones_rol_final := sort(f_phones_rol_ready, providerid, Prov_Clean_prim_name,
							            Prov_Clean_st, Prov_Clean_zip,
							            Prov_Clean_prim_range, Prov_Clean_sec_range, local);   
					 
f_phones_rol := group(TOPN(group(f_phones_rol_final, providerid, Prov_Clean_prim_name,
							                  Prov_Clean_st, Prov_Clean_zip,
							                  Prov_Clean_prim_range, Prov_Clean_sec_range), 10, 
			   	       PhoneNumberTierTypeID));


//append phones to address
f_addrs_dep app_phones(f_addrs_dep l,  f_phones_rol r) := transform
	self.phone := l.phone + dataset([{r.PhoneNumber,
							    r.PhoneType,
							    r.PhoneNumberTierTypeID}], 
							    doxie.ingenix_provider_module.ingenix_phone_slim_rec);
    self := l;						                     
end;

f_addrs_ready := denormalize(f_addrs_dep, f_phones_rol, 
                             left.providerid = right.providerid and
	                        left.Prov_Clean_prim_name = right.Prov_Clean_prim_name and
		                   left.Prov_Clean_st = right.Prov_Clean_st and
					    left.Prov_Clean_zip = right.Prov_Clean_zip and
	                        left.Prov_Clean_prim_range = right.Prov_Clean_prim_range and
		                   left.Prov_Clean_sec_range = right.Prov_Clean_sec_range,
				          app_phones(left, right), local);	

//get dob
pid_dob_rec := record
     unsigned6 providerid;
	doxie.ingenix_provider_module.ingenix_dob_rec;
end;

pid_dob_rec get_dobs(dedup_prov_base l) := transform
     self.providerid := (unsigned6)l.providerid;
	self.BirthDateTierTypeID := (unsigned2) l.BirthDateTierTypeID;
	self := l;
end;

f_dobs := project(dedup_prov_base, get_dobs(left));

f_dobs_srt := sort(f_dobs(BirthDate<>''), record, local);
f_dobs_dep := dedup(f_dobs_srt, record, except BirthDateTierTypeID, local);

//get license
pid_license_rec := record
     unsigned6 providerid;
	doxie.ingenix_provider_module.ingenix_license_rec;
end;

pid_license_rec get_licenses(license_in_dep l) := transform
     self.providerid := (unsigned6)l.providerid;
	self.LicenseNumberTierTypeID := (unsigned2) l.LicenseNumberTierTypeID;
	self := l;
end;

f_licenses := join(pids_dep, license_in_dep, 
                   left.providerid = (unsigned6)right.providerid,
			    get_licenses(right), local);

f_licenses_srt := sort(f_licenses(LicenseNumber<>'' or LicenseState<>''), record, local);
f_licenses_dep := dedup(f_licenses_srt, record, except LicenseNumberTierTypeID, local);

//get taxid
pid_taxid_rec := record
     unsigned6 providerid;
	doxie.ingenix_provider_module.ingenix_taxid_rec;
end;

pid_taxid_rec get_taxids(dedup_prov_base l) := transform
     self.providerid := (unsigned6)l.providerid;
	self.TaxIDTierTypeID := (unsigned2) l.TaxIDTierTypeID;
	self := l;
end;

f_taxids := project(dedup_prov_base, get_taxids(left));

f_taxids_srt := sort(f_taxids(TaxID<>''), record, local);
f_taxids_dep := dedup(f_taxids_srt, record, except TaxIDTierTypeID, local);

//initialize the out records
out_rec := doxie.ingenix_provider_module.layout_ingenix_provider_search;

out_rec init_out(pids_dep l) := transform
	self.ProviderID := (string10)l.providerid;
	self.name := [];
     self.address := [];
	self.dob := [];
	self.license := [];
	self.taxid := [];
end;

out_init := project(pids_dep, init_out(left));

//append name to output
out_rec app_names(out_init l,  f_names_dep r) := transform
	self.name := l.name + dataset([{r.Prov_Clean_fname,
							  r.Prov_Clean_mname,
							  r.Prov_Clean_lname,
							  r.Prov_Clean_name_suffix,
							  r.ProviderNameTierID}], 
							  doxie.ingenix_provider_module.ingenix_name_rec);
    self := l;						                     
end;

out_with_names := denormalize(out_init, f_names_dep, 
	                        (unsigned6) left.ProviderID = right.ProviderID,
			              app_names(left, right), local);	


//append address to output
out_rec app_addrs(out_with_names l,  f_addrs_ready r) := transform
	self.address := l.address + dataset([{r.Prov_Clean_prim_range,
								   r.Prov_Clean_predir,
								   r.Prov_Clean_prim_name,
								   r.Prov_Clean_addr_suffix,
								   r.Prov_Clean_postdir,
								   r.Prov_Clean_unit_desig,
								   r.Prov_Clean_sec_range,
								   r.Prov_Clean_p_city_name,
								   r.Prov_Clean_v_city_name,
								   r.Prov_Clean_st,
								   r.Prov_Clean_zip,
								   r.Prov_Clean_zip4,
								   r.ProviderAddressTierTypeID,
								   r.phone}], 
								   doxie.ingenix_provider_module.ingenix_addr_rec);
    self := l;						                     
end;

out_with_addrs := denormalize(out_with_names, f_addrs_ready, 
	                         (unsigned6) left.ProviderID = right.ProviderID,
		 		          app_addrs(left, right), local);	
				    
//append dobs to output
out_rec app_dobs(out_with_addrs l,  f_dobs_dep r) := transform
	self.dob := l.dob + dataset([{r.BirthDate,
		                         r.BirthDateTierTypeID}], 
							doxie.ingenix_provider_module.ingenix_dob_rec);
    self := l;						                     
end;

out_with_dobs := denormalize(out_with_addrs, f_dobs_dep, 
	                        (unsigned6) left.ProviderID = right.ProviderID,
				         app_dobs(left, right), local);
						
//append licenses to output
out_rec app_licenses(out_with_dobs l, f_licenses_dep r) := transform
	self.license := l.license + dataset([{r.LicenseState,
								   r.LicenseNumber,
								   r.LicenseNumberTierTypeID}], 
							        doxie.ingenix_provider_module.ingenix_license_rec);
    self := l;						                     
end;

out_with_licenses := denormalize(out_with_dobs, f_licenses_dep, 
	                            (unsigned6) left.ProviderID = right.ProviderID,
				             app_licenses(left, right), local);

//append taxids to output
out_rec app_taxids(out_with_licenses l, f_taxids_dep r) := transform
	self.taxid := l.taxid + dataset([{r.TaxID;
		                             r.TaxIDTierTypeID}], 
							    doxie.ingenix_provider_module.ingenix_taxid_rec);
    self := l;						                     
end;

out_with_taxids := denormalize(out_with_licenses, f_taxids_dep, 
 	                          (unsigned6) left.ProviderID = right.ProviderID,
				           app_taxids(left, right), local) : persist('per_out_with_taxids');
						 
export key_provider_search_id := index(out_with_taxids, 
                                          {unsigned6 l_providerid := (unsigned6)providerid},
						            {out_with_taxids},
				                      '~thor_data400::key::ing_provider_search_id_' + doxie.Version_SuperKey);