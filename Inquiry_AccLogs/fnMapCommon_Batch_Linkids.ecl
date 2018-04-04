import data_services, inquiry_acclogs, ut,lib_stringlib;

EXPORT fnMapCommon_Batch_Linkids := Module


export ready_file := function


fadditionfile := Inquiry_AccLogs.fnMapCommon_Batch.additionfile
									(orig_process_id in ['306','311','49','375']);
										
inquiry_acclogs.fncleanfunctions.cleanfields(fadditionfile, cleaned_fields);

input_data_dist := distribute(cleaned_fields, hash(orig_job_id));

input_data_dedup := dedup(sort(input_data_dist,record, local), record,local);

companyRec := RECORD

		string 		orig_datetime_stamp;
		string20 	orig_job_id;
		string 		orig_sequence_number;
		string    orig_process_id;
			
		string20 	orig_company_fax_number;         
		string9 	orig_fein;                
		string8 	orig_company_sic_code;            
		string8 	orig_company_naic_code;            
		string32 	orig_company_structure;   
		string3 	orig_company_years_in_business; 
		string8 	orig_company_start_date;       
		string12 	orig_company_yearly_revenue;
		string100 orig_company_alternate_name; 

END;

cleanCompanyRec := RECORD

		string datetime;
		string20 transaction_id;
		string sequence_number;
		string process_id;

		string20 	company_fax_number;         
		string9 	company_fein;                
		string8 	company_sic_code;            
		string8 	company_naic_code;            
		string32 	company_structure;   
		string3 	company_years_in_business; 
		string8 	company_start_date;       
		string12 	company_yearly_revenue; 
		string100 company_alternate_name; 
		
END;

cleanCompany := project(input_data_dedup,
									transform(cleanCompanyRec,
									fixtime := inquiry_acclogs.fncleanfunctions.ttimeadded(left.orig_datetime_stamp[1..8] + ' ' + left.orig_datetime_stamp[9..16]);
									self.datetime := fixtime;	
									self.Transaction_ID := left.orig_job_id;
									self.Sequence_number := left.orig_sequence_number;
									self.process_id     := left.orig_process_id;
									
									self.company_fax_number        		:=	inquiry_acclogs.fncleanfunctions.clean_phone(left.orig_company_fax_number);         
									self.company_fein                	:=	left.orig_fein;                
									self.company_sic_code            	:=	left.orig_company_sic_code;            
									self.company_naic_code            :=	left.orig_company_naic_code;            
									self.company_structure   					:=	left.orig_company_structure;   
									self.company_years_in_business 		:=	left.orig_company_years_in_business; 
									self.company_start_date       		:=	left.orig_company_start_date;       
									self.company_yearly_revenue 			:=	left.orig_company_yearly_revenue; 
									self.company_alternate_name       :=  left.orig_company_alternate_name;
									
									self := left;
									self := []));

subjectNormRec := RECORD

		unsigned  subj_nbr;
		string 		orig_datetime_stamp;
		string20 	orig_job_id;

		string 		orig_sequence_number;
		string 		orig_subj_first_name;
		string 		orig_subj_middle_name;
		string 		orig_subj_last_name;
		string 		orig_subj_suffix_name;
		string 		orig_subj_full_name;
		string 		orig_subj_ssn;
		string 		orig_subj_dob;
		string 		orig_subj_dl_num;
		string 		orig_subj_dl_state;
		string 		orig_subj_former_last_name;
		string 		orig_subj_address_addressline1;
		string 		orig_subj_address_addressline2;
		string 		orig_subj_address_prim_range;
		string 		orig_subj_address_predir;
		string 		orig_subj_address_prim_name;
		string 		orig_subj_address_suffix;
		string 		orig_subj_address_postdir;
		string 		orig_subj_address_unit_desig;
		string 		orig_subj_address_sec_range;
		string 		orig_subj_address_city;
		string 		orig_subj_address_st;
		string 		orig_subj_address_z5;
		string 		orig_subj_address_z4;
		string 		orig_subj_phone;
		string 		orig_subj_work_phone;
		string 		orig_subj_business_title;
		string 		orig_subj_email;
		string 		orig_subj_company_name;
		string 		orig_subj_fein;
END;

