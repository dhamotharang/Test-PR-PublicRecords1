import header, ut;

export dataset(Header.layout_didtrack) didtrack_fn_apply_joinrule(
	dataset(Header.layout_didtrack) in_ds_didtrack,
	dataset(header.Layout_PairMatch) in_ds_joinrule,
	unsigned1 in_ver_sub) := function
		// Distribute on DID to allow localized data operations.  This is necessary because
		// the didtrack_ds_apply_dodgy attribute changed the value of did on some records,
		// so we need to make sure all dids that are the same are on the same node again.
		temp_ds_didtrack_dist :=
			distribute(
				in_ds_didtrack,
				hash(did));

		// Distribute the DID moves on "old" DID to match the didtrack data's distribution.
		// Did_Rules1 wasn't distributed before being exported.
		temp_ds_didtrack_joinrule_dist :=
			distribute(
				header.fn_Did_Rules1(in_ds_joinrule),
				hash(old_rid));

		// Uncheck "current" flag on all records being merged to a new did.
		temp_ds_uncheck_current :=
			join(
				temp_ds_didtrack_dist(current),
				temp_ds_didtrack_joinrule_dist,
				left.did = right.old_rid,
				transform(
					{
						header.layout_didtrack,
						boolean marked,
						unsigned6 hold_did},
					self.marked := (right.old_rid != 0),
					self.hold_did := right.new_rid,
					self.current := ~self.marked,
					self := left),
				left outer,
				local);

		// For each rid, add a new didtrack record associating it to the new DID.
		temp_ds_new_records :=
			rollup(
				sort(
					join(
						temp_ds_uncheck_current(
							marked),
						distribute(
							in_ds_joinrule,
							hash(old_rid)),
						left.did = right.old_rid and
						left.hold_did = right.new_rid,
						transform(
							header.layout_didtrack,
							self.rid := left.rid,
							self.did := left.hold_did,
							self.current := true,
							self.rule_code := ut.bit_set(0,right.pflag-1),
							self.version := ut.GetDate,
							self.ver_sub := in_ver_sub),
						local),
					rid,
					did),
				left.rid = right.rid and
				left.did = right.did,
				transform(
					header.layout_didtrack,
					self.rule_code := left.rule_code | right.rule_code,
					self := left));

		return
			project(
				temp_ds_uncheck_current,
				header.layout_didtrack) +
			temp_ds_didtrack_dist(~current) +
			temp_ds_new_records;
	end;
	