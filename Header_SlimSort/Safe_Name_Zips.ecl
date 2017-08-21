import pgncoa, header, ut;
nc := pgncoa.head_namecount(counted <= 50 and counted > 0);
head := header_slimsort.propagated_matchrecs(fname <> '', lname <> '');

head_slim_rec := record
	head.did;
	head.fname;
	head.lname;
	head.zip;
end;

head_slim_rec slimit(head l) := transform
	self := l;
end;

//pull them off and store the_name
headrec := record
	head.did;
	head.fname;
	head.lname;
	head.zip;
	integer namecount;
end;

headrec tra(head_slim_rec l, nc r) := transform
	self.did := l.did;
	self.fname := r.fname;
	self.lname := r.lname;
	self.zip := l.zip;
	self.namecount := r.counted;
end;

//these are all the recs from the header where the person has a rare name
names := join(distribute(project(head, slimit(left)), 
						 hash(trim((string)fname), trim((string)lname))),
			  nc, 
			  left.fname = right.fname and left.lname = right.lname,
			  tra(left, right), local);

names_srtd := sort(names, did, fname, lname, zip, local);
names_ddpd := dedup(names_srtd, did, fname, lname, zip, local);

//count(names_ddpd);
//output(choosen(names_ddpd, 1000));

headrec keepclean(names_ddpd l) := transform
	self := l;
end;

close := join(names_ddpd, names_ddpd, 
			  left.did <> right.did and		
			  left.fname = right.fname and 
			  left.lname = right.lname and 
			  ut.zip_Dist(left.zip, right.zip) < 100,
			  keepclean(left), left only, local);

isn(string a) := a <> '' and stringlib.StringFilterOut(a,'0123456789') = '';

close_better := close(length(trim((string)fname)) > 1, 
					  length(trim((string)lname)) > 1, 
				      not isn(fname),
					  not isn(lname),
					  ut.getLL(zip) <> '');


export Safe_Name_Zips := close_better : persist('persist_hss_safe_name_zips');