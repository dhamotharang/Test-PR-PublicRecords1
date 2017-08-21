import monitoring;

f_hist_addr_base := distribute(monitoring.file_address_history, 
                               hash(customer_id, record_id, prim_name, z5,  prim_range));
f_hist_addr_in := monitoring.files.ShortHistoryAddr;
f_hist_phone_base := distribute(monitoring.file_phone_history,
                                hash(customer_id, record_id, phone10));
f_hist_phone_in := monitoring.files.ShortHistoryPhone;
			    
monitoring.Layout_Address_History addr_in2std(f_hist_addr_in l) := transform
   self.suffix := l.addr_suffix;
   self.z5 := l.zip5;
   self.z4 := l.zip4;
   self.addr_version_number := StringLib.GetDateYYYYMMDD();
   self := l;
end;

f_hist_addr_in_std := distribute(project(f_hist_addr_in(prim_name<>''), addr_in2std(left)),
                                 hash(customer_id, record_id, prim_name, z5,  prim_range));

f_hist_addr_in_srt := sort(f_hist_addr_in_std, record, local);
f_hist_addr_in_dep := dedup(f_hist_addr_in_srt, record, local);

monitoring.Layout_Address_History get_hist_addr_before(f_hist_addr_in_dep l) := transform
	self := l;
end;				 
				 
f_hist_addr_new := join(f_hist_addr_in_dep, f_hist_addr_base,
                           left.customer_id = right.customer_id and 
			            left.record_id = right.record_id and
			            left.prim_name = right.prim_name and 
			            left.z5 = right.z5 and
			            left.prim_range = right.prim_range and
			   	       (left.sec_range='' or 
			            right.sec_range<>'' and left.sec_range=right.sec_range), 
				       get_hist_addr_before(left), left only, local);
				      
monitoring.Layout_Phone_Update phone_in2std(f_hist_phone_in l) := transform
   self.phone_type := '';
   self.phone_version_number := StringLib.GetDateYYYYMMDD();
   self := l;
   self := [];
end;

f_hist_phone_in_std := distribute(project(f_hist_phone_in((unsigned)phone10<>0), phone_in2std(left)),
                                  hash(customer_id, record_id, phone10));

f_hist_phone_in_srt := sort(f_hist_phone_in_std, record, local);
f_hist_phone_in_dep := dedup(f_hist_phone_in_srt, record, local);

monitoring.Layout_Phone_Update get_hist_phone_before(f_hist_phone_in_dep l) := transform
	self := l;
end;				 
				 
f_hist_phone_new := join(f_hist_phone_in_dep, f_hist_phone_base,
                           left.customer_id = right.customer_id and 
			            left.record_id = right.record_id and
			            left.phone10 = right.phone10 and
			            (left.phone_type = right.phone_type or right.phone_type=''), 
				       get_hist_phone_before(left), left only, local);
				  				  			  
create_addr_hist := sequential(output(f_hist_addr_new,,'~thor_data400::base::monitoring_address_history_before' + thorlib.wuid()),
			  	                  fileservices.AddSuperFile('~thor_data400::base::monitoring_address_history',
							                             '~thor_data400::base::monitoring_address_history_before' + thorlib.wuid()));

create_phone_hist := sequential(output(f_hist_phone_new,,'~thor_data400::base::monitoring_phone_history_before' + thorlib.wuid()),
		  	  	                   fileservices.AddSuperFile('~thor_data400::base::monitoring_phone_history',
							                              '~thor_data400::base::monitoring_phone_history_before' + thorlib.wuid()));


//clean vlad's history file
clear_in_super := parallel (
  monitoring.FileUtils.CleanSTHAddress (),
  monitoring.FileUtils.CleanSTHPhone ()
);
					    
export proc_update_history_before := sequential(create_addr_hist, create_phone_hist, clear_in_super);
