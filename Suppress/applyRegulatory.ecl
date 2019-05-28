
import std, header_services, vehiclev2, Watercraft;

export applyRegulatory := module

			export debug_ar := false : stored('debug_ar');
			
			export IP := header_services.ProductionLZ.IP_Loc; 	
			export unix_path := header_services.ProductionLZ.Directory_Loc1 : stored('unix_path_override');
			export thor_path := header_services.ProductionLZ.Directory_Loc  : stored('thor_path_override');

			export enhFileName := 'file_enhanced_fnames.txt';
			
			export notification_email_addr := header_services.ProductionLZ.notification_email; 
			
			export full_file_name(string fname) := STD.File.ExternalLogicalFileName(IP, thor_path + fname);
			export enhfull_file_name := STD.File.ExternalLogicalFileName(IP, thor_path + enhFileName);
			
			export should_fail := true : stored('fail_switch');

			shared emailAddr := notification_email_addr;
			shared emailInfo := '\r\n Job Name: ' + thorlib.jobname() + ' \r\n User Name: ' + thorlib.jobowner() + ' \r\n Cluster: ' + thorlib.cluster();
			export emailMsg(string msg) := FileServices.sendemail(emailAddr, 'Upload from Drop Zone Status ' + Thorlib.WUID(), msg + emailInfo);

			export check_found(string fullname) := 
					function
							file_exists					:= std.file.fileexists(fullname);
							file_not_found_msg  := 'supplemental data file ' + fullname + ' not found';
							file_not_found 			:= if(should_fail
																				, sequential(emailMsg(file_not_found_msg)
																									, fail(file_not_found_msg))
																				, emailMsg(file_not_found_msg)
							);
							if(not file_exists
									, file_not_found);
						
							return file_exists;
					end;


			export check_size(string fname, unsigned record_length) := 
					function
							fsize := STD.File.RemoteDirectory(IP,unix_path,fname)[1].size;
							file_size_good   := (((fsize % record_length) = 0) or (fsize % (record_length+8) = 0)) and (fsize <> 0);
							// file_size_good   := ((fsize % record_length) = 0) and (fsize <> 0);
							size_failure_msg := 'unexpected supplemental data file size/record length: ' + fsize + ', expected record length: ' +  record_length + ' for '+ full_file_name(fname);
							size_failure     := if(should_fail
																			, sequential(emailMsg(size_failure_msg), fail(size_failure_msg))
																			, emailMsg(size_failure_msg)
							);
							if(not file_size_good
									, size_failure);
						
							return file_size_good;
					end;							


			export determine_file( fname, layout) := 
					functionmacro
							debug_ar := false : stored('debug_ar');

							enhanced_layout := 
										record 
												unsigned8 record_source_id; 
												layout;
										end;

							enh_base_file:=dataset(fname, enhanced_layout, flat);
							base_file:=dataset(fname, layout, flat);
					
							unenhanced_base_ds := project(enh_base_file(record_source_id % 2 = 0) ,
									transform(layout,
											self := left;
											self := []));
					
							final_file := if(is_enhancedFile, unenhanced_base_ds, base_file); 
								
							return final_file;
					endmacro;	

			export is_file_enh(string enhffName, string fname) := 
					function
							enhanced_fname_layout := 
										record 
												string32 file_name;
												string2  crlf;
										end;
							enhffds := 	dataset(enhffName, enhanced_fname_layout, flat);
													
							enhfile	:= enhffds(file_name=stringlib.Data2String(hashmd5(fname)));
							enhfilecnt := if(count(enhfile)>0, true, false);
							return enhfilecnt;
					end;


			export getfile(filename, layout) := 
					functionmacro
							import _control;

							local full_filename_path    := suppress.applyregulatory.full_file_name(filename);		
							local isFound           		:= nothor(suppress.applyregulatory.check_found(full_filename_path));
							local record_length     		:= sizeof(Layout);
							local isSizeGood        		:= nothor(suppress.applyregulatory.check_size(filename,record_length));
							
							local	enhfull_filename_path := suppress.applyregulatory.enhfull_file_name;		
							local is_enhFound         	:= nothor(suppress.applyregulatory.check_found(enhfull_filename_path));
							local is_enhancedFile				:= suppress.applyregulatory.is_file_enh(enhfull_filename_path,filename);
							
							local determine_outfile			:= suppress.applyRegulatory.determine_file(full_filename_path, layout);
							local success_msg       		:= 'successfully read supplemental data filename ' + full_filename_path;
							local success_email     		:= nothor(suppress.applyregulatory.emailMsg(success_msg));
							local isProd            		:= (_control.ThisEnvironment.name = 'Prod' or _control.ThisEnvironment.Name = 'Prod_Thor'); // Alpha Prod or Boca Prod						

							if(isFound
									, if(isSizeGood
												, success_email)
												);
												 
							return ( if((isFound and is_enhFound)
												, if(isSizeGood 
															,	if (isProd
																		, determine_outfile 
																		, dataset([], layout)))));

					endmacro;


			export layout_in := 
					record
							string32 hval_s;
							string2  nl;
					end;


			export complex_append(base_ds, filename, Drop_Layout, trans) := 
					functionmacro
							Base_File_Append_In := suppress.applyregulatory.getFile(filename, Drop_Layout);
							Base_File_Append 		:= project(Base_File_Append_In, trans(left));

							return base_ds + Base_file_append;
					endmacro; // complex_append

			export simple_append(base_ds, filename, Drop_Layout, endrec=false) := 
					functionmacro
							Base_File_Append_In := suppress.applyregulatory.getFile(filename, Drop_Layout);
			
							recordof(base_ds) reformat_append(Base_File_Append_In L) := 
									transform
											self := L;
											self := [];
									end;
			
							Base_File_Append := project(Base_File_Append_In, reformat_append(left));															

							return base_ds + Base_file_append;						
					endmacro; // simple_append

			export CR_simple_append(base_ds, filename, Drop_Layout, endrec=false) := 
					functionmacro
							import std;
							Base_File_Append_In := suppress.applyregulatory.getFile(filename, Drop_Layout);
			
							recordof(base_ds) reformat_append(Base_File_Append_In L) := 
									transform
											self.process_date := (STRING8)Std.Date.Today();
											self := L;
											self := [];
									end;
			
							Base_File_Append := project(Base_File_Append_In, reformat_append(left));															

							return base_ds + Base_file_append;						
					endmacro; // CR_simple_append				

			export CR_simple_append_Punish(base_ds, filename, Drop_Layout, endrec=false) := 
					functionmacro
							import std;
							Base_File_Append_In := suppress.applyregulatory.getFile(filename, Drop_Layout);
			
							recordof(base_ds) reformat_append(Base_File_Append_In L) := 
									transform
											self.process_date := (STRING8)Std.Date.Today();
											self.conviction_override_date := if(L.conviction_override_date <> '', L.conviction_override_date, (STRING8)Std.Date.Today());
											self := L;
											self := [];
									end;
			
							Base_File_Append := project(Base_File_Append_In, reformat_append(left));															

							return base_ds + Base_file_append;						
					endmacro; // CR_simple_append_Punish	
					
			export CCW_simple_append(base_ds, filename, Drop_Layout, endrec=false) := 
					functionmacro
							import std;
							Base_File_Append_In := suppress.applyregulatory.getFile(filename, Drop_Layout);
			
							max_unique_id := max(base_ds, unique_id);
							
							recordof(base_ds) reformat_append(Base_File_Append_In L, UNSIGNED c ) := 
									transform
											// obviously this equation is a little weak, but will give us a unique id
											self.unique_id :=  intformat((c*thorlib.nodes() + (integer) max_unique_id), 8, 1); 
											self := L;
											self := [];
									end;
			
							Base_File_Append := project(Base_File_Append_In, reformat_append(left, counter));															

							return base_ds + Base_file_append;						
					endmacro; // CCW_simple_append		

					
      export simple_sup(base_ds, filename, hashFunc) := 
					functionmacro
							import header_services;
							local supLayout := header_services.Supplemental_Data.layout_in;		
						
							sup_in := suppress.applyregulatory.getFile(filename, supLayout);																			

							local dSuppressedIn := project(sup_In, header_services.Supplemental_Data.in_to_out(left));
						
							return join(base_ds, dSuppressedIn
													, hashFunc(left) = right.hval
													, transform(left)
													, left only
													, lookup);
					endmacro; // simple_sup
		
			export reverse_sup_layout := {unsigned8 rid;};
			
      export simple_reverse_sup(base_ds, filename, hashFunc) := 
					functionmacro
							import header_services;
							local supLayout := header_services.Supplemental_Data.layout_in;		
						
							sup_in := suppress.applyregulatory.getFile(filename, supLayout);																			

							local dSuppressedIn := project(sup_In, header_services.Supplemental_Data.in_to_out(left));
						
							return join(base_ds, dSuppressedIn
													, hashFunc(left) = right.hval
													, transform(suppress.applyRegulatory.reverse_sup_layout, self := left)
													, lookup);
					endmacro; // simple_reverse_sup
				
			export applyBIPV2(ds) := 
					functionmacro
							bdidAddrSupHash(recordof(ds) rec) := hashmd5(intformat(rec.seleID, 12, 1), rec.st, rec.zip,
																																		 rec.v_city_name, rec.prim_name, rec.prim_range, rec.predir,
																																		 rec.addr_suffix, rec.postdir, rec.sec_range);
							bdidAddrSup := Suppress.applyRegulatory.simple_sup(ds, 'bip_didaddress_sup.txt', bdidAddrSupHash);

							contactsAllSupHash(recordof(ds) rec) := hashmd5(intformat(rec.seleID, 12, 1));
							contactsAllSup := bdidAddrSup(isContact != 'T')
																+ Suppress.applyRegulatory.simple_sup(bdidAddrSup(isContact = 'T'), 'bip_contactsall_sup.txt', contactsAllSupHash);

							contactsSupHash(recordof(ds) rec) := hashmd5(intformat(rec.seleID, 12, 1), intformat(rec.contact_did, 12, 1));
							contactsSup := contactsAllSup(isContact != 'T')
														 + Suppress.applyRegulatory.simple_sup(contactsAllSup(isContact = 'T'), 'bip_contacts_sup.txt', contactsSupHash);

							contactsTitleSupHash(recordof(ds) rec) := hashmd5(intformat(rec.seleID, 12, 1), rec.contact_job_title_raw, rec.lname, rec.fname);
							contactsTitleSup := contactsSup(isContact != 'T')
																	+ Suppress.applyRegulatory.simple_sup(contactsSup(isContact = 'T'), 'bip_contactsbytitle_sup.txt', contactsTitleSuphash);

							return Suppress.applyRegulatory.simple_append(contactsTitleSup, 'file_bipv2_inj.txt', BIPV2.CommonBase_mod.Layout_S18);
					endmacro;
								
															
			export applyContactBIPV2(ds) := 
					functionmacro
							bdidAddrSupHash(recordof(ds) rec) := hashmd5(intformat(rec.seleID, 12, 1), rec.company_address.st, rec.company_address.zip,
																												 rec.company_address.v_city_name, rec.company_address.prim_name, rec.company_address.prim_range, rec.company_address.predir,
																												 rec.company_address.addr_suffix, rec.company_address.postdir, rec.company_address.sec_range);
																												 
							bdidAddrSup := Suppress.applyRegulatory.simple_sup(ds, 'bip_didaddress_sup.txt', bdidAddrSupHash);

							contactsAllSupHash(recordof(ds) rec) := hashmd5(intformat(rec.seleID, 12, 1));
							contactsAllSup := bdidAddrSup(is_Contact != true)
															  + Suppress.applyRegulatory.simple_sup(bdidAddrSup(is_Contact = true), 'bip_contactsall_sup.txt', contactsAllSupHash);

							contactsSupHash(recordof(ds) rec) := hashmd5(intformat(rec.seleID, 12, 1), intformat(rec.contact_did, 12, 1));
							contactsSup := contactsAllSup(is_Contact != true)
														 + Suppress.applyRegulatory.simple_sup(contactsAllSup(is_Contact = true), 'bip_contacts_sup.txt', contactsSupHash);

							contactsTitleSupHash(recordof(ds) rec) := hashmd5(intformat(rec.seleID, 12, 1), rec.contact_job_title_raw, rec.contact_name.lname, rec.contact_name.fname);
							contactsTitleSup := contactsSup(is_Contact != true)
																	+ Suppress.applyRegulatory.simple_sup(contactsSup(is_Contact = true), 'bip_contactsbytitle_sup.txt', contactsTitleSuphash);

							contact_layout := 
									record
											unsigned8 rid:=0;
											BIPV2.IDlayouts.l_xlink_ids; 
											BIPV2.Layout_Business_Linking_Full ;
											boolean executive_ind:=False;
											integer executive_ind_order:=0;
									end;

							return Suppress.applyRegulatory.simple_append(contactsTitleSup, 'file_business_contact_bip_inj.txt', contact_layout);				
					endmacro;


			export relativesSup(ds,hashes) := 
					functionmacro
							ro_temp_rec := 
									record
											insuranceheader_relative.layout_output.titled;
											data16 hval1;
											data16 hval2;
											data16 hval3;
											data16 hval4;
									end;

							ro_temp_rec tHash_vals(insuranceheader_relative.layout_output.titled l) := 
									transform                            
											self.hval1 := hashmd5(intformat(l.did1,15,1),intformat(l.did2,15,1));
											self.hval2 := hashmd5(intformat(l.did2,15,1),intformat(l.did1,15,1));
											self.hval3 := hashmd5(intformat(l.did1,15,1));
											self.hval4 := hashmd5(intformat(l.did2,15,1));
											self := l;
									end;

							ro_temp := project(ds, tHash_vals(left));

							insuranceheader_relative.layout_output.titled tSuppress(ro_Temp l, hashes r) := 
									transform
											self := l;
									end;

							rs := join(ro_temp, hashes,
												(left.hval1=right.hval or left.hval2=right.hval or left.hval3=right.hval or left.hval4=right.hval),
												tSuppress(left, right)
												,	left only
												, all);
										 
							return rs;
					endmacro;


			export getHashes(filename) := 
					functionmacro
							import Header_Services;
							local supLayout := suppress.applyregulatory.layout_in;
							sup_in := suppress.applyregulatory.getFile(filename, supLayout);
							local dIn := project(sup_in, Header_Services.Supplemental_Data.in_to_out(left));

							return dIn;
					endmacro;

                
			export applyRelatives(ds) := 
					functionmacro
							Drop_Header_Layout := 
									Record
											string13  person1;
											string13  person2;
											string8   recent_cohabit;
											string8   zip;
											string5   prim_range;
											string1   same_lname;
											string5   number_cohabits;
											string2   eor;
									end; 
					
							ds1 := suppress.applyRegulatory.getHashes('associates_sup.txt');
							ds4 := suppress.applyRegulatory.relativesSup(ds,ds1);
					
							insuranceheader_relative.layout_output.titled trans(Drop_Header_Layout L) := 
									transform
											self.did1 									:= (unsigned6) L.person1;
											self.did2 									:= (unsigned6) L.person2;
											// self.rel_dt_last_seen 		:= (integer3) L.recent_cohabit * 100;
											// self.zip 								:= (integer3) L.zip;
											//self.source_type 					:= (integer2) L.prim_range;
											self.isCurrLnameMatch 			:= (boolean) L.same_lname;
											self.isAnyLnameMatch  			:= (boolean) L.same_lname;
											self.total_score 						:= (unsigned2) L.number_cohabits * 6;
											self.total_cnt 							:= 1;
											self.copolicy_cnt     			:= IF(L.prim_range = '0', 1 , 0);
											self.copolicy_score   			:= IF(L.prim_range = '0', self.total_score, 0);
											self.cossn_cnt        			:= IF(L.prim_range = '-1', 1 , 0);
											self.cossn_score      			:= IF(L.prim_range = '-1', self.total_score, 0);
											self.cohabit_cnt      			:= IF(L.prim_range = '-3' OR L.prim_range > '0', 1 , 0);
											self.cohabit_score  			  := IF(L.prim_range = '-3' OR L.prim_range > '0', self.total_score, 0);
											self.coucc_cnt  				    := IF(L.prim_range = '-4', 1 , 0);
											self.coucc_score     				:= IF(L.prim_range = '-4', self.total_score, 0);
											self.covehicle_cnt    			:= IF(L.prim_range = '-5', 1 , 0);
											self.covehicle_score				:= IF(L.prim_range = '-5', self.total_score, 0);
											self.coproperty_cnt   			:= IF(L.prim_range = '-6', 1 , 0);
											self.coproperty_score 			:= IF(L.prim_range = '-6', self.total_score, 0);
											self.comarriagedivorce_cnt  := IF(L.prim_range = '-7', 1 , 0);
											self.comarriagedivorce_score 	:= IF(L.prim_range = '-7', self.total_score, 0);
											// self.relative_matches		:= '';
											// self.relatives_match_score := ''; 
											// self.shared_addr_score  	:=0;
											// self.Match_by_zip_score 	:= 0 ; 
											// self.nbr_of_addresses 		:= 0 ; 
											// self.dt_last_relative 		:= 0 ; 
											// self.current_relatives 	:= true;
											// self.__filepos 					:= 0;
											self.type 									:= IF(L.prim_range = '-2', 'TRANS CLOSURE', 'PERSONAL');
											self.confidence 						:= 'HIGH';
											self.cluster    						:= 'CORE';
											self.generation 						:= 'S';
											self.title 									:= 43;
											self.personal 							:= TRUE;
											self.lname_cnt 							:= 1;
											self 												:= L;
											self												:= []; 
									end;

							return suppress.applyregulatory.complex_append(ds4, 'file_relatives_inj.txt', Drop_Header_Layout,trans);
					endmacro;


			export applyHeaderLinking(ds) := 
					functionmacro
							dlSupHash(recordof(ds) L) := HASHMD5(	intformat((unsigned6)l.did,15,1), TRIM((string14)l.vendor_id, left, right));
							ds1 := Suppress.applyRegulatory.simple_sup(ds, 'driverslicense_sup.txt', dlSupHash);

							didAddrSupHash(recordof(ds1) L) := hashmd5(intformat(l.did,15,1), (string)l.st, (string)l.zip, (string)l.city
																												, (string)l.prim_name, (string)l.prim_range, (string)l.predir
																												, (string)l.addr_suffix,(string)l.postdir,(string)l.sec_range);
							ds2 := Suppress.applyRegulatory.simple_sup(ds1, 'didaddress_sup.txt', didAddrSupHash);

							return suppress.applyRegulatory.simple_append(ds2,'header_linking_inj.thor', suppress.layout_regulatory.IDL_Header);
					endmacro;

			//
			// Special append for watercraft 
			//
			export simple_append_WC (base_ds, filename, Drop_Layout, endrec=false) := 
					functionmacro
							Base_File_Append_In := suppress.applyregulatory.getFile(filename, Drop_Layout);				
							src_cd_max := count(base_ds);

							recordof(base_ds) reformat_append(Base_File_Append_In L, Integer C ) := 
									transform
											self.source_rec_id := src_cd_max + C ;
											self := L ;
											self := [] ;
									end;

						Base_file_append := project(Base_File_Append_In, reformat_append(left, COUNTER));	
					
						return base_ds + Base_file_append;			
			endmacro; // simple_append WC


			export applyWatercraftS(ds) := 
					functionmacro
							WatercraftHash(recordof(ds) L) := hashmd5(trim((string)l.watercraft_key, 	left, right), 
																												trim((string)l.sequence_key, 		left, right),
																												trim((string)l.fname, 					left, right),
																												trim((string)l.lname, 					left, right)) ;						  
					
							ds1 := Suppress.applyRegulatory.simple_sup(ds, 'file_watercraft_search_sup.txt', WatercraftHash);
												
							return suppress.applyRegulatory.simple_append_WC(ds1, 'file_watercraft_search_inj.txt', Watercraft.Layout_Scrubs.Search_Base); 
					endmacro;


			export applyWatercraftMain (ds) := 
					functionmacro	
							WatercraftHash(recordof(ds) L) := hashmd5(trim((string)l.watercraft_key, 	left, right), 
																												trim((string)l.sequence_key, 		left, right)) ;						  
							
							ds1 := Suppress.applyRegulatory.simple_sup(ds, 'file_watercraft_main_sup.txt', WatercraftHash);
														
							return suppress.applyRegulatory.simple_append(ds1, 'file_watercraft_main_inj.txt', Watercraft.Layout_Scrubs.Main_Base); 
					endmacro ;


			//
			// process vehicle party information
			//
			export applyMotorVehicleP(ds) := 
					functionmacro					
							VehiclePartySupHash(recordof(ds) L) := hashmd5(trim((string)l.Vehicle_key, 	 left, right), 
																														 trim((string)l.Iteration_key, left, right),
																														 trim((string)l.sequence_key,  left, right),
																														 trim((string)l.fname,         left, right),
																														 trim((string)l.lname,         left, right));
							ds1 := Suppress.applyRegulatory.simple_sup(ds, 'file_vehicle_party_sup.txt', VehiclePartySupHash);

							return suppress.applyRegulatory.simple_append(ds1, 'file_vehicle_party_inj.thor', VehicleV2.Layout_Base.Party_bip); 
					endmacro;


			//
			// process vehicle information
			// code has been commented as need and keys haven't been determine.  
			// Note the infrastructure changes made in vehicleV2.files and prep_build still support the calling of this file in case future direction changes	
			//
			export applyMotorVehicleM(ds) := 
					functionmacro
							return ds;
					endmacro;

			export complex_sup_trio(base_ds, filename, hashFunc1, hashFunc2, hashFunc3) := 
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
					endmacro; // complex_sup_trio
					
			//
			// process hunting/fishing information
			//
			export applyHF(ds) := 
					functionmacro
	            HF_DID_Hash(recordof(ds) L) := hashmd5(trim(l.did_out, 	left, right));				
							HF_DID_SOURCE_STATE_Hash(recordof(ds) L) := hashmd5(trim(l.did_out, 	left, right), trim(l.source_state, 	left, right));
							HF_PERSISTENT_ID_Hash(recordof(ds) L) := hashmd5(l.persistent_record_id);

							// complex_hunt_fish_sup(base_ds, filename, hashFunc1, hashFunc2)
							
							ds1 := Suppress.applyRegulatory.complex_sup_trio(ds, 'file_hunt_fish_sup.txt', HF_DID_SOURCE_STATE_Hash, HF_DID_Hash, HF_PERSISTENT_ID_Hash);
						
							return suppress.applyRegulatory.simple_append(ds1, 'file_hunt_fish_inj.thor', emerges.layout_hunters_out); 
					endmacro; // applyHF

			//
			// process CCW information
			//
			export applyCCW(ds) := 
					functionmacro						

	            CCW_Hash1(recordof(ds) L) := hashmd5(trim(l.did_out, 	left, right));				
							CCW_Hash2(recordof(ds) L) := hashmd5(trim(l.did_out, 	left, right), trim(l.source_state, 	left, right));
							CCW_Hash3(recordof(ds) L) := hashmd5(l.persistent_record_id);

							ds1 := Suppress.applyRegulatory.complex_sup_trio(ds, 'file_ccw_sup.txt', CCW_Hash1, CCW_Hash2, CCW_Hash3);

							return Suppress.applyRegulatory.CCW_simple_append(ds1, 'file_ccw_inj.thor', emerges.layout_ccw_out);  
							// return Suppress.applyRegulatory.simple_append(ds1, 'file_ccw_inj.thor', emerges.layout_ccw_out);  
					endmacro; // applyCCW


			export complex_email_append(base_ds, filename, drop_layout, base_layout) := 
					functionmacro
							base_layout xToEmail_Data(drop_layout L):= 
									TRANSFORM
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
											self.best_dob								:= (unsigned6) L.best_dob ;
											self.current_rec						:= (boolean) ((unsigned) L.current_rec) ;
											self												:= L ;
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
			export applyEMail(ds) := 
					functionmacro
							Email_Hash(recordof(ds) L) 		:= hashmd5(trim(l.clean_email, left, right));
							DID_Hash(recordof(ds) L) 			:= hashmd5(trim((string)l.did, left, right));
							combined_hash(recordof(ds) L) := hashmd5(trim((string)l.did, left, right), trim(l.clean_email, left, right));
					
							ds1 := Suppress.applyRegulatory.complex_email_sup(ds, 'file_email_sup.txt', email_Hash, did_hash, combined_hash);

							return	Suppress.applyRegulatory.complex_email_append(ds1, 'file_email_inj.txt', Email_Data.Layout_Email.eor_base_sz, email_data.layout_email.base);
					endmacro; // applyEMail
					
		//
		// process Criminal Records Offenders information
		// this is a placeholder until SDS code is written														
		//
			export complex_CRSO_sup(base_ds, filename, hashfunc1, hashfunc2, hashfunc3) := 
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
					endmacro; // complex_CR_sup
					
					
			//
			// process Criminal Records Offender information
			//
			export apply_CR_Offenders(ds) := 
					functionmacro
							// CR_Offn_DID_Hash(recordof(ds) L) 					:= hashmd5(trim(l.did, left, right));
							// CR_Offn_SSN_Hash(recordof(ds) L) 					:= hashmd5(trim(l.ssn, left, right));
							CR_Offn_Offender_Key_Hash(recordof(ds) L) := hashmd5(trim(l.offender_key, left, right));
			
							// ds1 := Suppress.applyRegulatory.complex_CRSO_sup(ds, 'file_cr_offndr_sup.txt', CR_Offn_DID_Hash, CR_Offn_SSN_Hash, CR_Offn_Offender_Key_Hash);
							ds1 := Suppress.applyRegulatory.simple_sup(ds, 'file_cr_offndr_sup.txt', CR_Offn_Offender_Key_Hash);
													
							return 	Suppress.applyRegulatory.CR_simple_append(ds1, 'file_cr_offndr_inj.thor', hygenics_crim.layout_offender);
					endmacro; // apply_CR_Offenders


			//
			// process Criminal Records Offenses information
			//
			// *** if suppression value is ssn or did, then we need to get the offender key based on those values.  
			export apply_CR_Offenses(ds) := 
					functionmacro
							CR_Offs_Offender_Key_Hash(recordof(ds) L) 	:= hashmd5(trim(l.offender_key, left, right));
			
							ds1 := Suppress.applyRegulatory.simple_sup(ds, 'file_cr_offense_sup.txt', CR_Offs_Offender_Key_Hash);
							
							return 	Suppress.applyRegulatory.CR_simple_append(ds1, 'file_cr_offense_inj.thor', hygenics_crim.Layout_Base_Offenses_with_OffenseCategory);
					endmacro; // apply_CR_Offenses

									
			//
			// process Criminal Records Punishment information
			//
			// *** if suppression value is ssn or did, then we need to get the offender key based on those values.  
			export apply_CR_Punishment(ds) := 
					functionmacro
							CR_Pun_Offender_Key_Hash(recordof(ds) L) := hashmd5(trim(l.offender_key, left, right));
			
							ds1 := Suppress.applyRegulatory.simple_sup(ds, 'file_cr_punishment_sup.txt', CR_Pun_Offender_Key_Hash);
							
							return 	Suppress.applyRegulatory.CR_simple_append_Punish(ds1, 'file_cr_punishment_inj.thor', hygenics_crim.Layout_CrimPunishment);					
					endmacro; // apply_CR_Punishment 			


			//
			// process Criminal Records Activity information
			// this is a placeholder until Activity is processed														
			//
			export apply_CR_Activity(ds) := 
					functionmacro
							return (ds);
					endmacro; // apply_CR_Activity

			
			//
			// process Criminal Records Court Offenses information
			//
			export apply_CR_CourtOffenses(ds) := 
					functionmacro
							CR_CourtOffs_Offender_Key_Hash(recordof(ds) L) 	:= hashmd5(trim(l.offender_key, left, right));
			
							ds1 := Suppress.applyRegulatory.simple_sup(ds, 'file_cr_traffic_offense_sup.txt', CR_CourtOffs_Offender_Key_Hash);
							
							return 	Suppress.applyRegulatory.CR_simple_append(ds1, 'file_cr_traffic_offense_inj.thor', hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory);
					endmacro; // apply_CR_CourtOffenses
														
			//
			// process Sex Offender information
			//
			export apply_SO_Offender_Main(ds) := 
					functionmacro
							// Soff_offn_DID_Hash(recordof(ds) L) 			:= hashmd5(trim((string)l.did, left, right));
							// Soff_Offn_Hash(recordof(ds) L) 					:= hashmd5(trim(l.ssn_appended, left, right));
							Soff_Offn_Prim_Key_Hash(recordof(ds) L) := hashmd5(trim(l.seisint_primary_key, left, right));
			
							// ds1 := Suppress.applyRegulatory.complex_CRSO_sup(ds, 'file_soff_offndr_sup.txt', Soff_offn_DID_Hash, Soff_Offn_Hash, Soff_Offn_Prim_Key_Hash);
							ds1 := Suppress.applyRegulatory.simple_sup(ds, 'file_soff_offndr_sup.txt', Soff_Offn_Prim_Key_Hash);
													
							return 	Suppress.applyRegulatory.simple_append(ds1, 'file_soff_offndr_inj.thor', sexoffender.layout_out_main);
					endmacro; // apply_apply_SO_Offender_Main 


			//
			// process Sex Offender Offense information
			//
			export apply_SO_Offender_Offense(ds) := 
					functionmacro
							Soff_Offs_Prim_Key_Hash(recordof(ds) L) := hashmd5(trim(l.seisint_primary_key, left, right));
			
							ds1 := Suppress.applyRegulatory.simple_sup(ds, 'file_soff_offense_sup.txt', Soff_Offs_Prim_Key_Hash);
							
							return 	Suppress.applyRegulatory.simple_append(ds1, 'file_soff_offense_inj.thor', sexoffender.layout_Common_Offense_new);
					endmacro; // apply_SO_Offender_Offense 									
			
			export apply_SO_enh_fdid(ds) := 
					functionmacro
							return (ds);
					endmacro; // apply_SO_enh_fdid 
					
							
			export hdr_incremental_sup(ds) := 
				functionmacro
					local hashFunc(recordof(ds) l) := hashmd5(l.rid);
					local reverse_sup_result := Suppress.applyRegulatory.simple_reverse_sup(ds, 'hdr_incremental_sup.txt', hashFunc);
					return reverse_sup_result;
				endmacro;
end;
