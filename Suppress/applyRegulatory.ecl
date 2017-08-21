import std, header_services, vehiclev2, Watercraft;

export applyRegulatory := module
                shared IP := header_services.ProductionLZ.IP_Loc; 
                shared thor_path := header_services.ProductionLZ.Directory_Loc;
                // shared thor_path := '/mnt/disk1/var/lib/HPCCSystems/mydropzone/';
                // shared thor_path := '/c$/bdurrant/';
                shared unix_path := header_services.ProductionLZ.Directory_Loc1;
                // shared unix_path := '/mnt/disk1/var/lib/HPCCSystems/mydropzone/';
                // shared unix_path := '/c$/bdurrant/';
                // shared notification_email_addr := 'james.cook@lnssi.com'; //header_services.ProductionLZ.notification_email; 
                // export notification_email_addr := 'bradley.durrant@lnssi.com'; //header_services.ProductionLZ.notification_email; 
							
                export notification_email_addr := header_services.ProductionLZ.notification_email; 
                
                export full_file_name(string fname)              := STD.File.ExternalLogicalFileName(IP, thor_path + fname);

                export should_fail := true : stored('fail_switch');

                shared emailAddr                                                                          := notification_email_addr;
                shared emailInfo := '\r\n Job Name: ' + thorlib.jobname() + ' \r\n User Name: ' + thorlib.jobowner() + ' \r\n Cluster: ' + thorlib.cluster();
                export emailMsg(string msg) := FileServices.sendemail(emailAddr, 'Upload from Drop Zone Status ' + Thorlib.WUID(), msg + emailInfo);

                export check_found(string fullname) := function
                                file_exists                                                                              := std.file.fileexists(fullname);
                                file_not_found_msg           := 'supplemental data file ' + fullname + ' not found';
                                file_not_found := if(
                                                should_fail,
                                                sequential(emailMsg(file_not_found_msg), fail(file_not_found_msg)),
                                                emailMsg(file_not_found_msg)
                                );

                                if(not file_exists, file_not_found);
                                return file_exists;
                end;

                export check_size(string fname, unsigned record_length) := function
                                                fsize := STD.File.RemoteDirectory(IP,unix_path,fname)[1].size;

                                                file_size_good                     := ((fsize % record_length) = 0) and (fsize <> 0);
                                                size_failure_msg := 'unexpected supplemental data file size/record length: ' + fsize + ', expected record length: ' +  record_length + ' for '+ full_file_name(fname);
                                                size_failure                                           := if(
                                                                should_fail,
                                                                sequential(emailMsg(size_failure_msg), fail(size_failure_msg)),
                                                                emailMsg(size_failure_msg)
                                                );
                                                if(not file_size_good, size_failure);
                                                return file_size_good;
                end;							

