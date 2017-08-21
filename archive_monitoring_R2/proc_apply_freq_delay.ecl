import doxie, monitoring, ut;

f_in := monitoring.files.monitor;
f_base := monitoring.file_customer_base;
f_addr_out := monitoring.file_address_out;
f_addr_reserve := monitoring.file_address_reserve;
f_phone_out := monitoring.file_phone_Out;
f_phone_reserve := monitoring.file_phone_reserve;

base_slim_rec := record
		string10  customer_id;       
		string30  record_id;
		dataset(doxie.layout_references) dids;
end;

f_base_slim := distribute(project(f_base, base_slim_rec), hash(customer_id, record_id));
f_base_dep := dedup(sort(f_base_slim, customer_id, record_id, local), customer_id, record_id, local);

freq_delay_rec := record
	  string10  customer_id;
    string30  record_id;
		unsigned1 best_address_number;
		string8   date_in;
		unsigned2 addr_delay_days;
		boolean   addr_delay_tr_flag;
		unsigned2 addr_freq_days;
		boolean   addr_freq_tr_flag;
		boolean   addr_needed_flag;
		unsigned2 phone_delay_days;
		boolean   phone_delay_tr_flag;
		unsigned2 phone_freq_days;
		boolean   phone_freq_tr_flag;
		boolean   phone_needed_flag;
		unsigned6 did1;
		unsigned6 did2;
		unsigned6 did3;
end;

cal_days(string1 in_type, unsigned2 in_time) := function
	return map(in_type='M' => in_time*30,
	           in_type='W' => in_time*7,
						 in_type='D' => in_time,
						 in_time);
end;

freq_delay_rec get_freq_delay(f_in l) := transform
    subj := Constants.T_SUBJECT;
		m_address := l.matrix (subject = subj.ADDRESS);
		m_phone := l.matrix (subject = subj.PHONE);
	  self.customer_id := l.customer_id;
    self.record_id := l.record_id;
 	  self.best_address_number := if (exists (m_address), m_address[1].best_number, 0);
		self.date_in := l.wuid[2..9];
		//5,2 should be replaced with the real delay value
		self.addr_delay_days := cal_days(l.matrix (subject = subj.ADDRESS)[1].delay_type,
		                                 l.matrix (subject = subj.ADDRESS)[1].delay_time);
		self.addr_delay_tr_flag := if(ut.DaysApart(ut.GetDate,l.wuid[2..9])>=self.addr_delay_days, true, false);
		self.addr_freq_days := cal_days(l.matrix (subject = subj.ADDRESS)[1].frequency_type,
		                                l.matrix (subject = subj.ADDRESS)[1].frequency_time);		
		self.addr_freq_tr_flag := true; //if(abs(ut.daysApart(ut.GetDate,l.wuid[2..9])-self.addr_delay_days)%self.addr_freq_days=0, true, false);
		self.addr_needed_flag := exists (m_address);
		self.phone_delay_days := cal_days(l.matrix (subject = subj.PHONE)[1].delay_type,
		                                  l.matrix (subject = subj.PHONE)[1].delay_time);
		self.phone_delay_tr_flag := if(ut.DaysApart(ut.GetDate,l.wuid[2..9])>=self.phone_delay_days, true, false);
		self.phone_freq_days := cal_days(l.matrix (subject = subj.PHONE)[1].frequency_type,
		                                l.matrix (subject = subj.PHONE)[1].frequency_time);
		self.phone_freq_tr_flag := true; //if(abs(ut.daysApart(ut.GetDate,l.wuid[2..9])-self.phone_delay_days)%self.phone_freq_days=0, true, false);
		self.phone_needed_flag := exists (m_phone); 
		self := [];
end;

f_freq_delay := distribute(project(f_in, get_freq_delay(left)), hash(customer_id, record_id));
f_freq_delay_dep := dedup(sort(f_freq_delay, customer_id, record_id, local), customer_id, record_id, local);

freq_delay_rec get_three_did(f_freq_delay_dep l, f_base_dep r) := transform
		self.did1 := r.dids[1].did;
		self.did2 := r.dids[2].did;
		self.did3 := r.dids[3].did;
		self := l;
end;

f_freq_delay_w_dids := join(f_freq_delay_dep, f_base_dep,
                            left.customer_id = right.customer_id and 
														left.record_id = right.record_id,
														get_three_did(left, right), local) : persist('perf_freq_delay_w_dids');

//apply filter 
f_ids_addr_tr := f_freq_delay_w_dids(addr_delay_tr_flag and addr_freq_tr_flag);
f_ids_addr_ts := f_freq_delay_w_dids(addr_delay_tr_flag=false or addr_freq_tr_flag=false);
f_addr_out_all := f_addr_out + f_addr_reserve;

out_ext_rec := record
	monitoring.layout_address_update;
	unsigned1 best_address_number;
	boolean good_acct_flag := true;
	boolean addr_needed_flag := true;
end;	

out_ext_rec get_addr(f_addr_out_all l, f_ids_addr_tr r) := transform
  self.best_address_number := r.best_address_number;
	self.good_acct_flag := if(l.did in [r.did1, r.did2, r.did3], true, false); 
	self.addr_needed_flag := r.addr_needed_flag;
	self := l;
end;

f_addr_to_save := join(f_addr_out_all, f_ids_addr_ts,
                       left.customer_id = right.customer_id and 
							  			 left.record_id = right.record_id,
											 get_addr(left, right), hash) : persist('per_f_addr_to_save');

f_addr_to_save_final := project(f_addr_to_save(good_acct_flag=true, addr_needed_flag=true), monitoring.layout_address_update);

