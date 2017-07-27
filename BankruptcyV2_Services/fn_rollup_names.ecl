import bankruptcyv3, bankruptcyv2_services;
export fn_rollup_names(
	dataset(recordof(bankruptcyv3.key_bankruptcyV3_search_full_bip())) in_records) :=
		function
			// SLIM DOWN TO REQUIRED FIELDS.  ROLLUP ON BDID/DID OR IF NOT AVAILABLE
			// ROLLUP ON NAME.
			temp_names_slim :=
				project(
					in_records,
					transform(
						bankruptcyv2_services.layouts.layout_name_ext,
						self.debtor_type_1 := left.debtor_type[1],
						self.HasCriminalConviction:=false,
						self.IsSexualOffender:=false,
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
						tmsid,debtor_type_1,bdid,did,ssn,app_ssn,tax_id,app_tax_id,-date_last_seen);
			// ROLL UP THE NAMES FOR EACH PARTY KEY
			temp_names_roll :=
				rollup(
					group(temp_names_keep,tmsid,debtor_type_1,bdid,did,ssn,app_ssn,tax_id,app_tax_id),
					group,
					transform(
						bankruptcyv2_services.layouts.layout_name_roll,
						self.names := choosen(project(rows(left),bankruptcyv2_services.layouts.layout_name),bankruptcyv2_services.layouts.NAMES_PER_PARTY),
						self := left));
			return
				temp_names_roll;
		end;
		