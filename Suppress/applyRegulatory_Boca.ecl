//
// 	Suppress.applyRegulatory_Boca
//
// 	Author 					: Many people contributed to the original suppress_applyregulatory code
//									: B Durrant separated the original code into multiple modules
// 	Date of change  : 10/5/2017
//  Update Comment
//  		New module created when suppress_applyregulatory was broken up into common and site specific modules.
//	Change Ticket or justification
//			This enhancement was suggested by Alpharetta personnel
//

import std, header_services, vehiclev2, Watercraft;

export applyRegulatory_Boca := module

			export applyBIPV2(ds) := functionmacro
			
						bdidAddrSupHash(recordof(ds) rec) := hashmd5(intformat(rec.seleID, 12, 1), rec.st, rec.zip,
																												 rec.v_city_name, rec.prim_name, rec.prim_range, rec.predir,
																												 rec.addr_suffix, rec.postdir, rec.sec_range);
						bdidAddrSup := Suppress.applyRegulatory_Common.simple_sup(ds, 'bip_didaddress_sup.txt', bdidAddrSupHash);

						contactsAllSupHash(recordof(ds) rec) := hashmd5(intformat(rec.seleID, 12, 1));
						contactsAllSup := bdidAddrSup(isContact != 'T')
														+ Suppress.applyRegulatory_Common.simple_sup(bdidAddrSup(isContact = 'T'), 'bip_contactsall_sup.txt', contactsAllSupHash);

						contactsSupHash(recordof(ds) rec) := hashmd5(intformat(rec.seleID, 12, 1), intformat(rec.contact_did, 12, 1));
						contactsSup := contactsAllSup(isContact != 'T')
												 + Suppress.applyRegulatory_Common.simple_sup(contactsAllSup(isContact = 'T'), 'bip_contacts_sup.txt', contactsSupHash);

						contactsTitleSupHash(recordof(ds) rec) := hashmd5(intformat(rec.seleID, 12, 1), rec.contact_job_title_raw, rec.lname, rec.fname);
						contactsTitleSup := contactsSup(isContact != 'T')
															+ Suppress.applyRegulatory_Common.simple_sup(contactsSup(isContact = 'T'), 'bip_contactsbytitle_sup.txt', contactsTitleSuphash);

						return Suppress.applyRegulatory_Common.simple_append(contactsTitleSup, 'file_bipv2_inj.txt', BIPV2.CommonBase_mod.Layout_S18);
			endmacro;
								
												
			export applyContactBIPV2(ds) := functionmacro

						bdidAddrSupHash(recordof(ds) rec) := hashmd5(intformat(rec.seleID, 12, 1), rec.company_address.st, rec.company_address.zip,
																												 rec.company_address.v_city_name, rec.company_address.prim_name, rec.company_address.prim_range, rec.company_address.predir,
																												 rec.company_address.addr_suffix, rec.company_address.postdir, rec.company_address.sec_range);
																												 
						bdidAddrSup := Suppress.applyRegulatory_Common.simple_sup(ds, 'bip_didaddress_sup.txt', bdidAddrSupHash);

						contactsAllSupHash(recordof(ds) rec) := hashmd5(intformat(rec.seleID, 12, 1));
						contactsAllSup := bdidAddrSup(is_Contact != true)
														+ Suppress.applyRegulatory_Common.simple_sup(bdidAddrSup(is_Contact = true), 'bip_contactsall_sup.txt', contactsAllSupHash);

						contactsSupHash(recordof(ds) rec) := hashmd5(intformat(rec.seleID, 12, 1), intformat(rec.contact_did, 12, 1));
						contactsSup := contactsAllSup(is_Contact != true)
												 + Suppress.applyRegulatory_Common.simple_sup(contactsAllSup(is_Contact = true), 'bip_contacts_sup.txt', contactsSupHash);

						contactsTitleSupHash(recordof(ds) rec) := hashmd5(intformat(rec.seleID, 12, 1), rec.contact_job_title_raw, rec.contact_name.lname, rec.contact_name.fname);
						contactsTitleSup := contactsSup(is_Contact != true)
															+ Suppress.applyRegulatory_Common.simple_sup(contactsSup(is_Contact = true), 'bip_contactsbytitle_sup.txt', contactsTitleSuphash);

						contact_layout := record
									unsigned8 rid:=0;
									BIPV2.IDlayouts.l_xlink_ids; 
									BIPV2.Layout_Business_Linking_Full ;
									boolean executive_ind:=False;
									integer executive_ind_order:=0;
							end;
							
						return Suppress.applyRegulatory_Common.simple_append(contactsTitleSup, 'file_business_contact_bip_inj.txt', contact_layout);
			endmacro;


			export applyWatercraftS(ds) := functionmacro
								
						WatercraftHash(recordof(ds) L) := hashmd5(trim((string)l.watercraft_key, left, right), 
																										   trim((string)l.sequence_key, left, right),
																											 trim((string)l.fname, left, right),
																											 trim((string)l.lname, left, right)) ;						  
							
						ds1 := Suppress.applyRegulatory_Common.simple_sup(ds, 'file_watercraft_search_sup.txt', WatercraftHash);
														
						return suppress.applyRegulatory_Common.simple_append_WC(ds1, 'file_watercraft_search_inj.txt', Watercraft.Layout_Scrubs.Search_Base); 
			endmacro;

			export applyWatercraftMain (ds) := functionmacro
		
						WatercraftHash(recordof(ds) L) := hashmd5(trim((string)l.watercraft_key, left, right), 
																											trim((string)l.sequence_key, left, right)) ;						  
							
						ds1 := Suppress.applyRegulatory_Common.simple_sup(ds, 'file_watercraft_main_sup.txt', WatercraftHash);
														
						return suppress.applyRegulatory_Common.simple_append(ds1, 'file_watercraft_main_inj.txt', Watercraft.Layout_Scrubs.Main_Base); 			
			endmacro ;


			//
			// process vehicle party information
			//
			export applyMotorVehicleP(ds) := functionmacro
								
						VehiclePartySupHash(recordof(ds) L) := hashmd5(trim((string)l.Vehicle_key, 	 left, right), 
																													 trim((string)l.Iteration_key, left, right),
																												   trim((string)l.sequence_key,  left, right),
																													 trim((string)l.fname,         left, right),
																													 trim((string)l.lname,         left, right));
						ds1 := Suppress.applyRegulatory_Common.simple_sup(ds, 'file_vehicle_party_sup.txt', VehiclePartySupHash);
						// ds1 := Suppress.applyRegulatory_Common.simple_sup(ds, 'file_vehicle_party_sup.txt', VehiclePartySupHash): persist('~thor_data400::persist::vehiclev2::interm_party', single);

						return suppress.applyRegulatory_Common.simple_append(ds1, 'file_vehicle_party_inj.thor', VehicleV2.Layout_Base.Party_bip); 
			endmacro;

			//
			// process vehicle information
			// code has been commented as need and keys haven't been determine.  
			// Note the infrastructure changes made in vehicleV2.files and prep_build still support the calling of this file in case future direction changes	
			//
			export applyMotorVehicleM(ds) := functionmacro
			
						// vinSupHash(recordof(ds) L) := hashmd5(trim((string)l.Vina_Vin, left,right));
								
						// VehicleKeySupHash(recordof(ds) L) := hashmd5(trim((string)l.Vehicle_key, left,right));
								
						// ds1 := Suppress.applyRegulatory_Common.simple_sup(ds, 		'file_mvr_main_vin_sup.txt', vinSupHash);
						// ds2 := Suppress.applyRegulatory_Common.simple_sup(ds1, 	 	'file_mvr_vehkey_sup.txt', VehicleKeySupHash);
						// return suppress.applyRegulatory_Common.simple_append(ds1, 'file_mvr_main_inj.thor', Suppress.Layout_Regulatory.MVR_Main_Lo);
						
						return ds;
			endmacro;

			//
			// process hunting/fishing information
			// placeholder code as this isn't being called yet
			//
			export applyHF(ds) := functionmacro
								
						HF_SSN_Hash(recordof(ds) L) := hashmd5(trim(l.best_ssn, left, right));
						HF_DID_Hash(recordof(ds) L) := hashmd5(trim(l.did_out, 	left, right));
																														 
						// this could be done better via use of a multi-sup function.  Refer to one of the complex sup functions for an example
						ds1 := Suppress.applyRegulatory_Common.simple_sup(ds, 'file_hunt_fish_sup.txt', HF_SSN_Hash);
						ds2 := Suppress.applyRegulatory_Common.simple_sup(ds1, 'file_hunt_fish_sup.txt', HF_DID_Hash);
								
						return Suppress.applyRegulatory_Common.simple_append(ds2, 'file_hunt_fish_inj.thor', emerges.layout_hunters_out); 
			endmacro; // applyHF

			//
			// process CCW information
			// placeholder code as this isn't being called yet
			//
			export applyCCW(ds) := functionmacro
								
						CCW_SSN_Hash(recordof(ds) L) := hashmd5(trim(l.best_ssn, left, right));
						CCW_DID_Hash(recordof(ds) L) := hashmd5(trim(l.did_out,  left, right));

						// this could be done better via use of a multi-sup function.  Refer to one of the complex sup functions for an example
						ds1 := Suppress.applyRegulatory_Common.simple_sup(ds, 'file_ccw_sup.txt', CCW_SSN_Hash);
						ds2 := Suppress.applyRegulatory_Common.simple_sup(ds1, 'file_ccw_sup.txt', CCW_DID_Hash);

						return Suppress.applyRegulatory_Common.simple_append(ds2, 'file_ccw_inj.thor', emerges.layout_ccw_out);  
			endmacro; // applyCCW


			export complex_email_append(base_ds, filename, drop_layout, base_layout) := functionmacro
					
						base_layout xToEmail_Data(drop_layout L):= TRANSFORM
									self.append_is_tld_state := (boolean) ((unsigned) L.append_is_tld_state) ;
									self.append_is_tld_generic := (boolean)  ((unsigned) L.append_is_tld_generic) ;
									self.append_is_tld_country := (boolean)  ((unsigned)L.append_is_tld_country);
									self.append_is_valid_domain_ext := (boolean)  ((unsigned) L.append_is_valid_domain_ext) ;
									self.email_rec_key := (unsigned6) L.email_rec_key;
									self.rec_src_all := (unsigned2) L.email_src_all ;
									self.email_src_all := (unsigned2)  L.email_src_all ;
									self.email_src_num := (unsigned2)  L.email_src_num ;
									self.num_email_per_did := (unsigned2)  L.email_src_num ;
									self.num_did_per_email := (unsigned2)  L.email_src_num ;		
									self.did := (unsigned6) L.did ;
									self.did_score:= (unsigned8) L.did_score ;
									self.is_did_prop := (boolean) ((unsigned) L.is_did_prop) ;
									self.hhid := (unsigned6) L.hhid ;
									self.append_rawaid:= (unsigned8) L.append_rawaid ;
									self.best_dob:= (unsigned6) L.best_dob ;
									self.current_rec:= (boolean) ((unsigned) L.current_rec) ;
									self := L ;

						END;  					
						
            Base_File_Append_In := Suppress.applyRegulatory_Common.getFile(filename, Email_Data.Layout_Email.eor_base_sz);  	
			
						Projected_lz := project(Base_File_Append_in, xToEmail_Data(LEFT));
									
						return distribute((base_ds + Projected_lz), random());	
			endmacro;		//complex_email_append	

			export complex_email_sup(base_ds, filename, hashfunc1, hashfunc2, hashfunc3) := functionmacro
						import header_services;
            
						local supLayout := header_services.Supplemental_Data.layout_in;
																
            sup_in := Suppress.applyRegulatory_Common.getFile(filename, supLayout);
							
						local dSuppressedIn := project(sup_In, header_services.Supplemental_Data.in_to_out(left));
							
						return join (base_ds, dSuppressedIn, 
															hashFunc1(left) = right.hval or
															hashFunc2(left) = right.hval or
															hashFunc3(left) = right.hval,
															transform(LEFT)
															, LEFT ONLY, ALL) ;							
							
			endmacro; // complex_email_sup

			//
			// process EMail information
			//
			export applyEMail(ds) := functionmacro
									
						Email_Hash(recordof(ds) L) 		:= hashmd5(trim(l.clean_email, left, right));
						DID_Hash(recordof(ds) L) 			:= hashmd5(trim((string)l.did, left, right));
						combined_hash(recordof(ds) L) := hashmd5(trim((string)l.did, left, right), trim(l.clean_email, left, right));
							
						ds1 := Suppress.applyRegulatory_Boca.complex_email_sup(ds, 'file_email_sup.txt', email_Hash, did_hash, combined_hash);
		
						return	Suppress.applyRegulatory_Boca.complex_email_append(ds1, 'file_email_inj.txt', Email_Data.Layout_Email.eor_base_sz, email_data.layout_email.base);
			endmacro; // applyEMail

end;
