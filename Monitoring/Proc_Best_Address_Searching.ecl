import doxie, didville, header, header_quick, monitoring, ut, utilfile, mdr;

//get diffrent version for input files
header_version_value := monitoring.version.header_file;
utility_version_value := monitoring.version.utility_daily_file;
quick_version_init := monitoring.version.quick_header_file;

current_month := ((unsigned)StringLib.GetDateYYYYMMDD()) DIV 100 % 100;
two_months_ago := if(current_month>2, ((unsigned)StringLib.GetDateYYYYMMDD()) DIV 100 - 2,
                       ((unsigned)StringLib.GetDateYYYYMMDD()) DIV 100 - 100 + 12 - 2);


//keep quick header version between header version and utility version
quick_version_value := map(quick_version_init > utility_version_value => utility_version_value, 
                           quick_version_init < header_version_value =>  header_version_value,
                           quick_version_init);
				
//utililty version should be >= header version 
return_version := if(utility_version_value>header_version_value, 
                     utility_version_value, header_version_value);

//apply seqeunce number to the base file
f_in_raw := monitoring.File_Customer_Base; 			
f_in_seq_init := project(f_in_raw, Layout_Customer_Base_Seq);
ut.MAC_Sequence_Records(f_in_seq_init, seq, f_in_seq_ready);

f_in_seq_srt := sort(distribute(f_in_seq_ready, hash(customer_id, record_id)), customer_id, record_id, local);

f_in_seq_srt iter_seq(f_in_seq_srt l, f_in_seq_srt r) := transform
	self.seq := if(l.customer_id=r.customer_id and l.record_id=r.record_id, l.seq, r.seq);
	self := r;
end; 

f_in_seq_all := iterate(f_in_seq_srt, iter_seq(left, right), local) : persist('per_f_in_seq_all');
f_in_seq_flt := f_in_seq_all((unsigned)date_to_run<=(unsigned)StringLib.GetDateYYYYMMDD());
f_in_seq := dedup(sort(f_in_seq_flt, customer_id, record_id, local), customer_id, record_id, local);
 
//classifing inputs for different category's match		  
f_in_triple_ready := f_in_seq((unsigned)addr_version_number<header_version_value);
f_in_triple_3_ready := f_in_seq_flt((unsigned)addr_version_number<header_version_value);

has_triple := count(f_in_triple_ready)>0;

monitoring.Layout_Best_Addr_In get_batch_in(f_in_triple_ready l) := transform
     self.acctno := (string20)l.seq;
     self.version_number := l.addr_version_number;
	self := l;
end;

f_in_triple := project(distribute(f_in_triple_ready, hash(seq)), get_batch_in(left));
f_in_triple_3 := project(f_in_triple_3_ready, get_batch_in(left));

//using dids for double and single match								  
f_in_double_ready := f_in_seq((unsigned)addr_version_number>=header_version_value,
                              (unsigned)addr_version_number<quick_version_value);
has_double := count(f_in_double_ready)>0;			

layout_acctno_did norm_dids(f_in_double_ready l, doxie.layout_references r) := transform
     self.acctno := (string20)l.seq;
	self.did := r.did;
	self.best_address_number := l.best_address_number;
end;

f_in_double_ids := distribute(normalize(f_in_double_ready,left.dids,norm_dids(left,right)), hash(did));
f_in_double := project(distribute(f_in_double_ready, hash(seq)), get_batch_in(left));
						
f_in_single_ready := f_in_seq((unsigned)addr_version_number>=quick_version_value,
                            (unsigned)addr_version_number<utility_version_value);
has_single := count(f_in_single_ready)>0;

f_in_single_ids := distribute(normalize(f_in_single_ready,left.dids,norm_dids(left,right)), hash(did));
f_in_single := project(distribute(f_in_single_ready, hash(seq)), get_batch_in(left));

//define file will be used
header_dummy := dataset([],header.layout_header);
header_ext_dummy := dataset([],monitoring.layout_header_ext);
//**** should use ssn pathced version
file_header_in := distribute(project(dataset(ut.foreign_prod + 'thor_data400::base::header_prod',header.layout_header_v2,thor), header.Layout_Header)
                                    (~mdr.Source_is_on_Probation(src), 
																		 header.get_last_seen(dt_first_seen,dt_last_seen,
							           		                              dt_vendor_first_reported,dt_vendor_last_reported)>=two_months_ago),
					                   hash(did)) : persist('per_header_50way');
