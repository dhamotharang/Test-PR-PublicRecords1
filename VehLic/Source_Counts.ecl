v := vehlic.File_Vehicles;

slimrec := record
	v.orig_state;
	v.source_code;
end;

vslim := table(v, slimrec);

countrec := record
	vslim.orig_state;
	vslim.source_code;
	unsigned6 counted := count(group);
	string2 src := vehlic.Header_Src(vslim.orig_state,vslim.source_code);
end;

get_count := table(vslim, countrec, orig_state,source_code,few);

slim_again := record
 get_count.orig_state;
 get_count.counted;
 get_count.src;
end;

vcount := distribute(table(get_count,slim_again),  hash(src));
export Source_Counts := vcount(counted > 10) : persist('vehlic_source_counts');