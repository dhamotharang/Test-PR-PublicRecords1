import cellphone, doxie, gong, header, phonesplus, monitoring, standard, ut, watchdog, risk_indicators, progressive_phone, NID;

//phonesplus, gong weekly, daily version
phonesplus_version := monitoring.version.phonesplus_file;
gong_weekly_version := monitoring.version.gong_weekly_file;
utility_daily_version := monitoring.version.utility_daily_file;
header_file_version := monitoring.version.header_file;
quick_header_version := monitoring.version.quick_header_file;

five_years_ago := ((unsigned)StringLib.GetDateYYYYMMDD()) DIV 100 - 500;
current_month := ((unsigned)StringLib.GetDateYYYYMMDD()) DIV 100 % 100;
two_months_ago := if(current_month>2, ((unsigned)StringLib.GetDateYYYYMMDD()) DIV 100 - 2,
                     ((unsigned)StringLib.GetDateYYYYMMDD()) DIV 100 - 100 + 12 - 2);										 

//version to return, pick the newest
return_phone_version := (string8)ut.max2(phonesplus_version, gong_weekly_version);
return_address_version := (string8)ut.max2(utility_daily_version, ut.max2(header_file_version, quick_header_version));

//files to monitor
addr_blue_file := monitoring.file_address_blue;

customer_base_file := monitoring.file_customer_base((unsigned)date_to_run<=(unsigned)StringLib.GetDateYYYYMMDD()) : persist('per_base_file_to_run');

//phones plus: slim down
layout_did := record
	   string10  customer_id;          
     string30  record_id;
     doxie.layout_references;	
	   string9 ssn;
	   unsigned1 best_phone_number;
end;

layout_did norm_dids(customer_base_file l, doxie.layout_references r) := transform
	self.did := if(r.did=0, skip, r.did);
	self := l;
end;

f_tg_to_try_ready := normalize(customer_base_file((unsigned)phone_version_number<phonesplus_version,
                                            phone_level_tg),
					left.dids, norm_dids(left, right));

f_tg_to_try := dedup(sort(f_tg_to_try_ready, record), record);
					
					
has_type_tg := count(f_tg_to_try)>0;				   
		    
//phones plus: get dids 				    			    
f_tg_to_try_dist := distribute(f_tg_to_try, hash(did));

//phones plus: slim the ppl file															
phonesplus_dist_did := distribute(dataset(ut.foreign_prod + 'thor_data400::base::phonesplus', 
   							       Phonesplus.layoutCommonOut, thor)
										(did<>0,
                                                   CellPhone<>'',
										 confidencescore>10,
										 phonesplus.IsCellSource(vendor)), 
							hash(did)) : persist('per_phonesplus_50way');

layout_phonesplus_slim get_phonesplus_by_did(f_tg_to_try_dist l, 
                                             phonesplus_dist_did r) := transform
									
	dt_last_seen_val := header.get_last_seen(r.DateFirstSeen,
	                                         r.DateLastSeen,
	  							      r.DateVendorFirstReported,
								      r.DateVendorLastReported);
								  
	dt_first_seen_val := header.get_first_seen(r.DateFirstSeen,
	                                           r.DateLastSeen,
	 							        r.DateVendorFirstReported,
								        r.DateVendorLastReported);
								  
	self.customer_id := l.customer_id;
	self.record_id := l.record_id;
	self.best_phone_number := l.best_phone_number;
	self.phone_type := 'TG';
	self.phone10 := r.CellPhone;
	self.phone_dt_last_seen := (string6)dt_last_seen_val + if(dt_last_seen_val>0, '01', '');
	self.phone_dt_first_seen := (string6)dt_first_seen_val + if(dt_first_seen_val>0, '01', '');
	self.name_first := r.fname;
	self.name_middle := r.mname;
	self.name_last := r.lname;
	self.name_suffix := if(r.name_suffix[1..2]='UN','',r.name_suffix);
	self.suffix := r.addr_suffix;
	self.unit_desig := if(r.sec_range='', '', r.unit_desig); 
	self.st := r.state;
	self.z5 := r.zip5;
	self.z4 := r.zip4;
	self := r;		
	self.phone_version_number := return_phone_version;
	self.in_ssn := l.ssn;
	self := [];