file_header := if(has_triple,file_header_in,header_dummy); 
file_quick_header_in := distribute(dataset(ut.foreign_prod + 'thor_data400::base::quick_header', header.Layout_Header,thor)
                                   (header.get_last_seen(dt_first_seen,dt_last_seen,
							           		                             dt_vendor_first_reported,dt_vendor_last_reported)>=two_months_ago), 
                                   hash(did)) : persist('per_quick_header_50way');
file_quick_header := if((has_double or has_triple),file_quick_header_in,header_dummy);

//workaround for a bug
file_utility_daily_raw := dataset(ut.foreign_prod + 'thor_data400::in::utility::daily_did',utilfile.Layout_DID_Out,flat,opt)(record_date >= UtilFile.StartDate);
file_utililty_daily := distribute(file_utility_daily_raw((unsigned)record_date<=utility_version_value,
                                                        (unsigned6)did<>0), hash((unsigned6)did));

//hdr+qk&util: batch call to get Dids 
dids_all_dep_ready := monitoring.Dids_Batch_Call(f_in_triple_3);
dids_all_dep_raw := distribute(dedup(sort(dids_all_dep_ready, record), record), hash(did))  : persist('per_dids_all_dep_raw');

dids_all_dep_tbl_rec := record
		dids_all_dep_raw.acctno;
		grp_cnt := count(group);
end;

dids_all_dep_bad := table(dids_all_dep_raw, dids_all_dep_tbl_rec, acctno)(grp_cnt>3);

monitoring.layout_acctno_did get_good_dids(dids_all_dep_raw l) := transform
		self := l;
end;

dids_all_dep := distribute(join(dids_all_dep_raw, dids_all_dep_bad,
                           left.acctno = right.acctno,
										       get_good_dids(left), left only, hash), hash(did)) : persist('per_dids_all_dep');

//hdr+qk&util: match against header file
monitoring.layout_header_ext get_hdr(layout_acctno_did l, file_header r) := transform
	self.rid := (unsigned6)l.acctno,
	self.did := l.did,
	self.best_address_number := l.best_address_number;
	self := r,
end;
		  
tpl_hdr_rl_recs := join(dids_all_dep, file_header, 
                        left.did = right.did,
	      	         get_hdr(left, right), local, LIMIT(500,SKIP)) : persist('per_tpl_hdr_rl_recs');
				 
//hdr+qk&util: match against quick header key		  
tpl_hdr_qk_recs := join(dids_all_dep, file_quick_header, 
                        left.did = right.did, 
	  		         get_hdr(left, right), local, LIMIT(500,SKIP)) : persist('per_tpl_hdr_qk_recs');				 

//hdr+qk&util: get util recs by did
unsigned3 add4(unsigned3 dt) := if ((dt+4) % 100 > 12, dt + 104 - 12, dt+4);
unsigned3 todaydate := (unsigned3)((integer)ut.GetDate div 100);
unsigned3 lesser(unsigned3 dt2) := if (add4(dt2) < todaydate, add4(dt2),todaydate);

monitoring.layout_header_ext get_util_by_did(layout_acctno_did l, file_utililty_daily r) := transform
	self.rid := (unsigned6)l.acctno,
	self.did := l.did,
	self.best_address_number := l.best_address_number;
	self.rec_type := '1';
	self.src := 'DU';
	self.vendor_id := r.id;
	self.suffix := r.addr_suffix;
	self.city_name := r.v_city_name;
	self.dt_first_seen :=  (integer)r.date_first_seen div 100;
	self.dt_last_seen := if((integer)r.date_first_seen div 100=0,0,
	                        lesser((integer)r.date_first_seen div 100));
	self.dt_vendor_first_reported := self.dt_first_seen;
	self.dt_vendor_last_reported := self.dt_last_seen;
     self.dt_nonglb_last_seen := self.dt_last_seen;
	self.county := r.county[3..5];
	self.tnt := 'Y';
	self.dob := (unsigned)r.dob;
	SELF := r;
	self := [];
end;
		  
tpl_util_recs := join(dids_all_dep, file_utililty_daily, 
                      left.did = (unsigned6)right.did,
		 		  get_util_by_did(left, right), local, LIMIT(500,SKIP)) : persist('per_tpl_util_recs');

//hdr+qk&util: get util recs by ssn and name			
tpl_raw_init := if(has_triple, tpl_hdr_rl_recs + tpl_hdr_qk_recs + tpl_util_recs, header_ext_dummy);
tpl_raw_recs := distribute(tpl_raw_init, hash(rid));