// dataset(layout)
                export getfile(filename,layout) := functionmacro
                                import _control;
                                local full_filename_path    := suppress.applyregulatory.full_file_name(filename);
                                
                                local isFound           := nothor(suppress.applyregulatory.check_found(full_filename_path));
                                
                                local record_length     := sizeof(Layout);

                                local isSizeGood        := nothor(suppress.applyregulatory.check_size(filename,record_length));

                                local success_msg       := 'successfully read supplemental data filename ' + full_filename_path;
                                local success_email     := nothor(suppress.applyregulatory.emailMsg(success_msg));
                                
                                local isProd            := (_control.ThisEnvironment.name = 'Prod' or _control.ThisEnvironment.Name = 'Prod_Thor'); // Alpha Prod or Boca Prod
                                
                                if(isFound, if(isSizeGood, success_email));
																
                                return if( isFound and isSizeGood and isProd, dataset(full_filename_path,layout,flat,opt), dataset([],layout) );
                endmacro;

                export layout_in := record
                                string32 hval_s;
                                string2  nl;
                end;

                export complex_append(base_ds, filename, Drop_Layout, trans) := functionmacro

                                Base_File_Append_In := suppress.applyregulatory.getFile(filename, Drop_Layout);
                
                                Base_File_Append := project(Base_File_Append_In, trans(left));

                                return base_ds + Base_file_append;

                endmacro; // complex_append

								// base_ds is the thor dataset to be appended to
								// filename is the lz file to be injected
								// drop_layout is the layout of the ls file
								// endrec is an indicator that the lz file contains and end of rec (newline) character
                export simple_append(base_ds, filename, Drop_Layout, endrec=false) := functionmacro
                                Base_File_Append_In := suppress.applyregulatory.getFile(filename, Drop_Layout);
                
                                recordof(base_ds) reformat_append(Base_File_Append_In L) := transform
                                                self := L;
                                                self := [];
                                end;
                
                                Base_File_Append := project(Base_File_Append_In, reformat_append(left));															
																														
																// this code was an attempt to warn if the boca and miamisburg layouts differed.  
																// commented out 5-12 as this code could warn of false positives  - BJD
																
																// sizechg := FileServices.sendemail(suppress.applyRegulatory.notification_email_addr, 
																																	// '**** Record Layout size change detected ****', 
																																	// 'Did BOCA Layout change for ' + filename );
																																	
																// endcnt := if(endrec, 1, 0);
																// if (sizeof(recordof(Base_File_Append_In))-endcnt <> sizeof(recordof(base_ds)), sizechg);														
																// if (sizeof(Drop_Layout) <> sizeof(recordof(base_ds)), sizechg);														

                                return base_ds + Base_file_append;
                endmacro; // simple_append
								
								

                export simple_sup(base_ds, filename, hashFunc) := functionmacro
                                import header_services;
                                local supLayout := header_services.Supplemental_Data.layout_in;
																
                                sup_in := suppress.applyregulatory.getFile(filename, supLayout);
																														
                                local dSuppressedIn := project(sup_In, header_services.Supplemental_Data.in_to_out(left));
																
                                return join(base_ds, dSuppressedIn, hashFunc(left) = right.hval, transform(left), left only, lookup);
                endmacro; // simple_sup

                export applyBIPV2(ds) := functionmacro
                                bdidAddrSupHash(recordof(ds) rec) := hashmd5(intformat(rec.company_bdid, 12, 1), rec.st, rec.zip,
                                                                             rec.v_city_name, rec.prim_name, rec.prim_range, rec.predir,
                                                                             rec.addr_suffix, rec.postdir, rec.sec_range);
                                bdidAddrSup := Suppress.applyRegulatory.simple_sup(ds, 'didaddressbusiness_sup.txt', bdidAddrSupHash);

                                contactsAllSupHash(recordof(ds) rec) := hashmd5(intformat(rec.company_bdid, 12, 1));
                                contactsAllSup := bdidAddrSup(isContact != 'T')
                                                + Suppress.applyRegulatory.simple_sup(bdidAddrSup(isContact = 'T'), 'businesscontactsall_sup.txt', contactsAllSupHash);

                                contactsSupHash(recordof(ds) rec) := hashmd5(intformat(rec.company_bdid, 12, 1), intformat(rec.contact_did, 12, 1));
                                contactsSup := contactsAllSup(isContact != 'T')
                                             + Suppress.applyRegulatory.simple_sup(contactsAllSup(isContact = 'T'), 'businesscontacts_sup.txt', contactsSupHash);

                                contactsTitleSupHash(recordof(ds) rec) := hashmd5(intformat(rec.company_bdid, 12, 1), rec.contact_job_title_raw, rec.lname, rec.fname);
                                contactsTitleSup := contactsSup(isContact != 'T')
                                                  + Suppress.applyRegulatory.simple_sup(contactsSup(isContact = 'T'), 'businesscontactsbytitle_sup.txt', contactsTitleSuphash);

                                return Suppress.applyRegulatory.simple_append(contactsTitleSup, 'file_bipv2_inj.txt', BIPV2.CommonBase_mod.Layout_S18);
                endmacro;

                export relativesSup(ds,hashes) := functionmacro
                                ro_temp_rec := record
                                insuranceheader_relative.layout_output.titled;
                                data16 hval1;
                                data16 hval2;
                                data16 hval3;
                                data16 hval4;
                                end;

                                ro_temp_rec tHash_vals(insuranceheader_relative.layout_output.titled l) := transform                            
                                 self.hval1 := hashmd5(intformat(l.did1,15,1),intformat(l.did2,15,1));
                                self.hval2 := hashmd5(intformat(l.did2,15,1),intformat(l.did1,15,1));
                                self.hval3 := hashmd5(intformat(l.did1,15,1));
                                self.hval4 := hashmd5(intformat(l.did2,15,1));
                                self := l;
                                end;

                                ro_temp := project(ds, tHash_vals(left));

                                insuranceheader_relative.layout_output.titled tSuppress(ro_Temp l, hashes r) := transform
                                self := l;
                                end;

																rs := join(ro_temp,hashes,
                                       (left.hval1=right.hval or left.hval2=right.hval or left.hval3=right.hval or left.hval4=right.hval),
                                       tSuppress(left,right),
                                       left only,all);
																				 
															 return rs;
                endmacro;

                export getHashes(filename) := functionmacro
                                import Header_Services;
                                local supLayout := suppress.applyregulatory.layout_in;
                                sup_in := suppress.applyregulatory.getFile(filename, supLayout);
                                local dIn := project(sup_in, Header_Services.Supplemental_Data.in_to_out(left));

                                return dIn;
                endmacro;
                
                export applyRelatives(ds) := functionmacro
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
                                                self.did1 := (unsigned6) L.person1;
                                                self.did2 := (unsigned6) L.person2;
                                                // self.rel_dt_last_seen := (integer3) L.recent_cohabit * 100;
                                                // self.zip := (integer3) L.zip;
                                                //self.source_type := (integer2) L.prim_range;
                                                self.isCurrLnameMatch := (boolean) L.same_lname;
                                                self.isAnyLnameMatch  := (boolean) L.same_lname;
                                                self.total_score := (unsigned2) L.number_cohabits * 6;
                                                self.total_cnt := 1;
                                                self.copolicy_cnt     := IF(L.prim_range = '0', 1 , 0);
                                                self.copolicy_score   := IF(L.prim_range = '0', self.total_score, 0);
                                                self.cossn_cnt        := IF(L.prim_range = '-1', 1 , 0);
                                                self.cossn_score      := IF(L.prim_range = '-1', self.total_score, 0);
                                                self.cohabit_cnt      := IF(L.prim_range = '-3' OR L.prim_range > '0', 1 , 0);
                                                self.cohabit_score    := IF(L.prim_range = '-3' OR L.prim_range > '0', self.total_score, 0);
                                                self.coucc_cnt        := IF(L.prim_range = '-4', 1 , 0);
                                                self.coucc_score      := IF(L.prim_range = '-4', self.total_score, 0);
                                                self.covehicle_cnt    := IF(L.prim_range = '-5', 1 , 0);
                                                self.covehicle_score  := IF(L.prim_range = '-5', self.total_score, 0);
                                                self.coproperty_cnt   := IF(L.prim_range = '-6', 1 , 0);
                                                self.coproperty_score := IF(L.prim_range = '-6', self.total_score, 0);
                                                self.comarriagedivorce_cnt   := IF(L.prim_range = '-7', 1 , 0);
                                                self.comarriagedivorce_score := IF(L.prim_range = '-7', self.total_score, 0);
                                                // self.relative_matches:= '';
                                                // self.relatives_match_score := ''; 
                                                // self.shared_addr_score  :=0;
                                                // self.Match_by_zip_score := 0 ; 
                                                // self.nbr_of_addresses := 0 ; 
                                                // self.dt_last_relative := 0 ; 
                                                // self.current_relatives := true;
                                                // self.__filepos := 0;
                                                self.type := IF(L.prim_range = '-2', 'TRANS CLOSURE', 'PERSONAL');
                                                self.confidence := 'HIGH';
                                                self.cluster    := 'CORE';
                                                self.generation := 'S';
                                                self.title := 43;
                                                self.personal := TRUE;
                                                self.lname_cnt := 1;
                                                self := L;
                                                self:= []; 
                                 end;

                                return suppress.applyregulatory.complex_append(ds4,'file_relatives_inj.txt',Drop_Header_Layout,trans);
                
                endmacro;

	export applyHeaderLinking(ds) := functionmacro

		dlSupHash(recordof(ds) L) := HASHMD5(	intformat((unsigned6)l.did,15,1),TRIM((string14)l.vendor_id, left, right));
		ds1 := Suppress.applyRegulatory.simple_sup(ds, 'driverslicense_sup.txt', dlSupHash);

		didAddrSupHash(recordof(ds1) L) := hashmd5(intformat(l.did,15,1),(string)l.st,(string)l.zip,(string)l.city,
									(string)l.prim_name,(string)l.prim_range,(string)l.predir,(string)l.addr_suffix,(string)l.postdir,(string)l.sec_range);
		ds2 := Suppress.applyRegulatory.simple_sup(ds1, 'didaddress_sup.txt', didAddrSupHash);

		return suppress.applyRegulatory.simple_append(ds2,'header_linking_inj.thor', suppress.layout_regulatory.IDL_Header);
