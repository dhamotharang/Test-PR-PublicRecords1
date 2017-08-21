/* For notes, see the _Documentation_forAccountMonitoring attribute. */

IMPORT AccountMonitoring;

EXPORT Run( AccountMonitoring.types.productMask product_mask = AccountMonitoring.types.productMask.allProducts, 
						STRING           despray_ip_address = '',  // the IP address of the server receiving the completed file
						STRING           despray_path = '',        // the /path including filename of the destination file
						UNSIGNED1        pseudo_environment = AccountMonitoring.constants.pseudo.DEFAULT,
						BOOLEAN          use_daily_file = FALSE,
						SET OF UNSIGNED6 run_pids = []
          ) :=	    
	FUNCTION
		
		// Get the already sorted and distributed main portfolio records and assign them to pf_AllRecords
		// *** TODO *** Since we're saving the portfolio "already deduped", we don't need the -timestamp for: SORTED (because there is only one record for each pid/rid)
		pf_AllRecords := SORTED( 
				              DISTRIBUTED(AccountMonitoring.files(pseudo_environment).portfolio.base, 
					                       HASH32(pid,rid)),
						        pid,rid,-timestamp, LOCAL
				           );

      // Added a filter to allow for a run of only certain PIDs  Bug: 74736
		pf := IF( run_pids != [],
		          pf_AllRecords( pid IN run_pids ),
					 pf_AllRecords
				  ) : INDEPENDENT;

		// get runtime time stamp
		timestamp := thorlib.wuid();
		
		// i_Job_Config Interface contains only the monitor_daily_file with a default value of False
		// job_config sets the i_Job_Config file to the passed in value for monitor_daily_file
		job_config := MODULE( AccountMonitoring.i_Job_Config )
			EXPORT monitor_daily_file := use_daily_file;
		END;
		
		// 1. Perform account monitoring.
		product_config := AccountMonitoring.product_configs( product_mask, pseudo_environment, pf, job_config );
		
			// ***** Bankruptcies *****
		candidates_bankruptcy          := AccountMonitoring.fn_monitor_for_candidates( product_config.bankruptcy, timestamp ) : INDEPENDENT;
		update_history_file_bankruptcy := AccountMonitoring.fn_update_history_file( candidates_bankruptcy, product_config.bankruptcy, timestamp );
		
			// ***** Address *****
		candidates_address          := AccountMonitoring.fn_monitor_for_candidates( product_config.address, timestamp ) : INDEPENDENT;
		update_history_file_address := AccountMonitoring.fn_update_history_file( candidates_address, product_config.address, timestamp );
		
			// ***** Phones *****
		candidates_phone          := AccountMonitoring.fn_monitor_for_candidates( product_config.phone, timestamp ) : INDEPENDENT;
		update_history_file_phone := AccountMonitoring.fn_update_history_file( candidates_phone, product_config.phone, timestamp );

			// ***** People-At-Work *****
		candidates_paw          := AccountMonitoring.fn_monitor_for_candidates( product_config.paw, timestamp ) : INDEPENDENT;
		update_history_file_paw := AccountMonitoring.fn_update_history_file( candidates_paw, product_config.paw, timestamp );

			// ***** Property *****
		candidates_property          := AccountMonitoring.fn_monitor_for_candidates( product_config.property, timestamp ) : INDEPENDENT;
		update_history_file_property := AccountMonitoring.fn_update_history_file( candidates_property, product_config.property, timestamp );

			// ***** Deceased *****
		candidates_deceased          := AccountMonitoring.fn_monitor_for_candidates( product_config.deceased, timestamp ) : INDEPENDENT;
		update_history_file_deceased := AccountMonitoring.fn_update_history_file( candidates_deceased, product_config.deceased, timestamp );

			// ***** Possible Litigious Debtor *****
		candidates_litigiousdebtor          := AccountMonitoring.fn_monitor_for_candidates( product_config.litigiousdebtor, timestamp ) : INDEPENDENT;
		update_history_file_litigiousdebtor := AccountMonitoring.fn_update_history_file( candidates_litigiousdebtor, product_config.litigiousdebtor, timestamp );

			// ***** Judgments and Liens *****
		candidates_liens          := AccountMonitoring.fn_monitor_for_candidates( product_config.liens, timestamp ) : INDEPENDENT;
		update_history_file_liens := AccountMonitoring.fn_update_history_file( candidates_liens, product_config.liens, timestamp );

			// ***** Criminal *****
		candidates_criminal          := AccountMonitoring.fn_monitor_for_candidates( product_config.criminal, timestamp ) : INDEPENDENT;
		update_history_file_criminal := AccountMonitoring.fn_update_history_file( candidates_criminal, product_config.criminal, timestamp );

			// ***** Phones Feedback *****
		candidates_phonefeedback          := AccountMonitoring.fn_monitor_for_candidates( product_config.phonefeedback, timestamp ) : INDEPENDENT;
		update_history_file_phonefeedback := AccountMonitoring.fn_update_history_file( candidates_phonefeedback, product_config.phonefeedback, timestamp );

			// ***** Foreclosure *****
		candidates_foreclosure          := AccountMonitoring.fn_monitor_for_candidates( product_config.foreclosure, timestamp ) : INDEPENDENT;
		update_history_file_foreclosure := AccountMonitoring.fn_update_history_file( candidates_foreclosure, product_config.foreclosure, timestamp );

			// ***** Workplace *****
		candidates_workplace          := AccountMonitoring.fn_monitor_for_candidates( product_config.workplace, timestamp ) : INDEPENDENT;
		update_history_file_workplace := AccountMonitoring.fn_update_history_file( candidates_workplace, product_config.workplace, timestamp );

			// ***** Reverse Address *****
		candidates_reverseaddress          := AccountMonitoring.fn_monitor_for_candidates( product_config.reverseaddress, timestamp ) : INDEPENDENT;
		update_history_file_reverseaddress := AccountMonitoring.fn_update_history_file( candidates_reverseaddress, product_config.reverseaddress, timestamp );

			// ***** DIDUpdate *****
		candidates_didupdate          := AccountMonitoring.fn_monitor_for_candidates( product_config.didupdate, timestamp ) : INDEPENDENT;
		update_history_file_didupdate := AccountMonitoring.fn_update_history_file( candidates_didupdate, product_config.didupdate, timestamp );

			// ***** BDIDUpdate *****
		candidates_bdidupdate          := AccountMonitoring.fn_monitor_for_candidates( product_config.bdidupdate, timestamp ) : INDEPENDENT;
		update_history_file_bdidupdate := AccountMonitoring.fn_update_history_file( candidates_bdidupdate, product_config.bdidupdate, timestamp );
		
			// ***** BIPBestUpdate *****
		candidates_bipbestupdate          := AccountMonitoring.fn_monitor_for_candidates( product_config.bipbestupdate, timestamp ) : INDEPENDENT;
		update_history_file_bipbestupdate := AccountMonitoring.fn_update_history_file( candidates_bipbestupdate, product_config.bipbestupdate, timestamp );

			// ***** PhoneOwnership *****
		candidates_phoneownership      			:= AccountMonitoring.fn_monitor_for_candidates( product_config.phoneownership, timestamp ) : INDEPENDENT;
		update_history_file_phoneownership	:= AccountMonitoring.fn_update_history_file( candidates_phoneownership, product_config.phoneownership, timestamp );

			// ***** SBFE *****
		candidates_sbfe      			:= AccountMonitoring.fn_monitor_for_candidates( product_config.sbfe, timestamp ) : INDEPENDENT;
		update_history_file_sbfe	:= AccountMonitoring.fn_update_history_file( candidates_sbfe, product_config.sbfe, timestamp );

			// ***** UCC *****
		candidates_ucc      			:= AccountMonitoring.fn_monitor_for_candidates( product_config.ucc, timestamp ) : INDEPENDENT;
		update_history_file_ucc		:= AccountMonitoring.fn_update_history_file( candidates_ucc, product_config.ucc, timestamp );

			// ***** Govt Debarred *****
		candidates_govtdebarred							:= AccountMonitoring.fn_monitor_for_candidates( product_config.govtdebarred, timestamp ) : INDEPENDENT;
		update_history_file_govtdebarred		:= AccountMonitoring.fn_update_history_file( candidates_govtdebarred, product_config.govtdebarred, timestamp );

			// ***** Inquiry *****
		candidates_inquiry    				:= AccountMonitoring.fn_monitor_for_candidates( product_config.inquiry, timestamp ) : INDEPENDENT;
		update_history_file_inquiry		:= AccountMonitoring.fn_update_history_file( candidates_inquiry, product_config.inquiry, timestamp );

			// ***** Corp *****
		candidates_corp      			:= AccountMonitoring.fn_monitor_for_candidates( product_config.corp, timestamp ) : INDEPENDENT;
		update_history_file_corp	:= AccountMonitoring.fn_update_history_file( candidates_corp, product_config.corp, timestamp );

			// ***** MVR *****
		candidates_mvr      			:= AccountMonitoring.fn_monitor_for_candidates( product_config.mvr, timestamp ) : INDEPENDENT;
		update_history_file_mvr		:= AccountMonitoring.fn_update_history_file( candidates_mvr, product_config.mvr, timestamp );

			// ***** Aircraft *****
		candidates_aircraft      			:= AccountMonitoring.fn_monitor_for_candidates( product_config.aircraft, timestamp ) : INDEPENDENT;
		update_history_file_aircraft	:= AccountMonitoring.fn_update_history_file( candidates_aircraft, product_config.aircraft, timestamp );

			// ***** Watercraft *****
		candidates_watercraft      			:= AccountMonitoring.fn_monitor_for_candidates( product_config.watercraft, timestamp ) : INDEPENDENT;
		update_history_file_watercraft	:= AccountMonitoring.fn_update_history_file( candidates_watercraft, product_config.watercraft, timestamp );


		// Union all records, maintaining record order on each node ('&' -- ref. Lang. Guide, p. 26); then filter.
		candidates_all := IF(product_config.bankruptcy.product_is_in_mask,candidates_bankruptcy)
		                & IF(product_config.address.product_is_in_mask,candidates_address)
		                & IF(product_config.phone.product_is_in_mask,candidates_phone)
		                & IF(product_config.paw.product_is_in_mask,candidates_paw)
		                & IF(product_config.property.product_is_in_mask,candidates_property)
		                & IF(product_config.deceased.product_is_in_mask,candidates_deceased)
		                & IF(product_config.litigiousdebtor.product_is_in_mask,candidates_litigiousdebtor)
		                & IF(product_config.liens.product_is_in_mask,candidates_liens)
									  & IF(product_config.criminal.product_is_in_mask,candidates_criminal)
									  & IF(product_config.phonefeedback.product_is_in_mask,candidates_phonefeedback)
									  & IF(product_config.foreclosure.product_is_in_mask,candidates_foreclosure)
									  & IF(product_config.workplace.product_is_in_mask,candidates_workplace)
									  & IF(product_config.reverseaddress.product_is_in_mask,candidates_reverseaddress)
									  & IF(product_config.didupdate.product_is_in_mask,candidates_didupdate)
									  & IF(product_config.bdidupdate.product_is_in_mask,candidates_bdidupdate)
									  & IF(product_config.phoneownership.product_is_in_mask,candidates_phoneownership)
										& IF(product_config.bipbestupdate.product_is_in_mask,candidates_bipbestupdate)
										& IF(product_config.sbfe.product_is_in_mask,candidates_sbfe)
										& IF(product_config.ucc.product_is_in_mask,candidates_ucc)
										& IF(product_config.govtdebarred.product_is_in_mask,candidates_govtdebarred)
										& IF(product_config.inquiry.product_is_in_mask,candidates_inquiry)
										& IF(product_config.corp.product_is_in_mask,candidates_corp)
										& IF(product_config.mvr.product_is_in_mask,candidates_mvr)
										& IF(product_config.aircraft.product_is_in_mask,candidates_aircraft)
										& IF(product_config.watercraft.product_is_in_mask,candidates_watercraft);
		
		// We check for 0 hashvalue here because we don't want to return history records that simply reflect
		// a deleted portfolio record.
		// NOTE TO SELF --  TO DO  -- This should probably be in fn_rollup_candidates --
		
		candidates_new_or_changed := candidates_all(candidates_all.hash_value != 0 AND candidates_all.timestamp = ^.timestamp[2..9] + ^.timestamp[11..16]);
		
		// 2. Roll up all candidates, update candidate history files, and output portfolio candidate hits.
										
		candidates_rolled_org := AccountMonitoring.fn_rollup_candidates( PROJECT(candidates_new_or_changed, AccountMonitoring.layouts.history) );
		candidates_rolled     := SORT(candidates_rolled_org, pid, rid, hid);
		output_results        := AccountMonitoring.proc_output_results(candidates_rolled, pseudo_environment, timestamp, despray_ip_address, despray_path); 
		
		update_history_files  := PARALLEL(IF(product_config.bankruptcy.product_is_in_mask AND NOT job_config.monitor_daily_file,update_history_file_bankruptcy), 
													 IF(product_config.address.product_is_in_mask,update_history_file_address),
													 IF(product_config.phone.product_is_in_mask,update_history_file_phone),
													 IF(product_config.paw.product_is_in_mask,update_history_file_paw),
													 IF(product_config.property.product_is_in_mask,update_history_file_property),
													 IF(product_config.deceased.product_is_in_mask,update_history_file_deceased),
													 IF(product_config.litigiousdebtor.product_is_in_mask,update_history_file_litigiousdebtor),
													 IF(product_config.liens.product_is_in_mask,update_history_file_liens),
													 IF(product_config.criminal.product_is_in_mask,update_history_file_criminal),
													 IF(product_config.phonefeedback.product_is_in_mask,update_history_file_phonefeedback),
													 IF(product_config.foreclosure.product_is_in_mask,update_history_file_foreclosure),
													 IF(product_config.workplace.product_is_in_mask,update_history_file_workplace),
													 IF(product_config.reverseaddress.product_is_in_mask,update_history_file_reverseaddress),
													 IF(product_config.didupdate.product_is_in_mask,update_history_file_didupdate),
													 IF(product_config.bdidupdate.product_is_in_mask,update_history_file_bdidupdate),
													 IF(product_config.phoneownership.product_is_in_mask,update_history_file_phoneownership),
													 IF(product_config.bipbestupdate.product_is_in_mask,update_history_file_bipbestupdate),
													 IF(product_config.sbfe.product_is_in_mask,update_history_file_sbfe),
													 IF(product_config.ucc.product_is_in_mask,update_history_file_ucc),
													 IF(product_config.govtdebarred.product_is_in_mask,update_history_file_govtdebarred),
													 IF(product_config.inquiry.product_is_in_mask,update_history_file_inquiry),
													 IF(product_config.corp.product_is_in_mask,update_history_file_corp),
													 IF(product_config.mvr.product_is_in_mask,update_history_file_mvr),
													 IF(product_config.aircraft.product_is_in_mask,update_history_file_aircraft),
													 IF(product_config.watercraft.product_is_in_mask,update_history_file_watercraft)
													);
		
		RETURN SEQUENTIAL(
			IF(pseudo_environment = AccountMonitoring.constants.pseudo.DEFAULT OR pseudo_environment NOT IN AccountMonitoring.constants.all_pseudo,
				FAIL('Must provide valid pseudo-environment.')),
			output_results,
			update_history_files);
			
	END;