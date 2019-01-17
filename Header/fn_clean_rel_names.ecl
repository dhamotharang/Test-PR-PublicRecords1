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

dx_BestRecords.layout_best patchit(dx_BestRecords.layout_best l, na r) := transform
	self.fname := if(l.fname = '', r.fname, l.fname);
	self.lname := if(l.lname = '', r.lname, l.lname);
	self := l;
end;

// GET RECS FROM THE BEST KEY
bna := dx_BestRecords.append(na, did, dx_BestRecords.Constants.perm_type.glb, use_distributed := true);
br := project(bna, patchit(left._best, left), local);

// JOIN TO MY REL RECORDS TO CLEAN THEM UP
pb(string30 n, string30 bestn, string30 othern) := 
	 if((bestn <> '' and UT.stringsimilar(n, bestn) < 3) or 
		stringlib.stringcontains(bestn, n, true) or
		(stringlib.stringcontains(n, bestn, true) and length(bestn) > 2) or
		(UT.stringsimilar100(n, othern) <= 22 and UT.stringsimilar100(n, bestn) >= 50) //when the lname is just a typo of the fname, or vice versa
		,
		bestn,
		n);

d tobest(d l, br r) := transform
	self.fname := pb(l.fname, r.fname, l.lname);
	self.lname := pb(l.lname, r.lname, l.fname);
	self := l;
end;

jb := join(d_d, br, left.did = right.did, tobest(left, right), left outer, keep(1), local);

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
// output(br, named('br'));
// output(jb_split, named('jb_split'));
return jb_split;
endmacro;