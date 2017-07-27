import bankruptcyv3, suppress, CriminalRecords_Services, bankruptcyv2_services;
export fn_rollup_debtors(
	dataset(recordof(bankruptcyv3.key_bankruptcyV3_search_full_bip())) in_records,
	string6 in_ssn_mask,
  boolean includeCriminalIndicators=false) :=
		function
			// ID DEBTORS THAT ARE BIZ/PEOPLE.
			temp_exists_people := table(dedup(sort(in_records,tmsid,debtor_type),tmsid,debtor_type[1]),{tmsid,debtor_type,did,bdid,app_ssn,ssn,app_tax_id,tax_id});
			// SLIM DOWN TO REQUIRED FIELDS.  PROVIDE A KEY TO MATCH PARTIES
			// TO INSIDE THEDATA.
			temp_parties_slim :=
				join(
					in_records,
					temp_exists_people,
					left.tmsid = right.tmsid and
					left.debtor_type[1] = right.debtor_type[1],
					transform(
						bankruptcyv2_services.layouts.layout_party_ext,
						self.debtor_type_1 := right.debtor_type[1],
						self.did := right.did,
						self.bdid := right.bdid,
						self.app_ssn := right.app_ssn,
						self.ssn := right.ssn,
						self.app_tax_id := right.app_tax_id,
						self.tax_id := right.tax_id,
						self := left,
						self := []));
			// SAVE THE LATEST LAST SEEN DATE FOR EACH UNIQUE PARTY FOR EACH TMSID
			temp_parties_dedup :=
				dedup(
					sort(
						temp_parties_slim,
						record),
					record,except date_last_seen,
					right);
			// JOIN TO THE ROLLED UP ADDRESSES
			temp_parties_add_addresses :=
				join(
					temp_parties_dedup,
					bankruptcyv2_services.fn_rollup_debtor_addresses(in_records),
					left.tmsid = right.tmsid and
					left.debtor_type_1 = right.debtor_type_1,
					transform(
						recordof(temp_parties_dedup),
						self.addresses := right.addresses,
						self := left),
					left outer);
			// JOIN TO THE ROLLED UP NAMES
			temp_parties_add_names :=
				join(
					temp_parties_add_addresses,
					bankruptcyv2_services.fn_rollup_debtor_names(in_records),
					left.tmsid = right.tmsid and
					left.debtor_type_1 = right.debtor_type_1,
					transform(
						recordof(temp_parties_dedup),
						self.names := right.names,
						self := left),
					left outer);
			// JOIN TO THE ROLLED UP PHONES
			temp_parties_add_phones :=
				join(
					temp_parties_add_names,
					bankruptcyv2_services.fn_rollup_debtor_phones(in_records),
					left.tmsid = right.tmsid and
					left.debtor_type_1 = right.debtor_type_1,
					transform(
						recordof(temp_parties_dedup),
						self.phones := right.phones,
						self := left),
					left outer);
			// SAVE THE MOST RECENT PARTIES FOR EACH TMSID
			temp_parties_keep :=
				sort(
					temp_parties_add_phones,
					tmsid,names[1].debtor_type,-date_last_seen);

			tmp_parties_masked := fn_mask_ssns(temp_parties_keep, in_ssn_mask);

      // ADD CRIM INDICATORS
      recsIn := PROJECT(tmp_parties_masked,TRANSFORM({bankruptcyv2_services.layouts.layout_party_ext,STRING12 UniqueId},SELF.UniqueId:=LEFT.did,SELF:=LEFT));
      CriminalRecords_Services.MAC_Indicators(recsIn,recsOut);
      tmp_parties := PROJECT(IF(includeCriminalIndicators,recsOut,recsIn),bankruptcyv2_services.layouts.layout_party_ext);

			// ROLL UP THE PARTIES FOR EACH TMSID
			temp_parties_roll := rollup(
				group(tmp_parties,tmsid),
				group,
				transform(
					bankruptcyv2_services.layouts.layout_party_roll,
					self.parties := choosen(project(rows(left),bankruptcyv2_services.layouts.layout_party),BankruptcyV2_Services.layouts.PARTIES_PER_ROLLUP),
					self := left));
			return
				temp_parties_roll;
		end;
