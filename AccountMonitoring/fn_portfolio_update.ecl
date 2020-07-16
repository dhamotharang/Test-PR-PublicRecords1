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
		
		
		
		RETURN SEQUENTIAL( spray_input_files//,
		                   //write_updated_files
		                 );
	END;
