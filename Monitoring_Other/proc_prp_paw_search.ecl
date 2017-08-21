import doxie, monitoring_other, monitoring, watchdog, header, ln_propertyv2, ut, paw, address, gong;

//should be changed to true for property and people at work control fields
f_base_in := monitoring_other.file_customer_base(customer_id in ['PRA'/*,'WAM','WAM2'*/] or 
                                                 phone_level_other1=true or 
																								 phone_level_other2=true);
																					
//join to get the best information
f_best_raw := dataset(ut.foreign_prod + 'thor_data400::BASE::Watchdog_Best',watchdog.Layout_Best,thor);
f_best_slim := project(f_best_raw, monitoring_other.layout_did_deed_paw) : persist('per_f_best_slim');
// f_best_slim := dataset ('~production_watch_thor::per_f_best_slim', monitoring_other.layout_did_deed_paw, THOR);

f_deed := project(dataset(ut.foreign_prod + 'thor_data400::base::ln_propertyv2::Deed',
                          LN_PropertyV2.layout_deed_mortgage_common_model_base,flat), 
                  monitoring_other.layout_slim_deed) : persist('per_f_deed');
// f_deed := dataset ('~production_watch_thor::per_f_deed', monitoring_other.layout_slim_deed, THOR);
									
f_prp_did := monitoring_other.key_prp_did;
             //project(ln_propertyV2.File_search_building((unsigned)did > 0, ln_fares_id[1..2] in ['OA', 'RA', 'DA']),
             //        monitoring_other.layout_slim_property_did) : persist('per_f_prp_did');
f_aser := project(dataset(ut.foreign_prod + 'thor_data400::base::ln_propertyv2::Assesor',
                  LN_PropertyV2.layout_property_common_model_base,flat)(fares_unformatted_apn<>''), 
                  monitoring_other.layout_slim_assessment);
f_aser_dst := distribute(f_aser, hash(ln_fares_id, fares_unformatted_apn)) : persist('per_f_aser_dst');
// f_aser_dst := dataset ('~production_watch_thor::per_f_aser_dst', monitoring_other.layout_slim_assessment, THOR);
f_fares_aser_key := monitoring_other.key_fares_aser;

f_paw_in := dataset(ut.foreign_prod + 'thor_data400::base::paw::built::data', 
                    layout_paw_in, thor);

f_paw := f_paw_in(did<>0, bdid<>0, score>'003');

//normalize, only keep multiple dids with a ssn to verify
monitoring_other.layout_base_slim norm_in(f_base_in l, doxie.layout_references r) := transform
			 self.did_count := if(count(l.dids)>1 and l.ssn='', skip, count(l.dids));
			 self.in_ssn := l.ssn;
			 self.monitoring_prp := l.phone_level_other1;
			 self.monitoring_paw := l.phone_level_other2;
			 self.did := r.did;
			 self := l;
end;

f_base_slim := normalize(f_base_in, left.dids, norm_in(left, right)) : persist('per_f_base_slim');

monitoring_other.layout_base_slim_best get_best(f_base_slim l, f_best_slim r) := transform
		self := l;
		self := r;
end;

f_with_best := join(f_base_slim, f_best_slim, 
                    left.did = right.did,
										get_best(left, right), hash, keep(1)) : persist('per_f_with_best');

f_with_best_refined := f_with_best(did_count=1 or header.ssn_value(in_ssn, ssn)>=0 and ssn<>'');

f_prp_update := project(f_with_best_refined(customer_id in ['PRA'] or monitoring_prp, prpty_deed_id<>''), 
                        transform(monitoring_other.layout_prp_slim, self := left, self := []));

f_paw_update := project(f_with_best_refined(customer_id in ['PRA'/*,'WAM','WAM2'*/] or monitoring_paw), 
                        transform(monitoring_other.layout_paw_slim, self:=left));
												
f_gong_in := dataset(ut.foreign_prod + 'thor_data400::base::gong',Gong.layout_gong,flat);

gong.Layout_bscurrent_raw trecs(f_gong_in L) := transform
self.phone10 := L.phoneno;
self.listed_name := L.company_name;
self := L;
end;
											
f_bus_phone_raw := project(f_gong_in,trecs(left))(listing_type_bus<>'', 
                                                  publish_code = 'P',
                                                  (unsigned)phone10<>0);

