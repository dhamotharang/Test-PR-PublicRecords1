IMPORT Autokey_batch, AutokeyB2, BatchServices, Email_Data;

EXPORT Email_BatchIds := MODULE;
	EXPORT AutoKeyIds(dataset(Autokey_batch.Layouts.rec_inBatchMaster) ds_batch_in) := FUNCTION

		// 1. Define values for obtaining autokeys and payloads.	
		ak_keyname    := Email_Data.Constants('').ak_qa_keyname;
		ak_dataset    := Email_Data.Constants('').ak_dataset;
		ak_skipSet		:= Email_Data.Constants('').ak_skipSet;
		ak_typeStr		:= Email_Data.Constants('').ak_typeStr;				

		// 2. Configure the autokey search.		
		ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
			EXPORT workHard        := TRUE;
			EXPORT useAllLookups   := TRUE;
			EXPORT PenaltThreshold := 20;
			EXPORT skip_set        := ak_skipset;
		END;

		// 3. Get fake ids from the autokeys based on batch input.
		ds_fids := Autokey_batch.get_fids(ds_batch_in, ak_keyname, ak_config_data);

		// 4. Get autokey payload data (outPLfat) using the fake ids.
		AutokeyB2.mac_get_payload(UNGROUP(ds_fids), ak_keyname, ak_dataset, outPLfat, did, zero, ak_typeStr);		
		
		// 5. project payload data into raw format.
		ds_payload := project(outplfat, 
														TRANSFORM(BatchServices.Layouts.email.rec_results_raw,
															SELF.title       := LEFT.Clean_Name.title,
															SELF.fname       := LEFT.Clean_name.fname,
															SELF.mname       := LEFT.Clean_name.mname,
															SELF.lname       := LEFT.Clean_name.lname,
															SELF.name_suffix := LEFT.Clean_name.name_suffix,
															SELF.prim_range  := LEFT.Clean_address.prim_range,
															SELF.predir      := LEFT.clean_address.predir,
															SELF.prim_name   := LEFT.clean_address.prim_name,
															SELF.addr_suffix := LEFT.clean_address.addr_suffix,
															SELF.postdir     := LEFT.clean_address.postdir,
															SELF.unit_desig  := LEFT.clean_address.unit_desig,
															SELF.sec_range	 := LEFT.clean_address.sec_range,
															SELF.p_city_name := LEFT.clean_address.p_city_name,
															SELF.v_city_name := LEFT.clean_address.v_city_name,
															SELF.st          := LEFT.clean_address.st,
															SELF.zip         := LEFT.clean_address.zip,
															SELF.zip4        := LEFT.clean_address.zip4,
															SELF := LEFT,
															SELF := []));
		RETURN ds_payload;
	END;
	
	EXPORT byDIDIds(dataset(Autokey_batch.Layouts.rec_inBatchMaster) ds_batch_in) := FUNCTION

		Key_DID := Email_Data.Key_Did;
		
		ds_acctnos_and_dids := BatchServices.Functions.fn_find_dids_and_append_to_acctno(ds_batch_in);
		
		// Match ds_acctnos_and_dids against did email key.
		ds_from_did := JOIN(ds_acctnos_and_dids, Key_DID, 
													keyed(LEFT.did = RIGHT.did), 
														TRANSFORM( BatchServices.Layouts.email.rec_results_raw,
															SELF.acctno			 := LEFT.acctno,
															SELF.did 				 := RIGHT.did,
															SELF.title       := RIGHT.Clean_Name.title,
															SELF.fname       := RIGHT.Clean_name.fname,
															SELF.mname       := RIGHT.Clean_name.mname,
															SELF.lname       := RIGHT.Clean_name.lname,
															SELF.name_suffix := RIGHT.Clean_name.name_suffix,
															SELF.prim_range  := RIGHT.Clean_address.prim_range,
															SELF.predir      := RIGHT.clean_address.predir,
															SELF.prim_name   := RIGHT.clean_address.prim_name,
															SELF.addr_suffix := RIGHT.clean_address.addr_suffix,
															SELF.postdir     := RIGHT.clean_address.postdir,
															SELF.unit_desig  := RIGHT.clean_address.unit_desig,
															SELF.sec_range	 := RIGHT.clean_address.sec_range,
															SELF.p_city_name := RIGHT.clean_address.p_city_name,
															SELF.v_city_name := RIGHT.clean_address.v_city_name,
															SELF.st          := RIGHT.clean_address.st,
															SELF.zip         := RIGHT.clean_address.zip,
															SELF.zip4        := RIGHT.clean_address.zip4,
															SELF.best_ssn    := RIGHT.best_ssn,
															SELF 						 := RIGHT,
															SELF := []),LIMIT(BatchServices.Constants.Email.JOIN_LIMIT, SKIP));
		RETURN ds_from_did;																					 
	END;					

	EXPORT byInputEmail(DATASET(BatchServices.Layouts.Email.rec_batch_email_input) ds_batch_in_email) := FUNCTION
		
		Key_Email := Email_Data.Key_Email_Address;

		layout_email_addr := record
			string72 orig_email;
			string72 email_addr1;
			string72 email_addr2;
			string30 acctno;
		end;

		raw_inputEmail := PROJECT(ds_batch_in_email, 
																TRANSFORM(layout_email_addr,
																	 tmp_orig_email := StringLib.StringToUpperCase(trim(LEFT.email_addrFull, LEFT, RIGHT));
																	 SELF.orig_email := tmp_orig_email;
																	 SELF.email_addr1 := StringLib.StringToUpperCase(tmp_orig_email[1..(stringlib.stringfind(tmp_orig_email,'@',1))-1]);
																	 SELF.email_addr2 := StringLib.StringToUpperCase(tmp_orig_email[(stringlib.stringfind(tmp_orig_email,'@',1))+1..]);																													
																	 SELF.acctno := LEFT.acctno;
																	 SELF := []));	
																						 
		email_lookup := join(raw_inputEmail,Key_Email, 
													keyed(LEFT.orig_email = RIGHT.clean_email), 
														TRANSFORM(BatchServices.Layouts.email.rec_results_raw,
															SELF.acctno      := LEFT.acctno,
															SELF.title       := RIGHT.Clean_Name.title,
															SELF.fname       := RIGHT.Clean_name.fname,
															SELF.mname       := RIGHT.Clean_name.mname,
															SELF.lname       := RIGHT.Clean_name.lname,
															SELF.name_suffix := RIGHT.Clean_name.name_suffix,
															SELF.prim_range  := RIGHT.Clean_address.prim_range,
															SELF.predir      := RIGHT.clean_address.predir,
															SELF.prim_name   := RIGHT.clean_address.prim_name,
															SELF.addr_suffix := RIGHT.clean_address.addr_suffix,
															SELF.postdir     := RIGHT.clean_address.postdir,
															SELF.unit_desig  := RIGHT.clean_address.unit_desig,
															SELF.sec_range	 := RIGHT.clean_address.sec_range,
															SELF.p_city_name := RIGHT.clean_address.p_city_name,
															SELF.v_city_name := RIGHT.clean_address.v_city_name,
															SELF.st          := RIGHT.clean_address.st,
															SELF.zip         := RIGHT.clean_address.zip,
															SELF.zip4        := RIGHT.clean_address.zip4,				
															SELF.best_ssn    := RIGHT.best_ssn,																
															SELF := RIGHT,
															SELF := []),LIMIT(BatchServices.Constants.Email.JOIN_LIMIT, SKIP));
		RETURN email_lookup;																					 
	END;	
END;