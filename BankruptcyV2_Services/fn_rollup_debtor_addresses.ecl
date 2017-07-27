import bankruptcyv3,bankruptcyv2_services;
export fn_rollup_debtor_addresses(
	dataset(recordof(bankruptcyv3.key_bankruptcyv3_search_full_bip())) in_records) :=
		function
			// SLIM DOWN TO REQUIRED FIELDS.  ROLLUP ON BDID/DID OR IF NOT AVAILABLE
			// ROLLUP ON NAME.
			temp_addresses_slim :=
				project(
					in_records,
					transform(
						bankruptcyv2_services.layouts.layout_address_ext,
						self.debtor_type_1 := left.debtor_type[1],
						self.HasCriminalConviction:=false,
						self.IsSexualOffender:=false,
						self := left));
			// SAVE THE LATEST LAST SEEN DATE FOR EACH UNIQUE ADDRESS FOR EACH PARTY
			temp_addresses_dedup :=
				dedup(
					sort(
						temp_addresses_slim,
						record,except bdid,did,ssn,app_ssn,tax_id,app_tax_id),
					record,except bdid,did,ssn,app_ssn,tax_id,app_tax_id,date_last_seen,
					right);
			// SAVE THE MOST RECENT ADDRESSES FOR EACH PARTY
			temp_addresses_keep :=
				sort(
					temp_addresses_dedup,
					tmsid,debtor_type_1,-date_last_seen);
			// ROLL UP THE ADDRESSES FOR EACH PARTY KEY
			temp_addresses_roll :=
				rollup(
					group(temp_addresses_keep,tmsid,debtor_type_1),
					group,
					transform(
						bankruptcyv2_services.layouts.layout_address_roll,
						self.addresses := choosen(project(rows(left),bankruptcyv2_services.layouts.layout_address),bankruptcyv2_services.layouts.ADDRESSES_PER_PARTY),
						self := left));
			return
				temp_addresses_roll;
		end;
		