end;

f_tg_raw := if(has_type_tg,
               join(f_tg_to_try_dist, phonesplus_dist_did,
                    left.did = right.did, 
 	               get_phonesplus_by_did(left, right), 
	  	          local, limit(ut.limits.PHONE_PER_PERSON, skip)),
			dataset([],layout_phonesplus_slim));

best_slim_file := project(distribute(dataset(ut.foreign_prod + 'thor_data400::BASE::Watchdog_Best',
                                             watchdog.layout_Best_v2,thor),
                                     hash(did)), 
                          transform({unsigned6 did, string9 ssn}, self:=left))(ssn<>'') : persist('per_slim_best_file_50way');								  

layout_phone_update check_tg_ssn(f_tg_raw l) := transform
	self := l;
	self := [];
end;

f_tg := if(has_type_tg,
           join(f_tg_raw, best_slim_file,
                left.did = right.did and 
			 header.ssn_value(left.in_ssn, right.ssn)>=0,
 	           check_tg_ssn(left), 
	  	      local, limit(ut.limits.PHONE_PER_PERSON, skip)),
		 dataset([],layout_phone_update)) : persist('per_f_tg');
						  						 									
//gong weekly: address slim layout	
layout_name_addr := record
     string10  customer_id;          
     string30  record_id;
	   standard.Name_Slim;
	   standard.Addr_Slim;
	   string8   phone_version_number;
	   unsigned1 best_phone_number;
     string6   addr_dt_last_seen := '';
  	 string6   addr_dt_first_seen := ''; 
end;
				 				 
//gong weekly(type ta): input file match by name & address
f_ta_to_try := project(customer_base_file(phone_level_ta, prim_name<>''), layout_name_addr);
							    						    
f_weekly_ta_to_try_dist := distribute(f_ta_to_try((unsigned)phone_version_number<gong_weekly_version), 
                                      hash(prim_name, prim_range, z5));
																			
//gong weekly: file to match
has_weekly := count(customer_base_file((unsigned)phone_version_number<gong_weekly_version))>0;
gong_weekly_dummy := dataset([], gong.layout_history);
gong_weekly_file := distribute(
                               project(dataset(ut.foreign_prod + 'thor_data400::base::gong_history',
                                               gong.layout_historyaid, flat, __compressed__),
														           transform(gong.Layout_history, self := left))
							                         (current_record_flag='Y', prim_name<>''),
                               hash(prim_name, prim_range, z5)) : persist('per_gong_weekly_50way');
gong_weekly_dist_addr := if(has_weekly, gong_weekly_file, gong_weekly_dummy);

//gong weekly(type ta): by input file address & fullname 
layout_phone_update get_weekly_by_addr_fullname(f_weekly_ta_to_try_dist l, 
                                                gong_weekly_dist_addr r) := transform
     self.customer_id := l.customer_id;
	self.record_id := l.record_id;								   
	self.best_phone_number := l.best_phone_number;								   
	self.phone10 := if(r.phone10<>'',r.phone10,skip);
	self.phone_type := 'TA';
	self.phone_dt_last_seen := r.dt_last_seen;
	self.phone_dt_first_seen := r.dt_first_seen;
	self.unit_desig := if(r.sec_range='', '', r.unit_desig);
	self.listing_type := trim(r.listing_type_bus) + trim(r.listing_type_res) + trim(r.listing_type_gov);
	self := r;
	self.phone_version_number := return_phone_version;
	self := [];
end;

f_weekly_ta := join(f_weekly_ta_to_try_dist, gong_weekly_dist_addr,
                    left.prim_name = right.prim_name and
		          left.z5 = right.z5 and
		          left.prim_range = right.prim_range and 
			     left.name_last = right.name_last and 
			     ((left.sec_range = '' and left.name_first[1] = right.name_first[1]) or
				 (left.sec_range <> '' and left.name_first = right.name_first)), 
			     get_weekly_by_addr_fullname(left, right), 
			     local, limit(ut.limits.PHONE_PER_PERSON, skip)) : persist('per_f_weekly_ta');
										 						    
