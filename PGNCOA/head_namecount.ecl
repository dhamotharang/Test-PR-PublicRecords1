import header,header_slimsort;

head := header_slimsort.propagated_matchrecs;

namerec := record
	head.fname;
	head.lname;
	head.did;
end;

headname := dedup(table(head, namerec), fname, lname, did, all);

//count the full names
namecountrec := record
	headname.fname;
	headname.lname;
	counted := count(group);
end;

namecount := table(headname, namecountrec, fname, lname);
namedist := distribute(namecount, hash(trim((string)fname), trim((string)lname))) : persist('pgncoa_namecount');

export head_namecount := namedist;