subjectNormRec fSubjectNorm(Inquiry_AccLogs.Layout_Batch_Logs.addedInput L,INTEGER C ) := TRANSFORM
SELF := L;
SELF.subj_nbr  := C;
self.orig_subj_first_name := CHOOSE(C,L.orig_first_name,L.orig_subj2_first_name,L.orig_subj3_first_name,L.orig_subj4_first_name,L.orig_subj5_first_name,L.orig_subj6_first_name,L.orig_subj7_first_name,L.orig_subj8_first_name);
self.orig_subj_middle_name := CHOOSE(C,L.orig_middle_name,L.orig_subj2_middle_name,L.orig_subj3_middle_name,L.orig_subj4_middle_name,L.orig_subj5_middle_name,L.orig_subj6_middle_name,L.orig_subj7_middle_name,L.orig_subj8_middle_name);
self.orig_subj_last_name := CHOOSE(C,L.orig_last_name,L.orig_subj2_last_name,L.orig_subj3_last_name,L.orig_subj4_last_name,L.orig_subj5_last_name,L.orig_subj6_last_name,L.orig_subj7_last_name,L.orig_subj8_last_name);
self.orig_subj_suffix_name := CHOOSE(C,L.orig_suffix_name,L.orig_subj2_suffix_name,L.orig_subj3_suffix_name,L.orig_subj4_suffix_name,L.orig_subj5_suffix_name,L.orig_subj6_suffix_name,L.orig_subj7_suffix_name,L.orig_subj8_suffix_name);
self.orig_subj_full_name := CHOOSE(C,L.orig_full_name,L.orig_subj2_full_name,L.orig_subj3_full_name,L.orig_subj4_full_name,L.orig_subj5_full_name,L.orig_subj6_full_name,L.orig_subj7_full_name,L.orig_subj8_full_name);
self.orig_subj_ssn := CHOOSE(C,L.orig_ssn,L.orig_subj3_ssn,L.orig_subj2_ssn,L.orig_subj3_ssn,L.orig_subj4_ssn,L.orig_subj5_ssn,L.orig_subj6_ssn,L.orig_subj7_ssn,L.orig_subj8_ssn);
self.orig_subj_dob := CHOOSE(C,L.orig_dob,L.orig_subj3_dob,L.orig_subj4_dob,L.orig_subj5_dob,L.orig_subj6_dob,L.orig_subj7_dob,L.orig_subj8_dob);
self.orig_subj_dl_num := CHOOSE(C,L.orig_dl_num,L.orig_subj2_dl_num,L.orig_subj3_dl_num,L.orig_subj4_dl_num,L.orig_subj5_dl_num,L.orig_subj6_dl_num,L.orig_subj7_dl_num,L.orig_subj8_dl_num);
self.orig_subj_dl_state := CHOOSE(C,L.orig_dl_state,L.orig_subj2_dl_state,L.orig_subj3_dl_state,L.orig_subj4_dl_state,L.orig_subj5_dl_state,L.orig_subj6_dl_state,L.orig_subj7_dl_state,L.orig_subj8_dl_state);
self.orig_subj_former_last_name := CHOOSE(C,L.orig_former_last_name,L.orig_subj2_former_last_name,L.orig_subj3_former_last_name,L.orig_subj4_former_last_name,L.orig_subj5_former_last_name,L.orig_subj6_former_last_name,L.orig_subj7_former_last_name,L.orig_subj8_former_last_name);
self.orig_subj_address_addressline1 := CHOOSE(C,L.orig_address1_addressline1,L.orig_subj2_address_addressline1,L.orig_subj3_address_addressline1,L.orig_subj4_address_addressline1,L.orig_subj5_address_addressline1,L.orig_subj6_address_addressline1,L.orig_subj7_address_addressline1,L.orig_subj8_address_addressline1);
self.orig_subj_address_addressline2 := CHOOSE(C,L.orig_address1_addressline2,L.orig_subj2_address_addressline2,L.orig_subj3_address_addressline2,L.orig_subj4_address_addressline2,L.orig_subj5_address_addressline2,L.orig_subj6_address_addressline2,L.orig_subj7_address_addressline2,L.orig_subj8_address_addressline2);
self.orig_subj_address_prim_range := CHOOSE(C,L.orig_address1_prim_range,L.orig_subj2_address_prim_range,L.orig_subj3_address_prim_range,L.orig_subj4_address_prim_range,L.orig_subj5_address_prim_range,L.orig_subj6_address_prim_range,L.orig_subj7_address_prim_range,L.orig_subj8_address_prim_range);
self.orig_subj_address_predir := CHOOSE(C,L.orig_address1_predir,L.orig_subj2_address_predir,L.orig_subj3_address_predir,L.orig_subj4_address_predir,L.orig_subj5_address_predir,L.orig_subj6_address_predir,L.orig_subj7_address_predir,L.orig_subj8_address_predir);
self.orig_subj_address_prim_name := CHOOSE(C,L.orig_address1_prim_name,L.orig_subj2_address_prim_name,L.orig_subj3_address_prim_name,L.orig_subj4_address_prim_name,L.orig_subj5_address_prim_name,L.orig_subj6_address_prim_name,L.orig_subj7_address_prim_name,L.orig_subj8_address_prim_name);
self.orig_subj_address_suffix := CHOOSE(C,L.orig_address1_suffix,L.orig_subj2_address_suffix,L.orig_subj3_address_suffix,L.orig_subj4_address_suffix,L.orig_subj5_address_suffix,L.orig_subj6_address_suffix,L.orig_subj7_address_suffix,L.orig_subj8_address_suffix);
self.orig_subj_address_postdir := CHOOSE(C,L.orig_address1_postdir,L.orig_subj2_address_postdir,L.orig_subj3_address_postdir,L.orig_subj4_address_postdir,L.orig_subj5_address_postdir,L.orig_subj6_address_postdir,L.orig_subj7_address_postdir,L.orig_subj8_address_postdir);
self.orig_subj_address_unit_desig := CHOOSE(C,L.orig_address1_unit_desig,L.orig_subj2_address_unit_desig,L.orig_subj3_address_unit_desig,L.orig_subj4_address_unit_desig,L.orig_subj5_address_unit_desig,L.orig_subj6_address_unit_desig,L.orig_subj7_address_unit_desig,L.orig_subj8_address_unit_desig);
self.orig_subj_address_sec_range := CHOOSE(C,L.orig_address1_sec_range,L.orig_subj2_address_sec_range,L.orig_subj3_address_sec_range,L.orig_subj4_address_sec_range,L.orig_subj5_address_sec_range,L.orig_subj6_address_sec_range,L.orig_subj7_address_sec_range,L.orig_subj8_address_sec_range);
self.orig_subj_address_city := CHOOSE(C,L.orig_address1_city,L.orig_subj2_address_city,L.orig_subj3_address_city,L.orig_subj4_address_city,L.orig_subj5_address_city,L.orig_subj6_address_city,L.orig_subj7_address_city,L.orig_subj8_address_city);
self.orig_subj_address_st := CHOOSE(C,L.orig_address1_st,L.orig_subj2_address_st,L.orig_subj3_address_st,L.orig_subj4_address_st,L.orig_subj5_address_st,L.orig_subj6_address_st,L.orig_subj7_address_st,L.orig_subj8_address_st);
self.orig_subj_address_z5 := CHOOSE(C,L.orig_address1_z5,L.orig_subj2_address_z5,L.orig_subj3_address_z5,L.orig_subj4_address_z5,L.orig_subj5_address_z5,L.orig_subj6_address_z5,L.orig_subj7_address_z5,L.orig_subj8_address_z5);
self.orig_subj_address_z4 := CHOOSE(C,L.orig_address1_z4,L.orig_subj2_address_z4,L.orig_subj3_address_z4,L.orig_subj4_address_z4,L.orig_subj5_address_z4,L.orig_subj6_address_z4,L.orig_subj7_address_z4,L.orig_subj8_address_z4);
self.orig_subj_phone := CHOOSE(C,L.orig_phone,L.orig_subj2_phone,L.orig_subj3_phone,L.orig_subj4_phone,L.orig_subj5_phone,L.orig_subj6_phone,L.orig_subj7_phone,L.orig_subj8_phone);
self.orig_subj_work_phone := CHOOSE(C,L.orig_work_phone,L.orig_subj2_work_phone,L.orig_subj3_work_phone,L.orig_subj4_work_phone,L.orig_subj5_work_phone,L.orig_subj6_work_phone,L.orig_subj7_work_phone,L.orig_subj8_work_phone);
self.orig_subj_business_title := CHOOSE(C,L.orig_business_title,L.orig_subj2_business_title,L.orig_subj3_business_title,L.orig_subj4_business_title,L.orig_subj5_business_title,L.orig_subj6_business_title,L.orig_subj7_business_title,L.orig_subj8_business_title);
self.orig_subj_email := CHOOSE(C,L.orig_email_address,L.orig_subj2_email,L.orig_subj3_email,L.orig_subj4_email,L.orig_subj5_email,L.orig_subj6_email,L.orig_subj7_email,L.orig_subj8_email);
self.orig_subj_company_name := CHOOSE(C,L.orig_company_name,L.orig_subj2_company_name,L.orig_subj3_company_name,L.orig_subj4_company_name,L.orig_subj5_company_name,L.orig_subj6_company_name,L.orig_subj7_company_name,L.orig_subj8_company_name);
self.orig_subj_fein := CHOOSE(C,L.orig_fein,L.orig_subj2_fein,L.orig_subj3_fein,L.orig_subj4_fein,L.orig_subj5_fein,L.orig_subj6_fein,L.orig_subj7_fein,L.orig_subj8_fein);
end;

