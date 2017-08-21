import monitoring, doxie, address;

subj := Constants.T_SUBJECT;
phn  := Constants.T_PHONES;

f_customer_base := monitoring.file_customer_base;
f_customer_base_dist := distribute(f_customer_base, hash(customer_id, record_id));
f_in_base := monitoring.files.monitor;

monitoring.layout_customer_base get_std(f_in_base l) := transform
     self.suffix := l.addr_suffix;
	self.z5 := l.zip5;
	self.z4 := l.zip4;
	self.date_in := l.wuid[2..9];
	self.date_to_run := ''; //if(l.delay_time<>0,monitoring.func_calc_frequency(StringLib.GetDateYYYYMMDD(),
	                        //                                                  l.delay_type,
					    //   								           l.delay_time), '');
    m_phones := l.matrix (subject = subj.PHONE);
    m_address := l.matrix (subject = subj.ADDRESS);
		//need address to find phone, will filter out the address later, if don't need address
 	  self.best_address_number := if (exists (m_address), m_address[1].best_number, 1); 
	  self.best_phone_number   := if (exists (m_phones), m_phones[1].best_number, 0);
	  self.phone_level_ta      := exists (m_phones) AND (m_phones[1].sub_type & phn.PHONE_TA = phn.PHONE_TA);
	  self.phone_level_tb      := exists (m_phones) AND (m_phones[1].sub_type & phn.PHONE_TB = phn.PHONE_TB);
	  self.phone_level_td      := exists (m_phones) AND (m_phones[1].sub_type & phn.PHONE_TC = phn.PHONE_TC);
	  self.phone_level_tg      := exists (m_phones) AND (m_phones[1].sub_type & phn.PHONE_TG = phn.PHONE_TG);

	  self.phone_level_other1  := exists (l.matrix (subject = subj.PROPERTY));
	  self.phone_level_other2  := exists (l.matrix (subject = subj.PAW));
	 
	self := l;

	self := []; //phone_level_other2, phone_level_other3, dids
end;

f_in_base_std := project(f_in_base, get_std(left));

f_in_base_dist := distribute(f_in_base_std, hash(customer_id, record_id));

monitoring.layout_customer_base get_customer_base(f_in_base_dist l, f_customer_base_dist r) := transform
  is_add := r.customer_id='' and r.record_id='';
  is_update := if(r.customer_id<>'' and r.record_id<>'' and (unsigned)l.date_in>(unsigned)r.date_in, true, false);
	
	//clean name if add or update
	clean_name := if(is_add or is_update, address.CleanPersonFML73(trim(l.name_first) + ' ' +
	                                                                    trim(l.name_middle) + ' ' +
									                            trim(l.name_last) + ' ' +
									                            trim(l.name_suffix)),'');
	self.name_first := if(is_add or is_update, clean_name[6..25], r.name_first);
	self.name_middle := if(is_add or is_update, clean_name[26..45], r.name_middle);
	self.name_last := if(is_add or is_update, clean_name[46..65], r.name_last);
	self.name_suffix := if(is_add or is_update, clean_name[66..70],r.name_suffix);
	self.ssn := if(is_add or is_update, map(l.ssn='' => '',
	                                        (integer)l.ssn in doxie.bad_ssn_list => '', 
																			 	  l.ssn), 
	               r.ssn);
	
	//get saved information
	self.dids := if(is_update, dataset([], doxie.layout_references), r.dids);
	self.addr_version_number := if(is_update,'',r.addr_version_number);
	self.phone_version_number := if(is_update,'',r.phone_version_number);
	self.date_to_run := ''; //if(r.customer_id<>'' and r.record_id<>'' and ~is_update, 
	                        //   r.date_to_run, l.date_to_run);
	self := l;
end;

f_in_base_new := join(f_in_base_dist, f_customer_base_dist,
                      left.customer_id = right.customer_id and
				  left.record_id = right.record_id,
				  get_customer_base(left, right), left outer, keep(1), local);

create_base_in := sequential(output(f_in_base_new,,'~thor_data400::base::monitoring_customer_base_in' + thorlib.wuid()),
                                    fileservices.ClearSuperFile('~thor_data400::base::monitoring_customer_base_2'),
								                    fileservices.AddSuperFile('~thor_data400::base::monitoring_customer_base_2',
							                                                '~thor_data400::base::monitoring_customer_base',, true),  
                                    fileservices.ClearSuperFile('~thor_data400::base::monitoring_customer_base'),
		  	  	                fileservices.AddSuperFile('~thor_data400::base::monitoring_customer_base',
							                           '~thor_data400::base::monitoring_customer_base_in' + thorlib.wuid()));

export Proc_Update_Customer_Base := create_base_in;