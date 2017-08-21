import address, monitoring, monitoring_other, ut;

//import property hisotry 
f_hist_prp_base := distribute(monitoring_other.file_prp_history, 
                              hash(customer_id, record_id, prim_name_d, zip_d,  prim_range_d));
f_hist_prp_in := monitoring.files.ShortHistoryProperty;
			    
monitoring_other.layout_prp_slim prp_in2std(f_hist_prp_in l) := transform
   	self.prim_range_d := l.prim_range;
    self.predir_d := l.predir;
    self.prim_name_d := l.prim_name;
    self.suffix_d := l.addr_suffix;
    self.postdir_d := l.postdir;
    self.unit_desig_d := l.unit_desig;
    self.sec_range_d := l.sec_range;
    self.p_city_name_d := l.p_city_name;
    self.st_d := l.st;
    self.zip_d := l.zip5;
    self.zip4_d := l.zip4;
		self.parcel_number_1 := l.parcel_number;
		self.name_owner_1_1 := l.name_owner_1;                                                  
		self.name_owner_2_1 := l.name_owner_2; 
		self.date_in := l.wuid[2..9];
    self := l;		
    self := [];
end;

f_hist_prp_in_std := distribute(project(f_hist_prp_in, prp_in2std(left)),
                                 hash(customer_id, record_id, prim_name_d, zip_d,  prim_range_d));

f_hist_prp_in_srt := sort(f_hist_prp_in_std, record, local);
f_hist_prp_in_dep := dedup(f_hist_prp_in_srt, record, local);

monitoring_other.layout_prp_slim get_hist_prp_before(f_hist_prp_in_dep l) := transform
	self := l;
end;				 
				 
f_hist_prp_new := join(f_hist_prp_in_dep, f_hist_prp_base,
                        left.customer_id = right.customer_id and 
			                  left.record_id = right.record_id and
			                  left.prim_name_d = right.prim_name_d and 
			                  left.zip_d = right.zip_d and
			                  left.prim_range_d = right.prim_range_d and
			   	              (left.sec_range_d='' or 
			                   right.sec_range_d<>'' and left.sec_range_d=right.sec_range_d), 
				                get_hist_prp_before(left), left only, local);
				      
				  				  			  
create_prp_hist := sequential(output(f_hist_prp_new,,'~thor_data400::base::monitoring_property_history_before' + thorlib.wuid()),
			  	                    fileservices.AddSuperFile('~thor_data400::base::monitoring_property_history',
							                                          '~thor_data400::base::monitoring_property_history_before' + thorlib.wuid()));

//import paw history																												
f_hist_paw_base := distribute(monitoring_other.file_paw_history, hash(customer_id, record_id));
f_hist_paw_in := monitoring.files.ShortHistoryPAW;
			    
monitoring_other.layout_paw_hist paw_in2std(f_hist_paw_in l) := transform
			 self.pawk_first_1 := l.name_first;                                                   
			 self.pawk_middle_1 := l.name_middle;                                                  
			 self.pawk_last_1 := l.name_last;                                                    
			 self.pawk_suffix_1 := l.name_suffix;                                                  
			 self.pawk_ssn_1 := l.ssn;                                                      
			 self.pawk_title_1 := l.title;                                                    
			 self.pawk_name_company_1 := l.company;                                             
			 self.pawk_department_1 := l.department;                                               
			 self.pawk_fein_1 := l.fein;                                                     
			 self.pawk_address_1 := address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name,
                                                          l.addr_suffix, l.postdir, l.unit_desig, l.sec_range);                                                  
			 self.pawk_city_1 := l.p_city_name;                                                     
			 self.pawk_state_1 := l.st;                                                    
			 self.pawk_zip_1 := l.zip5;                                                      
			 self.pawk_zip4_1 := l.zip4;                                                     
			 self.pawk_phone10_1 := l.phone10;                                                  
			 self.pawk_verified_1 := l.verified;
			 self.pawk_email_1 := l.email;                                                    
			 self.pawk_first_seen_1 := '';                                               
			 self.pawk_last_seen_1 := '';                                                
			 self.pawk_confidence_level_1 := l.confidence_level;    
			 self.date_in := l.wuid[2..9];
   	   self := l;		
       self := [];
end;

f_hist_paw_in_std := distribute(project(f_hist_paw_in, paw_in2std(left)),hash(customer_id, record_id));

f_hist_paw_in_srt := sort(f_hist_paw_in_std, record, local);
f_hist_paw_in_dep := dedup(f_hist_paw_in_srt, record, local);

monitoring_other.layout_paw_hist get_hist_paw_before(f_hist_paw_in_dep l) := transform
	self := l;
end;				 
				 
f_hist_paw_new := join(f_hist_paw_in_dep, f_hist_paw_base,
                        left.customer_id = right.customer_id and 
			                  left.record_id = right.record_id and
			                  left.pawk_name_company_1 = right.pawk_name_company_1,
				                get_hist_paw_before(left), left only, local);

create_paw_hist := sequential(output(f_hist_paw_new,,'~thor_data400::base::monitoring_paw_history_before' + thorlib.wuid()),
			  	                    fileservices.AddSuperFile('~thor_data400::base::monitoring_paw_history',
							                                          '~thor_data400::base::monitoring_paw_history_before' + thorlib.wuid()));
																												
//clean vlad's history file
clear_in_super := parallel (
  monitoring.FileUtils.CleanSTHProperty (),
  monitoring.FileUtils.CleanSTHPaw ()
);
																											
export proc_prp_paw_history_update_before := sequential(create_prp_hist, create_paw_hist, clear_in_super);