tpl_flt_recs := if(has_triple, monitoring.func_positive_check(tpl_raw_recs, f_in_triple), 
                   header_ext_dummy) : persist('per_tpl_flt_recs');

//workaround for a bug
set_triple := sequential(fileservices.startsuperfiletransaction(),
                         fileservices.clearsuperfile('~thor_data400::base::monitoring_filtered_triple'),
                         if(count(tpl_flt_recs)>0,
			             sequential(output(tpl_flt_recs,,'~thor_data400::base::monitoring_filtered_triple' + thorlib.wuid()),
			                               fileservices.addsuperfile('~thor_data400::base::monitoring_filtered_triple',
				                                                    '~thor_data400::base::monitoring_filtered_triple' + thorlib.wuid()))),
					fileservices.finishsuperfiletransaction()									  
			         );
f_tpl_filter := dataset('~thor_data400::base::monitoring_filtered_triple', monitoring.layout_header_ext, thor, opt);

//header.MAC_GlbClean_Header(tpl_flt_recs, tpl_clean_recs);
tpl_best_ready := project(f_tpl_filter, transform({monitoring.layout_header_ext}, 
                                                   self.did := left.rid, 
										 self.rid := left.did,
										 self := left));
empty := dataset([],didville.Layout_BestInfo_BatchIn_w_did);					  			    
monitoring.Mac_Monitoring_Best_Addr(tpl_best_ready, did, tpl_best, true,empty);    

//qk&util: get util recs by dids(should be able to get un-dids records)	
dbl_qk_did_recs := join(f_in_double_ids, file_quick_header, 
                        left.did = right.did,
	     		    get_hdr(left, right), local, LIMIT(500,SKIP)) : persist('per_dbl_qk_did_recs');	

dbl_util_recs := join(f_in_double_ids, file_utililty_daily,
                      left.did = (unsigned6)right.did,
                      get_util_by_did(left, right), local, LIMIT(500,SKIP)) : persist('per_dbl_util_recs');

dbl_raw_init := if(has_double, dbl_qk_did_recs + dbl_util_recs, header_ext_dummy) : persist('per_dbl_raw_init');
dbl_raw_recs := distribute(dbl_raw_init, hash(rid));

dbl_flt_recs := if(has_double, monitoring.func_positive_check(dbl_raw_recs, f_in_double),
                   header_ext_dummy) : persist('per_dbl_flt_recs');

//workaround for a bug
set_double := sequential(fileservices.startsuperfiletransaction(),
                         fileservices.clearsuperfile('~thor_data400::base::monitoring_filtered_double'),
                         if(count(dbl_flt_recs)>0,
			             sequential(output(dbl_flt_recs,,'~thor_data400::base::monitoring_filtered_double' + thorlib.wuid()),
			                               fileservices.addsuperfile('~thor_data400::base::monitoring_filtered_double',
				                                                    '~thor_data400::base::monitoring_filtered_double' + thorlib.wuid()))),
					fileservices.finishsuperfiletransaction()									  
			         );
f_dbl_filter := dataset('~thor_data400::base::monitoring_filtered_double', monitoring.layout_header_ext, thor, opt);
  	 
dbl_best_ready := project(f_dbl_filter, transform({monitoring.layout_header_ext}, 
                                                   self.did := left.rid, 
										 self.rid := left.did,
										 self := left));
			  			    						    		    
monitoring.Mac_Monitoring_Best_Addr(dbl_best_ready, did, dbl_best, true,empty);				    

//util only: get util recs by dids(should be able to get un-dids records)
sgl_util_recs := join(f_in_single_ids, file_utililty_daily,
                      left.did = (unsigned6)right.did,
                      get_util_by_did(left, right), local, LIMIT(500,SKIP)) : persist('per_sgl_util_recs');

sgl_raw_init := if(has_single,sgl_util_recs,header_ext_dummy) : persist('per_sgl_raw_init');
sgl_raw_recs := distribute(sgl_raw_init, hash(rid));

//need to add true	 
sgl_flt_recs := if(has_single,monitoring.func_positive_check(sgl_raw_recs, f_in_single),
                   header_ext_dummy) : persist('per_sgl_flt_recs');

//workaround for a bug
set_single := sequential(fileservices.startsuperfiletransaction(),
                         fileservices.clearsuperfile('~thor_data400::base::monitoring_filtered_single'),
                         if(count(sgl_flt_recs)>0,
			             sequential(output(sgl_flt_recs,,'~thor_data400::base::monitoring_filtered_single' + thorlib.wuid()),
			                               fileservices.addsuperfile('~thor_data400::base::monitoring_filtered_single',
				                                                    '~thor_data400::base::monitoring_filtered_single' + thorlib.wuid()))),
					fileservices.finishsuperfiletransaction()									  
			         );
