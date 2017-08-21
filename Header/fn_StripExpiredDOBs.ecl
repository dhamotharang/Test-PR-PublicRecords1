import ut,mdr, address;

export fn_StripExpiredDOBs(
	dataset(header.layout_matchcandidates) mc0,
	dataset(header.Layout_Header) head,
	boolean new_version = false) :=
FUNCTION


//***** REMOVE THE SUFFIXED FROM CONSIDERATION

suff_ssns := dedup(project(head((name_suffix <> '')), {head.ssn}), all);
mc	 := join(mc0, suff_ssns,
					    left.ssn = right.ssn,
							transform(header.layout_matchcandidates,
											  self := left),
							left only,
							lookup);
		
		
//***** REMOVE THE DECEASED FROM CONSIDERATION


dead_ssns := dedup(project(head(MDR.sourceTools.SourceIsDeath(src)), {head.ssn}), all);
mcliv1 := join(distribute(mc,hash(ssn)), distribute(dead_ssns,hash(ssn)),
					    left.ssn = right.ssn,
							transform(header.layout_matchcandidates,
											  self := left),
							left only,
							local);
							
dead_dids := dedup(project(head(MDR.sourceTools.SourceIsDeath(src)), {head.did}), all);
mcliv := join(distribute(mcliv1,hash(did)), distribute(dead_dids,hash(did)),
					    left.did = right.did,
							transform(header.layout_matchcandidates,
											  self := left),
							left only,
							local);


//***** ROLLUP DT BY DID/DOB/SRC AND APPEND TO MATCHRECS

slimrec := record
	mc.did;
	mc.ssn;
	mc.fname;
	mc.dob;
end;

pop := dedup(sort(distribute(project(mcliv, slimrec), 
														 hash(DID)),
									record, local),
						 record, local);
hfh := distribute(head, hash(DID));


rec0 :=
RECORD(pop),
	unsigned3 dob_date;
	STRING2 src;
	hfh.lname;
	hfh.mname;
END;

rec0 get_dob_date(pop le, hfh ri) :=
TRANSFORM
	SELF.dob_date := ri.dt_last_seen;
	SELF.src := ri.src;
	self.lname := ri.lname;
	self.mname := ri.mname;
	SELF := le;
END;

hfh roller(hfh le, hfh ri) :=
TRANSFORM
	SELF.dt_last_seen := ut.max2(le.dt_last_seen,ri.dt_last_seen);
	SELF := le;
END;

fh := ROLLUP(SORT(hfh(dob > 0,(not(src = 'EM' and ut.getageI(dob) < 17))), //should be fixed soon, but we came across voter records with too recent DOBs, so ignore them here
									did,dob,src,LOCAL),
						 roller(LEFT,RIGHT),did,dob,src,LOCAL);


j0 := JOIN(pop(dob > 0, length(trim(ssn)) = 9), fh, 
				  LEFT.did=RIGHT.did AND 
					LEFT.dob[1..4]=RIGHT.dob[1..4], 
					get_dob_date(LEFT,RIGHT), 
					LOCAL);


//****** ACCOUNT FOR THOSE RECORDS WHERE FNAME AND LNAME ARE TRANSPOSED

rec := rec0 -[mname,lname];
j := project(j0, transform(rec, self.fname := left.fname, self := left)) +
     project(j0, transform(rec, self.fname := left.lname, self := left)) +
		 project(j0(length(trim(mname)) > 1), transform(rec, self.fname := left.mname, self := left));
		


//***** TABLE OF FNAME/SSN/DOB RECENCY

set_untrusted := ['LT','TU'];   //these three are more mistake prone wrt DOB

cross :=
RECORD
	j.fname;
	j.ssn;
	j.dob;
	max_date := MAX(GROUP,j.dob_date);
	min_src :=  MIN(GROUP,j.src);
	max_src :=  MAX(GROUP,j.src);	
	boolean hasDeath := 	MAX(GROUP,mdr.sourceTools.SourceIsDeath(j.src));
	boolean hasDL := 			MAX(GROUP,mdr.sourceTools.SourceIsDL(j.src));
	boolean hasTrusted := MAX(GROUP,j.src not in set_untrusted);
	cnt := COUNT(GROUP);
END;

jdist := distribute(j, hash(fname, ssn));
jsort := sort(jdist, fname, ssn, dob, src, -dob_date, local);
jddp  := dedup(jsort, fname, ssn, dob, src, local);

tab_both0 := TABLE(jddp,cross,fname,ssn,dob,local)(not hasDeath and not hasDL);


//***** DISALLOW THOSE WITH MORE THAN TWO YOBS WITHIN A SSN/FNAME BECAUSE THEY LEAD TO OVERCOLLAPSES

yob_ddp := dedup(tab_both0,fname,ssn,dob[1..4],local);

yobrec := record
	tab_both0.ssn;
	tab_both0.fname;
	cnt := count(group);
end;

yob_cnt := table(yob_ddp, yobrec, ssn, fname, local);
tab_both := join(tab_both0, yob_cnt(cnt > 2),
							   left.ssn = right.ssn and
								 left.fname = right.fname,
								 transform(cross, self := left),
								 left only,
								 local);
						

//***** REMOVE BY SSN/FNAME THOSE DOBS THAT WE FOUND TO BE EXPIRED
//		  CURRENTLY, EXPIRED IS DEFINED AS ONLY OCCURING IN SET_UNTRUSTED SOURCES

tab2 := tab_both(not hasTrusted);

return join(distribute(mc0(ssn <> ''), hash(fname, ssn)), dedup(project(tab2, {tab2.ssn, tab2.fname, tab2.dob}), all, local),
						left.ssn = right.ssn and
						left.fname = right.fname and
						left.dob = right.dob,
					  transform(header.layout_matchcandidates,
										  self.dob := if(right.dob > 0, 0, left.dob);
											self := left),
						left outer,
						local
						) +
				mc0(ssn = '');
	

END;