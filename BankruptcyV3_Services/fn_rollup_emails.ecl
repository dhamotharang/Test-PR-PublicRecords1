import bankruptcyv3_Services;
export fn_rollup_emails(
	dataset(bankruptcyv3_services.Layout_key_bankruptcyv3_search_full_bip_plus_case_numbers) in_records) :=
		function
			// SLIM DOWN TO REQUIRED FIELDS.  ROLLUP ON BDID/DID OR IF NOT AVAILABLE
			// ROLLUP ON NAME.
			temp_emails_slim :=
				project(
					in_records,
					transform(
						bankruptcyv3_services.layouts.layout_email_ext,
						self.debtor_type_1 := left.debtor_type[1],
						self := left));
			// SAVE THE LATEST LAST SEEN DATE FOR EACH UNIQUE EMAIL FOR EACH PARTY
			temp_emails_dedup :=
				dedup(
					sort(
						temp_emails_slim,
						record),
					record,except date_last_seen,
					right);
			// SAVE THE MOST RECENT EMAILS FOR EACH PARTY
			temp_emails_keep :=
					sort(
						temp_emails_dedup,
						tmsid,debtor_type_1,bdid,did,ssn,app_ssn,tax_id,app_tax_id,-date_last_seen);
			// ROLL UP THE EMAILS FOR EACH PARTY KEY
			temp_emails_roll :=
				rollup(
					group(temp_emails_keep,tmsid,debtor_type_1,bdid,did,ssn,app_ssn,tax_id,app_tax_id),
					group,
					transform(
						bankruptcyv3_services.layouts.layout_email_roll,
						self.emails := choosen(project(rows(left),bankruptcyv3_services.layouts.layout_email),
																	bankruptcyv3_services.consts.EMAILS_PER_PARTY),
						self := left));
			return
				temp_emails_roll;
		end;
		