SubjectNorm := NORMALIZE(input_data_dedup, 8, fSubjectNorm(LEFT, COUNTER));


cleanSubjectRec := RECORD

		string datetime;
		string20 transaction_id;
		string sequence_number;

		string subj_first_name;
		string subj_middle_name;
		string subj_last_name;
		string subj_suffix_name;
		string subj_full_name;
		string subj_ssn;
		string subj_dob;
		string subj_dl_num;
		string subj_dl_state;
		string subj_former_last_name;
		string subj_address_addressline1;
		string subj_address_addressline2;
		string subj_address_prim_range;
		string subj_address_predir;
		string subj_address_prim_name;
		string subj_address_suffix;
		string subj_address_postdir;
		string subj_address_unit_desig;
		string subj_address_sec_range;
		string subj_address_city;
		string subj_address_st;
		string subj_address_z5;
		string subj_address_z4;
		string subj_phone;
		string subj_work_phone;
		string subj_business_title;
		string subj_email;
		string subj_company_name;
		string subj_company_fein;
END;

cleanSubject := project(SubjectNorm,
									transform(cleanSubjectRec,
									fixtime := inquiry_acclogs.fncleanfunctions.ttimeadded(left.orig_datetime_stamp[1..8] + ' ' + left.orig_datetime_stamp[9..16]);
									self.datetime := fixtime;	
									self.Transaction_ID := left.orig_job_id;
									self.Sequence_number := left.orig_sequence_number;

									self.subj_first_name := left.orig_subj_first_name;
									self.subj_middle_name := left.orig_subj_middle_name;
									self.subj_last_name   := left.orig_subj_last_name;
									self.subj_suffix_name := left.orig_subj_suffix_name;
									self.subj_full_name :=  map(left.orig_subj_full_name <> '' => left.orig_subj_full_name, 
													  									left.orig_subj_first_name + 
																							left.orig_subj_middle_name + 
																							left.orig_subj_last_name <> '' 
																							 															 => stringlib.stringcleanspaces(left.orig_subj_first_name + ' ' + 
																																						                                left.orig_subj_middle_name + ' ' + 
																																																					  left.orig_subj_last_name)
																								 													     ,'');
									
									
									self.subj_ssn       				:= inquiry_acclogs.fncleanfunctions.clean_ssn(left.orig_subj_ssn);
									self.subj_dob       				:= inquiry_acclogs.fncleanfunctions.clean_dob(left.orig_subj_dob);
									self.subj_dl_num    				:= left.orig_subj_dl_num;
									self.subj_dl_state  				:= left.orig_subj_dl_state;
								  self.subj_former_last_name 	:= left.orig_subj_former_last_name;
						
									line1 := map(left.orig_subj_address_addressline1 <> '' => left.orig_subj_address_addressline1,
									stringlib.stringcleanspaces(left.orig_subj_address_prim_range + ' ' + 
												left.orig_subj_address_predir + ' ' +
												left.orig_subj_address_prim_name + ' ' +
												left.orig_subj_address_suffix + ' ' +
												left.orig_subj_address_postdir + ' ' +
												left.orig_subj_address_unit_desig + ' ' +
												left.orig_subj_address_sec_range));
									self.subj_address_addressline1 := line1;

									line2 := map(left.orig_subj_address_addressline2 <> '' => left.orig_subj_address_addressline2, 
									stringlib.stringcleanspaces(left.orig_subj_address_city + ' ' + 
												left.orig_subj_address_st + ' ' +
												left.orig_subj_address_z5 + ' ' +
												left.orig_subj_address_z4));
									self.subj_address_addressline2 		:= line2;
									self.subj_address_prim_range 			:= left.orig_subj_address_prim_range;		
									self.subj_address_predir					:= left.orig_subj_address_predir;		
									self.subj_address_prim_name				:= left.orig_subj_address_prim_name;		
									self.subj_address_suffix					:= left.orig_subj_address_suffix;		
									self.subj_address_postdir					:= left.orig_subj_address_postdir;		
									self.subj_address_unit_desig			:= left.orig_subj_address_unit_desig;		
									self.subj_address_sec_range				:= left.orig_subj_address_sec_range;		
									self.subj_address_city						:= left.orig_subj_address_city;
									self.subj_address_st 							:= left.orig_subj_address_st;
									self.subj_address_z5 							:= left.orig_subj_address_z5;
									self.subj_address_z4 							:= left.orig_subj_address_z4;
									self.subj_phone 									:= inquiry_acclogs.fncleanfunctions.clean_phone(left.orig_subj_phone);
									self.subj_work_phone							:= inquiry_acclogs.fncleanfunctions.clean_phone(left.orig_subj_work_phone);
									self.subj_business_title					:= left.orig_subj_business_title;
									self.subj_email 									:= left.orig_subj_email;
									self.subj_company_name            := left.orig_subj_company_name;
									self.subj_company_fein										:= left.Orig_subj_fein;
									self := left;
									self := []));