endmacro;

// Special append for watercraft 

 export simple_append_WC (base_ds, filename, Drop_Layout, endrec=false) := functionmacro
 
                            Base_File_Append_In := suppress.applyregulatory.getFile(filename, Drop_Layout);
														
														src_cd_max := count(base_ds);
							
														recordof(base_ds) reformat_append(Base_File_Append_In L, Integer C ) := transform
															self.source_rec_id := src_cd_max + C ;
															self := L ;
															self := [] ;
							             end;

							              Base_file_append := project(Base_File_Append_In, reformat_append(left, COUNTER));	
														
	                          return base_ds + Base_file_append;
        endmacro; // simple_append Watercraft
//

export applyWatercraftS(ds) := functionmacro
								
							WatercraftHash(recordof(ds) L) := hashmd5(trim((string)l.watercraft_key, left, right), 
																													   trim((string)l.sequence_key, left, right),
																														 trim((string)l.state_origin, left, right)) ;						  
							
						  ds1 := Suppress.applyRegulatory.simple_sup(ds, 'file_watercraft_sup.txt', WatercraftHash);
														
							return suppress.applyRegulatory.simple_append_WC(ds1, 'file_watercraft_search_inj.txt', Watercraft.Layout_Scrubs.Search_Base); 

endmacro;

