import header, ut;

// If we want to start our DID tracking from the current situation, set to true.
boolean temp_v_start_fresh := false : stored('DIDTrack_StartFresh');

// Selects the current DIDTrack file if we're not starting new, otherwise,
// opts to project the current header file into DIDTrack form.
temp_ds_didtrack_select :=
	if(
		temp_v_start_fresh,
		header.didtrack_ds_initial,
		header.didtrack_ds_file);

// Uncheck "current" flag on all records with a dodgy did.
temp_ds_uncheck_current :=
	join(
		// These two files were distributed on DID before saving.
		temp_ds_didtrack_select(current),
		header.dodgydids,
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
			self.version := ut.GetDate));
		
export didtrack_ds_apply_dodgy :=
	project(
		temp_ds_uncheck_current,
		header.layout_didtrack) +
	temp_ds_didtrack_select(~current) +
	temp_ds_new_records;
	