EXPORT Regulatory := module

		// LZ layouts can be found in Email_DataV2.Regulatory

		//
		export complex_email_append(base_ds, filename, drop_layout, base_layout) := 
					functionmacro
							base_layout xToEmail_Data(drop_layout L):= 
									TRANSFORM   // transform LZ to Prod V2
											self.append_is_tld_state 		:= (boolean) ((unsigned) L.append_is_tld_state) ;
											self.append_is_tld_generic	:= (boolean) ((unsigned) L.append_is_tld_generic) ;
											self.append_is_tld_country 	:= (boolean) ((unsigned)L.append_is_tld_country);
											self.append_is_valid_domain_ext := (boolean) ((unsigned) L.append_is_valid_domain_ext) ;
											self.email_rec_key 					:= (unsigned6) L.email_rec_key;
											self.rec_src_all 						:= (unsigned2) L.email_src_all ;
											self.email_src_all 					:= (unsigned2) L.email_src_all ;
											self.email_src_num 					:= (unsigned2) L.email_src_num ;
											self.num_email_per_did 			:= (unsigned2) L.email_src_num ;
											self.num_did_per_email 			:= (unsigned2) L.email_src_num ;		
											self.did 										:= (unsigned6) L.did ;
											self.did_score							:= (unsigned8) L.did_score ;
											self.is_did_prop 						:= (boolean) ((unsigned) L.is_did_prop) ;
											self.hhid 									:= (unsigned6) L.hhid ;
											self.append_rawaid					:= (unsigned8) L.append_rawaid ;
											self.best_dob							:= (unsigned4) L.best_dob ;
											self.current_rec						:= (boolean) ((unsigned) L.current_rec) ;
											// the only source we currently use is currently ET, but as that my change i put in a case statement to 
											// help evaluate possible future source codes
											self.global_sid							:= case(l.email_src,
																										'ET' => 25321,
																										25321);     
											self												:= L ;
											self 												:= [];
									END;  					
			
							Base_File_Append_In := suppress.applyregulatory.getFile(filename, Drop_Layout);  		
							Base_Proj := project(Base_File_Append_in, xToEmail_Data(LEFT));
							
							return (base_ds + base_proj);
					endmacro;		//complex_email_append	


			export complex_email_sup(base_ds, filename, hashfunc1, hashfunc2, hashfunc3) := 
					functionmacro
							import header_services;
							local supLayout := header_services.Supplemental_Data.layout_in;
														
							sup_in := suppress.applyregulatory.getFile(filename, supLayout);
					
							local dSuppressedIn := project(sup_In, header_services.Supplemental_Data.in_to_out(left));
					
							return join (base_ds, dSuppressedIn, 
									hashFunc1(left) = right.hval or
									hashFunc2(left) = right.hval or
									hashFunc3(left) = right.hval
									, transform(LEFT)
											, LEFT ONLY
											, ALL) ;											
					endmacro; // complex_email_sup

			//
			// process EMail information
			//
			export apply_email(ds) := 
					functionmacro
							Import Email_dataV2;
							Email_Hash(recordof(ds) L) 		:= hashmd5(trim(l.clean_email, left, right));
							DID_Hash(recordof(ds) L) 			:= hashmd5(trim((string)l.did, left, right));
							combined_hash(recordof(ds) L) := hashmd5(trim((string)l.did, left, right), trim(l.clean_email, left, right));
					
							ds1 := Email_Data.Regulatory.complex_email_sup(ds, 'file_email_sup.txt', email_Hash, did_hash, combined_hash);

							return	Email_Data.Regulatory.complex_email_append(ds1, 'file_email_inj.txt', Email_DataV2.Regulatory.Email_Layout, Email_Data.layout_email.base);					
							
					endmacro; // applyEMail		

end;