bus_phone_raw_rec := record
	f_bus_phone_raw.phone10;
	f_bus_phone_raw.listed_name;
	phone_date := f_bus_phone_raw.filedate[1..8];
end;
												
f_bus_phone_slim := sort(table(f_bus_phone_raw, bus_phone_raw_rec), phone10, -phone_date);												

f_bus_phone := dedup(f_bus_phone_slim, phone10) : persist('per_f_bus_phone'); 
// f_bus_phone := dataset ('~production_watch_thor::per_f_bus_phone', bus_phone_raw_rec, thor);

monitoring_other.layout_prp_out get_prp_out1(f_prp_update l, f_deed r) := transform
			self.customer_id := l.customer_id;
      self.record_id := l.record_id;   
			self.did := l.did;
			self.ln_prp_deed := r.ln_fares_id;
			self.parcel_number_1 := r.fares_unformatted_apn;                                                 
			self.name_owner_1_1 := r.name1;                                                  
			self.name_owner_2_1 := r.name2;                                                  
			self.prop_address_1 := trim(r.property_full_street_address) + ' ' + trim(r.property_address_unit_number);                                                  
			self.prop_city_state_zip_1 := r.property_address_citystatezip;                                                     
		  self.sale_price_1 := r.sales_price;                                                    
			self.name_seller_1 := r.seller1;      
			self.first_td_loan_amount_1 := r.first_td_loan_amount;        
      self.second_td_loan_amount_1 := r.second_td_loan_amount;  
			self := [];
end;

f_prp_out1 := join(f_prp_update, f_deed,
                   left.prpty_deed_id[3..] = right.ln_fares_id,
						 			 get_prp_out1(left, right), left outer, keep(1), hash) : persist('per_f_prp_out1');			
								
f_prp_out1_dep := dedup(sort(f_prp_out1, customer_id, record_id, did, ln_prp_deed), 
                        customer_id, record_id, did, ln_prp_deed);										

monitoring_other.layout_prp_out clean_deed_addr(f_prp_out1_dep l) := transform
	    clean_addr := address.CleanAddress182(l.prop_address_1, l.prop_city_state_zip_1);
			self.prim_range_d := clean_addr[1..10];
      self.predir_d := clean_addr[11..12];
      self.prim_name_d := clean_addr[13..40];
      self.suffix_d := clean_addr[41..44];
      self.postdir_d := clean_addr[45..46];
      self.unit_desig_d := clean_addr[47..56];
      self.sec_range_d := clean_addr[57..64];
      self.p_city_name_d := clean_addr[65..89];
      self.st_d := clean_addr[115..116];
      self.zip_d := clean_addr[117..121];
      self.zip4_d := clean_addr[122..125];
			self := l;
end;

f_prp_out1_cln := project(f_prp_out1_dep, clean_deed_addr(left))(prim_name_d<>'') : persist('per_f_prp_out1_cln');

//check against the history
monitoring_other.layout_prp_out get_slim_prp(f_prp_out1_cln l) := transform
   	 self := l;
end;

f_prp_out_raw := join(f_prp_out1_cln, monitoring_other.file_prp_history,
                      left.customer_id = right.customer_id and 
									    left.record_id = right.record_id and
									    left.prim_range_d = right.prim_range_d and 
									    left.prim_name_d = right.prim_name_d and
									    left.zip_d = right.zip_d,
									    get_slim_prp(left), left only, hash);

//join with did file to get assessment fare id
monitoring_other.layout_prp_out get_prp_out2(f_prp_out_raw l, f_prp_did r) := transform
		  self.ln_prp_aser := if(r.ln_fares_id[1..2] in ['OA', 'RA', 'DA'], r.ln_fares_id, '');
			self := l;
			self := [];
end;

f_prp_out2 := join(f_prp_out_raw, f_prp_did,
                   left.did = right.s_did and
									 left.prim_range_d = right.prim_range and 
									 left.prim_name_d = right.prim_name and
									 left.zip_d = right.zip and
									 ut.NNEQ(left.sec_range_d, right.sec_range),
						 			 get_prp_out2(left, right), left outer, limit(1000, skip), hash) : persist('per_f_prp_out2');								 
						
f_prp_out2_dep := dedup(sort(f_prp_out2, customer_id, record_id, did, ln_prp_deed, ln_prp_aser), 
                        customer_id, record_id, did, ln_prp_deed, ln_prp_aser);
												
