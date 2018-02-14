import PromoteSupers, Email_Data, std;

//Create emaail_key
dsEmailDataBoca := project(Files.INCOMING_BOCA, transform(Layouts.base, 
																														v_append_email_username  := STD.Str.ToUpperCase(email_data.Fn_Clean_Email_Username(left.clean_email));
																														v_append_domain 				 := left.clean_email[length(v_append_email_username)+2..];
																														v_append_domain_root 	 	:= TRIM(v_append_domain[1..STD.Str.Find(v_append_domain, '.', 1) -1], right);	
																														v_append_domain_ext			 := v_append_domain[length(v_append_domain_root)+1..];
																														
																														self.append_email_username 	 := if(left.append_email_username = '',v_append_email_username,left.append_email_username);
																														self.append_domain 					 := if(left.append_domain = '',v_append_domain, left.append_domain);	
																														self.append_domain_root 		 := if(left.append_domain_root = '',v_append_domain_root, left.append_domain_root);
																														self.append_domain_ext 			 := if(left.append_domain_ext = '',v_append_domain_ext,left.append_domain_ext);
																														self.orig_address 	:= STD.Str.CleanSpaces(left.orig_address);
																														self.email_rec_key  := Email_Data.Email_rec_key(left.clean_email,
																																																			 		 left.clean_address.prim_range,
																																																					 left.clean_address.prim_name, 	
																																																					 left.clean_address.sec_range, 
																																																					 left.clean_address.zip,
																																																					 left.Clean_Name.lname, 
																																																					 left.Clean_Name.fname);
																																
																														self := left;
																														self := [];
																														));

dsEmailDataAlpha := project(Files.INCOMING_ALPhA, transform(Layouts.base, 
																														self.email_rec_key := Email_Data.Email_rec_key(left.clean_email,
																																																					 left.clean_address.prim_range,
																																																					 left.clean_address.prim_name, 	
																														  																						 left.clean_address.sec_range, 
																																																					 left.clean_address.zip,
																																																					 left.Clean_Name.lname, 
																																																					 left.Clean_Name.fname);
																														self.ssn				:= left.best_ssn;
																														self.dob				:= (string8)left.best_dob;
																														self := left;
																														self := [];
																														));




PromoteSupers.Mac_SF_BuildProcess(dsEmailDataBoca,Constants.base_prefix_name+ 'boca'	,boca_base,,,true);																
PromoteSupers.Mac_SF_BuildProcess(dsEmailDataAlpha,Constants.base_prefix_name+'alpha'	,alpha_base,,,true);																

export proc_build_base := parallel(boca_base,alpha_base);	