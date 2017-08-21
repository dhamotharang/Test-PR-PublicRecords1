Import Data_Services, doxie,ut, mdr, autokeyb2,standard;

EXPORT _keys (STRING filedateString)  := MODULE

		EXPORT Email_Base_Recs := _files.File_Email_Base_DS(did > 0 and current_rec and append_is_valid_domain_ext);		

		SHARED STRING email_dated_did_name := _constants.bk_email_dated_name(filedateString , 'did');
		SHARED STRING email_dated_addr_name := _constants.bk_email_dated_name(filedateString , 'email_addresses');

		// --------------------------------------------------------------------------
		// - Key_Payload ------------------------------------------------------------
		dBase 		  := dataset([], recordof(_files.File_AutoKey));
		autokeyb2.MAC_FID_Payload(dBase ,'','','','','','','','','',0,0,_constants.keyPayloadName,plk,'');
		EXPORT Key_Payload := plk;
		// --------------------------------------------------------------------------


		// --------------------------------------------------------------------------
		// - Key_Did ----------------------------------------------------------------		
		email_did := project(Email_Base_Recs, _layouts.Keys);
		did_w_fakes := project(Key_Payload, _layouts.Keys);
		did_ready := did_w_fakes + email_did;
		
		//enter did and get the did and the rest of the record back				   
		EXPORT Key_Did := index(did_ready
														,{did}
														,{did_ready}
														,email_dated_did_name
														);
		// --------------------------------------------------------------------------
		
		// --------------------------------------------------------------------------
		// - Key_Email_Address ------------------------------------------------------

		temp_ds := project(Email_Base_Recs,_layouts.Keys);
		payload := project(Key_Payload,_layouts.Keys);
		emailAddr := temp_ds + payload;		
		dedp_emailAddr := dedup(sort(distribute(emailAddr, hash(did)) 
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