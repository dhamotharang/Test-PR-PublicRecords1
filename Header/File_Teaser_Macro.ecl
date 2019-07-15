export File_Teaser_Macro(teaserInFile, teaserOutFile, is_watchdog_best = 'true') := MACRO
	import AutoStandardI,ut,suppress,doxie_files,infutor;

	// filter probation data
	hdrNonProb := teaserInFile(mdr.sourcetools.sourceisonprobation(src)=false);

	// filter dppa data
	hdrNonDPPA := hdrNonProb(~mdr.Source_is_DPPA(src));

	// remove ambiguous records that get removed from the header search keys
	hdrNonAmbig := hdrNonDPPA(jflag2 not in ['A','B','D','E']);

	// should only contain alphas and allowable name punctuation, and optionally be tested for non-blank
	isValidStr(string str, boolean emptyOK = false) := (emptyOK or length(trim(str)) > 0) 
																									and str = stringlib.stringfilter(str, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ -');

	// need to allow for empty state values that come from death records,
	// but require populated name fields 
	hdrClean := hdrNonAmbig(isValidStr(st, true) and isValidStr(lname) and isValidStr(fname));

	// remove all of the records for minors
	minors := distribute(header.File_minors, hash(did));
	hdrAdult := join(hdrClean, minors, left.did = right.did and ut.GetAgeI(right.dob) < 18, transform(left), 
									 left only, local);

	appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
	Suppress.MAC_Suppress(hdrAdult,pulled_ssn,appType,Suppress.Constants.LinkTypes.SSN,ssn);
	Suppress.MAC_Suppress(pulled_ssn,hdrPullSsnDid,appType,Suppress.Constants.LinkTypes.DID,did);

	hdrSlim := project(hdrPullSsnDid, layout_teaser);

	// look up DOD from death master
	dm := Header.File_DID_Death_MasterV2((integer)did <>0, (integer)dod8 <> 0);

	layout_dm_lite := record
		unsigned6 did;
		integer4 dod;
	end;
	dm_lite := project(dm, transform(layout_dm_lite, 
																	 self.did := (unsigned6) left.did, 
																	 self.dod := (integer4) left.dod8));
	dm_dist := distribute(dm_lite, hash(did));
	dm_uniq := dedup(sort(dm_dist, did, dod, local), did, dod, local);
  
	layout_teaser getDOD(layout_teaser l, layout_dm_lite r) := transform
		self.dod := r.dod;
		self := l;
	end;
	
	hdrDeath := join(hdrSlim, dm_uniq, left.did = right.did, getDOD(left, right),left outer, local);
	
	hdrTbl := table(hdrDeath, {hdrDeath.did, cnt := COUNT(GROUP)}, did, local);
	hdrCnts := join(hdrDeath, hdrTbl, left.did = right.did, transform(layout_teaser, self.totalRecords := right.cnt; 
																																									 self := left),local);

	hdrGrp := group(sort(hdrCnts, did, local), did, local);

	// mnames are same if nneq or if either is an initial match for the first char of the other
	nneq_mname(string l, string r) := l='' or r='' or l=r or l = r[1] or r = l[1];

	hdrGrp roll(hdrGrp l, hdrGrp r) := transform
		self.mname := if(length(l.mname) > length(r.mname), l.mname, r.mname);
		self.dt_last_seen := max(l.dt_last_seen,r.dt_last_seen);
		self.dt_vendor_last_reported := max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		self := l;
	end;
	
	// get unique name/address combinations per DID
	hdrUniqNameAddr := rollup(sort(hdrGrp,prim_name, city_name, st, zip, lname, fname, mname),
									 				 left.prim_name = right.prim_name and
													 left.city_name = right.city_name and
													 left.st = right.st and
													 left.zip = right.zip and
													 left.lname = right.lname and
													 left.fname = right.fname and
													 nneq_mname(left.mname,right.mname),roll(LEFT,RIGHT));
															
	// need to determine the best/most current address per DID and mark it differently than
	// the remaining addresses 
	// a match on best address is first priority, then recency
	infutor_best := table(pull(infutor.key_infutor_best_did), {did,lname, fname, mname, prim_name, city_name,st, zip, dob});
    wdog_best := table(pull(Watchdog.key_watchdog_nonglb_nonblank), {did,lname, fname, mname, prim_name, city_name,st, zip, dob});

	wdog := if(is_watchdog_best, wdog_best, infutor_best);
	wdog_dist := distribute(wdog, hash(did));

	layout_teaser getBest(hdrUniqNameAddr l, wdog_dist r) := transform
		// mark the matching address as best
		self.bestAddr := r.did <> 0 and l.prim_name = r.prim_name and l.city_name = r.city_name and
										 l.st = r.st and l.zip = r.zip;
		// calculate the sort criterion to use for putting the best name at the top
		// prefer last name, then fname, then mname
		self.nameOrder := IF(l.lname=r.lname,4,0) + IF(l.fname=r.fname,2,0) + IF(l.mname=r.mname,1,0);
		// use the best DOB for all records if matched
		self.dob := if(r.did<>0,r.dob,l.dob);
		self := l;
	end;
	
	hdrAddrBest := join(hdrUniqNameAddr, wdog_dist,left.did = right.did,  
													getBest(left, right), left outer, local);
													
	hdrAddrSorted := group(sort(ungroup(hdrAddrBest), did, -(bestAddr), -dt_last_seen, record, local), did, local);

	layout_teaser markCurrent(layout_teaser l, layout_teaser r) := transform
		// mark all of the bestAddress records as current, or in lieu of any bestAddresses, 
		// mark the most recent one current (first pass in each group iterated)
		self.isCurrent := l.did = 0 or r.bestAddr;
		self := r;
	end;

	teaserOutFile := iterate(hdrAddrSorted, markCurrent(left, right));

ENDMACRO;