//gong weekly(type tb): by address & last name - should use blue marked address 
f_tb_to_try_in := project(addr_blue_file(phone_level_tb, prim_name<>''), layout_name_addr) ;

layout_name_addr get_tb_raw(f_tb_to_try_in l) := transform
	self := l;
end;

f_tb_to_try_raw := join(f_tb_to_try_in, customer_base_file,
                        left.customer_id = right.customer_id and           
                        left.record_id = right.record_id,
				    get_tb_raw(left), hash, keep(1));

f_tb_to_try := f_tb_to_try_raw + f_ta_to_try : persist('per_f_tb_to_try');
     
f_weekly_tb_to_try_dist := distribute(f_tb_to_try((unsigned)phone_version_number<gong_weekly_version), 
                                      hash(prim_name, prim_range, z5));

layout_phone_update get_weekly_by_addr_lastname(f_weekly_tb_to_try_dist l, 
                                                gong_weekly_dist_addr r) := transform
	self.customer_id := l.customer_id;
	self.record_id := l.record_id;
	self.best_phone_number := l.best_phone_number;								   
	self.phone10 := if(r.phone10<>'',r.phone10,skip);
	self.phone_type := 'TB';
	self.phone_dt_last_seen := if(l.addr_dt_last_seen<>'',l.addr_dt_last_seen + '01', r.dt_last_seen);
	self.phone_dt_first_seen := if(l.addr_dt_first_seen<>'',l.addr_dt_first_seen + '01', r.dt_first_seen);
	self.unit_desig := if(r.sec_range='', '', r.unit_desig);
	self.listing_type := trim(r.listing_type_bus) + trim(r.listing_type_res) + trim(r.listing_type_gov);
	self := r;
	self.phone_version_number := return_phone_version;
	self := [];
end;

f_weekly_tb := join(f_weekly_tb_to_try_dist, gong_weekly_dist_addr,
                    left.prim_name = right.prim_name and
	               left.z5 = right.z5 and
		          left.prim_range = right.prim_range and
		          (left.name_last = right.name_last or
			     left.name_first = right.name_first and 
				(stringlib.EditDistance(left.name_last, right.name_last)<2 or
				 length(trim(left.name_last))>5 and 
				 stringlib.EditDistance(left.name_last, right.name_last)<3)) and
				(left.sec_range = '' or left.sec_range = right.sec_range or
				 NID.PreferredFirstNew(left.name_first)=NID.PreferredFirstNew(right.name_first)),					          
		          get_weekly_by_addr_lastname(left, right), 
		          local, limit(ut.limits.PHONE_PER_PERSON, skip)) : persist('per_f_weekly_tb');

//gong weekly(type td): by best address + input address(if no best)
td_cust_set := ['WAM'];
f_td_update_file_in := dedup(sort(project(addr_blue_file(customer_id in td_cust_set,phone_level_td, prim_name<>''),layout_name_addr),
                               customer_id, record_id, -addr_dt_last_seen, -addr_dt_first_seen, -prim_range, prim_name),
												  customer_id, record_id);
					
f_td_customer_base := customer_base_file(customer_id in td_cust_set, phone_level_td,prim_name<>'');
						 
f_td_base_file := join(f_td_customer_base, f_td_update_file_in,
                       left.customer_id = right.customer_id and          
                       left.record_id = right.record_id,
                       transform({layout_name_addr}, self:=left),hash, left only);
											 
//get the latest version number, also cleaning up records not in base anymore											 
layout_name_addr get_phone_version(f_td_update_file_in l, f_td_customer_base r) := transform
		self.phone_version_number := r.phone_version_number;
		self := l;
end;