f_prp_out2_dep_dst := distribute(f_prp_out2_dep, hash(ln_prp_aser, parcel_number_1));												

monitoring_other.layout_prp_out get_prp_out3(f_prp_out2_dep_dst l, f_aser_dst r) := transform
      //clean the address to check if agrees with 
	    clean_addr := address.CleanAddress182(r.property_full_street_address + ' ' + r.property_unit_number, 
			                                           r.property_city_state_zip);
			prim_range_a := clean_addr[1..10];
      prim_name_a := clean_addr[13..40];
      sec_range_a := clean_addr[57..64];
      zip_a := clean_addr[117..121];
      
			is_same_addr := l.prim_range_d = prim_range_a and 
									    l.prim_name_d = prim_name_a and
						 			    l.zip_d = zip_a and
									    ut.NNEQ(l.sec_range_d, sec_range_a);
			 
			self.addr_agree := is_same_addr;
	    self.sale_date_1 := if(is_same_addr, if(is_same_addr, r.sale_date, ''), '');   
			self.sale_price_1 := if(is_same_addr, if(l.sale_price_1<>'', l.sale_price_1, r.sales_price), '');
	    self.mortgage_amount_1 := if(is_same_addr, r.mortgage_loan_amount, '');
			self.assessed_land_value_1 := if(is_same_addr, r.assessed_land_value, '');
			self.assessed_improvement_value_1 := if(is_same_addr, r.assessed_improvement_value, ''); 
	    self.assessed_total_value_1 := if(is_same_addr, r.assessed_total_value, '');                                                
			self.assessed_value_year := if(is_same_addr, r.assessed_value_year, '');
			self.tax_year := if(is_same_addr, r.tax_year, '');
			
			self.market_land_value_1 := if(is_same_addr, r.market_land_value, '');
			self.market_improvement_value_1 := if(is_same_addr, r.market_improvement_value, '');
			self.market_total_value_1 := if(is_same_addr, r.market_total_value, '');
		  self.market_value_year := if(is_same_addr, r.market_value_year, '');       
			
			self.legal_description_1 := if(is_same_addr, r.legal_brief_description, ''); 
			
	    self.property_full_street_address_aser := if(is_same_addr, r.property_full_street_address, '');
      self.property_unit_number_aser := if(is_same_addr, r.property_unit_number, '');
      self.property_city_state_zip_aser := if(is_same_addr, r.property_city_state_zip, '');  
				
			self := l;
end;

f_prp_out3 := join(f_prp_out2_dep_dst, f_aser_dst,
                   left.ln_prp_aser = right.ln_fares_id and 
                   left.parcel_number_1 = right.fares_unformatted_apn,
						 			 get_prp_out3(left, right), left outer, local) : persist('per_f_prp_out3');
// f_prp_out3 := dataset ('~production_watch_thor::per_f_prp_out3', monitoring_other.layout_prp_out, thor);
							 					 
f_prp_out3_dep := dedup(sort(f_prp_out3, customer_id, record_id, ln_prp_deed, -addr_agree, -tax_year, -assessed_value_year),
                        customer_id, record_id, ln_prp_deed);
																								
																								
monitoring_other.layout_prp_out get_tot_val(f_prp_out3_dep l, f_fares_aser_key r) := transform
		  self.fares_calculated_total_value := r.fares_calculated_total_value;
	    self := l;			
end;

f_prp_out4 := join(f_prp_out3_dep, f_fares_aser_key,
                   keyed(left.ln_prp_aser=right.ln_fares_id),
							     get_tot_val(left, right), left outer, keep(1));
					
