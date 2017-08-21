export fn_FindDodgyFnameSSN(dataset(header.Layout_Header) h) := function


//SLIM AND DEDUP

rec := record
	h.did;
	h.ssn;
	string2 lname;
	string2 mname;
	string2 fname;
	h.zip;
	h.city_name;
	h.dob;
	h.valid_ssn;
	h.src;
end;

p := dedup(
				 project(h(length(trim(ssn)) = 9), transform(rec,
																				 self.lname := metaphonelib.DMetaPhone1(left.lname)[1..2],
																				 self.mname := metaphonelib.DMetaPhone1(left.mname)[1..2],
																				 self.fname := metaphonelib.DMetaPhone1(left.fname)[1..2],
																				 self.src   := if(left.src = 'LT', 'TU', left.src), //consider LT and TU the same for these purposes
																				 self := left)),
		 all, local);


//CANDIDATES MUST HAVE MULTIPLE SSNS AND MULTIPLE LNAMES

ssns := sort(p, did, ssn, local);
ssnd := dedup(ssns, did, ssn, local);
ssnrec := record
	ssnd.did;
	cnt := count(group);
end;
ssnt := table(ssnd, ssnrec, did, local)(cnt > 1);

lnames := sort(p, did, lname, local);
lnamed := dedup(lnames, did, lname, local);
lnamerec := record
	lnamed.did;
	cnt := count(group);
end;
lnamet := table(lnamed, lnamerec, did, local)(cnt > 1);

canddids := join(ssnt, lnamet, 
						 left.did = right.did, 
						 transform({unsigned6 did},
											 self := left),
						 local);
						 
cand := join(p, canddids, 
						 left.did = right.did, 
						 transform(rec,
											 self := left),
						 local);


//LNAME EXISTS THAT IS CONTAINED COMPLETELY WITHIN ONE SSN 
//THAT SSN IS NOT "GOOD OR OK"
//THAT SSN IS NOT USED BY MULTIPLE SOURCES OUTSIDE OF THAT LNAME

lnames2 := sort(cand, did, lname, ssn, local);
lnamed2 := dedup(lnames2, did, lname, ssn, local);
lnamerec2 := record
	lnamed2.did;
	lnamed2.lname;
	cnt := count(group);
	vs := max(group, lnamed2.valid_ssn);
	ss := max(group, lnamed2.ssn);
end;
lnamet2 := table(lnamed2, lnamerec2, did, lname, local)(cnt = 1 and vs not in ['G','O']);

srcs := sort(cand, did, ssn, lname, src, local);
srcd := dedup(srcs, did, ssn, lname, src, local);
srcrec := record
	srcd.did;
	srcd.ssn;
	srcd.lname;
	cnt := count(group);
end;
srct := table(srcd, srcrec, did, ssn, lname, local);

lnamet2j := join(lnamet2, srct(cnt > 1),
								 left.did = right.did and
								 left.ss = right.ssn and
								 left.lname <> right.lname,
								 transform(lnamerec2, self := left),
								 local,
								 left only);
								 
cand_thename := 
				join(cand, lnamet2j, 
						 left.did = right.did and
						 left.lname = right.lname,
						 transform(rec,
											 self := left),
						 local);

cand_therest := 
				join(cand, lnamet2j, 
						 left.did = right.did and
						 left.lname <> right.lname,
						 transform(rec,
											 self := left),
						 local);



//THAT LNAME HAS NO DOB OR ZIP OVERLAP WITH ANY THE OTHER LNAME
//AND CANNOT BE FOUND IN THE MNAME OR FNAME FIELD

jhit := dedup(
		 join(cand_thename, cand_therest,
				  left.did = right.did and
					(left.zip = right.zip or
					 left.lname = right.mname or
					 left.lname = right.fname or  //wont equal right.lname by definition
					 left.city_name = right.city_name or
					 (left.dob > 0 and left.dob div 10000 = right.dob div 10000)),
						 transform({unsigned6 did},
											 self := left),
						 local), all, local);				

j := dedup(
		 join(cand_thename, jhit,
				  left.did = right.did,
						 transform({unsigned6 did},
											 self := left),
						 local,
						 left only), all, local);						
return j;
end;



