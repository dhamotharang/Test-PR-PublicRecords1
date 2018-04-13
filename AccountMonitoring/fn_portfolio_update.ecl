IMPORT AccountMonitoring, DidVille, Doxie_cbrs, Address, Business_Header_SS;

EXPORT fn_portfolio_update(UNSIGNED1 pseudo_environment,
                           STRING spray_ip_address,
                           STRING spray_ip_path,
									BOOLEAN Inq_Tracking = TRUE) := 
	FUNCTION
		time_stamp := thorlib.wuid();		
		
		// Actions:
		MODIFY   := AccountMonitoring.constants.actions.MODIFY;
		PRODUCTS := AccountMonitoring.constants.actions.PRODUCTS;
		GO       := AccountMonitoring.constants.actions.GO;
		STOP     := AccountMonitoring.constants.actions.STOP;
		DELETE   := AccountMonitoring.constants.actions.DELETE;
		
		//  portfolio update file:
		spray_input_files := AccountMonitoring.proc_input_portfolio_update(pseudo_environment,spray_ip_address,spray_ip_path,time_stamp);
		portfolio_update  := DISTRIBUTE(files(pseudo_environment).portfolio.update,HASH32(pid,rid)) : INDEPENDENT;
		
		// 1.  Add new entities to the Portfolio from the update file.		
		
		// 1a. Clean the raw portfolio update.	
		clean_addr_rec := record
			AccountMonitoring.layouts.portfolio.update;
			STRING address_cln;
		end;

		fn_CleanInput(string s) := TRIM(REGEXREPLACE('\\s+',REGEXREPLACE('[^\\x20-\\x7E]',s,' '),' '),LEFT,RIGHT);

		clean_addr_rec toCleanAddrRec(AccountMonitoring.layouts.portfolio.update l) := 
					TRANSFORM
						clnin_address_1 := fn_CleanInput(l.address_1);
						clnin_address_2 := fn_CleanInput(l.address_2);
						clnin_city := fn_CleanInput(l.city);
						clnin_state := fn_CleanInput(l.state);
						clnin_zip := fn_CleanInput(l.zip);
						new_address1 := StringLib.StringCleanSpaces(clnin_address_1 + clnin_address_2);
						new_address2 := StringLib.StringCleanSpaces(TRIM(clnin_city) +
																												IF(clnin_city != '' AND (clnin_state != '' OR clnin_zip != ''), ', ', '') +
																												TRIM(clnin_state + ' ' + clnin_zip[1..5]));

						// thorprd
							// Address.Constants.CorrectServer
							// Address.Constants.CorrectPort
						// batchprd
							// Address.Constants.newbatchserver
							// Address.Constants.newbatchport
						SELF.address_cln := MAP(new_address1 != '' AND
																		new_address2 != '' => Address.CleanAddress182(new_address1, 
																																									new_address2, 
																																									Address.Constants.CorrectServer, 
																																									Address.Constants.CorrectPort),
																													'');
						SELF             := l;
					END;
					
		portfolio_update_clean_addr := PROJECT(portfolio_update(action_code = MODIFY), toCleanAddrRec(LEFT), LOCAL) : INDEPENDENT;

		AccountMonitoring.layouts.DIDMetaRec toDIDMetaRec(clean_addr_rec l) := 
					TRANSFORM																			
						SELF.seq         := HASH32(l.pid, l.rid);
						SELF.fname       := l.name_first;
						SELF.mname       := l.name_middle;
						SELF.lname       := l.name_last;
						SELF.suffix      := l.name_suffix;
						SELF.comp_name   := IF( TRIM(l.name_first) = '', l.name_last, '' );
						SELF.prim_range  := l.address_cln[1..10];
						SELF.predir      := l.address_cln[11..12];
						SELF.prim_name   := l.address_cln[13..40];
						SELF.addr_suffix := l.address_cln[41..44];
						SELF.postdir     := l.address_cln[45..46];
						SELF.unit_desig  := l.address_cln[47..56];
						SELF.sec_range   := l.address_cln[57..64];
						SELF.p_city_name := l.address_cln[65..89];
						SELF.st          := IF(l.address_cln[115..116] !='' AND l.address_cln[1..10] !='' , l.address_cln[115..116],  l.state);
						SELF.z5          := IF(l.address_cln[117..121] !='' AND l.address_cln[1..10] !='', l.address_cln[117..121], TRIM(l.zip)[1..5]);
						SELF.zip4        := IF(l.address_cln[122..125] !='' AND l.address_cln[1..10] !='', l.address_cln[122..125], TRIM(REGEXREPLACE('[^0-9]',l.zip,''))[6..9]);
						SELF.phone10     := l.phone;
						SELF             := l;
						SELF             := [];
					END;
					
		portfolio_update_for_new_entites := PROJECT(portfolio_update_clean_addr, toDIDMetaRec(LEFT)) : INDEPENDENT;
						
		infos := PROJECT(portfolio_update_for_new_entites, layouts.InfoRec); // INFO: 'seq' is HASH32(pid,rid)
		
		// 1b. Add DIDs.
		DID_values := rpc_for_Dids(portfolio_update_for_new_entites(did = 0));
		
		portfolio_update_with_DIDs := 
			JOIN( 
				   portfolio_update_for_new_entites, DISTRIBUTED(DID_values),
				   LEFT.seq = RIGHT.seq,
				   TRANSFORM( layouts.DIDMetaRec,
					           SELF.did := IF(LEFT.did = 0, RIGHT.did, LEFT.did),
					           SELF     := LEFT ),
				   LEFT OUTER,
				   LOCAL
			    );
				
		// 1c. Add BDIDs.
		BDID_values := rpc_for_Bdids(portfolio_update_for_new_entites(bdid = 0));
		
		portfolio_update_with_DIDs_BDIDs := 
			JOIN( portfolio_update_with_DIDs, BDID_values,
				   LEFT.seq = RIGHT.seq,
				   TRANSFORM( layouts.DIDMetaRec,
					           SELF.bdid := IF(LEFT.bdid = 0, RIGHT.bdid, LEFT.bdid),
					           SELF      := LEFT ),
				   LEFT OUTER,
				   LOCAL
			    );
		
		// 1d. Join records having DIDs, BDIDs, and zero values for DIDs/BDIDs, to the cleaned update file
		AccountMonitoring.layouts.portfolio.base toPortfolio(AccountMonitoring.layouts.DIDMetaRec l, AccountMonitoring.layouts.InfoRec r) := 
			TRANSFORM
				SELF.timestamp := time_stamp[2..9] + time_stamp[11..16];
				SELF.name_first  := l.fname;
				SELF.name_middle := l.mname;
				SELF.name_last   := IF( l.fname  = '', '', l.lname );
				SELF.name_suffix := l.suffix;
				SELF.comp_name   := IF( l.fname != '', '', l.lname );
				SELF := l;
				SELF := r;
				SELF := [];
			END;
			
		modify_updates := JOIN(portfolio_update_with_DIDs_BDIDs, infos,
		                       LEFT.seq = RIGHT.seq,
		                       toPortfolio(LEFT, RIGHT),
		                       KEEP(1), LOCAL):INDEPENDENT;
		OUTPUT(modify_updates,,AccountMonitoring.constants.pseudo_ext(pseudo_environment) + 'PORTFOLIO_DELTA',COMPRESSED, OVERWRITE);
		
		modify_updates_dist_temp := DISTRIBUTE(modify_updates,HASH32(pid,rid));
		modify_updates_dist      := PROJECT( modify_updates_dist_temp,
		                                     TRANSFORM( {AccountMonitoring.layouts.Portfolio.base, UNSIGNED6 RevTimeStamp},
														             SELF.RevTimeStamp := 99999999999999 - (UNSIGNED6) LEFT.timestamp;
		                                                 SELF              := LEFT
														          )
													  );  
		modify_updates_sorted    := SORT(modify_updates_dist,pid,rid,Revtimestamp,LOCAL);  
		
		
		// 2. Modify existing entities in the Portfolio from the update file.
		
		portfolio_update_for_existing_entites := portfolio_update(action_code IN	[PRODUCTS, GO, STOP, DELETE]);
		
