v := header.file_headers(header.Blocked_data());

slimrec := record
	v.src;
end;

vslim := table(v, slimrec);

countrec := record
	vslim.src;
	unsigned6 counted := count(group);
end;

vcount := distribute(table(vslim, countrec, src), hash(src));
export Source_Counts_prev := vcount(counted > 10) : persist('header_source_counts_prev');