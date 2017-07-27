// determine records to display
import AutoStandardI,doxie,suppress,Standard, DriversVTSA, DriversV2_Services;

ids := DLSearchService_ids();

// narrow to just sequences
seqs := dedup( project( ids, layouts.seq ), all);

// retrieve results
rpen := DLRaw.narrow_view.by_seq(seqs);

histFilter := map(input.IncludeHistory = DriversVTSA.Constants.IncludeHistory.current and rpen.history <> '' => false,
				input.IncludeHistory = DriversVTSA.Constants.IncludeHistory.history and rpen.history = '' => false,
				true);

rpenhist := rpen(histFilter);


// prepend deep dive status, and shift deep dives to the bottom of the results
rdd := join(
	rpenhist, dedup(sort(ids, dl_seq), dl_seq),
	left.dl_seq = right.dl_seq,	
	transform({ids.isDeepDive,rpen}, self.isDeepDive := right.isDeepDive, self := left),
	left outer
);
rsrt := sort(
	rdd(penalt <= input.pThresh),
	 penalt, -lic_issue_date, -expiration_date, record
);

// slim to final output format (preserving sort)
// final_fmt	:= project(rsrt, layouts.result_narrow); // no need to narrow -- it's the same plus IsDeepDive
pre_dobmasking := dedup(rsrt, except dl_seq);

// output(ids,	named('ids'));	// DEBUG
// output(seqs,	named('seqs'));	// DEBUG
// output(rpen,	named('rpen'));	// DEBUG
// output(rsrt,	named('rsrt'));	// DEBUG


	doxie.MAC_Header_Field_Declare()
	
	layout_dobmask := record
		pre_dobmasking;
		Standard.Date.Datestr dob_masked;
	end;
	layout_dobmask pre_dm_trans(pre_dobmasking l) := transform
	  self.dob_masked := ROW ({'', '', ''}, Standard.Date.Datestr);
		self := L;
	end;
	
	
	pre_dobmask_ready := project(pre_dobmasking,pre_dm_trans(left));
	
	Suppress.MAC_Mask_Date(pre_dobmask_ready, post_dobmasking, dob, dob_masked, dob_mask_value);
	final_d := post_dobmasking;

export DLSearchService_records := final_d;