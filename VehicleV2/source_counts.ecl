import vehlic;

v := vehiclev2.file_vehicleV2_party;

slimrec := record
	v.state_origin;
	v.source_code;
end;

vslim := table(v, slimrec);

countrec := record
	vslim.state_origin;
	vslim.source_code;
	unsigned6 counted := count(group);
	string2 src       := vehlic.Header_Src(vslim.state_origin,vslim.source_code);
end;

get_count := table(vslim,countrec,state_origin,source_code,few);

slim_again := record
 get_count.state_origin;
 get_count.counted;
 get_count.src;
end;

vcount := distribute(table(get_count,slim_again),  hash(src));
export Source_Counts := vcount(counted > 10) : persist('vehlic_source_counts');