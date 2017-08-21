import address, monitoring, ut;

cust_base_new := dedup(sort(distribute(monitoring.File_Customer_Base(customer_id[1..3]='NCO'), hash(customer_id, record_id)), 
                                       customer_id, record_id, -name_last, -ssn, -prim_range, local), 
				                    customer_id, record_id, local);
cust_base_old := dedup(sort(distribute(monitoring.File_Customer_Base_2(customer_id[1..3]='NCO'), hash(customer_id, record_id)),
                                 customer_id, record_id, -name_last, -ssn, -prim_range, local),
												    customer_id, record_id, local);

ext_base_layout := record
	monitoring.layout_customer_base;
	string1 rec_flag;
end;	

ext_base_layout create_delta_file(cust_base_new l, cust_base_old r) := transform
  self.rec_flag := map(l.customer_id<>'' and  r.customer_id='' => 'A', 
											 l.customer_id='' and r.customer_id<>'' => 'D', '');
	self := if(l.customer_id<>'', l, r); 
end;

cust_base_delta := join(cust_base_new, cust_base_old,
                        left.customer_id = right.customer_id and 
												left.record_id = right.record_id,
												create_delta_file(left, right), full outer, local) : persist('per_cust_base_delta');

monitoring.layout_delta_file_out generate_delta_out(cust_base_delta l) := transform
	SELF.DATETIME_STAMP := l.date_in;
  SELF.GLOBAL_COMPANY_ID := '';
  SELF.COMPANY_ID := l.customer_id;	
  SELF.PRODUCT_CD := 'MONITORING';	
  SELF.METHOD := 'BATCH';	
  SELF.VERTICAL := 'COLLECTION';	
  SELF.FUNCTION_NAME := 'MONITORING';	
  SELF.TRANSACTION_TYPE := l.rec_flag;	
  SELF.LOGIN_HISTORY_ID := '';	
  SELF.JOB_ID := '';	
  SELF.SEQUENCE_NBR := l.record_id;		
	SELF.GLB_PURPOSE := '0';	
  SELF.DPPA_PURPOSE := '0';	
  SELF.FCRA_PURPOSE := '0';	
  SELF.ALLOW_FRAUD_PREVENTION := '';	
  SELF.ALLOW_ID_VERIFICATION := '';	
  SELF.ALLOW_AUTHENTICATION := '';	
  SELF.ALLOW_CREDIT_RISK := '';	
  SELF.ALLOW_INSURANCE := '';	
  SELF.ALLOW_COLLECTIONS := '';	
  SELF.ALLOW_LE := '';	
  SELF.ALLOW_MARKETING := '';	
  SELF.ALLOW_EMP_SCREENING := '';	
  SELF.ALLOW_TENANT_SCREENING := '';	
  SELF.ALLOW_ALL := '';	
  SELF.LINK_ID := (string14)sort(l.dids, did)[1].did;	
  SELF.FIRST_NAME := l.name_first;	
  SELF.MIDDLE_NAME := l.name_middle;	
  SELF.LAST_NAME := l.name_last;	
  SELF.FULL_NAME := trim(l.name_first) + ' ' + trim(l.name_middle) + ' ' + trim(l.name_last);	
  SELF.SSN := l.ssn;	
  SELF.DOB := l.dob;	
  SELF.ADDR1_STREET := address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name,
                                                   l.suffix, l.postdir, l.unit_desig, l.sec_range);	
  SELF.ADDR1_CITY := l.p_city_name;	
  SELF.ADDR1_STATE := l.st;	
  SELF.ADDR1_ZIP := l.z5;	
  SELF.PHONE := l.phoneno;	
  SELF.REFERENCE_CODE := '';	
  SELF.STOP_MONITOR := if(l.rec_flag='D',ut.GetDate,'');	
	SELF := [];
end;

cust_base_update := project(cust_base_delta(rec_flag in ['A','D']), generate_delta_out(left)) : persist('cust_base_update');

export proc_create_base_delta_file := sequential(output(cust_base_update,,'~thor_data400::base::monitoring_customer_base_delta' + thorlib.wuid(),
                                                        csv(separator(','), terminator('\n'), quote('"'))),
																								 fileservices.ClearSuperFile('~thor_data400::base::monitoring_customer_base_delta'),				
		  	  	                                     fileservices.AddSuperFile('~thor_data400::base::monitoring_customer_base_delta',
							                                                             '~thor_data400::base::monitoring_customer_base_delta' + thorlib.wuid()));
                                    
