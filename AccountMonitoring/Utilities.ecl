// A set of utility functions that can be run to effect change within the Account Monitoring system.

IMPORT _control;

export Utilities := MODULE

	// Calculates the number of products available for Monitoring
	EXPORT NUM_ACCT_MON_PRODUCTS := (UNSIGNED)( LOG( AccountMonitoring.types.productMask.allProducts + 1 ) / LOG( 2 ) );
	
	EXPORT fn_update_superfiles(STRING superfile_stem_name, STRING logical_file_name, BOOLEAN delete_subfile, BOOLEAN copy_file_contents) :=
		FUNCTION

			// The following code ensures that the current/father/grandfather files exists by checking for them and 
         // creating an empty file if it doesn't exist.
			sf1 := IF( NOT FileServices.SuperfileExists(superfile_stem_name),
							   FileServices.CreateSuperFile(superfile_stem_name) );	
			sf2 := IF( NOT FileServices.SuperfileExists(superfile_stem_name + '_father'),
							   FileServices.CreateSuperFile(superfile_stem_name + '_father') );	
			sf3 := IF( NOT FileServices.SuperfileExists(superfile_stem_name + '_grandfather'),
							   FileServices.CreateSuperFile(superfile_stem_name + '_grandfather') );	


			// Make sure the files exist, then delete the grandfather subfile, then copy the contents of the father subfile to the grandfather
			// file, delete the father file and copy the contents of the previous run to the father subfile, and finally write the current
			// (logical file name) file (thus keeping the three latest results files)
			update_action := 
				SEQUENTIAL( sf1,
					         sf2,
					         sf3,
					         FileServices.StartSuperFileTransaction(),
					            FileServices.ClearSuperFile(superfile_stem_name + '_grandfather', delete_subfile),
					            FileServices.AddSuperFile(superfile_stem_name   + '_grandfather', superfile_stem_name + '_father',,copy_file_contents),
					            FileServices.ClearSuperFile(superfile_stem_name + '_father'),
					            FileServices.AddSuperFile(superfile_stem_name   + '_father', superfile_stem_name,,copy_file_contents),
					            FileServices.ClearSuperFile(superfile_stem_name),
					            FileServices.AddSuperFile(superfile_stem_name, logical_file_name), 
					         FileServices.FinishSuperFileTransaction()
				          );
			RETURN NOTHOR(update_action);
		END;
		
													 
   EXPORT fn_dedup_portfolio_archive ( DATASET (AccountMonitoring.layouts.portfolio.base) updated_portfolio_archive ) :=
	   FUNCTION
	      updated_portfolio_base := 
		      DEDUP(
			          SORTED( 
				               DISTRIBUTED( updated_portfolio_archive, 
					   	                   HASH32(pid,rid)
						   					  ),
					            pid,rid,-timestamp, LOCAL
				             ),
			          pid,rid,LOCAL
		           )
		      (product_mask > 0);
			
	   RETURN updated_portfolio_base;		
	END;
		
	// Main function used to remove history for a particular pid-rid combination within a particular history file
	SHARED fn_purge_history( AccountMonitoring.i_Monitoring_Product_Config mod_cfg,
	                         STRING time_stamp,
	                         UNSIGNED6 purge_pid,
									 UNSIGNED6 purge_rid
								  ) := 
		FUNCTION
			
			updated_history := mod_cfg.history_file(
				NOT(
					mod_cfg.product_is_in_mask AND
					(purge_pid = 0 OR (purge_pid = pid AND (purge_rid = 0 OR purge_rid = rid)))
				));
	
			superfile_stem_name := mod_cfg.history_file_name;
			logical_file_name   := superfile_stem_name + time_stamp;
			DELETE_SUBFILE      := TRUE;
			COPY_FILE_CONTENTS  := TRUE;

			update_superfiles := SEQUENTIAL( OUTPUT(updated_history,,logical_file_name,COMPRESSED),
							                     fn_update_superfiles(superfile_stem_name, logical_file_name, DELETE_SUBFILE, COPY_FILE_CONTENTS)
							                   );

			RETURN update_superfiles;
	
		END;

	// Purge the history for a single pid-rid combination within a particular pseudo-environment history file
	EXPORT Purge_History( UNSIGNED1 pseudo_environment,
		                   AccountMonitoring.types.productMask product_mask, // Histories for products in the mask will be purged
		                   UNSIGNED6 purge_pid = 0,
		                   UNSIGNED6 purge_rid = 0
	                    ) := 
	FUNCTION
	
		timestamp := thorlib.wuid();
		product_cfg := AccountMonitoring.product_configs( product_mask, pseudo_environment );

			// ***** Bankruptcies *****
		update_history_file_bankruptcy := fn_purge_history( product_cfg.bankruptcy, timestamp, purge_pid, purge_rid );
		
			// ***** Address *****
		update_history_file_address := fn_purge_history( product_cfg.address, timestamp, purge_pid, purge_rid );
		
			// ***** Phones *****
		update_history_file_phone := fn_purge_history( product_cfg.phone, timestamp, purge_pid, purge_rid );

			// ***** People-At-Work *****
		update_history_file_paw := fn_purge_history( product_cfg.paw, timestamp, purge_pid, purge_rid );

			// ***** Property *****
		update_history_file_property := fn_purge_history( product_cfg.property, timestamp, purge_pid, purge_rid );

			// ***** Deceased *****
		update_history_file_deceased := fn_purge_history( product_cfg.deceased, timestamp, purge_pid, purge_rid );

			// ***** Possible Litigious Debtor *****
		update_history_file_litigiousdebtor := fn_purge_history( product_cfg.litigiousdebtor, timestamp, purge_pid, purge_rid );

			// ***** Liens *****
		update_history_file_liens := fn_purge_history( product_cfg.liens, timestamp, purge_pid, purge_rid );

			// ***** Criminal *****
		update_history_file_criminal := fn_purge_history( product_cfg.criminal, timestamp, purge_pid, purge_rid );

			// ***** Phones Feedback *****
		update_history_file_phonefeedback := fn_purge_history( product_cfg.phonefeedback, timestamp, purge_pid, purge_rid );

			// ***** Foreclosure *****
		update_history_file_foreclosure := fn_purge_history( product_cfg.foreclosure, timestamp, purge_pid, purge_rid );

			// ***** Workplace *****
		update_history_file_workplace := fn_purge_history( product_cfg.workplace, timestamp, purge_pid, purge_rid );

			// ***** reverseaddress *****
		update_history_file_reverseaddress := fn_purge_history( product_cfg.reverseaddress, timestamp, purge_pid, purge_rid );
		
			// ***** DIDUpdate *****
		update_history_file_didupdate := fn_purge_history( product_cfg.didupdate, timestamp, purge_pid, purge_rid );

			// ***** BDIDUpdate *****
		update_history_file_bdidupdate := fn_purge_history( product_cfg.bdidupdate, timestamp, purge_pid, purge_rid );
		
			// ***** PhoneOwnership *****
		update_history_file_phoneownership := fn_purge_history( product_cfg.phoneownership, timestamp, purge_pid, purge_rid );

			// ***** BipBest Update *****
		update_history_file_bipbestupdate := fn_purge_history( product_cfg.bipbestupdate, timestamp, purge_pid, purge_rid );

			// ***** SBFE Update *****
		update_history_file_sbfe := fn_purge_history( product_cfg.sbfe, timestamp, purge_pid, purge_rid );

			// ***** UCC Update *****
		update_history_file_ucc := fn_purge_history( product_cfg.ucc, timestamp, purge_pid, purge_rid );

			// ***** Govt Debarred Update *****
		update_history_file_govtdebarred := fn_purge_history( product_cfg.govtdebarred, timestamp, purge_pid, purge_rid );

			// ***** Inquiry Update *****
		update_history_file_inquiry := fn_purge_history( product_cfg.inquiry, timestamp, purge_pid, purge_rid );

			// ***** Corp Update *****
		update_history_file_corp := fn_purge_history( product_cfg.corp, timestamp, purge_pid, purge_rid );

			// ***** MVR Update *****
		update_history_file_mvr := fn_purge_history( product_cfg.mvr, timestamp, purge_pid, purge_rid );

			// ***** Aircraft Update *****
		update_history_file_aircraft := fn_purge_history( product_cfg.aircraft, timestamp, purge_pid, purge_rid );

			// ***** Watercraft Update *****
		update_history_file_watercraft := fn_purge_history( product_cfg.watercraft, timestamp, purge_pid, purge_rid );

  	// ***** PersonHeader Update *****
		update_history_file_personheader := fn_purge_history( product_cfg.personheader, timestamp, purge_pid, purge_rid );


		update_history_files := PARALLEL( IF(product_cfg.bankruptcy.product_is_in_mask,update_history_file_bankruptcy), 
													 IF(product_cfg.address.product_is_in_mask,update_history_file_address),
													 IF(product_cfg.phone.product_is_in_mask,update_history_file_phone),
													 IF(product_cfg.paw.product_is_in_mask,update_history_file_paw),
													 IF(product_cfg.property.product_is_in_mask,update_history_file_property),
													 IF(product_cfg.deceased.product_is_in_mask,update_history_file_deceased),
													 IF(product_cfg.litigiousdebtor.product_is_in_mask,update_history_file_litigiousdebtor),
													 IF(product_cfg.liens.product_is_in_mask,update_history_file_liens),
													 IF(product_cfg.criminal.product_is_in_mask,update_history_file_criminal),
													 IF(product_cfg.phonefeedback.product_is_in_mask,update_history_file_phonefeedback),
													 IF(product_cfg.foreclosure.product_is_in_mask,update_history_file_foreclosure),
													 IF(product_cfg.workplace.product_is_in_mask,update_history_file_workplace),
													 IF(product_cfg.reverseaddress.product_is_in_mask,update_history_file_reverseaddress),
													 IF(product_cfg.didupdate.product_is_in_mask,update_history_file_didupdate),
													 IF(product_cfg.bdidupdate.product_is_in_mask,update_history_file_bdidupdate),
													 IF(product_cfg.phoneownership.product_is_in_mask,update_history_file_phoneownership),
													 IF(product_cfg.bipbestupdate.product_is_in_mask,update_history_file_bipbestupdate),
													 IF(product_cfg.sbfe.product_is_in_mask,update_history_file_sbfe),
													 IF(product_cfg.ucc.product_is_in_mask,update_history_file_ucc),
													 IF(product_cfg.govtdebarred.product_is_in_mask,update_history_file_govtdebarred),
													 IF(product_cfg.inquiry.product_is_in_mask,update_history_file_inquiry),
													 IF(product_cfg.corp.product_is_in_mask,update_history_file_corp),
													 IF(product_cfg.mvr.product_is_in_mask,update_history_file_mvr),
													 IF(product_cfg.aircraft.product_is_in_mask,update_history_file_aircraft),
													 IF(product_cfg.watercraft.product_is_in_mask,update_history_file_watercraft),
													 IF(product_cfg.personheader.product_is_in_mask,update_history_file_personheader)
												  );
		
		RETURN SEQUENTIAL(
			IF(pseudo_environment = AccountMonitoring.constants.pseudo.DEFAULT OR pseudo_environment NOT IN AccountMonitoring.constants.all_pseudo,
				FAIL('Must provide valid pseudo-environment.')),
			IF(product_mask = 0,
				FAIL('Must provide valid product mask.')),
			update_history_files);
		
	END;

	// Main function used to remove history for a multiple pid-rid combinations within a particular history file 
	SHARED fn_purge_history_multi( AccountMonitoring.i_Monitoring_Product_Config mod_cfg,
	                               STRING time_stamp,
	                               SET OF UNSIGNED6 purge_pids,
									       SET OF UNSIGNED6 purge_rids
										  ) := 
		FUNCTION
			
			updated_history := mod_cfg.history_file(
				NOT(
					mod_cfg.product_is_in_mask AND
					(pid IN purge_pids) AND (purge_rids = [0] OR rid IN purge_rids)
				));
	
			superfile_stem_name := mod_cfg.history_file_name;
			logical_file_name   := superfile_stem_name + time_stamp;
			DELETE_SUBFILE      := TRUE;
			COPY_FILE_CONTENTS  := TRUE;

			update_superfiles := SEQUENTIAL( OUTPUT(updated_history,,logical_file_name,COMPRESSED),
							                     fn_update_superfiles(superfile_stem_name, logical_file_name, DELETE_SUBFILE, COPY_FILE_CONTENTS) 
													 );

			RETURN update_superfiles;
	
		END;
		
	// Purges the history for a set of pid-rid combinations within a particular pseudo_environment
	EXPORT Purge_History_Multi( UNSIGNED1 pseudo_environment,
                               AccountMonitoring.types.productMask product_mask, // Histories for products in the mask will be purged
                               SET OF UNSIGNED6 purge_pids = [0],
                               SET OF UNSIGNED6 purge_rids = [0] ) := 
	   FUNCTION
	
		timestamp := thorlib.wuid();
		product_cfg := AccountMonitoring.product_configs( product_mask, pseudo_environment );
		update_history_file_bankruptcy := fn_purge_history_multi( product_cfg.bankruptcy, timestamp, purge_pids, purge_rids );
		update_history_file_address := fn_purge_history_multi( product_cfg.address, timestamp, purge_pids, purge_rids );
		update_history_file_phone := fn_purge_history_multi( product_cfg.phone, timestamp, purge_pids, purge_rids );
		update_history_file_paw := fn_purge_history_multi( product_cfg.paw, timestamp, purge_pids, purge_rids );
		update_history_file_property := fn_purge_history_multi( product_cfg.property, timestamp, purge_pids, purge_rids );
		update_history_file_deceased := fn_purge_history_multi( product_cfg.deceased, timestamp, purge_pids, purge_rids );
		update_history_file_litigiousdebtor := fn_purge_history_multi( product_cfg.litigiousdebtor, timestamp, purge_pids, purge_rids );
		update_history_file_liens := fn_purge_history_multi( product_cfg.liens, timestamp, purge_pids, purge_rids );
		update_history_file_criminal := fn_purge_history_multi( product_cfg.criminal, timestamp, purge_pids, purge_rids );
		update_history_file_phonefeedback := fn_purge_history_multi( product_cfg.phonefeedback, timestamp, purge_pids, purge_rids );
		update_history_file_foreclosure := fn_purge_history_multi( product_cfg.foreclosure, timestamp, purge_pids, purge_rids );
		update_history_file_workplace := fn_purge_history_multi( product_cfg.workplace, timestamp, purge_pids, purge_rids );
		update_history_file_reverseaddress := fn_purge_history_multi( product_cfg.reverseaddress, timestamp, purge_pids, purge_rids );
		update_history_file_didupdate := fn_purge_history_multi( product_cfg.didupdate, timestamp, purge_pids, purge_rids );
		update_history_file_bdidupdate := fn_purge_history_multi( product_cfg.bdidupdate, timestamp, purge_pids, purge_rids );
		update_history_file_phoneownership := fn_purge_history_multi( product_cfg.phoneownership, timestamp, purge_pids, purge_rids );
		update_history_file_bipbestupdate := fn_purge_history_multi( product_cfg.bipbestupdate, timestamp, purge_pids, purge_rids );
		update_history_file_sbfe := fn_purge_history_multi( product_cfg.sbfe, timestamp, purge_pids, purge_rids );
		update_history_file_ucc := fn_purge_history_multi( product_cfg.ucc, timestamp, purge_pids, purge_rids );
		update_history_file_govtdebarred := fn_purge_history_multi( product_cfg.govtdebarred, timestamp, purge_pids, purge_rids );
		update_history_file_inquiry := fn_purge_history_multi( product_cfg.inquiry, timestamp, purge_pids, purge_rids );
		update_history_file_corp := fn_purge_history_multi( product_cfg.corp, timestamp, purge_pids, purge_rids );
		update_history_file_mvr := fn_purge_history_multi( product_cfg.mvr, timestamp, purge_pids, purge_rids );
		update_history_file_aircraft := fn_purge_history_multi( product_cfg.aircraft, timestamp, purge_pids, purge_rids );
		update_history_file_watercraft := fn_purge_history_multi( product_cfg.watercraft, timestamp, purge_pids, purge_rids );
		update_history_file_personheader := fn_purge_history_multi( product_cfg.personheader, timestamp, purge_pids, purge_rids );

		update_history_files := PARALLEL(IF(product_cfg.bankruptcy.product_is_in_mask,update_history_file_bankruptcy), 
													IF(product_cfg.address.product_is_in_mask,update_history_file_address),
													IF(product_cfg.phone.product_is_in_mask,update_history_file_phone),
													IF(product_cfg.paw.product_is_in_mask,update_history_file_paw),
													IF(product_cfg.property.product_is_in_mask,update_history_file_property),
													IF(product_cfg.deceased.product_is_in_mask,update_history_file_deceased),
													IF(product_cfg.litigiousdebtor.product_is_in_mask,update_history_file_litigiousdebtor),
													IF(product_cfg.liens.product_is_in_mask,update_history_file_liens),
													IF(product_cfg.criminal.product_is_in_mask,update_history_file_criminal),
													IF(product_cfg.phonefeedback.product_is_in_mask,update_history_file_phonefeedback),
													IF(product_cfg.foreclosure.product_is_in_mask,update_history_file_foreclosure),
													IF(product_cfg.workplace.product_is_in_mask,update_history_file_workplace),
													IF(product_cfg.reverseaddress.product_is_in_mask,update_history_file_reverseaddress),
													IF(product_cfg.didupdate.product_is_in_mask,update_history_file_didupdate),
													IF(product_cfg.bdidupdate.product_is_in_mask,update_history_file_bdidupdate),
													IF(product_cfg.phoneownership.product_is_in_mask,update_history_file_phoneownership),
													IF(product_cfg.bipbestupdate.product_is_in_mask,update_history_file_bipbestupdate),
													IF(product_cfg.sbfe.product_is_in_mask,update_history_file_sbfe),
													IF(product_cfg.ucc.product_is_in_mask,update_history_file_ucc),
													IF(product_cfg.govtdebarred.product_is_in_mask,update_history_file_govtdebarred),
													IF(product_cfg.inquiry.product_is_in_mask,update_history_file_inquiry),
													IF(product_cfg.corp.product_is_in_mask,update_history_file_corp),
													IF(product_cfg.mvr.product_is_in_mask,update_history_file_mvr),
													IF(product_cfg.aircraft.product_is_in_mask,update_history_file_aircraft),
													IF(product_cfg.watercraft.product_is_in_mask,update_history_file_watercraft));
													IF(product_cfg.personheader.product_is_in_mask,update_history_file_personheader));
		
		RETURN SEQUENTIAL(
			IF(pseudo_environment = AccountMonitoring.constants.pseudo.DEFAULT OR pseudo_environment NOT IN AccountMonitoring.constants.all_pseudo,
				FAIL('Must provide valid pseudo-environment.')),
			IF(product_mask = 0,
				FAIL('Must provide valid product mask.')),
			update_history_files);
		
	END;

	// Purge the portfolio for a particular pseudo-environment
	EXPORT Purge_Portfolio( UNSIGNED1 pseudo_environment,
                           AccountMonitoring.types.productMask product_mask, // Histories for products in the mask will be purged
                           UNSIGNED6 purge_pid = 0,
                           UNSIGNED6 purge_rid = 0 ) := 
	   FUNCTION
	
		   timestamp := thorlib.wuid();
		
		   pm := product_mask;
		
		   starting_portfolio := AccountMonitoring.files(pseudo_environment).portfolio.archive;
		
		   updated_portfolio_archive := 
			   PROJECT( starting_portfolio,
				         TRANSFORM( AccountMonitoring.layouts.portfolio.base,
			                       change_pm         := (purge_pid = 0 or purge_pid = LEFT.pid) AND (purge_rid = 0 OR purge_rid = LEFT.rid);
			                       temp_product_mask := IF(change_pm,(((UNSIGNED)(-1)) ^ pm) & LEFT.product_mask,LEFT.product_mask);
			                       skip_condition    := change_pm AND temp_product_mask = 0;
			                       SELF.product_mask := IF(skip_condition,SKIP,temp_product_mask),
			                       SELF := LEFT
										)
						 );
		
		   updated_portfolio_base      := fn_dedup_portfolio_archive ( updated_portfolio_archive );
			
			superfile_stem_name_archive := AccountMonitoring.filenames(pseudo_environment).portfolio.archive; 
		   superfile_stem_name_base    := AccountMonitoring.filenames(pseudo_environment).portfolio.base; 
		   logical_file_name_archive   := superfile_stem_name_archive + timestamp;
		   logical_file_name_base      := superfile_stem_name_base + timestamp;
		   DELETE_SUBFILE              := TRUE;
		   COPY_FILE_CONTENTS          := TRUE;

		   update_superfiles := 
			   SEQUENTIAL( 
				            // update portfolio archive file
							   OUTPUT(updated_portfolio_archive,,logical_file_name_archive,COMPRESSED),
				            fn_update_superfiles(superfile_stem_name_archive, logical_file_name_archive, DELETE_SUBFILE, COPY_FILE_CONTENTS), 
							   // update portfolio base file
							   OUTPUT(updated_portfolio_base,,logical_file_name_base,COMPRESSED),
				            fn_update_superfiles(superfile_stem_name_base, logical_file_name_base, DELETE_SUBFILE, COPY_FILE_CONTENTS)
						    );

		   RETURN SEQUENTIAL(
			   IF(pseudo_environment = AccountMonitoring.constants.pseudo.DEFAULT OR pseudo_environment NOT IN AccountMonitoring.constants.all_pseudo,
				   FAIL('Must provide valid pseudo-environment.')),
			   IF(product_mask = 0,
				   FAIL('Must provide valid product mask.')),
			   update_superfiles);
		
	   END;

	// Purges multiple portfolios for a particular pseudo-environment
	EXPORT Purge_Portfolio_Multi( UNSIGNED1 pseudo_environment,
		                           AccountMonitoring.types.productMask product_mask, // Histories for products in the mask will be purged
		                           SET OF UNSIGNED6 purge_pids = [0],
		                           SET OF UNSIGNED6 purge_rids = [0]
	                            ) := 
	   FUNCTION
	
		   timestamp          := thorlib.wuid();
			pm                 := product_mask;
		   starting_portfolio := AccountMonitoring.files(pseudo_environment).portfolio.archive;
		
		updated_portfolio_archive := PROJECT( starting_portfolio,
		                                      TRANSFORM( AccountMonitoring.layouts.portfolio.base,
			                                              change_pm         := (LEFT.pid IN purge_pids) AND (purge_rids = [0] OR LEFT.rid IN purge_rids);
			                                              temp_product_mask := IF(change_pm,(((UNSIGNED)(-1)) ^ pm) & LEFT.product_mask,LEFT.product_mask);
			                                              skip_condition    := change_pm AND temp_product_mask = 0;
			                                              SELF.product_mask := IF(skip_condition,SKIP,temp_product_mask),
			                                              SELF              := LEFT
																	  )
													   );
		
		updated_portfolio_base      := fn_dedup_portfolio_archive ( updated_portfolio_archive );
		
		superfile_stem_name_archive := AccountMonitoring.filenames(pseudo_environment).portfolio.archive; 
		superfile_stem_name_base    := AccountMonitoring.filenames(pseudo_environment).portfolio.base; 
		logical_file_name_archive   := superfile_stem_name_archive + timestamp;
		logical_file_name_base      := superfile_stem_name_base + timestamp;
		DELETE_SUBFILE              := TRUE;
		COPY_FILE_CONTENTS          := TRUE;

		update_superfiles := 
		   SEQUENTIAL(
			            // update portfolio archive file
							OUTPUT(updated_portfolio_archive,,logical_file_name_archive,COMPRESSED),
				         fn_update_superfiles(superfile_stem_name_archive, logical_file_name_archive, DELETE_SUBFILE, COPY_FILE_CONTENTS), 
							// update portfolio base file
							OUTPUT(updated_portfolio_base,,logical_file_name_base,COMPRESSED),
				         fn_update_superfiles(superfile_stem_name_base, logical_file_name_base, DELETE_SUBFILE, COPY_FILE_CONTENTS)
						 );

		RETURN SEQUENTIAL(
			IF(pseudo_environment = AccountMonitoring.constants.pseudo.DEFAULT or pseudo_environment not in AccountMonitoring.constants.all_pseudo,
				FAIL('Must provide valid pseudo-environment.')),
			IF(product_mask = 0,
				FAIL('Must provide valid product mask.')),
			update_superfiles);
		
	END;

	// Purge the document for a particular pid within a pseudo-environment
	EXPORT document_purge(UNSIGNED1 pseudo_env = AccountMonitoring.constants.pseudo.DEFAULT, 
	                      DATASET({UNSIGNED6 pid}) purge_pids = DATASET([],{UNSIGNED6 pid}), 
								 STRING timestamp
								) := MODULE

		SHARED mac_build_purge_fn(in_document_type) := MACRO
			
			EXPORT in_document_type() := FUNCTION

					document_file := AccountMonitoring.files(pseudo_env).documents.in_document_type.base;

					temp_join :=
						JOIN(
							document_file, purge_pids,
							LEFT.pid = RIGHT.pid,
							TRANSFORM(LEFT),
							LEFT ONLY,
							MANY LOOKUP
						);
					
					superfile_stem_name := AccountMonitoring.filenames(pseudo_env).documents.in_document_type.base; 
					logical_file_name   := superfile_stem_name + timestamp;
					DELETE_SUBFILE      := TRUE;
					COPY_FILE_CONTENTS  := TRUE;

					update_superfiles := SEQUENTIAL(
									OUTPUT(temp_join,,logical_file_name,COMPRESSED)
								 ,fn_update_superfiles(superfile_stem_name, logical_file_name, DELETE_SUBFILE, COPY_FILE_CONTENTS) 
					);

					RETURN SEQUENTIAL(
						IF(pseudo_env = AccountMonitoring.constants.pseudo.DEFAULT OR pseudo_env NOT IN AccountMonitoring.constants.all_pseudo,
							FAIL('Must provide valid pseudo-environment.')),
						IF( NOT EXISTS(document_file),
							FAIL('Document file not found.')),
						update_superfiles);
					
					// DEBUG:
					// RETURN TABLE(temp_join, {pid, cnt := COUNT(GROUP)}, pid);
					
				END;
				
		ENDMACRO;
		
		mac_build_purge_fn(bankruptcy);
		mac_build_purge_fn(deceased);
		mac_build_purge_fn(address);
		mac_build_purge_fn(phone);
		mac_build_purge_fn(paw);
		mac_build_purge_fn(property);
		mac_build_purge_fn(litigiousdebtor);
		mac_build_purge_fn(liens);
		mac_build_purge_fn(criminal);
		mac_build_purge_fn(phonefeedback);  
		mac_build_purge_fn(foreclosure);
		mac_build_purge_fn(workplace);
		mac_build_purge_fn(reverseaddress);
		mac_build_purge_fn(didupdate);
		mac_build_purge_fn(bdidupdate);
		mac_build_purge_fn(phoneownership);
		mac_build_purge_fn(bipbestupdate);
		mac_build_purge_fn(sbfe);
		mac_build_purge_fn(ucc);
		mac_build_purge_fn(govtdebarred);
		mac_build_purge_fn(inquiry);
		mac_build_purge_fn(corp);
		mac_build_purge_fn(mvr);
		mac_build_purge_fn(aircraft);
		mac_build_purge_fn(watercraft);
		
	END;

	// Purge multiple documents for a a set of pids within a particular pseudo-environment
	EXPORT Purge_Document_Multi(
		 UNSIGNED1 pseudo_env,
		 AccountMonitoring.types.productMask product_mask,
		 SET OF UNSIGNED6 purge_pids = [0]
	) := FUNCTION
		
		timestamp := thorlib.wuid();
		pm := AccountMonitoring.types.productMask;
		ds_purge_pids := DATASET(purge_pids, {UNSIGNED6 pid});

		mac_purge_doc_file(pm_value, doctype, purge_docfile) := 
			MACRO
			purge_docfile := 
				IF( AccountMonitoring.types.testPMBits(pm_value, product_mask),
			      document_purge(pseudo_env, ds_purge_pids, timestamp).doctype());	
			ENDMACRO;
		
		mac_purge_doc_file(pm.bankruptcy     , bankruptcy     , purge_bankruptcy)
		mac_purge_doc_file(pm.deceased       , deceased       , purge_deceased)
		mac_purge_doc_file(pm.address        , address        , purge_address)
		mac_purge_doc_file(pm.phone          , phone          , purge_phone)
		mac_purge_doc_file(pm.paw            , paw            , purge_paw)
		mac_purge_doc_file(pm.property       , property       , purge_property)
		mac_purge_doc_file(pm.litigiousdebtor, litigiousdebtor, purge_litigiousdebtor)
		mac_purge_doc_file(pm.liens          , liens          , purge_liens)
		mac_purge_doc_file(pm.criminal       , criminal       , purge_criminal)
		mac_purge_doc_file(pm.phonefeedback  , phonefeedback  , purge_phonefeedback)
		mac_purge_doc_file(pm.foreclosure    , foreclosure    , purge_foreclosure)
		mac_purge_doc_file(pm.workplace      , workplace      , purge_workplace)
		mac_purge_doc_file(pm.reverseaddress , reverseaddress , purge_reverseaddress)
		mac_purge_doc_file(pm.didupdate 		 , didupdate 			, purge_didupdate)
		mac_purge_doc_file(pm.bdidupdate 		 , bdidupdate 		, purge_bdidupdate)
		mac_purge_doc_file(pm.phoneownership , phoneownership	, purge_phoneownership)
		mac_purge_doc_file(pm.bipbestupdate  , bipbestupdate	, purge_bipbestupdate)
		mac_purge_doc_file(pm.sbfe  				 , sbfe						, purge_sbfe)
		mac_purge_doc_file(pm.ucc  				 	 , ucc						, purge_ucc)
		mac_purge_doc_file(pm.govtdebarred 	 , govtdebarred		, purge_govtdebarred)
		mac_purge_doc_file(pm.inquiry			 	 , inquiry				, purge_inquiry)
		mac_purge_doc_file(pm.corp 				 	 , corp						, purge_corp)
		mac_purge_doc_file(pm.mvr  				 	 , mvr						, purge_mvr)
		mac_purge_doc_file(pm.aircraft  	 	 , aircraft				, purge_aircraft)
		mac_purge_doc_file(pm.watercraft	 	 , watercraft			, purge_watercraft)
		mac_purge_doc_file(pm.personheader	 	 , personheader			, purge_personheader)
							
		RETURN SEQUENTIAL(
			purge_bankruptcy, 
			purge_deceased,
			purge_address,
			purge_phone,
			purge_paw, 
			purge_property,
			purge_litigiousdebtor,
			purge_liens,
			purge_criminal,
			purge_phonefeedback,
			purge_foreclosure,
			purge_workplace,
			purge_reverseaddress,
			purge_didupdate,
			purge_bdidupdate,
			purge_phoneownership,
			purge_bipbestupdate,
			purge_sbfe,
			purge_ucc,
			purge_govtdebarred,
			purge_inquiry,
			purge_corp,
			purge_mvr,
			purge_aircraft,
			purge_watercraft
			purge_personheader
			);
		
	END;

   // Obtains the current portfolio filename and timestamp of the file
	SHARED current_portfolio_version_number(UNSIGNED1 pseudo_environment) := MODULE
		EXPORT STRING   filename  := NOTHOR(FileServices.GetSuperFileSubName(AccountMonitoring.filenames(pseudo_environment).portfolio.base, 1));
		EXPORT STRING   wuid      := filename[ (LENGTH(filename) - 15) .. LENGTH(filename)];
		EXPORT UNSIGNED timestamp := (UNSIGNED)(wuid[ 2..9 ] + wuid[ 11..16 ]);
	END;


	// Replaces the superfile with a newer version of the file.
	SHARED fn_replace_current_superfile(STRING superfile_stem_name, STRING logical_file_name) :=
		FUNCTION
			// Here we're looking to swap out the subfile in the current history superfile with 
			// the just-purged history file.
			update_action := 
				SEQUENTIAL(
					FileServices.StartSuperFileTransaction(),
					FileServices.ClearSuperFile(superfile_stem_name),
					FileServices.AddSuperFile(superfile_stem_name, logical_file_name), 
					FileServices.FinishSuperFileTransaction()
				);
			RETURN NOTHOR(update_action);
		END;
		

	// Filters out pids from the requested history file in a particular pseudo environment
	SHARED fn_purge_straggler_history( AccountMonitoring.i_Monitoring_Product_Config mod_cfg,
	                                   UNSIGNED1 pseudo_environment,
	                                   SET OF UNSIGNED6 purge_pids
												) := 
		FUNCTION
			
			timestamp := thorlib.wuid();

			purged_history := mod_cfg.history_file(
				NOT(
					mod_cfg.product_is_in_mask AND
					pid IN purge_pids AND 
					(UNSIGNED)timestamp < current_portfolio_version_number(pseudo_environment).timestamp
				));
	
			superfile_stem_name   := mod_cfg.history_file_name;
			logical_file_name     := superfile_stem_name + timestamp;

			replace_current_superfile := SEQUENTIAL(
							OUTPUT(purged_history,,logical_file_name,COMPRESSED),
							fn_replace_current_superfile(superfile_stem_name, logical_file_name) );

			RETURN replace_current_superfile;
	
		END;
		
	/*
		Due to timing issues with long running CGMs and the portfolio PURGE and UPDATE process, 
		we have product history for certain PIDs with a timestamp older than the "oldest timestamp" 
		in the current portfolio for that PID. 

		Current portfolio is defined as "current" portfolio logical file:
		thorwatch::base::account_monitoring::prod::portfolio::base

		Strategy: generate a dataset with a single record for each PID. Record structure is PID 
		and oldest_timestamp. Utilize this pid-specific oldest_timestamp to purge ANY product 
		history for that PID with a timestamp older than oldest_timestamp.

		Example: The oldest timestamp of ANY record in PID 123 is timestamp 20110407120000 
		(12:00:00 on 04/07/2011). This value corresponds to the oldest any record was added to 
		the THOR portfolio for this PID. 

		This is our "oldest_timestamp" for PID 123. We will use this value to purge all product 
		history (history::bankruptcy, history::deceased, etc...) for PID 123 that occurred BEFORE 
		this min_timestamp. 
	*/
	EXPORT Purge_Straggler_History_Multi(
		 UNSIGNED1 pseudo_environment,
		 AccountMonitoring.types.productMask product_mask = AccountMonitoring.types.productMask.allProducts, // Histories for products in the mask will be purged
		 SET OF UNSIGNED6 purge_pids = [0]
	) := FUNCTION
	
		product_cfg := AccountMonitoring.product_configs( product_mask, pseudo_environment );
		
		update_history_file_bankruptcy      := fn_purge_straggler_history( product_cfg.bankruptcy     , pseudo_environment, purge_pids );
		update_history_file_address         := fn_purge_straggler_history( product_cfg.address        , pseudo_environment, purge_pids );
		update_history_file_phone           := fn_purge_straggler_history( product_cfg.phone          , pseudo_environment, purge_pids );
		update_history_file_paw             := fn_purge_straggler_history( product_cfg.paw            , pseudo_environment, purge_pids );
		update_history_file_property        := fn_purge_straggler_history( product_cfg.property       , pseudo_environment, purge_pids );
		update_history_file_deceased        := fn_purge_straggler_history( product_cfg.deceased       , pseudo_environment, purge_pids );
		update_history_file_litigiousdebtor := fn_purge_straggler_history( product_cfg.litigiousdebtor, pseudo_environment, purge_pids );
		update_history_file_liens           := fn_purge_straggler_history( product_cfg.liens          , pseudo_environment, purge_pids );
		update_history_file_criminal        := fn_purge_straggler_history( product_cfg.criminal       , pseudo_environment, purge_pids );
		update_history_file_phonefeedback   := fn_purge_straggler_history( product_cfg.phonefeedback  , pseudo_environment, purge_pids );
		update_history_file_foreclosure     := fn_purge_straggler_history( product_cfg.foreclosure    , pseudo_environment, purge_pids );
		update_history_file_workplace       := fn_purge_straggler_history( product_cfg.workplace      , pseudo_environment, purge_pids );
		update_history_file_reverseaddress  := fn_purge_straggler_history( product_cfg.reverseaddress , pseudo_environment, purge_pids );
		update_history_file_didupdate			  := fn_purge_straggler_history( product_cfg.didupdate 			, pseudo_environment, purge_pids );
		update_history_file_bdidupdate		  := fn_purge_straggler_history( product_cfg.bdidupdate 		, pseudo_environment, purge_pids );
		update_history_file_phoneownership  := fn_purge_straggler_history( product_cfg.phoneownership	, pseudo_environment, purge_pids );
		update_history_file_bipbestupdate  	:= fn_purge_straggler_history( product_cfg.bipbestupdate	, pseudo_environment, purge_pids );
		update_history_file_sbfe  					:= fn_purge_straggler_history( product_cfg.sbfe						, pseudo_environment, purge_pids );
		update_history_file_ucc  						:= fn_purge_straggler_history( product_cfg.ucc						, pseudo_environment, purge_pids );
		update_history_file_govtdebarred		:= fn_purge_straggler_history( product_cfg.govtdebarred		, pseudo_environment, purge_pids );
		update_history_file_inquiry					:= fn_purge_straggler_history( product_cfg.inquiry				, pseudo_environment, purge_pids );
		update_history_file_corp 						:= fn_purge_straggler_history( product_cfg.corp						, pseudo_environment, purge_pids );
		update_history_file_mvr  						:= fn_purge_straggler_history( product_cfg.mvr						, pseudo_environment, purge_pids );
		update_history_file_aircraft				:= fn_purge_straggler_history( product_cfg.aircraft				, pseudo_environment, purge_pids );
		update_history_file_watercraft			:= fn_purge_straggler_history( product_cfg.watercraft			, pseudo_environment, purge_pids );
		update_history_file_personheader			:= fn_purge_straggler_history( product_cfg.personheader			, pseudo_environment, purge_pids );

		update_history_files := PARALLEL(IF(product_cfg.bankruptcy.product_is_in_mask     ,update_history_file_bankruptcy), 
													IF(product_cfg.address.product_is_in_mask        ,update_history_file_address),
													IF(product_cfg.phone.product_is_in_mask          ,update_history_file_phone),
													IF(product_cfg.paw.product_is_in_mask            ,update_history_file_paw),
													IF(product_cfg.property.product_is_in_mask       ,update_history_file_property),
													IF(product_cfg.deceased.product_is_in_mask       ,update_history_file_deceased),
													IF(product_cfg.litigiousdebtor.product_is_in_mask,update_history_file_litigiousdebtor),
													IF(product_cfg.liens.product_is_in_mask          ,update_history_file_liens),
													IF(product_cfg.criminal.product_is_in_mask       ,update_history_file_criminal),
													IF(product_cfg.phonefeedback.product_is_in_mask  ,update_history_file_phonefeedback),
													IF(product_cfg.foreclosure.product_is_in_mask    ,update_history_file_foreclosure),
													IF(product_cfg.workplace.product_is_in_mask      ,update_history_file_workplace),
													IF(product_cfg.reverseaddress.product_is_in_mask ,update_history_file_reverseaddress),
													IF(product_cfg.didupdate.product_is_in_mask 		 ,update_history_file_didupdate),
													IF(product_cfg.bdidupdate.product_is_in_mask 		 ,update_history_file_bdidupdate),
													IF(product_cfg.phoneownership.product_is_in_mask ,update_history_file_phoneownership),
													IF(product_cfg.bipbestupdate.product_is_in_mask  ,update_history_file_bipbestupdate),
													IF(product_cfg.sbfe.product_is_in_mask  				 ,update_history_file_sbfe),
													IF(product_cfg.ucc.product_is_in_mask  				 	 ,update_history_file_ucc),
													IF(product_cfg.govtdebarred.product_is_in_mask   ,update_history_file_govtdebarred),
													IF(product_cfg.inquiry.product_is_in_mask  		 	 ,update_history_file_inquiry),
													IF(product_cfg.corp.product_is_in_mask  			 	 ,update_history_file_corp),
													IF(product_cfg.mvr.product_is_in_mask  				 	 ,update_history_file_mvr),
													IF(product_cfg.aircraft.product_is_in_mask  	 	 ,update_history_file_aircraft),
													IF(product_cfg.watercraft.product_is_in_mask  	 ,update_history_file_watercraft));
													IF(product_cfg.personheader.product_is_in_mask  	 ,update_history_file_personheader));
		
		RETURN SEQUENTIAL(
			IF(pseudo_environment = AccountMonitoring.constants.pseudo.DEFAULT OR pseudo_environment NOT IN AccountMonitoring.constants.all_pseudo,
				FAIL('Must provide valid pseudo-environment.')),
			IF(product_mask = 0,
				FAIL('Must provide valid product mask.')),
			update_history_files);
		
	END;
	
	// We can roll back and replace the current file with the 'father' version and the father
	// version with the 'grandfather' version -- deleting the grandfather version and leaving us with only
	// two back up versions.
	SHARED fn_rollback_history( AccountMonitoring.i_Monitoring_Product_Config mod_cfg ) := 
		FUNCTION
			
			superfile_stem_name := mod_cfg.history_file_name;
			DELETE_SUBFILE      := TRUE;
			COPY_FILE_CONTENTS  := TRUE;

			update_superfiles := SEQUENTIAL(
							FileServices.StartSuperFileTransaction(),
								FileServices.ClearSuperFile(superfile_stem_name, DELETE_SUBFILE),
								FileServices.AddSuperFile(superfile_stem_name, superfile_stem_name + '_father',,COPY_FILE_CONTENTS),
								FileServices.ClearSuperFile(superfile_stem_name + '_father'),
								FileServices.AddSuperFile(superfile_stem_name   + '_father', superfile_stem_name + '_grandfather',,COPY_FILE_CONTENTS),
								FileServices.ClearSuperFile(superfile_stem_name + '_grandfather'),
							FileServices.FinishSuperFileTransaction() );

			RETURN NOTHOR(update_superfiles);
	
		END;
		
	// Roll back the history for a particular pseudo-environment to the previous version for particular products
	// Histories for products in the mask will be rolled back
	EXPORT Rollback_History( UNSIGNED1 pseudo_environment,
                            AccountMonitoring.types.productMask product_mask ) := 
	   FUNCTION

		   product_cfg := AccountMonitoring.product_configs( product_mask, pseudo_environment );

		   	// ***** Bankruptcies *****
		   update_history_file_bankruptcy := fn_rollback_history( product_cfg.bankruptcy );
		
		   	// ***** Address *****
		   update_history_file_address := fn_rollback_history( product_cfg.address );
		
		   	// ***** Phones *****
		   update_history_file_phone := fn_rollback_history( product_cfg.phone );

		   	// ***** People-At-Work *****
		   update_history_file_paw := fn_rollback_history( product_cfg.paw );

		   	// ***** Property *****
		   update_history_file_property := fn_rollback_history( product_cfg.property );

		   	// ***** Deceased *****
		   update_history_file_deceased := fn_rollback_history( product_cfg.deceased );
		
		   	// ***** Possible Litigous Debtor *****
		   update_history_file_litigiousdebtor := fn_rollback_history( product_cfg.litigiousdebtor );

		   	// ***** Liens *****
		   update_history_file_liens := fn_rollback_history( product_cfg.liens );

		   	// ***** Criminal *****
		   update_history_file_criminal := fn_rollback_history( product_cfg.criminal );

		   	// ***** Phones Feedback *****
		   update_history_file_phonefeedback := fn_rollback_history( product_cfg.phonefeedback );

		   	// ***** Foreclosure *****
		   update_history_file_foreclosure := fn_rollback_history( product_cfg.foreclosure );

		   	// ***** Workplace *****
		   update_history_file_workplace := fn_rollback_history( product_cfg.workplace );

		   	// ***** reverseaddress *****
		   update_history_file_reverseaddress := fn_rollback_history( product_cfg.reverseaddress );
			 
 		   	// ***** DIDUpdate *****
		   update_history_file_didupdate := fn_rollback_history( product_cfg.didupdate );

 		   	// ***** BDIDUpdate *****
		   update_history_file_bdidupdate := fn_rollback_history( product_cfg.bdidupdate );
			 
 		   	// ***** PhoneOwnership *****
		   update_history_file_phoneownership := fn_rollback_history( product_cfg.phoneownership );

			 	// ***** BipBest Update *****
		   update_history_file_bipbestupdate := fn_rollback_history( product_cfg.bipbestupdate );
			 
			  // *****  SBFE *****
		   update_history_file_sbfe := fn_rollback_history( product_cfg.sbfe );
			 
			  // *****  UCC *****
		   update_history_file_ucc := fn_rollback_history( product_cfg.ucc );

			  // *****  Govt Debarred *****
		   update_history_file_govtdebarred := fn_rollback_history( product_cfg.govtdebarred );
	
			  // *****  Inquiry *****
		   update_history_file_inquiry := fn_rollback_history( product_cfg.inquiry );
	
			  // *****  Corp *****
		   update_history_file_corp := fn_rollback_history( product_cfg.corp );
	
			  // *****  MVR *****
		   update_history_file_mvr := fn_rollback_history( product_cfg.mvr );
	
			  // *****  Aircraft *****
		   update_history_file_aircraft := fn_rollback_history( product_cfg.aircraft );
	
			  // *****  Watercraft *****
		   update_history_file_watercraft := fn_rollback_history( product_cfg.watercraft );
	
	  // *****  PersonHeader *****
		   update_history_file_personheader := fn_rollback_history( product_cfg.personheader );
       
		   update_history_files := PARALLEL( IF(product_cfg.bankruptcy.product_is_in_mask,update_history_file_bankruptcy), 
													    IF(product_cfg.address.product_is_in_mask,update_history_file_address),
													    IF(product_cfg.phone.product_is_in_mask,update_history_file_phone),
													    IF(product_cfg.paw.product_is_in_mask,update_history_file_paw),
													    IF(product_cfg.property.product_is_in_mask,update_history_file_property),
													    IF(product_cfg.deceased.product_is_in_mask,update_history_file_deceased),
													    IF(product_cfg.litigiousdebtor.product_is_in_mask,update_history_file_litigiousdebtor),
													    IF(product_cfg.liens.product_is_in_mask,update_history_file_liens),
													    IF(product_cfg.criminal.product_is_in_mask,update_history_file_criminal),
													    IF(product_cfg.phonefeedback.product_is_in_mask,update_history_file_phonefeedback),
													    IF(product_cfg.foreclosure.product_is_in_mask,update_history_file_foreclosure),
													    IF(product_cfg.workplace.product_is_in_mask,update_history_file_workplace),
													    IF(product_cfg.reverseaddress.product_is_in_mask,update_history_file_reverseaddress),
															IF(product_cfg.didupdate.product_is_in_mask,update_history_file_didupdate),
															IF(product_cfg.bdidupdate.product_is_in_mask,update_history_file_bdidupdate),
															IF(product_cfg.phoneownership.product_is_in_mask,update_history_file_phoneownership),
															IF(product_cfg.bipbestupdate.product_is_in_mask,update_history_file_bipbestupdate),
															IF(product_cfg.sbfe.product_is_in_mask,update_history_file_sbfe),
															IF(product_cfg.ucc.product_is_in_mask,update_history_file_ucc),
															IF(product_cfg.govtdebarred.product_is_in_mask,update_history_file_govtdebarred),
															IF(product_cfg.inquiry.product_is_in_mask,update_history_file_inquiry),
															IF(product_cfg.corp.product_is_in_mask,update_history_file_corp),
															IF(product_cfg.mvr.product_is_in_mask,update_history_file_mvr),
															IF(product_cfg.aircraft.product_is_in_mask,update_history_file_aircraft),
															IF(product_cfg.watercraft.product_is_in_mask,update_history_file_watercraft)
															IF(product_cfg.personheader.product_is_in_mask,update_history_file_personheader)
													  );
		
		   RETURN SEQUENTIAL(
			   IF(pseudo_environment = AccountMonitoring.constants.pseudo.DEFAULT OR pseudo_environment NOT IN AccountMonitoring.constants.all_pseudo,
			   	FAIL('Must provide valid pseudo-environment.')),
			   IF(product_mask = 0,
			   	FAIL('Must provide valid product mask.')),
			   update_history_files);
		
	   END;

	// Roll back the portfolio for a particular pseudo-environment to the previous version
	EXPORT Rollback_Portfolio(
		 UNSIGNED1 pseudo_environment
	) := FUNCTION
	
		superfile_stem_name := AccountMonitoring.filenames(pseudo_environment).portfolio.base;
		DELETE_SUBFILE      := TRUE;
		COPY_FILE_CONTENTS  := TRUE;

		update_superfiles := SEQUENTIAL(
						FileServices.StartSuperFileTransaction(),
							FileServices.ClearSuperFile(superfile_stem_name, DELETE_SUBFILE),
							FileServices.AddSuperFile(superfile_stem_name, superfile_stem_name + '_father',,COPY_FILE_CONTENTS), 
							FileServices.ClearSuperFile(superfile_stem_name + '_father'),
							FileServices.AddSuperFile(superfile_stem_name   + '_father', superfile_stem_name + '_grandfather',,COPY_FILE_CONTENTS),
							FileServices.ClearSuperFile(superfile_stem_name + '_grandfather'),
						FileServices.FinishSuperFileTransaction() );

		RETURN SEQUENTIAL(
			IF(pseudo_environment = AccountMonitoring.constants.pseudo.DEFAULT OR pseudo_environment NOT IN AccountMonitoring.constants.all_pseudo,
				FAIL('Must provide valid pseudo-environment.')),
			NOTHOR(update_superfiles));
		
	END;

	// Copies the passed in logical file to the passed in destination location & file name
	EXPORT Copy_From_WatchThor(STRING sourceLogicalName = '', STRING destLogicalFileName = '') := // to DataLand
		FUNCTION
			// sourceLogicalName: e.g. '~thorwatch::base::account_monitoring::cert::portfolio::basew20100823-094208'
			// destLogicalFileName: e.g. '~thor_data400::base::account_monitoring::dev::portfolio::base'
			
			timestamp := thorlib.wuid();
			
			destinationGroup       := 'thor400_88_dev';
			destinationLogicalName := TRIM(destLogicalFileName) + timestamp;
			scrDali                := _control.IPAddress.prod_watch_dali;
			maxConnections         := 400;
			do_allowoverwrite      := TRUE;
			do_replicate           := TRUE;
			not_asSuperfile        := FALSE;

			fs_copy := 
				FileServices.Copy(sourceLogicalName,
				                  destinationGroup,
				                  destinationLogicalname,
				                  scrDali,
				                   ,
				                   ,
				                  maxConnections,
				                  do_allowoverwrite,
				                  do_replicate,
				                  not_asSuperfile
				                 );
			RETURN NOTHOR(fs_copy);
		END;
	
	// Gets the file size of the logical file passed in
	EXPORT Get_FileSize(STRING logical_file_name) :=
		FUNCTION
			file_list_name := logical_file_name[2..LENGTH(logical_file_name)]; // Remove prepended '~'
			file_list      := FileServices.LogicalFileList(file_list_name);
			sizeOf_file    := file_list[1].size;
			
			RETURN NOTHOR(sizeOf_file);
		END;

	// Gets the row/record count of the logical file passed in
	EXPORT Get_FileRowCount(STRING logical_file_name) :=
		FUNCTION
			file_list_name  := logical_file_name[2..LENGTH(logical_file_name)]; // Remove prepended '~'
			file_list       := FileServices.LogicalFileList(file_list_name);
			rowcountOf_file := file_list[1].rowcount;
			
			RETURN NOTHOR(rowcountOf_file);
		END;

   // Preparation for new portfolio archive superfile.  Prior to the change all records were
	// kept in one master Portfolio Archive superfile. We are creating a new "Portfolio Archive" superfile 
	// that will be equivalent to this master Portfolio superfile.  The portfolio file will from this point on 
	// be strictly the de-duped the records with a product mask > 0 (only currently run/monitored records).

   // The following function handles moving the original portfolio dataset to the new Portfolio Archive 
   // file so that once the new Portfolio Update process begins we won't loose any history; and creates
	// the new deduped records with a product mask >0; attaching that new file to the Portfolio Base superfile.
	
	// Per Franz, this function will not copy the Portfolio::Base father and grandfather files because 
	// they are so large
			
	// The function returns, strictly speaking, no datatype but rather multiple Actions.
	EXPORT Prepare_Files_For_Archive_Portfolio (UNSIGNED1 pseudo_environment) :=
	   FUNCTION
			
         COPY_FILE_CONTENTS := TRUE;
			DELETE_SUBFILE     := FALSE;  // not deleting the portfolio base file subfile (just in case)
	      TIME_STAMP         := thorlib.wuid();

			// The following code ensures that the current/father/grandfather Archive files exist by checking for them and 
         // creating an empty file if they doesn't exist.
			sf1 := IF( NOT FileServices.SuperfileExists(AccountMonitoring.filenames(pseudo_environment).portfolio.archive),
							   FileServices.CreateSuperFile(AccountMonitoring.filenames(pseudo_environment).portfolio.archive) );	
			sf2 := IF( NOT FileServices.SuperfileExists(AccountMonitoring.filenames(pseudo_environment).portfolio.archive + '_father'),
							   FileServices.CreateSuperFile(AccountMonitoring.filenames(pseudo_environment).portfolio.archive + '_father') );	
			sf3 := IF( NOT FileServices.SuperfileExists(AccountMonitoring.filenames(pseudo_environment).portfolio.archive + '_grandfather'),
							   FileServices.CreateSuperFile(AccountMonitoring.filenames(pseudo_environment).portfolio.archive + '_grandfather') );	
		   
			current_portfolio_dist   := DISTRIBUTE(AccountMonitoring.files(pseudo_environment).portfolio.base,HASH32(pid,rid));
		   current_portfolio_sorted := SORT(current_portfolio_dist,pid,rid,-timestamp,LOCAL);

			// Dedup the existing Portfolio base file and filter product_mask >0 to save the new portfolio with 
			// ONLY currently run records
			portfolio_current_records_only := 
			DEDUP(
				SORTED( 
					DISTRIBUTED( current_portfolio_sorted, 
						          HASH32(pid,rid)),
					pid,rid,-timestamp, LOCAL
				),
			   pid,rid,LOCAL
		   )( product_mask > 0 );
			
			// Create New Portfolio Logical File Name
			superfile_Portfolio_stem_name   := AccountMonitoring.filenames( pseudo_environment ).portfolio.base;
	      new_portfolio_logical_file_name := superfile_Portfolio_stem_name + TIME_STAMP;

			// Write the new "deduped portfolio file with all product_masks > 0" 
			// this file will be the new Portfolio file and attached to the Portfolio base superfile 
			output_NewPortfolioFile       := OUTPUT( portfolio_current_records_only,,new_portfolio_logical_file_name,COMPRESSED );

			// Clear/detach the Portfolio Base logical from from the Superfile so that the new deduped Portfolio base file can 
			// be attached to the Portfolio Base superfile (preserving the subfile)
			ClearPortfolioBaseSuperfile   := FileServices.ClearSuperFile(AccountMonitoring.filenames(pseudo_environment).portfolio.base, DELETE_SUBFILE);
         
			// Add/attach the deduped and filtered file to the Portfolio Superfile
			update_PortfolioBasesuperfile := FileServices.AddSuperFile( superfile_Portfolio_stem_name, new_portfolio_logical_file_name );

			// Get the Portfolio Base - Logical File name and convert the name by replacing the word "base" with 
			// "archive" so that the new Archive logical file name with be consistent with the Archive file structure 
			// for the first two updates.
			STRING portfolio_logical_filename := FileServices.GetSuperFileSubName(AccountMonitoring.filenames(pseudo_environment).portfolio.base, 1);
			PortfolioBase_logicalFileName     := '~' + portfolio_logical_filename;
         Archive_logicalFileName           := StringLib.StringFindReplace(Portfoliobase_logicalFileName, 'basew', 'archivew');

         // Copy the Portfolio Base logical file to the Archive file structure (replacing "base" with "archive" in the filename
			CopyBaseFileToArchive         := FileServices.Copy(PortfolioBase_logicalFileName, thorlib.cluster(), Archive_logicalFileName,,,,,TRUE, TRUE, FALSE, TRUE);

 			AddArchiveSuperFile           := FileServices.AddSuperFile( AccountMonitoring.filenames(pseudo_environment).portfolio.archive, 
			                                                            Archive_logicalFileName);

			PrepareForNewPortfolioProcessing := SEQUENTIAL(
																						NOTHOR(SEQUENTIAL(sf1,
																											 sf2,
																											 sf3,
																											 FileServices.StartSuperFileTransaction(),
																											 CopyBaseFileToArchive)),
																						output_NewPortfolioFile,
																						NOTHOR(SEQUENTIAL(ClearPortfolioBaseSuperfile,
																											 update_PortfolioBasesuperfile,  
																											 AddArchiveSuperFile,
																											 FileServices.FinishSuperFileTransaction())));
		
	      RETURN IF( NOTHOR(NOT FileServices.SuperfileExists(AccountMonitoring.filenames(pseudo_environment).portfolio.archive)),
			            PrepareForNewPortfolioProcessing, 
							IF( NOTHOR(FileServices.GetSuperFileSubCount( AccountMonitoring.filenames(pseudo_environment).portfolio.archive) < 1),
							    PrepareForNewPortfolioProcessing,
								 FAIL('There already is an Archive Super file with a sub-file')
							  )
						  );
			END;											 
	
END;
