export MAC_GetBestNameGlb(outfile, infile, key) := macro
	#uniquename(tra)
	typeof(infile) %tra%(infile l, recordof(key) r) := transform	
		isbest := r.fname <> '';
		self.title := if(isbest, r.title, l.title);
		self.fname := if(isbest, r.fname, l.fname);
		self.mname := if(isbest, r.mname, l.mname);
		self.lname := if(isbest, r.lname, l.lname);
		self.name_suffix := if(isbest, r.name_suffix, l.name_suffix);
		self := l;
	end;

	outfile := join(infile,key, 
		left.did > 0 and 
		keyed(left.did = right.did) and
		right.fname <> '' and right.lname <> '',
		%tra%(left, right), left outer, keep(1));
endmacro;
