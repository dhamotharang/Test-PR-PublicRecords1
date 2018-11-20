//replicates person_models.FN_Clean_Rel_Names for the data layer

import doxie,doxie_raw,dx_BestRecords,ut;
// relrec := recordof(doxie.Relative_Records);

export FN_Clean_Rel_Names(d) := functionmacro 

d_d := distribute(d, hash(did));

// PATCH LOOSELY WHERE THE BEST KEY MISSES
fnr := record
	d.did;
	d.fname;
	cnt := count(group);
end;

fna := dedup(sort(table(d_d, fnr, did, fname), did, -cnt, -fname, local), did, local);

lnr := record
	d.did;
	d.lname;
	cnt := count(group);
end;

lna := dedup(sort(table(d_d, lnr, did, lname), did, -cnt, -lname, local), did, local);

nr := record
	d.did;
	d.fname;
	d.lname;
end;

nr natra(fna l, lna r) := transform
	self.fname := l.fname;
	self.lname := r.lname;
	self := l;
end;

na := join(distribute(fna, hash(did)), distribute(lna, hash(did)), left.did = right.did, natra(left, right), local);

// APPEND BEST RECORD DATA TO RECS
dbst := dx_BestRecords.append(d_d, did, dx_BestRecords.Constants.perm_type.glb, use_distributed := true);

recordof(dbst) patchit(dbst l, na r) := transform
	self._best.fname := if(l._best.fname = '', r.fname, l._best.fname);
	self._best.lname := if(l._best.lname = '', r.lname, l._best.lname);
	self := l;
end;

// PATCH MISSING BEST RECORD NAMES
dpch := join(dbst, na, left.did = right.did, patchit(left, right), left outer, keep(1), local);

// PROJECT TO MY REL RECORDS TO CLEAN THEM UP
pb(string30 n, string30 bestn, string30 othern) := 
	 if((bestn <> '' and UT.stringsimilar(n, bestn) < 3) or 
		stringlib.stringcontains(bestn, n, true) or
		(stringlib.stringcontains(n, bestn, true) and length(bestn) > 2) or
		(UT.stringsimilar100(n, othern) <= 22 and UT.stringsimilar100(n, bestn) >= 50) //when the lname is just a typo of the fname, or vice versa
		,
		bestn,
		n);

d tobest(dbst l) := transform
	self.fname := pb(l.fname, l._best.fname, l.lname);
	self.lname := pb(l.lname, l._best.lname, l.fname);
	self := l;
end;

jb = project(dbst, tobest(left), local);

// IF HYPHENATED, MAKE TWO ROWS FROM IT - actually, the ideal would be to keep the hyphenated and know it is early-late in the details calculator
isHyphenated(string lname) := stringlib.stringfind(lname,'-',1) > 0;
getHalf(string lname, unsigned1 whichHalf) := ut.Word(lname,whichHalf,'-');
jb_split := jb(not isHyphenated(lname)) + 
						// project(jb(isHyphenated(lname)),   //right now, i suspect ill do better with just the second
										// transform(doxie_raw.Layout_HeaderRawOutput,
															// self.lname := getHalf(left.lname, 1),
															// self := left)) +
						project(jb(isHyphenated(lname)), 
										transform(recordof(d),
															self.lname := getHalf(left.lname, 2),
															self := left));

// output(d, named('d'));
// output(jb_split, named('jb_split'));
return jb_split;
endmacro;