f_sgl_filter := dataset('~thor_data400::base::monitoring_filtered_single', monitoring.layout_header_ext, thor, opt);				    

sgl_best_ready := project(f_sgl_filter, transform({monitoring.layout_header_ext}, 
                                                   self.did := left.rid, 
										 self.rid := left.did,
										 self := left));
			  			    						    		    
monitoring.Mac_Monitoring_Best_Addr(sgl_best_ready, did, sgl_best, true,empty);

out_ready := (tpl_best + dbl_best + sgl_best)(prim_name<>'');

monitoring.Layout_Address_Update get_update_file(f_in_seq l, out_ready r) := transform
     self.customer_id := l.customer_id;
	self.record_id := l.record_id;
	self.phone_version_number := l.phone_version_number;
	self.best_phone_number := l.best_phone_number;
	self.phone_level_ta := l.phone_level_ta;
	self.phone_level_tb := l.phone_level_tb;
	self.phone_level_td := l.phone_level_td;
	self.phone_level_tg := l.phone_level_tg;
	self.addr_dt_first_seen := (string6)header.get_first_seen(r.dt_first_seen,
								                                            r.dt_last_seen,
																			                      r.dt_vendor_first_reported,
							           			                              r.dt_vendor_last_reported);
	self.addr_dt_last_seen := (string6)header.get_last_seen(r.dt_first_seen,
								                                          r.dt_last_seen,
																													r.dt_vendor_first_reported,
							           		                              r.dt_vendor_last_reported);
	self.addr_version_number := (string8)return_version;
	self.name_first := r.fname;
	self.name_middle := r.mname;
	self.name_last := r.lname;
	self.p_city_name := r.city_name;
	self.unit_desig := if(r.sec_range='','',r.unit_desig);
	self.z5 := r.zip;
	self.z4 := r.zip4;
	self.did := r.rid;
	self.name_score := ut.NameMatch100(l.name_first, l.name_middle, l.name_last,
	                                   r.fname, r.mname, r.lname);
     self.ssn_score := ut.SSNMatch100(l.ssn, r.ssn);								
	self := r;
end;

f_new_update := join(f_in_seq, out_ready, 
                     left.seq = right.did,
                     get_update_file(left, right), hash) : persist('per_f_update_addr');
				 
monitoring.Layout_Address_Update get_out(f_new_update l) := transform
     self.addr_dt_last_seen := if((unsigned)(l.addr_dt_last_seen[1..4])<>0 and (unsigned)(l.addr_dt_last_seen[5..6])=0, 
	                             l.addr_dt_last_seen[1..4] + '01', l.addr_dt_last_seen);
	self.addr_dt_first_seen := if((unsigned)(l.addr_dt_first_seen[1..4])<>0 and (unsigned)(l.addr_dt_first_seen[5..6])=0, 
	                             l.addr_dt_first_seen[1..4] + '01', l.addr_dt_first_seen);					    
	self := l;
end;				 
				 
f_new_out1 := if(count(f_new_update)=0, 
                 dataset([],monitoring.Layout_Address_Update),
                 join(f_new_update, monitoring.File_Address_History,
                      left.customer_id = right.customer_id and 
			       left.record_id = right.record_id and
			       left.prim_name = right.prim_name and 
			       left.z5 = right.z5 and
			       left.prim_range = right.prim_range and
			 	 (left.sec_range='' or 
			       right.sec_range<>'' and left.sec_range=right.sec_range), 
		   	      get_out(left), left only, hash));
				 
f_new_out2 := 	if(count(f_new_update)=0, 
                 dataset([],monitoring.Layout_Address_Update),
                 join(f_new_update(best_address_count=1 and (customer_id not in monitoring.special_treat_set)), 
			       monitoring.File_Address_History(best_address_count=0 or  best_address_count=1),
                      left.customer_id = right.customer_id and 
			       left.record_id = right.record_id and
			       left.prim_name = right.prim_name and 
			       left.z5 = right.z5 and
			       left.prim_range = right.prim_range,
		   	      get_out(left), left only, hash));
				 
f_new_out := dedup(sort(f_new_out1 + f_new_out2, record), record)((unsigned)(addr_dt_last_seen[1..6])>=two_months_ago,
                                                                  (unsigned)(addr_dt_last_seen[1..6])<=(unsigned)StringLib.GetDateYYYYMMDD() DIV 100);				 