// --- start of getting paw file 
monitoring_other.layout_paw_out get_paw_out_raw(f_paw_update l, f_paw r) := transform                                                                                              
	self.pawk_first_1 := l.name_first;                                                   
	self.pawk_middle_1 := l.name_middle;                                                  
	self.pawk_last_1 := l.name_last;                                                    
	self.pawk_suffix_1 := l.name_suffix;                                                  
	self.pawk_ssn_1 := l.in_ssn;      
	self.bdid := r.bdid;
	self.pawk_title_1 := r.company_title;                                                    
	self.pawk_name_company_1 := r.company_name;                                             
	self.pawk_department_1 := r.company_department;                                               
	self.pawk_fein_1 := r.company_fein;                                                     
	self.pawk_address_1 := address.Addr1FromComponents(r.company_prim_range, 
	                                                   r.company_predir, 
																										 r.company_prim_name,
                                                     r.company_addr_suffix, 
																										 r.company_postdir, 
																										 r.company_unit_desig, 
																										 r.company_sec_range);                                                  
	self.pawk_city_1 := r.company_city;                                                     
	self.pawk_state_1 := r.company_state;                                                    
	self.pawk_zip_1 := r.company_zip;                                                      
	self.pawk_zip4_1 := r.company_zip4;                                                     
	self.pawk_phone10_1 := r.company_phone;                                                  
	self.pawk_verified_1 := '';
	self.pawk_email_1 := r.email_address;                                                    
	self.pawk_first_seen_1 := r.dt_first_seen;                                               
	self.pawk_last_seen_1 := r.dt_last_seen;                                                
	self.pawk_confidence_level_1 := map((unsigned)r.score >= 6 => '1',
                                      '2'); 
	self := l;
end;

f_paw_out_raw := join(f_paw_update, f_paw, 
                      left.did = right.did,
							  			get_paw_out_raw(left, right), hash) : persist('per_f_paw_out_raw');
// f_paw_out_raw := dataset ('~production_watch_thor::per_f_paw_out_raw', monitoring_other.layout_paw_out, THOR);

// Need to apply general date filter for not returning wittingly rediculous results
boolean IsValidDate (string8 dt) := (integer) (dt [1..4]) > 1999;

f_paw_out_flt := f_paw_out_raw((unsigned)pawk_confidence_level_1<3, IsValidDate (pawk_last_seen_1));											
											
//dedup by bdid											
f_paw_out_dep1 := dedup(sort(f_paw_out_flt, customer_id, record_id, bdid, -pawk_last_seen_1, -pawk_first_seen_1), 
                       customer_id, record_id, bdid);
											 
//dedup by company name											 
f_paw_out_dep2 := dedup(sort(f_paw_out_dep1, customer_id, record_id, pawk_name_company_1, -pawk_last_seen_1, -pawk_first_seen_1), 
                       customer_id, record_id, pawk_name_company_1);	

//general dedup by account, keeping 3, since batch returns 3 latest (must be in sync!)
f_paw_out_dep3 := dedup(sort(f_paw_out_dep2, customer_id, record_id, -pawk_last_seen_1, -pawk_first_seen_1), 
                       customer_id, record_id, keep (3));

monitoring_other.layout_paw_out get_verified_flag(f_paw_out_dep3 l, f_bus_phone r) := transform
	self.pawk_verified_1 := if(r.phone10<>'' and ut.CompanySimilar100(l.pawk_name_company_1,r.listed_name) < 10, 'Y', 'N');
	self := l;
end;

f_paw_out_verified := join(f_paw_out_dep3, f_bus_phone,
                           left.pawk_phone10_1=right.phone10,
													 get_verified_flag(left, right), left outer, keep(1), hash);
													
monitoring_other.layout_paw_out get_slim_paw(f_paw_out_verified l) := transform
	self := l;
end; 				 									
													
//dedup against history
f_paw_out := join(f_paw_out_verified, monitoring_other.file_paw_history,
                  left.customer_id = right.customer_id and       
                  left.record_id = right.record_id and
									left.pawk_name_company_1 = right.pawk_name_company_1,
									get_slim_paw(left), left only, hash);													 

create_prp_out := sequential(output(f_prp_out4,,'~thor_data400::base::monitoring_property_out' + thorlib.wuid()),
					                   fileservices.ClearSuperFile('~thor_data400::base::monitoring_property_out'),
							               fileservices.AddSuperFile('~thor_data400::base::monitoring_property_out',
							                                         '~thor_data400::base::monitoring_property_out' + thorlib.wuid()));																								 

create_paw_out := sequential(output(f_paw_out,,'~thor_data400::base::monitoring_paw_out' + thorlib.wuid()),
					                   fileservices.ClearSuperFile('~thor_data400::base::monitoring_paw_out'),
							               fileservices.AddSuperFile('~thor_data400::base::monitoring_paw_out',
							                                         '~thor_data400::base::monitoring_paw_out' + thorlib.wuid()));																								 

export proc_prp_paw_search := sequential(create_prp_out, create_paw_out);