create_addr_to_save := 
       sequential(output(sort(f_addr_to_save_final, customer_id, record_id, best_address_count),,
                        '~thor_data400::base::monitoring_address_reserve' + thorlib.wuid()),
	       				  fileservices.ClearSuperFile('~thor_data400::base::monitoring_address_reserve'),
					        fileservices.AddSuperFile('~thor_data400::base::monitoring_address_reserve',
							                              '~thor_data400::base::monitoring_address_reserve' + thorlib.wuid()));				  


f_addr_to_return1 := join(f_addr_out_all, f_ids_addr_tr,
                          left.customer_id = right.customer_id and 
									 			  left.record_id = right.record_id,
												  get_addr(left, right), hash) : persist('per_f_addr_to_return1');

f_addr_to_return2 := dedup(sort(f_addr_to_return1(good_acct_flag=true, addr_needed_flag=true), customer_id, record_id, 
                                prim_name, prim_range, z5, -sec_range, -addr_dt_last_seen, -addr_dt_first_seen),
													 customer_id, record_id, prim_name, prim_range, z5);
													 
f_addr_to_return3 := group(sort(f_addr_to_return2, customer_id, 
                                                   record_id, 
                                                   -addr_dt_last_seen, 
                                                   -addr_dt_first_seen, 
																									 -addr_version_number),
                           customer_id, record_id);
									
out_ext_rec get_addr_rank(f_addr_to_return3 l, f_addr_to_return3 r, unsigned4 cnt) := transform
	self.best_address_count := cnt;
	self := r;
end;									
									 
f_addr_to_return4 := iterate(f_addr_to_return3, get_addr_rank(left, right, counter));
f_addr_to_return5 := f_addr_to_return4(best_address_count<=best_address_number);

f_addr_to_return_final := project(f_addr_to_return5, monitoring.layout_address_update);

create_addr_to_return := 
       sequential(output(sort(f_addr_to_return_final, customer_id, record_id, best_address_count),,
                        '~thor_data400::base::monitoring_address_out_cfd' + thorlib.wuid()),
	       				  fileservices.ClearSuperFile('~thor_data400::base::monitoring_address_out'),
					        fileservices.AddSuperFile('~thor_data400::base::monitoring_address_out',
							                              '~thor_data400::base::monitoring_address_out_cfd' + thorlib.wuid()));				  
						
f_ids_phone_tr := f_freq_delay_w_dids(phone_needed_flag and phone_delay_tr_flag and phone_freq_tr_flag);
f_ids_phone_ts := f_freq_delay_w_dids(phone_needed_flag and (phone_delay_tr_flag=false or phone_freq_tr_flag=false));
f_phone_out_all_ready := f_phone_out + f_phone_reserve;

f_bad_acct := dedup(sort(f_addr_to_save(good_acct_flag=false) + f_addr_to_return1(good_acct_flag=false),
                         customer_id, record_id), customer_id, record_id);
												 
layout_phone_out get_phone_out_all(f_phone_out_all_ready l) := transform
	self := l;
end;				

f_phone_out_all := join(f_phone_out_all_ready, f_bad_acct,
                        left.customer_id = right.customer_id and
												left.record_id = right.record_id,
												get_phone_out_all(left), left only, hash);

layout_phone_out get_phone(f_phone_out_all l) := transform
	self := l;
end;

f_phone_to_save := join(f_phone_out_all, f_ids_phone_ts,
                       left.customer_id = right.customer_id and 
							  			 left.record_id = right.record_id,
											 get_phone(left), hash);

create_phone_to_save := 
       sequential(output(sort(f_phone_to_save, customer_id, record_id, best_phone_count),,
                        '~thor_data400::base::monitoring_phone_reserve' + thorlib.wuid()),
	       				  fileservices.ClearSuperFile('~thor_data400::base::monitoring_phone_reserve'),
					        fileservices.AddSuperFile('~thor_data400::base::monitoring_phone_reserve',
							                              '~thor_data400::base::monitoring_phone_reserve' + thorlib.wuid()));				  

f_phone_to_return1 := join(f_phone_out_all, f_ids_phone_tr,
                           left.customer_id = right.customer_id and 
				 					 			   left.record_id = right.record_id,
												   get_phone(left), hash) : persist('per_f_phone_to_return1');

f_phone_to_return2 := dedup(sort(f_phone_to_return1, customer_id, record_id, 
                                 phone10, -phone_dt_last_seen, -phone_dt_first_seen),
				 									  customer_id, record_id, phone10);
													 
f_phone_to_return3 := group(sort(f_phone_to_return2, customer_id, 
                                                     record_id, 
                                                     -phone_dt_last_seen, 
                                                     -phone_dt_first_seen, 
																					 				   -phone_version_number),
                            customer_id, record_id);
									
layout_phone_out get_phone_rank(f_phone_to_return3 l, f_phone_to_return3 r, unsigned4 cnt) := transform
	self.best_phone_count := cnt;
	self := r;
end;									
									 
f_phone_to_return4 := iterate(f_phone_to_return3, get_phone_rank(left, right, counter));
f_phone_to_return_final := f_phone_to_return4(best_phone_count<=best_phone_number);

create_phone_to_return := 
       sequential(output(sort(f_phone_to_return_final, customer_id, record_id, best_phone_count),,
                        '~thor_data400::base::monitoring_phone_out_cfd' + thorlib.wuid()),
	       				  fileservices.ClearSuperFile('~thor_data400::base::monitoring_phone_out'),
					        fileservices.AddSuperFile('~thor_data400::base::monitoring_phone_out',
							                              '~thor_data400::base::monitoring_phone_out_cfd' + thorlib.wuid()));				  
															
export proc_apply_freq_delay := parallel(create_addr_to_save, create_addr_to_return,
                                         create_phone_to_save, create_phone_to_return);
