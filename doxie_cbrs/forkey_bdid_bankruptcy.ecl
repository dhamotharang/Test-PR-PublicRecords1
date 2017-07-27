import bankrupt;

mf := bankrupt.file_bk_main;
bdids_file := Bankrupt.file_bk_search((integer)bdid > 0);

//slim the bdids for join
bdids_rec := record
	bdids_file.case_number;
	bdids_file.bdid;
end;

bf := table(bdids_file, bdids_rec);


//get my bdids on the main file
outrec := record
	unsigned6 bdid;
	mf;
end;

outrec addbdid(mf l, bf r) := transform
	self.bdid := (unsigned6)r.bdid;
	self := l;
end;

wbdid := join(mf, bf, left.case_number = right.case_number, addbdid(left, right), hash);

export forkey_bdid_bankruptcy := wbdid;