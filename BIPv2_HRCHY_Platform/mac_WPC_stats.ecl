EXPORT mac_WPC_stats(ds) := 
functionmacro

s := #text(ds);

ds_true_ult := ds(derived_levels_from_top = 0, exists(children));

//cant really have two ult rows that share any children...
ds_conflicted_ultids := 
join(
	ds_true_ult,
	ds_true_ult,
	left.ultimate_id = right.ultimate_id and
	left.proxid < right.proxid ,
	transform(
		{ds_true_ult.ultimate_id, boolean has_conflict},
		self.has_conflict := exists(join(left.children, right.children, left.proxid = right.proxid)),
		self.ultimate_id := left.ultimate_id
	)
)(has_conflict);

ds_conflicted_ids := 
join(
	ds_true_ult,
	ds_true_ult,
	left.id = right.id and
	left.ultimate_id < right.ultimate_id,
	transform(
		{ds_true_ult.id, boolean has_conflict},
		self.has_conflict := exists(join(left.children, right.children, left.proxid = right.proxid)),
		self.id := left.id
	)
)(has_conflict);

//dups from same ult but with diff proxid.  i expect these to be fragmented hrchys
dups  			:= join(ds_true_ult, ds_true_ult, left.ultimate_id = right.ultimate_id and left.id = right.id and left.src = right.src and left.proxid < right.proxid, transform(left)) : independent;
duped	 			:= sort(ds_true_ult(ultimate_id in set(dedup(dups, ultimate_id, all), ultimate_id)), ultimate_id, src);

fragments		:= join(ds_true_ult, ds_true_ult, left.ultimate_id = right.ultimate_id and left.id < right.id and left.src = right.src, transform(left)) : independent;
fragmented	:= sort(ds_true_ult(ultimate_id in set(dedup(fragments, ultimate_id, all), ultimate_id)), ultimate_id, src);

return 
parallel(
	 output(enth(ds, 100), named('enth_' + s))
	,output(count(ds), named('count_' + s))
	
	,output(enth(ds_true_ult, 100), named('enth_true_ult_' + s))
	,output(count(ds_true_ult), named('count_true_ult_' + s))	
	,output(count(ds_true_ult) - count(dedup(ds_true_ult, ultimate_id, src, all)), named('count_disparity_' + s))	//sanity check
	,output(count(duped), named('count_duped' + s))
	,output(choosen(duped, 100), named('sample_duped_' + s))
	,output(count(fragmented), named('count_fragmented' + s))
	,output(choosen(fragmented, 100), named('sample_fragmented_' + s))
	
	,output(choosen(ds_conflicted_ultids, 100), named('sample_conflicted_ultids_' + s))
	,output(count(ds_conflicted_ultids), named('count_conflicted_ultids_' + s))

	,output(choosen(ds_conflicted_ids, 100), named('sample_conflicted_ids_' + s))
	,output(count(ds_conflicted_ids), named('count_conflicted_ids_' + s))
	
	,output(ave(ds_true_ult, count(children)), named('ave_count_children_' + s))
	,output(max(ds_true_ult, count(children)), named('max_count_children_' + s))
	,output(max(ds_true_ult, max(children, derived_levels_from_top)), named('max_depth_' + s))
	,output(sum(ds_true_ult, count(children)), named('total_count_children_' + s))
);

endmacro;

