IMPORT  ut, mdr, tools,_validate, Address, Ut, lib_stringlib, _Control, business_header, UPI_DataBuild__old,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID;

EXPORT ReturnToBatch (string pVersion, boolean pUseProd = false, string gcid, dataset (UPI_DataBuild__old.Layouts_V2.input_processing) pBaseFile, string pAppendOption):= MODULE
					
	EXPORT Batch_processing	:= FUNCTION
	
		//AppendOption:
		// 1 - Append LexID to records with LexID match AND Customer Record Key for all records
		// 2 - Append LexID to records with LexID match AND Customer Record Key ONLY for records with NO LEXID
		// 3 - Append LexID ONLY to records with LexID match and DO NOT append Customer Record Key for any records
		// 4 - Append ONLY Customer Record Key for all records - NO LEXID appends for any records
		// change flags null when input_lexid or input_crk fields are null/zero

		UPI_DataBuild__old.layouts_V2.input_processing tMapping(UPI_DataBuild__old.layouts_V2.input_processing L) := TRANSFORM
			self.batch_seq_number							:= L.batch_seq_number;
			self.input_lexid									:= L.input_lexid;
			self.input_crk										:= L.input_crk;
			self.member_id										:= L.member_id;
			self.customer_id									:= L.customer_id;
			self.account_id										:= L.account_id;
			self.subscriber_id								:= L.subscriber_id;
			self.group_id											:= L.group_id;
			self.relationship_code						:= L.relationship_code;
			self.input_first_name							:= L.input_first_name;
			self.input_middle_initial					:= L.input_middle_initial;
			self.input_last_name							:= L.input_last_name;
			self.input_suffix									:= L.input_suffix;
			self.input_full_name							:= L.input_full_name;
			self.address_line1								:= L.address_line1;
			self.address_line2								:= L.address_line2;
			self.input_city										:= L.input_city;
			self.input_state									:= L.input_state;
			self.input_zip										:= L.input_zip;
			self.input_dob										:= L.input_dob;
			self.input_gender									:= L.input_gender;
			self.input_ssn										:= L.input_ssn;
			self.input_home_phone							:= L.input_home_phone;
			self.input_alt_phone							:= L.input_alt_phone;
			self.input_primary_email_address	:= L.input_primary_email_address;
			self.input_guardian_first_name		:= L.input_guardian_first_name;
			self.input_guardian_last_name			:= L.input_guardian_last_name;
			self.input_guardian_dob						:= L.input_guardian_dob;
			self.input_guardian_ssn						:= L.input_guardian_ssn;
			self.udf1													:= L.udf1;
			self.udf2													:= L.udf2;
			self.udf3													:= L.udf3;
			self.lexid												:= map(L.append_option = '1' => L.lexid,
																							 L.append_option = '2' => L.lexid,
																							 L.append_option = '3' => L.lexid,
																							 L.append_option = '4' => 0,
																							 L.lexid); 
			self.lexid_score									:= map(L.append_option = '1' => L.lexid_score,
																							 L.append_option = '2' => L.lexid_score,
																							 L.append_option = '3' => L.lexid_score,
																							 L.append_option = '4' => 0,
																							 L.lexid_score); 
			self.lexid_changed								:= map(L.input_lexid = 0 => ''
																							,L.append_option = '1' AND L.input_lexid > 0 AND L.input_lexid <> L.lexid => 'Y'
																							,L.append_option = '1' AND L.input_lexid > 0 AND L.input_lexid =  L.lexid => 'N'
																							,L.append_option = '2' AND L.input_lexid > 0 AND L.input_lexid <> L.lexid => 'Y'
																							,L.append_option = '2' AND L.input_lexid > 0 AND L.input_lexid =  L.lexid => 'N'	
																							,L.append_option = '3' AND L.input_lexid > 0 AND L.input_lexid <> L.lexid => 'Y'
																							,L.append_option = '3' AND L.input_lexid > 0 AND L.input_lexid =  L.lexid => 'N'
																							,L.append_option = '4' => ''
																							,''); 
			self.prev_lexid										:= L.input_lexid; 
			self.crk													:= map(L.append_option = '1' => L.crk,
																							 L.append_option = '2' AND self.lexid = 0 => L.crk,
																							 L.append_option = '2' AND self.lexid > 0 => '',
																							 L.append_option = '3' => '',
																							 L.append_option = '4' => L.crk,
																							 L.crk);
			self.crk_changed									:= map(L.input_crk = '' => ''
																							,L.append_option = '1' AND L.input_crk <> '' AND L.input_crk <> L.crk => 'Y'
																							,L.append_option = '1' AND L.input_crk <> '' AND L.input_crk =  L.crk => 'N'
																							,L.append_option = '2' AND SELF.lexid > 0 => ''
																							,L.append_option = '2' AND L.input_crk <> '' AND L.input_crk <> L.crk AND SELF.lexid = 0 => 'Y'
																							,L.append_option = '2' AND L.input_crk <> '' AND L.input_crk =  L.crk AND SELF.lexid = 0 => 'N'
																							,L.append_option = '3' => ''
																							,L.append_option = '4' AND L.input_crk <> '' AND L.input_crk <> L.crk => 'Y'
																							,L.append_option = '4' AND L.input_crk <> '' AND L.input_crk =  L.crk => 'N'
																							,'');
			self.prev_crk											:= L.input_crk;
			SELF  :=  L;	
			SELF  :=  [];
		END;
		//AppendOption:
		// 1 - Append LexID to records with LexID match AND Customer Record Key for all records
		// 2 - Append LexID to records with LexID match AND Customer Record Key ONLY for records with NO LEXID
		// 3 - Append LexID ONLY to records with LexID match and DO NOT append Customer Record Key for any records
		// 4 - Append ONLY Customer Record Key for all records - NO LEXID appends for any records

		reformatFile	:= project(pBaseFile, tMapping(left));
		
		dedup_return	:= dedup(sort(reformatFile, record, local), record, local);
		
		sort_return	:= sort(dedup_return, (integer)batch_seq_number);
		
		RETURN sort_return;
	END;
		
END;