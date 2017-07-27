import bankruptcyv3_services,ut;
export fn_rollup_debtor_phones(
	dataset(bankruptcyv3_services.Layout_key_bankruptcyv3_search_full_bip_plus_case_numbers) in_records) :=
		function
			// SLIM DOWN TO REQUIRED FIELDS.  ROLLUP ON BDID/DID OR IF NOT AVAILABLE
			// ROLLUP ON NAME.
			temp_phones_slim :=
				project(
					in_records,
					transform(
						bankruptcyv3_services.layouts.layout_phone_ext,
						self.debtor_type_1 := left.debtor_type[1],
						self := left,self.timezone :=''));
			ut.getTimeZone(temp_phones_slim,phone,timezone,temp_phones_w_tzone)
			
			// SAVE THE LATEST LAST SEEN DATE FOR EACH UNIQUE PHONE FOR EACH PARTY
			temp_phones_dedup :=
				dedup(
					sort(
						temp_phones_w_tzone,
						record,except bdid,did,ssn,app_ssn,tax_id,app_tax_id),
					record,except bdid,did,ssn,app_ssn,tax_id,app_tax_id,date_last_seen,
					right);
			// SAVE THE MOST RECENT PHONES FOR EACH PARTY
			temp_phones_keep :=
				sort(
					temp_phones_dedup,
					tmsid,defendantID,debtor_type_1,-date_last_seen);
			// ROLL UP THE PHONES FOR EACH PARTY KEY
			temp_phones_roll :=
				rollup(
					group(temp_phones_keep,tmsid,defendantID,debtor_type_1),
					group,
					transform(
						bankruptcyv3_services.layouts.layout_phone_roll,
						self.phones := choosen(project(rows(left),bankruptcyv3_services.layouts.layout_phone),
																	 bankruptcyv3_services.consts.PHONES_PER_PARTY),
						self := left));
			return
				temp_phones_roll;
		end;
		