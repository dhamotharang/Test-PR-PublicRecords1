import Data_Services, doxie, ut, mdr, autokeyb2, standard, PRTE2_Email_Data_Ins;

EXPORT Keys (STRING filedateString)  := MODULE
		Files := PRTE2_Email_Data_Ins.Files;

		EXPORT Email_Base_Recs := Files.FINAL_DS(did > 0 and current_rec and append_is_valid_domain_ext);		

		SHARED STRING email_dated_did_name  := Files.bk_email_dated_name(filedateString , 'did');
		SHARED STRING email_dated_addr_name := Files.bk_email_dated_name(filedateString , 'email_addresses');
		// --------------------------------------------------------------------------
		// - Key_Payload ------------------------------------------------------------
		// SHARED dBase := Files.File_AutoKey;			//????
		// SHARED dBase  := dataset([], Layouts.Autokey_layout);
		// autokeyb2.MAC_FID_Payload(dBase ,'','','','','','','','','',0,0,Files.keyPayloadName,plk,'');
		// EXPORT Key_Payload := plk;
		// --------------------------------------------------------------------------
		// some confusing historical stuff here - commented out for now, zap later if not needed.
		// see any references to Key_Payload below, commented but zap later if not needed.
		// --------------------------------------------------------------------------

		// --------------------------------------------------------------------------
		// - Key_Did ----------------------------------------------------------------		
		SHARED email_did := project(Email_Base_Recs, Layouts.keyRec); //Cyndy:Change Keys => keyRec
		// SHARED did_w_fakes := project(Key_Payload, Layouts.keyRec);  //Cyndy:Change Keys => keyRec
		// SHARED did_ready := did_w_fakes + email_did;
		SHARED did_ready := email_did;
		
		//enter did and get the did and the rest of the record back				   
		EXPORT Key_Did := index(did_ready
														,{did}
														,{did_ready}
														,email_dated_did_name
														);
		// --------------------------------------------------------------------------
		
		
		// --------------------------------------------------------------------------
		// - Key_Email_Address ------------------------------------------------------

		SHARED emailAddr := email_did;	
		// SHARED emailAddr := project(Email_Base_Recs,Layouts.keyRec);
		// SHARED payload := project(Key_Payload,Layouts.keyRec);
		// SHARED emailAddr := temp_ds + payload;		
		// SHARED emailAddr := temp_ds;		
		SHARED dedp_emailAddr := dedup(sort(distribute(emailAddr, hash(did)) 
																,clean_email,did,local),
														clean_email,did,local);

		//enter the first part of emailaddr or enter the full email addr get the rest of the record back				   
		EXPORT Key_Email_Address := index(dedp_emailAddr
																			,{clean_email}
																			,{dedp_emailAddr}
																			,email_dated_addr_name
																			);
																			
		// --------------------------------------------------------------------------


		//*************************** PROBABLE OBSOLETE STUFF FOUND ONLY IN z_attributes ****************************
		// --------------------------------------------------------------------------
		// - Key_Did_FCRA (CT should not need this) ---------------------------------
/*		
		f_email_did	:= project(_files.File_Email_Base_FCRA_DS(did > 0 and current_rec and append_is_valid_domain_ext and activecode <> 'I' ), _layouts.Keys);
		f_did_w_fakes	:=  project(Key_Payload(did > 0 and current_rec and append_is_valid_domain_ext and activecode <> 'I' ), _layouts.Keys);
		f_did_ready := f_did_w_fakes + f_email_did;

		//enter did and get the did and the rest of the record back				   
		EXPORT Key_Did_FCRA := index(f_did_ready
														,{did}
														,{f_did_ready}
														,_constants.foreign_key_name_fcra
														);
*/
		// --------------------------------------------------------------------------


END;