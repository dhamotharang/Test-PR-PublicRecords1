import bankruptcyv3,ut,bankruptcyv2_services;
export fn_rollup_phones(
	dataset(recordof(bankruptcyv3.key_bankruptcyV3_search_full_bip())) in_records) :=
		function
			// SLIM DOWN TO REQUIRED FIELDS.  ROLLUP ON BDID/DID OR IF NOT AVAILABLE
			// ROLLUP ON NAME.
			temp_phones_slim :=
				project(
					in_records,
					transform(
						bankruptcyv2_services.layouts.layout_phone_ext,
						self.debtor_type_1 := left.debtor_type[1],
						self.timezone:='',
						self.HasCriminalConviction:=false,
						self.IsSexualOffender:=false,
						self := left));
						
			ut.getTimeZone(temp_phones_slim,phone,timezone,temp_phones_w_tzone)			
			// SAVE THE LATEST LAST SEEN DATE FOR EACH UNIQUE PHONE FOR EACH PARTY
			temp_phones_dedup :=
				dedup(
					sort(
						temp_phones_w_tzone,
						record),
					record,except date_last_seen,
					right);
			// SAVE THE MOST RECENT PHONES FOR EACH PARTY
			temp_phones_keep :=
				sort(
					temp_phones_dedup,
					tmsid,debtor_type_1,bdid,did,ssn,app_ssn,tax_id,app_tax_id,-date_last_seen);
			// ROLL UP THE PHONES FOR EACH PARTY KEY
			temp_phones_roll :=
				rollup(
					group(temp_phones_keep,tmsid,debtor_type_1,bdid,did,ssn,app_ssn,tax_id,app_tax_id),
					group,
					transform(
						bankruptcyv2_services.layouts.layout_phone_roll,
						self.phones := choosen(project(rows(left),bankruptcyv2_services.layouts.layout_phone),bankruptcyv2_services.layouts.PHONES_PER_PARTY),
						self := left));
			return
				temp_phones_roll;
		end;
		