// -- NOTE: when new portfolio (2 mutually exclusive files) update takes place, remove -timestamp from SORTED here
		current_portfolio_sorted_temp         := SORTED( DISTRIBUTED( AccountMonitoring.files(pseudo_environment).portfolio.archive,HASH32(pid,rid) ), pid,rid,-timestamp );
		current_portfolio_sorted              := PROJECT( current_portfolio_sorted_temp,
		                                                  TRANSFORM( {AccountMonitoring.layouts.Portfolio.base, UNSIGNED6 RevTimeStamp},
																		             SELF.RevTimeStamp := 99999999999999 - (UNSIGNED6) LEFT.timestamp;
		                                                             SELF              := LEFT
																		           )
																		);  
		
		
		// 2a. Project the filtered update file into pid/rid, and use a LOOKUP JOIN as a cheap filter to whittle
		// down the gigantic Portfolio file to only those matching records. Do a sort/dedup for safety since we're
		// using a LOOKUP JOIN (1-to-1).
		portfolio_update_lookups :=
			DEDUP(
				SORT(
					PROJECT(
						portfolio_update_for_existing_entites,
						{UNSIGNED6 pid, UNSIGNED6 rid}
					),
					pid,rid, LOCAL),
				pid,rid, LOCAL
			);
			
		current_portfolio_filtered :=
			JOIN(
				current_portfolio_sorted,
				DISTRIBUTED(portfolio_update_lookups),
				LEFT.pid = RIGHT.pid AND
				LEFT.rid = RIGHT.rid,
				TRANSFORM(LEFT),
				INNER,
				LOOKUP,
				LOCAL
			);
		
		latest_portfolio_filtered := DEDUP(current_portfolio_filtered,pid,rid,LOCAL);
		
		// 2b. Join the filtered update file to the greatly whittled-down Porfolio file and perform the update.
		product_or_delete_updates := JOIN(
			latest_portfolio_filtered,
			portfolio_update_for_existing_entites,
			// current_portfolio_sorted,
			LEFT.pid = RIGHT.pid AND
			LEFT.rid = RIGHT.rid,
			transform({AccountMonitoring.layouts.portfolio.base, UNSIGNED6 RevTimeStamp},
			  SELF.timestamp    := time_stamp[2..9] + time_stamp[11..16],
			  SELF.action_code  := IF(RIGHT.action_code = AccountMonitoring.constants.actions.DELETE,RIGHT.action_code,LEFT.action_code),
			  SELF.product_mask := MAP(
			    LEFT.action_code = AccountMonitoring.constants.actions.GO      =>    RIGHT.product_mask | LEFT.product_mask,
				 LEFT.action_code = AccountMonitoring.constants.actions.STOP     =>    LEFT.product_mask & BNOT(RIGHT.product_mask),
				 LEFT.action_code = AccountMonitoring.constants.actions.DELETE   =>    LEFT.product_mask,
			 /* left.action_code = constants.actions.PRODUCTS => */ RIGHT.product_mask),
			  SELF := LEFT),
			LOCAL);
			
		product_or_delete_updates_dist   := DISTRIBUTE(product_or_delete_updates,HASH32(pid,rid));
		
		product_or_delete_updates_RevTS := PROJECT( product_or_delete_updates_dist,
		                                            TRANSFORM( {AccountMonitoring.layouts.Portfolio.base, UNSIGNED6 RevTimeStamp},
															                 SELF.RevTimeStamp := 99999999999999 - (UNSIGNED6) LEFT.timestamp;
		                                                        SELF              := LEFT
														                 )
										                  );  
		
		product_or_delete_updates_sorted := SORT(product_or_delete_updates_dist,pid,rid,RevTimeStamp,LOCAL);
		
		// 3. Merge all changes into an updated Portfolio. NOTE: Cannot merge a set of datasets:
		// 'System error: 10107: Unsupported activity kind: nwaymerge'
		// create the new archive base portfolio
		merged_changes :=
			MERGE(
				modify_updates_sorted, product_or_delete_updates_sorted,
				SORTED(pid,rid,RevTimeStamp),
				LOCAL
			);


		// sort the new archive base portfolio
		merged_portfolio_temp := 
			MERGE(
				current_portfolio_sorted, merged_changes,
				SORTED(pid,rid,RevTimeStamp),
				LOCAL
			) : INDEPENDENT;
    
      // project the layout back to the original base layout (without the reverse time stamp field)
		merged_portfolio := PROJECT( merged_portfolio_temp,
		                             TRANSFORM( AccountMonitoring.layouts.Portfolio.base, 
														    SELF              := LEFT
															)
										   ) : INDEPENDENT;
		

      // dedup the archive and remove all product mask = 0 
		// to create the new portfolio base which contains ONLY records that are actively being monitored
      merged_portfolio_current_records_only_temp := 
		      DEDUP(
			          SORTED( 
				               DISTRIBUTED( merged_portfolio_temp, 
					   	                   HASH32(pid,rid)
						   					  ),
					            pid,rid,RevTimeStamp, LOCAL
				             ),
			          pid,rid,LOCAL
		           )
		      (product_mask > 0);

      // project the layout back to the original base layout (without the reverse time stamp field)
		merged_portfolio_current_records_only := PROJECT( merged_portfolio_current_records_only_temp,
		                                                  TRANSFORM( AccountMonitoring.layouts.Portfolio.base, 
														                         SELF              := LEFT
															                     )
										                        );

		// write the new portfolio, archive and inquiry tracking files
		write_updated_portfolio_file := fn_update_portfolio_file(merged_portfolio_current_records_only,pseudo_environment,time_stamp,'portfolio');
		write_updated_archive_file   := fn_update_portfolio_file(merged_portfolio,pseudo_environment,time_stamp,'archive');
		write_inquiry_tracking_file  := fn_update_inquiry_tracking(pseudo_environment,merged_portfolio,time_stamp);

		fnms := AccountMonitoring.filenames(pseudo_environment);

		mac_update_documents_file(pseudo_environment,bankruptcy,spray_ip_address,spray_ip_path,fnms.documents.bankruptcy.remote,write_updated_bankruptcy_documents_file);
		mac_update_documents_file(pseudo_environment,deceased,spray_ip_address,spray_ip_path,fnms.documents.deceased.remote,write_updated_deceased_documents_file);
		mac_update_documents_file(pseudo_environment,address,spray_ip_address,spray_ip_path,fnms.documents.address.remote,write_updated_address_documents_file);
		mac_update_documents_file(pseudo_environment,phone,spray_ip_address,spray_ip_path,fnms.documents.phone.remote,write_updated_phone_documents_file);
		mac_update_documents_file(pseudo_environment,paw,spray_ip_address,spray_ip_path,fnms.documents.paw.remote,write_updated_paw_documents_file);
		mac_update_documents_file(pseudo_environment,property,spray_ip_address,spray_ip_path,fnms.documents.property.remote,write_updated_property_documents_file);
		mac_update_documents_file(pseudo_environment,litigiousdebtor,spray_ip_address,spray_ip_path,fnms.documents.litigiousdebtor.remote,write_updated_litigiousdebtor_documents_file);
		mac_update_documents_file(pseudo_environment,liens,spray_ip_address,spray_ip_path,fnms.documents.liens.remote,write_updated_liens_documents_file);
		mac_update_documents_file(pseudo_environment,criminal,spray_ip_address,spray_ip_path,fnms.documents.criminal.remote,write_updated_criminal_documents_file);
		mac_update_documents_file(pseudo_environment,phonefeedback,spray_ip_address,spray_ip_path,fnms.documents.phonefeedback.remote,write_updated_phonefeedback_documents_file);
		mac_update_documents_file(pseudo_environment,foreclosure,spray_ip_address,spray_ip_path,fnms.documents.foreclosure.remote,write_updated_foreclosure_documents_file);
		mac_update_documents_file(pseudo_environment,workplace,spray_ip_address,spray_ip_path,fnms.documents.workplace.remote,write_updated_workplace_documents_file);
		mac_update_documents_file(pseudo_environment,reverseaddress,spray_ip_address,spray_ip_path,fnms.documents.reverseaddress.remote,write_updated_reverseaddress_documents_file);
		mac_update_documents_file(pseudo_environment,didupdate,spray_ip_address,spray_ip_path,fnms.documents.didupdate.remote,write_updated_didupdate_documents_file);
		mac_update_documents_file(pseudo_environment,bdidupdate,spray_ip_address,spray_ip_path,fnms.documents.bdidupdate.remote,write_updated_bdidupdate_documents_file);
		mac_update_documents_file(pseudo_environment,phoneownership,spray_ip_address,spray_ip_path,fnms.documents.phoneownership.remote,write_updated_phoneownership_documents_file);
		mac_update_documents_file(pseudo_environment,bipbestupdate,spray_ip_address,spray_ip_path,fnms.documents.bipbestupdate.remote,write_updated_bipbestupdate_documents_file);
		mac_update_documents_file(pseudo_environment,sbfe,spray_ip_address,spray_ip_path,fnms.documents.sbfe.remote,write_updated_sbfe_documents_file);
		mac_update_documents_file(pseudo_environment,ucc,spray_ip_address,spray_ip_path,fnms.documents.ucc.remote,write_updated_ucc_documents_file);
		mac_update_documents_file(pseudo_environment,govtdebarred,spray_ip_address,spray_ip_path,fnms.documents.govtdebarred.remote,write_updated_govtdebarred_documents_file);
		mac_update_documents_file(pseudo_environment,inquiry,spray_ip_address,spray_ip_path,fnms.documents.inquiry.remote,write_updated_inquiry_documents_file);
		mac_update_documents_file(pseudo_environment,corp,spray_ip_address,spray_ip_path,fnms.documents.corp.remote,write_updated_corp_documents_file);
		mac_update_documents_file(pseudo_environment,mvr,spray_ip_address,spray_ip_path,fnms.documents.mvr.remote,write_updated_mvr_documents_file);
		mac_update_documents_file(pseudo_environment,aircraft,spray_ip_address,spray_ip_path,fnms.documents.aircraft.remote,write_updated_aircraft_documents_file);
		mac_update_documents_file(pseudo_environment,watercraft,spray_ip_address,spray_ip_path,fnms.documents.watercraft.remote,write_updated_watercraft_documents_file);


      main_files_to_update := PARALLEL( write_updated_portfolio_file,
		                                  write_updated_archive_file,
			                               write_updated_bankruptcy_documents_file,
			                               write_updated_deceased_documents_file,
			                               write_updated_address_documents_file,
			                               write_updated_phone_documents_file,
			                               write_updated_paw_documents_file,
			                               write_updated_property_documents_file,
			                               write_updated_litigiousdebtor_documents_file,
			                               write_updated_liens_documents_file,
			                               write_updated_criminal_documents_file,
			                               write_updated_phonefeedback_documents_file,
			                               write_updated_foreclosure_documents_file,
			                               write_updated_workplace_documents_file,
			                               write_updated_reverseaddress_documents_file,
																		 write_updated_didupdate_documents_file,
																		 write_updated_bdidupdate_documents_file,
																		 write_updated_phoneownership_documents_file,
																		 write_updated_bipbestupdate_documents_file,
																		 write_updated_sbfe_documents_file,
																		 write_updated_ucc_documents_file,
																		 write_updated_govtdebarred_documents_file,
																		 write_updated_inquiry_documents_file,
																		 write_updated_corp_documents_file,
																		 write_updated_mvr_documents_file,
																		 write_updated_aircraft_documents_file,
																		 write_updated_watercraft_documents_file
										         );

		write_updated_files := IF( Inq_Tracking, 
		                           PARALLEL(write_inquiry_tracking_file,
			                                  main_files_to_update
		                                    ),
										   main_files_to_update
									     ); // end if
		
		RETURN SEQUENTIAL( spray_input_files,
		                   write_updated_files
		                 );
	END;