DeNormCleanInputRec := RECORD
		unsigned  numrows;
		string datetime;
		string20 transaction_id;
		string sequence_number;
    string process_id;
		
		string20 	company_fax_number;         
		string9 	company_fein;                
		string8 	company_sic_code;            
		string8 	company_naic_code;            
		string32 	company_structure;   
		string3 	company_years_in_business; 
		string8 	company_start_date;       
		string12 	company_yearly_revenue;
		string100 company_alternate_name;		
		
		DATASET(cleanSubjectRec) subjects;
END;

DenormCleanInputRec ParentMove(CleanCompanyRec L) := TRANSFORM
		SELF.NumRows := 0;
		SELF.subjects := [];
		SELF := L;
END;

companyOnly := PROJECT(cleanCompany, ParentMove(LEFT));

DenormCleanInputRec ChildMove(DenormCleanInputRec L,cleanSubjectRec R,INTEGER C):=TRANSFORM
		SELF.NumRows := C;
		SELF.subjects := L.subjects + R;
		SELF := L;
END;
DeNormCleanInput  := DENORMALIZE(CompanyOnly,cleanSubject,
                            	left.datetime =right.datetime and 
															left.transaction_id = right.transaction_id and
															left.sequence_number = right.sequence_number,
                            ChildMove(LEFT,RIGHT,COUNTER));

