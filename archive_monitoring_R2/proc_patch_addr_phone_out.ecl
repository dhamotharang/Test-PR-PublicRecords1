import monitoring, ut;

f_raw := monitoring.files.nco.Raw;
f_addr_out := monitoring.File_Address_Out;
f_phone_out := monitoring.File_Phone_Out;
f_addr_hist := monitoring.File_Address_History;

f_bad_recs := f_raw(location_code = '', 
                    customer_id in ['NCO_N06002',
																		'NCO_N06010',
																		'NCO_N06099',
																		'NCO_N07003',
																		'NCO_N07012',
																		'NCO_N07013',
																		'NCO_N07016',
																		'NCO_N07017',
																		'NCO_N07018',
																		'NCO_N07019',
																		'NCO_N07022',
																		'NCO_N07064',
																		'NCO_N07066',
																		'NCO_N09023',
																		'NCO_N09061',
																		'NCO_U15007',
																		'NCO_U15009',
																		'NCO_U15011',
																		'NCO_U15015',
																		'NCO_U15027',
																		'NCO_U15072',
																		'NCO_U15081',
																		'NCO_U24005',
																		'NCO_N07093']);
															 								 															 															 
f_addr_out remove_bad_for_addr(f_addr_out l) := transform
	self := l;
end;

f_addr_out_no_bad := join(f_addr_out, f_bad_recs,
                         left.customer_id = right.customer_id and 
												 left.record_id = right.record_id,
		   	                 remove_bad_for_addr(left), left only, hash);
										 
f_addr_no_special := f_addr_out_no_bad((customer_id not in monitoring.special_treat_set) and customer_id[1..3]<>'NCO');
f_addr_special := f_addr_out_no_bad((customer_id in monitoring.special_treat_set) or customer_id[1..3]='NCO');												 

f_addr_special_dep := dedup(sort(f_addr_special, customer_id, record_id, best_address_count),
                            customer_id, record_id)(best_address_count=1);												 

f_addr_hist_special := f_addr_hist((customer_id in monitoring.special_treat_set) or customer_id[1..3]='NCO');
f_addr_hist_special_dep := dedup(sort(f_addr_hist_special, customer_id, record_id, -addr_dt_last_seen),
                                 customer_id, record_id);
																 
f_addr_special_dep filter_addr_special(f_addr_special_dep l, f_addr_hist_special_dep r) := transform
    self.customer_id := if(((unsigned)r.addr_dt_last_seen > 0) and  
													 ((unsigned)l.addr_dt_last_seen <= (unsigned)r.addr_dt_last_seen), skip, l.customer_id);
		self := l;
end;
														
f_addr_special_flt := join(f_addr_special_dep, f_addr_hist_special_dep,
                           left.customer_id = right.customer_id and 
			 										 left.record_id = right.record_id,
													 filter_addr_special(left, right), left outer, hash) : persist('per_f_addr_special_flt');

f_addr_both := f_addr_no_special + f_addr_special_flt;
													 
create_addr_out_no_bad := 	
           sequential(output(sort(f_addr_both, customer_id, record_id, best_address_count),,
                             '~thor_data400::base::monitoring_address_out_patched' + thorlib.wuid()),
					 fileservices.ClearSuperFile('~thor_data400::base::monitoring_address_out'),
					 fileservices.AddSuperFile('~thor_data400::base::monitoring_address_out',
							                 '~thor_data400::base::monitoring_address_out_patched' + thorlib.wuid()));				  
												 
f_phone_out remove_bad_for_phone(f_phone_out l) := transform
	self := l;
end;				 
				 
f_phone_out_no_bad := join(f_phone_out, f_bad_recs,
                           left.customer_id = right.customer_id and 
													 left.record_id = right.record_id,			   
			                     remove_bad_for_phone(left), left only,  hash);
                      											
f_phone_no_special := f_phone_out_no_bad(customer_id not in monitoring.special_treat_set);
f_phone_special := f_phone_out_no_bad(customer_id in monitoring.special_treat_set);												 

f_phone_special filter_phone_special(f_phone_special l) := transform
	self := l;
end;										
						
f_phone_special_flt := join(f_phone_special, f_addr_special_flt,
                            left.customer_id = right.customer_id and 
														left.record_id = right.record_id and
														left.prim_name=right.prim_name and
		                        left.prim_range=right.prim_range and 
													  left.z5 = right.z5, filter_phone_special(left), keep(1), hash);						

f_phone_both := f_phone_no_special + f_phone_special_flt;			 
				
create_phone_out_no_bad := 	
           sequential(output(sort(f_phone_both,customer_id, record_id, best_phone_count),,
                             '~thor_data400::base::monitoring_phone_out_patched' + thorlib.wuid()),
					 fileservices.ClearSuperFile('~thor_data400::base::monitoring_phone_out'),
					 fileservices.AddSuperFile('~thor_data400::base::monitoring_phone_out',
					                           '~thor_data400::base::monitoring_phone_out_patched' + thorlib.wuid()));				  											 

export proc_patch_addr_phone_out := sequential(monitoring.proc_apply_freq_delay,
                                               create_addr_out_no_bad, 
																							 create_phone_out_no_bad);