f_new_blue_raw := f_tpl_filter + f_dbl_filter + f_sgl_filter;

monitoring.Layout_Address_Update get_blue_file(f_in_seq l, f_new_blue_raw r) := transform
     self.customer_id := l.customer_id;
	self.record_id := l.record_id;
	self.phone_version_number := l.phone_version_number;
	self.best_phone_number := l.best_phone_number;
	self.phone_level_ta := l.phone_level_ta;
	self.phone_level_tb := l.phone_level_tb;
	self.phone_level_td := l.phone_level_td;
	self.phone_level_tg := l.phone_level_tg;
     self.addr_dt_first_seen := (string6)header.get_first_seen(r.dt_first_seen,
								                                               r.dt_last_seen,
																			                         r.dt_vendor_first_reported,
							           			                                 r.dt_vendor_last_reported);
	self.addr_dt_last_seen := (string6)header.get_last_seen(r.dt_first_seen,
								                                          r.dt_last_seen,
																													r.dt_vendor_first_reported,
							           		                              r.dt_vendor_last_reported);
	self.addr_version_number := (string8)return_version;
	self.name_first := r.fname;
	self.name_middle := r.mname;
	self.name_last := r.lname;
	self.p_city_name := r.city_name;
	self.z5 := r.zip;
	self.z4 := r.zip4;
	self.did := r.did;
	self.best_address_count := 0;
     self.name_score := 0;
	self.ssn_score := 0;
	self := r;
end;

f_new_blue_ready := join(f_in_seq, f_new_blue_raw, 
                   left.seq = right.rid,
                   get_blue_file(left, right), hash)((unsigned)addr_dt_last_seen>=two_months_ago, 
			                                      (unsigned)addr_dt_last_seen<=(unsigned)StringLib.GetDateYYYYMMDD() DIV 100) +
                   monitoring.File_Address_Blue((unsigned)addr_dt_last_seen>=two_months_ago);
			
f_new_blue_dist := distribute(f_new_blue_ready, hash(customer_id, record_id));
f_new_blue := dedup(sort(f_new_blue_dist, customer_id, record_id, prim_name, prim_range, z5, name_last, 
                         -sec_range, -addr_dt_last_seen, -addr_dt_first_seen, local),			   
                    customer_id, record_id, prim_name, prim_range, z5, name_last, local);			
			
//update base file - only do this when there's a new header

f_new_base := project(if(has_triple, monitoring.func_update_base(f_in_seq_all, f_in_triple_ready, dids_all_dep),
                      f_in_seq_all), monitoring.Layout_Customer_Base);				 	

create_update := sequential(output(f_new_update,,'~thor_data400::base::monitoring_address_update' + thorlib.wuid()),
					             fileservices.ClearSuperFile('~thor_data400::base::monitoring_address_update'),
							   fileservices.AddSuperFile('~thor_data400::base::monitoring_address_update',
							                             '~thor_data400::base::monitoring_address_update' + thorlib.wuid()));

create_out := 	sequential(output(sort(f_new_out, customer_id, record_id, best_address_count),,
                                 '~thor_data400::base::monitoring_address_out' + thorlib.wuid()),
					 fileservices.ClearSuperFile('~thor_data400::base::monitoring_address_out'),
					 fileservices.AddSuperFile('~thor_data400::base::monitoring_address_out',
							                 '~thor_data400::base::monitoring_address_out' + thorlib.wuid()));				  
												    
create_blue := sequential(output(f_new_blue,,'~thor_data400::base::monitoring_address_bluemark' + thorlib.wuid()),
		    	                  fileservices.ClearSuperFile('~thor_data400::base::monitoring_address_bluemark'),
			  	             fileservices.AddSuperFile('~thor_data400::base::monitoring_address_bluemark',
							                             '~thor_data400::base::monitoring_address_bluemark' + thorlib.wuid()));												    
												    
create_base := sequential(output(f_new_base,,'~thor_data400::base::monitoring_customer_temp' + thorlib.wuid()),
			           fileservices.ClearSuperFile('~thor_data400::base::monitoring_customer_base'),
			  	      fileservices.AddSuperFile('~thor_data400::base::monitoring_customer_base',
							                             '~thor_data400::base::monitoring_customer_temp' + thorlib.wuid()));
												    
//final stage: create output file
create_files := sequential(set_triple, set_double, set_single,
			            create_update, create_out, create_blue, if(has_triple, create_base));
						
export Proc_Best_Address_Searching := create_files;						