AppendTransCompanySubjects := project(DeNormCleanInput, transform(inquiry_acclogs.Layout_Batch_Logs.addedCleaned, 
			
			self.datetime 															:= left.datetime ;
			self.transaction_id													:= left.transaction_id;
			self.sequence_number                       	:= left.sequence_number;                      
			self.process_id                             := left.process_id;
			
			self.cmp_fax_number        									:= left.company_fax_number;        
			self.cmp_fein                								:= left.company_fein;              
			self.cmp_sic_code            								:= left.company_sic_code;        
			self.cmp_naic_code            							:= left.company_naic_code;    
			self.cmp_business_structure   							:= left.company_structure;
			self.cmp_years_in_business 									:= left.company_years_in_business; 
			self.cmp_bus_start_date       							:= left.company_start_date; 
			self.cmp_yearly_revenue 										:= left.company_yearly_revenue;
			self.cmp_alt_name				 										:= left.company_alternate_name;			
			
			self.pii2_first_name    			:= left.subjects[2].subj_first_name;
			self.pii2_middle_name    			:= left.subjects[2].subj_middle_name;
			self.pii2_last_name    				:= left.subjects[2].subj_last_name;
			self.pii2_suffix_name    			:= left.subjects[2].subj_suffix_name;
			self.pii2_former_last_name    := left.subjects[2].subj_former_last_name;
			self.pii2_address    					:= left.subjects[2].subj_address_addressline1;
			self.pii2_city    						:= left.subjects[2].subj_address_city;
			self.pii2_state    						:= left.subjects[2].subj_address_st;
			self.pii2_zip    							:= left.subjects[2].subj_address_z5;
			self.pii2_phone    						:= left.subjects[2].subj_phone;
			self.pii2_work_phone    			:= left.subjects[2].subj_work_phone;
			self.pii2_dob    							:= left.subjects[2].subj_dob;
			self.pii2_dl    							:= left.subjects[2].subj_dl_num;
			self.pii2_dl_state    				:= left.subjects[2].subj_dl_state;
			self.pii2_email    						:= left.subjects[2].subj_email;
			self.pii2_ssn    							:= left.subjects[2].subj_ssn;
			self.pii2_business_title    	:= left.subjects[2].subj_business_title;
			self.pii2_clean_first_name    := left.subjects[2].subj_first_name;
			self.pii2_clean_middle_name   := left.subjects[2].subj_middle_name;
			self.pii2_clean_last_name    	:= left.subjects[2].subj_last_name;
			self.pii2_clean_suffix_name   := left.subjects[2].subj_suffix_name;
			self.pii2_clean_prim_range    := left.subjects[2].subj_address_prim_range;
			self.pii2_clean_prim_name    	:= left.subjects[2].subj_address_prim_name;
			self.pii2_clean_addr_suffix   := left.subjects[2].subj_address_suffix;
			self.pii2_clean_postdir    		:= left.subjects[2].subj_address_postdir;
			self.pii2_clean_unit_desig    := left.subjects[2].subj_address_unit_desig;
			self.pii2_clean_sec_range    	:= left.subjects[2].subj_address_sec_range;
			self.pii2_clean_st    				:= left.subjects[2].subj_address_st;
			self.pii2_clean_zip5    			:= left.subjects[2].subj_address_z5;
			self.pii2_clean_zip4    			:= left.subjects[2].subj_address_z4;
			self.pii2_clean_predir    		:= left.subjects[2].subj_address_predir;
			self.pii2_cmp_name    				:= left.subjects[2].subj_company_name;
			self.pii2_cmp_fein    				:= left.subjects[2].subj_company_fein;
			
			self.pii3_first_name    			:= left.subjects[3].subj_first_name;
			self.pii3_middle_name    			:= left.subjects[3].subj_middle_name;
			self.pii3_last_name    				:= left.subjects[3].subj_last_name;
			self.pii3_suffix_name    			:= left.subjects[3].subj_suffix_name;
			self.pii3_former_last_name    := left.subjects[3].subj_former_last_name;
			self.pii3_address    					:= left.subjects[3].subj_address_addressline1;
			self.pii3_city    						:= left.subjects[3].subj_address_city;
			self.pii3_state    						:= left.subjects[3].subj_address_st;
			self.pii3_zip    							:= left.subjects[3].subj_address_z5;
			self.pii3_phone    						:= left.subjects[3].subj_phone;
			self.pii3_work_phone    			:= left.subjects[3].subj_work_phone;
			self.pii3_dob    							:= left.subjects[3].subj_dob;
			self.pii3_dl    							:= left.subjects[3].subj_dl_num;
			self.pii3_dl_state    				:= left.subjects[3].subj_dl_state;
			self.pii3_email    						:= left.subjects[3].subj_email;
			self.pii3_ssn    							:= left.subjects[3].subj_ssn;
			self.pii3_business_title    	:= left.subjects[3].subj_business_title;
			self.pii3_clean_first_name    := left.subjects[3].subj_first_name;
			self.pii3_clean_middle_name   := left.subjects[3].subj_middle_name;
			self.pii3_clean_last_name    	:= left.subjects[3].subj_last_name;
			self.pii3_clean_suffix_name   := left.subjects[3].subj_suffix_name;
			self.pii3_clean_prim_range    := left.subjects[3].subj_address_prim_range;
			self.pii3_clean_prim_name    	:= left.subjects[3].subj_address_prim_name;
			self.pii3_clean_addr_suffix   := left.subjects[3].subj_address_suffix;
			self.pii3_clean_postdir    		:= left.subjects[3].subj_address_postdir;
			self.pii3_clean_unit_desig    := left.subjects[3].subj_address_unit_desig;
			self.pii3_clean_sec_range    	:= left.subjects[3].subj_address_sec_range;
			self.pii3_clean_st    				:= left.subjects[3].subj_address_st;
			self.pii3_clean_zip5    			:= left.subjects[3].subj_address_z5;
			self.pii3_clean_zip4    			:= left.subjects[3].subj_address_z4;
			self.pii3_clean_predir    		:= left.subjects[3].subj_address_predir;
			self.pii3_cmp_name    				:= left.subjects[3].subj_company_name;
			self.pii3_cmp_fein    				:= left.subjects[3].subj_company_fein;
			
			self.pii4_first_name    			:= left.subjects[4].subj_first_name;
			self.pii4_middle_name    			:= left.subjects[4].subj_middle_name;
			self.pii4_last_name    				:= left.subjects[4].subj_last_name;
			self.pii4_suffix_name    			:= left.subjects[4].subj_suffix_name;
			self.pii4_former_last_name    := left.subjects[4].subj_former_last_name;
			self.pii4_address    					:= left.subjects[4].subj_address_addressline1;
			self.pii4_city    						:= left.subjects[4].subj_address_city;
			self.pii4_state    						:= left.subjects[4].subj_address_st;
			self.pii4_zip    							:= left.subjects[4].subj_address_z5;
			self.pii4_phone    						:= left.subjects[4].subj_phone;
			self.pii4_work_phone    			:= left.subjects[4].subj_work_phone;
			self.pii4_dob    							:= left.subjects[4].subj_dob;
			self.pii4_dl    							:= left.subjects[4].subj_dl_num;
			self.pii4_dl_state    				:= left.subjects[4].subj_dl_state;
			self.pii4_email    						:= left.subjects[4].subj_email;
			self.pii4_ssn    							:= left.subjects[4].subj_ssn;
			self.pii4_business_title    	:= left.subjects[4].subj_business_title;
			self.pii4_clean_first_name    := left.subjects[4].subj_first_name;
			self.pii4_clean_middle_name   := left.subjects[4].subj_middle_name;
			self.pii4_clean_last_name    	:= left.subjects[4].subj_last_name;
			self.pii4_clean_suffix_name   := left.subjects[4].subj_suffix_name;
			self.pii4_clean_prim_range    := left.subjects[4].subj_address_prim_range;
			self.pii4_clean_prim_name    	:= left.subjects[4].subj_address_prim_name;
			self.pii4_clean_addr_suffix   := left.subjects[4].subj_address_suffix;
			self.pii4_clean_postdir    		:= left.subjects[4].subj_address_postdir;
			self.pii4_clean_unit_desig    := left.subjects[4].subj_address_unit_desig;
			self.pii4_clean_sec_range    	:= left.subjects[4].subj_address_sec_range;
			self.pii4_clean_st    				:= left.subjects[4].subj_address_st;
			self.pii4_clean_zip5    			:= left.subjects[4].subj_address_z5;
			self.pii4_clean_zip4    			:= left.subjects[4].subj_address_z4;
			self.pii4_clean_predir    		:= left.subjects[4].subj_address_predir;
			self.pii4_cmp_name    				:= left.subjects[4].subj_company_name;
			self.pii4_cmp_fein    				:= left.subjects[4].subj_company_fein;
			
			self.pii5_first_name    			:= left.subjects[5].subj_first_name;
			self.pii5_middle_name    			:= left.subjects[5].subj_middle_name;
			self.pii5_last_name    				:= left.subjects[5].subj_last_name;
			self.pii5_suffix_name    			:= left.subjects[5].subj_suffix_name;
			self.pii5_former_last_name    := left.subjects[5].subj_former_last_name;
			self.pii5_address    					:= left.subjects[5].subj_address_addressline1;
			self.pii5_city    						:= left.subjects[5].subj_address_city;
			self.pii5_state    						:= left.subjects[5].subj_address_st;
			self.pii5_zip    							:= left.subjects[5].subj_address_z5;
			self.pii5_phone    						:= left.subjects[5].subj_phone;
			self.pii5_work_phone    			:= left.subjects[5].subj_work_phone;
			self.pii5_dob    							:= left.subjects[5].subj_dob;
			self.pii5_dl    							:= left.subjects[5].subj_dl_num;
			self.pii5_dl_state    				:= left.subjects[5].subj_dl_state;
			self.pii5_email    						:= left.subjects[5].subj_email;
			self.pii5_ssn    							:= left.subjects[5].subj_ssn;
			self.pii5_business_title    	:= left.subjects[5].subj_business_title;
			self.pii5_clean_first_name    := left.subjects[5].subj_first_name;
			self.pii5_clean_middle_name   := left.subjects[5].subj_middle_name;
			self.pii5_clean_last_name    	:= left.subjects[5].subj_last_name;
			self.pii5_clean_suffix_name   := left.subjects[5].subj_suffix_name;
			self.pii5_clean_prim_range    := left.subjects[5].subj_address_prim_range;
			self.pii5_clean_prim_name    	:= left.subjects[5].subj_address_prim_name;
			self.pii5_clean_addr_suffix   := left.subjects[5].subj_address_suffix;
			self.pii5_clean_postdir    		:= left.subjects[5].subj_address_postdir;
			self.pii5_clean_unit_desig    := left.subjects[5].subj_address_unit_desig;
			self.pii5_clean_sec_range    	:= left.subjects[5].subj_address_sec_range;
			self.pii5_clean_st    				:= left.subjects[5].subj_address_st;
			self.pii5_clean_zip5    			:= left.subjects[5].subj_address_z5;
			self.pii5_clean_zip4    			:= left.subjects[5].subj_address_z4;
			self.pii5_clean_predir    		:= left.subjects[5].subj_address_predir;
			self.pii5_cmp_name    				:= left.subjects[5].subj_company_name;
			self.pii5_cmp_fein    				:= left.subjects[5].subj_company_fein;
			
			self.pii6_first_name    			:= left.subjects[6].subj_first_name;
			self.pii6_middle_name    			:= left.subjects[6].subj_middle_name;
			self.pii6_last_name    				:= left.subjects[6].subj_last_name;
			self.pii6_suffix_name    			:= left.subjects[6].subj_suffix_name;
			self.pii6_former_last_name    := left.subjects[6].subj_former_last_name;
			self.pii6_address    					:= left.subjects[6].subj_address_addressline1;
			self.pii6_city    						:= left.subjects[6].subj_address_city;
			self.pii6_state    						:= left.subjects[6].subj_address_st;
			self.pii6_zip    							:= left.subjects[6].subj_address_z5;
			self.pii6_phone    						:= left.subjects[6].subj_phone;
			self.pii6_work_phone    			:= left.subjects[6].subj_work_phone;
			self.pii6_dob    							:= left.subjects[6].subj_dob;
			self.pii6_dl    							:= left.subjects[6].subj_dl_num;
			self.pii6_dl_state    				:= left.subjects[6].subj_dl_state;
			self.pii6_email    						:= left.subjects[6].subj_email;
			self.pii6_ssn    							:= left.subjects[6].subj_ssn;
			self.pii6_business_title    	:= left.subjects[6].subj_business_title;
			self.pii6_clean_first_name    := left.subjects[6].subj_first_name;
			self.pii6_clean_middle_name   := left.subjects[6].subj_middle_name;
			self.pii6_clean_last_name    	:= left.subjects[6].subj_last_name;
			self.pii6_clean_suffix_name   := left.subjects[6].subj_suffix_name;
			self.pii6_clean_prim_range    := left.subjects[6].subj_address_prim_range;
			self.pii6_clean_prim_name    	:= left.subjects[6].subj_address_prim_name;
			self.pii6_clean_addr_suffix   := left.subjects[6].subj_address_suffix;
			self.pii6_clean_postdir    		:= left.subjects[6].subj_address_postdir;
			self.pii6_clean_unit_desig    := left.subjects[6].subj_address_unit_desig;
			self.pii6_clean_sec_range    	:= left.subjects[6].subj_address_sec_range;
			self.pii6_clean_st    				:= left.subjects[6].subj_address_st;
			self.pii6_clean_zip5    			:= left.subjects[6].subj_address_z5;
			self.pii6_clean_zip4    			:= left.subjects[6].subj_address_z4;
			self.pii6_clean_predir    		:= left.subjects[6].subj_address_predir;
			self.pii6_cmp_name    				:= left.subjects[6].subj_company_name;
			self.pii6_cmp_fein    				:= left.subjects[6].subj_company_fein;
			
			self.pii7_first_name    			:= left.subjects[7].subj_first_name;
			self.pii7_middle_name    			:= left.subjects[7].subj_middle_name;
			self.pii7_last_name    				:= left.subjects[7].subj_last_name;
			self.pii7_suffix_name    			:= left.subjects[7].subj_suffix_name;
			self.pii7_former_last_name    := left.subjects[7].subj_former_last_name;
			self.pii7_address    					:= left.subjects[7].subj_address_addressline1;
			self.pii7_city    						:= left.subjects[7].subj_address_city;
			self.pii7_state    						:= left.subjects[7].subj_address_st;
			self.pii7_zip    							:= left.subjects[7].subj_address_z5;
			self.pii7_phone    						:= left.subjects[7].subj_phone;
			self.pii7_work_phone    			:= left.subjects[7].subj_work_phone;
			self.pii7_dob    							:= left.subjects[7].subj_dob;
			self.pii7_dl    							:= left.subjects[7].subj_dl_num;
			self.pii7_dl_state    				:= left.subjects[7].subj_dl_state;
			self.pii7_email    						:= left.subjects[7].subj_email;
			self.pii7_ssn    							:= left.subjects[7].subj_ssn;
			self.pii7_business_title    	:= left.subjects[7].subj_business_title;
			self.pii7_clean_first_name    := left.subjects[7].subj_first_name;
			self.pii7_clean_middle_name   := left.subjects[7].subj_middle_name;
			self.pii7_clean_last_name    	:= left.subjects[7].subj_last_name;
			self.pii7_clean_suffix_name   := left.subjects[7].subj_suffix_name;
			self.pii7_clean_prim_range    := left.subjects[7].subj_address_prim_range;
			self.pii7_clean_prim_name    	:= left.subjects[7].subj_address_prim_name;
			self.pii7_clean_addr_suffix   := left.subjects[7].subj_address_suffix;
			self.pii7_clean_postdir    		:= left.subjects[7].subj_address_postdir;
			self.pii7_clean_unit_desig    := left.subjects[7].subj_address_unit_desig;
			self.pii7_clean_sec_range    	:= left.subjects[7].subj_address_sec_range;
			self.pii7_clean_st    				:= left.subjects[7].subj_address_st;
			self.pii7_clean_zip5    			:= left.subjects[7].subj_address_z5;
			self.pii7_clean_zip4    			:= left.subjects[7].subj_address_z4;
			self.pii7_clean_predir    		:= left.subjects[7].subj_address_predir;
			self.pii7_cmp_name    				:= left.subjects[7].subj_company_name;
			self.pii7_cmp_fein    				:= left.subjects[7].subj_company_fein;
			
			self.pii8_first_name    			:= left.subjects[8].subj_first_name;
			self.pii8_middle_name    			:= left.subjects[8].subj_middle_name;
			self.pii8_last_name    				:= left.subjects[8].subj_last_name;
			self.pii8_suffix_name    			:= left.subjects[8].subj_suffix_name;
			self.pii8_former_last_name    := left.subjects[8].subj_former_last_name;
			self.pii8_address    					:= left.subjects[8].subj_address_addressline1;
			self.pii8_city    						:= left.subjects[8].subj_address_city;
			self.pii8_state    						:= left.subjects[8].subj_address_st;
			self.pii8_zip    							:= left.subjects[8].subj_address_z5;
			self.pii8_phone    						:= left.subjects[8].subj_phone;
			self.pii8_work_phone    			:= left.subjects[8].subj_work_phone;
			self.pii8_dob    							:= left.subjects[8].subj_dob;
			self.pii8_dl    							:= left.subjects[8].subj_dl_num;
			self.pii8_dl_state    				:= left.subjects[8].subj_dl_state;
			self.pii8_email    						:= left.subjects[8].subj_email;
			self.pii8_ssn    							:= left.subjects[8].subj_ssn;
			self.pii8_business_title    	:= left.subjects[8].subj_business_title;
			self.pii8_clean_first_name    := left.subjects[8].subj_first_name;
			self.pii8_clean_middle_name   := left.subjects[8].subj_middle_name;
			self.pii8_clean_last_name    	:= left.subjects[8].subj_last_name;
			self.pii8_clean_suffix_name   := left.subjects[8].subj_suffix_name;
			self.pii8_clean_prim_range    := left.subjects[8].subj_address_prim_range;
			self.pii8_clean_prim_name    	:= left.subjects[8].subj_address_prim_name;
			self.pii8_clean_addr_suffix   := left.subjects[8].subj_address_suffix;
			self.pii8_clean_postdir    		:= left.subjects[8].subj_address_postdir;
			self.pii8_clean_unit_desig    := left.subjects[8].subj_address_unit_desig;
			self.pii8_clean_sec_range    	:= left.subjects[8].subj_address_sec_range;
			self.pii8_clean_st    				:= left.subjects[8].subj_address_st;
			self.pii8_clean_zip5    			:= left.subjects[8].subj_address_z5;
			self.pii8_clean_zip4    			:= left.subjects[8].subj_address_z4;
			self.pii8_clean_predir    		:= left.subjects[8].subj_address_predir;
			self.pii8_cmp_name    				:= left.subjects[8].subj_company_name;
			self.pii8_cmp_fein    				:= left.subjects[8].subj_company_fein;
			
			self := []));

			return AppendTransCompanySubjects;

end;


END;