export applyWatercraftMain (ds) := functionmacro

					return ds ;
					
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
							ds1 := Suppress.applyRegulatory.simple_sup(ds, 'file_vehicle_party_sup.txt', VehiclePartySupHash);
							return suppress.applyRegulatory.simple_append(ds1, 'file_vehicle_party_inj.thor', VehicleV2.Layout_Base.Party_bip); 

					endmacro;

					//
					// process vehicle information
					// code has been commented as need and keys haven't been determine.  
					// Note the infrastructure changes made in vehicleV2.files and prep_build still support the calling of this file in case future direction changes	
					//
					export applyMotorVehicleM(ds) := functionmacro
								// vinSupHash(recordof(ds) L) := hashmd5(trim((string)l.Vina_Vin, left,right));
								
								// VehicleKeySupHash(recordof(ds) L) := hashmd5(trim((string)l.Vehicle_key, left,right));
								
								// ds1 := Suppress.applyRegulatory.simple_sup(ds, 		'file_mvr_main_vin_sup.txt', vinSupHash);
								// ds2 := Suppress.applyRegulatory.simple_sup(ds1, 	 	'file_mvr_vehkey_sup.txt', VehicleKeySupHash);
								// return suppress.applyRegulatory.simple_append(ds1, 'file_mvr_main_inj.thor', Suppress.Layout_Regulatory.MVR_Main_Lo);
								return ds;
					endmacro;

					//
					// process hunting/fishing information
					//
					export applyHF(ds) := functionmacro
								
							HF_SSN_Hash(recordof(ds) L) := hashmd5(trim(l.best_ssn, left, right));
							HF_DID_Hash(recordof(ds) L) := hashmd5(trim(l.did_out, 	left, right));
																														 
							// this could be done better via use of a multi-sup function
							ds1 := Suppress.applyRegulatory.simple_sup(ds, 'file_hunt_fish_sup.txt', HF_SSN_Hash);
							ds2 := Suppress.applyRegulatory.simple_sup(ds1, 'file_hunt_fish_sup.txt', HF_DID_Hash);
								
							return suppress.applyRegulatory.simple_append(ds2, 'file_hunt_fish_inj.thor', emerges.layout_hunters_out); 

					endmacro; // applyHF

					//
					// process CCW information
					//
					export applyCCW(ds) := functionmacro
								
							CCW_SSN_Hash(recordof(ds) L) := hashmd5(trim(l.best_ssn, left, right));
							CCW_DID_Hash(recordof(ds) L) := hashmd5(trim(l.did_out,  left, right));

							// this could be done better via use of a multi-sup function
							ds1 := Suppress.applyRegulatory.simple_sup(ds, 'file_ccw_sup.txt', CCW_SSN_Hash);
							ds2 := Suppress.applyRegulatory.simple_sup(ds1, 'file_ccw_sup.txt', CCW_DID_Hash);

							return Suppress.applyRegulatory.simple_append(ds2, 'file_ccw_inj.thor', emerges.layout_ccw_out);  

					endmacro; // spplyCCW


end;


