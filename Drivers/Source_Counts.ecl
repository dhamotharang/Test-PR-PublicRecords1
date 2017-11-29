v := drivers.File_Dl;

slimrec := record
	v.source_code;
	v.orig_state;
end;

vslim := table(v, slimrec);

countrec := record
	vslim.source_code;
	vslim.orig_state;
	unsigned6 counted := count(group);
	string2 src := drivers.Header_Src(vslim.source_code,vslim.orig_state);
end;

vcount := distribute(table(vslim, countrec, source_code, orig_state), hash(src));
// export Source_Counts := vcount(counted > 10) : persist('Persist::DrvLic_Source_Counts');
export Source_Counts:=dataset('~thor400_84::persist::drvlic_source_counts',countrec,thor);