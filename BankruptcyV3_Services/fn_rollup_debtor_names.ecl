import bankruptcyv3_services;
export fn_rollup_debtor_names(
	dataset(bankruptcyv3_services.Layout_key_bankruptcyv3_search_full_bip_plus_case_numbers) in_records) :=
		function
			// SLIM DOWN TO REQUIRED FIELDS.  ROLLUP ON BDID/DID OR IF NOT AVAILABLE
			// ROLLUP ON NAME.
			temp_names_slim :=
				project(
					in_records,
					transform(
						bankruptcyv3_services.layouts.layout_name_ext,
						self.debtor_type_1 := left.debtor_type[1],
						self := left));
			// SAVE THE LATEST LAST SEEN DATE FOR EACH UNIQUE NAME FOR EACH PARTY
			temp_names_dedup :=
				dedup(
					sort(
						temp_names_slim,
						record),
					record,except date_last_seen,
					right);
			// SAVE THE MOST RECENT NAMES FOR EACH PARTY
			temp_names_keep :=
					sort(
						temp_names_dedup,
						tmsid,defendantID,debtor_type_1,debtor_type,-date_last_seen);
			// ROLL UP THE NAMES FOR EACH PARTY KEY
			temp_names_roll :=
				rollup(
					group(temp_names_keep,tmsid,defendantID,debtor_type_1),
					group,
					transform(
						bankruptcyv3_services.layouts.layout_name_roll,
						self.names := choosen(project(rows(left),bankruptcyv3_services.layouts.layout_name),
																	bankruptcyv3_services.consts.NAMES_PER_PARTY),
						self := left));
			return
				temp_names_roll;
		end;
		