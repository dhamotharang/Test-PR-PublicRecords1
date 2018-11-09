//
// 	Suppress.applyRegulatory_Common
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

export applyRegulatory_Common := module

			shared IP := header_services.ProductionLZ.IP_Loc; 
									
			shared thor_path := header_services.ProductionLZ.Directory_Loc;
			// shared thor_path := '/mnt/disk1/var/lib/HPCCSystems/mydropzone/';

			shared unix_path := header_services.ProductionLZ.Directory_Loc1;
			// shared unix_path := '/mnt/disk1/var/lib/HPCCSystems/mydropzone/';
			
			// shared notification_email_addr := 'james.cook@lnssi.com'; //header_services.ProductionLZ.notification_email; 
			// export notification_email_addr := 'bradley.durrant@lnssi.com'; //header_services.ProductionLZ.notification_email; 
			export notification_email_addr := header_services.ProductionLZ.notification_email; 
									
			export full_file_name(string fname) := STD.File.ExternalLogicalFileName(IP, thor_path + fname);

			export should_fail := true : stored('fail_switch');

			shared emailAddr						:= notification_email_addr;
			shared emailInfo 						:= '\r\n Job Name: ' + thorlib.jobname() + ' \r\n User Name: ' + thorlib.jobowner() + ' \r\n Cluster: ' + thorlib.cluster();
			export emailMsg(string msg) := FileServices.sendemail(emailAddr, 'Upload from Drop Zone Status ' + Thorlib.WUID(), msg + emailInfo);

			export check_found(string fullname) := function
			
						file_exists 				:= std.file.fileexists(fullname);
						
						file_not_found_msg	:= 'supplemental data file ' + fullname + ' not found';
						file_not_found 			:= if(should_fail,
																			sequential(emailMsg(file_not_found_msg), fail(file_not_found_msg)),
																			emailMsg(file_not_found_msg)
																		 );

						if(not file_exists, file_not_found);
						
						return file_exists;
			end;

			export check_size(string fname, unsigned record_length) := function
			
						fsize := STD.File.RemoteDirectory(IP,unix_path,fname)[1].size;

						file_size_good 		:= ((fsize % record_length) = 0) and (fsize <> 0);
						size_failure_msg 	:= 'unexpected supplemental data file size/record length: ' + fsize + ', expected record length: ' +  record_length + ' for '+ full_file_name(fname);
						size_failure			:= if(should_fail,
																		sequential(emailMsg(size_failure_msg), fail(size_failure_msg)),
																		emailMsg(size_failure_msg)
																		);
						if(not file_size_good, size_failure);
						
						return file_size_good;
			end;							

// dataset(layout)
			export getfile(filename,layout) := functionmacro
						import _control;
						
						local full_filename_path    := Suppress.applyRegulatory_Common.full_file_name(filename);
						
						local isFound           		:= nothor(Suppress.applyRegulatory_Common.check_found(full_filename_path));
						
						local record_length     		:= sizeof(Layout);

						local isSizeGood        		:= nothor(Suppress.applyRegulatory_Common.check_size(filename,record_length));

						local success_msg       		:= 'successfully read supplemental data filename ' + full_filename_path;
						local success_email     		:= nothor(Suppress.applyRegulatory_Common.emailMsg(success_msg));
						
						local isProd            		:= (_control.ThisEnvironment.name = 'Prod' or _control.ThisEnvironment.Name = 'Prod_Thor'); // Alpha Prod or Boca Prod
						
						if(isFound, if(isSizeGood, success_email));
						
						return if( isFound and isSizeGood and isProd, dataset(full_filename_path,layout,flat,opt), dataset([],layout) );
			endmacro;

			export layout_in := record
															string32 hval_s;
															string2  nl;
													end;

			export complex_append(base_ds, filename, Drop_Layout, trans) := functionmacro

						Base_File_Append_In := Suppress.applyRegulatory_Common.getFile(filename, Drop_Layout);

						Base_File_Append := project(Base_File_Append_In, trans(left));

						return base_ds + Base_file_append;
			endmacro; // complex_append


			// base_ds is the thor dataset to be appended to
			// filename is the lz file to be injected
			// drop_layout is the layout of the ls file
			// endrec is an indicator that the lz file contains and end of rec (newline) character
			export simple_append(base_ds, filename, Drop_Layout, endrec=false) := functionmacro

						Base_File_Append_In := Suppress.applyRegulatory_Common.getFile(filename, Drop_Layout);

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
						
						sup_in := Suppress.applyRegulatory_Common.getFile(filename, supLayout);
																				
						local dSuppressedIn := project(sup_In, header_services.Supplemental_Data.in_to_out(left));
						
						return join(base_ds, dSuppressedIn, hashFunc(left) = right.hval, transform(left), left only, lookup);
			endmacro; // simple_sup

 
			// Special append for watercraft 
			export simple_append_WC (base_ds, filename, Drop_Layout, endrec=false) := functionmacro
	 
						Base_File_Append_In := Suppress.applyRegulatory_Common.getFile(filename, Drop_Layout);
															
						src_cd_max := count(base_ds);
								
						recordof(base_ds) reformat_append(Base_File_Append_In L, Integer C ) := transform
									self.source_rec_id := src_cd_max + C ;
									self := L ;
									self := [] ;
						end;

						Base_file_append := project(Base_File_Append_In, reformat_append(left, COUNTER));	
															
						return base_ds + Base_file_append;
			endmacro; // simple_append_WC

end;