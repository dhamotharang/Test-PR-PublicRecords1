import header, ut;

export dataset(Header.layout_didtrack) didtrack_fn_apply_dodgy(
	dataset(Header.layout_didtrack) in_ds_didtrack,
	dataset(header.layout_DodgyDids) in_ds_dodgy,
	unsigned1 in_ver_sub) := function
		// Uncheck "current" flag on all records with a dodgy did.
		temp_ds_uncheck_current :=
			join(
				// These two files were distributed on DID before saving.
				distribute(in_ds_didtrack(current),hash64(did)),
				distribute(in_ds_dodgy,hash64(did)),
				left.did = right.did,
				transform(
					{
						header.layout_didtrack,
						boolean marked,
						integer1 hold_rule_code},
					self.marked := (right.did != 0),
					self.hold_rule_code := -ut.bit_set(0,(unsigned)right.rule_number-1),
					self.current := ~self.marked,
					self := left),
				left outer,
				local);

		temp_ds_new_records :=
			project(
				temp_ds_uncheck_current(
					marked),
				transform(
					header.layout_didtrack,
					self.rid := left.rid,
					self.did := left.rid,
					self.current := true,
					self.rule_code := left.hold_rule_code,
					self.version := ut.GetDate,
					self.ver_sub := in_ver_sub));
				
		return
			project(
				temp_ds_uncheck_current,
				header.layout_didtrack) +
			in_ds_didtrack(~current) +
			temp_ds_new_records;
	end;
	