f_td_update_file := join(f_td_update_file_in, f_td_customer_base,
                         left.customer_id = right.customer_id and          
                         left.record_id = right.record_id,
		               get_phone_version(left, right), hash, keep(1));										 
				   
f_td_to_try := f_td_update_file + f_td_base_file;
f_weekly_td_to_try_raw := f_td_to_try((unsigned)phone_version_number<gong_weekly_version);

layout_apt_building := record  
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  qstring5 zip;
  qstring4 suffix;
	integer4 apt_cnt;
  integer4 did_cnt;
end;

Key_AptBuildings := index(dataset([], layout_apt_building),{prim_range, prim_name, zip, suffix, predir}, {apt_cnt, did_cnt}, 
                          ut.foreign_prod + 'thor_data400::key::hdr_apt_bldgs_' + doxie.Version_SuperKey);

f_weekly_td_to_try_raw rmv_apt_recs(f_weekly_td_to_try_raw l) := transform
	self := l;
end;

f_weekly_td_to_try_better := join(f_weekly_td_to_try_raw(sec_range=''), Key_AptBuildings,
                                  keyed(left.prim_range = right.prim_range) and
																	keyed(left.prim_name = right.prim_name) and
																	keyed(left.z5 = right.zip) and
																	right.apt_cnt > 1, rmv_apt_recs(left), left only) +
														 f_weekly_td_to_try_raw(sec_range<>'');			
																	
f_weekly_td_to_try_dist := distribute(f_weekly_td_to_try_better, hash(prim_name, prim_range, z5));

//gong weekly(type td): get gong weekly phones
layout_phone_update get_weekly_by_addr(f_weekly_td_to_try_dist l, 
                                       gong_weekly_dist_addr r) := transform
	self.customer_id := l.customer_id;
	self.record_id := l.record_id;
	self.best_phone_number := l.best_phone_number;
	self.phone10 := if(r.phone10<>'',r.phone10,skip);
	self.phone_dt_last_seen := if(l.addr_dt_last_seen<>'',l.addr_dt_last_seen + '01', r.dt_last_seen);
	self.phone_dt_first_seen := if(l.addr_dt_first_seen<>'',l.addr_dt_first_seen + '01', r.dt_first_seen);
	self.phone_type := 'TC';
	self.unit_desig := if(r.sec_range='', '', r.unit_desig);
	self.listing_type := trim(r.listing_type_bus) + trim(r.listing_type_res) + trim(r.listing_type_gov);
	self := r;
	self.phone_version_number := return_phone_version;
	self := [];
end;

f_weekly_td := join(f_weekly_td_to_try_dist, gong_weekly_dist_addr,
		                left.prim_name = right.prim_name and
		                left.z5 = right.z5 and
		                left.prim_range = right.prim_range and
		                (left.sec_range = '' or left.sec_range = right.sec_range or
				       NID.PreferredFirstNew(left.name_first)=NID.PreferredFirstNew(right.name_first) and
				       stringlib.EditDistance(left.name_last, right.name_last)<2),
		                get_weekly_by_addr(left, right), 
		                local, limit(10, skip))  : persist('per_f_weekly_td');
				
f_weekly_all := f_weekly_ta + f_weekly_tb + f_weekly_td;
				    
f_all := f_tg + f_weekly_all;

//get the best phones
monitoring.Mac_Monitoring_Best_Phone(f_all, f_out);

//set the update file
f_base := monitoring.file_customer_base;
f_base_dep := dedup(sort(distribute(f_base, hash(customer_id, record_id)), 
                         customer_id, record_id, local), 
				customer_id, record_id, local);

monitoring.layout_phone_update get_update_file(f_base_dep l, f_out r) := transform
     self.customer_id := l.customer_id;
	self.record_id := l.record_id;
	self.best_phone_number := l.best_phone_number;
	self.phone_version_number := return_phone_version;
	self := r;
end;

f_new_update := join(f_base_dep, f_out, 
                         left.customer_id = right.customer_id and
				     left.record_id = right.record_id,
                         get_update_file(left, right), local) : persist('per_f_update_phone');
				 
monitoring.layout_phone_update get_out(f_new_update l) := transform
	self := l;
end;				 
				 
f_new_out_ready := if(count(f_new_update)>0,
                      join(f_new_update(customer_id<>'PRA'), monitoring.file_phone_history,
                           left.customer_id = right.customer_id and 
			                     left.record_id = right.record_id and
			                     left.phone10 = right.phone10 and
			                     (left.phone_type = right.phone_type or right.phone_type=''),			   
			                     get_out(left), hash, left only) +
									     join(f_new_update(customer_id='PRA'), monitoring.file_phone_history,
                           left.customer_id = right.customer_id and 
			                     left.record_id = right.record_id and
			                     left.phone10 = right.phone10,			   
			                     get_out(left), hash, left only),
				              dataset([],monitoring.layout_phone_update))((unsigned)(phone_dt_last_seen[1..6])>=two_months_ago or 
					                                                         phone_type<>'TB');			   

f_new_out_append_in := project(f_new_out_ready, transform(monitoring.Layout_Phone_Out, 
                                                          self.subj_phone10 := left.phone10,
																													self := left));
   
progressive_phone.mac_get_switchtype(f_new_out_append_in, f_new_out_append_out)

f_NeuStar := dataset([], CellPhone.layoutNeuStar);
key_NeuStar := index(f_NeuStar,{cellphone},{cellphone},
								     ut.foreign_prod + 'thor_data400::key::neustar_phone_qa');

monitoring.Layout_Phone_Out check_neustar(f_new_out_append_out l, key_NeuStar r) := transform
   self.switch_type := if(r.cellphone<>'', 'C', l.switch_type);
	 self := l;
end;

f_new_out := join(f_new_out_append_out, key_NeuStar,
                  left.subj_phone10 = right.cellphone,
			 		        check_neustar(left, right), left outer, keep(1));



f_new_base := project(f_base, transform({monitoring.layout_customer_base},
                                        self.addr_version_number := if((unsigned)left.date_to_run<=(unsigned)StringLib.GetDateYYYYMMDD(),
								                                return_address_version, left.addr_version_number);
                                        self.phone_version_number := if((unsigned)left.date_to_run<=(unsigned)StringLib.GetDateYYYYMMDD(),
								                                return_phone_version, left.phone_version_number);
								self.date_to_run := if((unsigned)left.date_to_run<=(unsigned)StringLib.GetDateYYYYMMDD(),
								                        if(left.frequency_time<>0,
												       monitoring.func_calc_frequency(StringLib.GetDateYYYYMMDD(),
	                                                                                             left.frequency_type,
														    	                       left.frequency_time),''),
												  left.date_to_run);
								self := left));
								
create_update := sequential(output(f_new_update,,'~thor_data400::base::monitoring_phone_update' + thorlib.wuid()),
					             fileservices.ClearSuperFile('~thor_data400::base::monitoring_phone_update'),
							   fileservices.AddSuperFile('~thor_data400::base::monitoring_phone_update',
							                             '~thor_data400::base::monitoring_phone_update' + thorlib.wuid()));
create_out := 	sequential(output(sort(f_new_out,customer_id, record_id, best_phone_count),,
                                      '~thor_data400::base::monitoring_phone_out' + thorlib.wuid()),
					             fileservices.ClearSuperFile('~thor_data400::base::monitoring_phone_out'),
							   fileservices.AddSuperFile('~thor_data400::base::monitoring_phone_out',
							                             '~thor_data400::base::monitoring_phone_out' + thorlib.wuid()));				  
create_base := sequential(output(f_new_base,,'~thor_data400::base::monitoring_customer' + thorlib.wuid()),
			           fileservices.ClearSuperFile('~thor_data400::base::monitoring_customer_base'),
			  	      fileservices.AddSuperFile('~thor_data400::base::monitoring_customer_base',
							                 '~thor_data400::base::monitoring_customer' + thorlib.wuid()));
			   					    
export Proc_Best_Phone_Searching := sequential(create_update, create_out, create_base);