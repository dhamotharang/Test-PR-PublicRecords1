import ut,doxie,header, mdr, suppress ;

export fn_ADLSegmentation(dataset(header.Layout_Header) hdr_in, boolean isFCRA = FALSE )  := module

	hdr_adl_in := header.regulatory.apply_ADL_Segment(hdr_in); 
		
	f_ := distribute(hdr_adl_in, hash(did));

	slimr :=
	RECORD
		f_.did;
		f_.dt_last_seen;
		f_.dt_first_seen;
		f_.ssn;
		f_.jflag2;
		f_.prim_name;
		unsigned cnt := 1;
		STRING10 ind := '';
	END;
	f := TABLE(distributed(f_,hash(did)),slimr);

	// Just get all DIDs
	f roller(f le,f ri) :=
	TRANSFORM
		SELF.dt_last_seen := max(le.dt_last_seen,ri.dt_last_seen);
		SELF.dt_first_seen := ut.Min2(le.dt_first_seen,ri.dt_first_seen);
		SELF.ssn := IF(le.ssn<>'',le.ssn,ri.ssn);
		SELF.jflag2 := IF(le.jflag2<>'',le.jflag2,ri.jflag2);
		SELF.cnt := le.cnt + ri.cnt;
		SELF := le;
	END;
	rollem := ROLLUP(SORT(f, did, local),LEFT.DID=RIGHT.DID,roller(LEFT,RIGHT), LOCAL);
	
	latest_dt_rec := RECORD
		rollem.dt_last_seen;
		cnt := count(group);
	END;
	
	latest_date_table := table(sort(distribute(rollem,hash(dt_last_seen)),dt_last_seen,local),latest_dt_rec,dt_last_seen,local);
	
	latest_date := ((string6) max(latest_date_table(cnt>1000),dt_last_seen))+ '01';
	

	// Known Dead
	slimr deadtra(slimr le, header.File_Did_Death_Masterv3 ri) :=
	TRANSFORM
		SELF.ind := IF(le.did=(unsigned6)ri.did,'DEAD','');
		SELF := le
	END;
	df := DEDUP(SORT(DISTRIBUTE(IF (isFCRA,header.File_Did_Death_Masterv3((src in mdr.sourceTools.set_scoring_FCRA) and (src not in mdr.sourceTools.set_scoring_FCRA_retro_test)), header.File_Did_Death_Masterv3), HASH((unsigned6)did)),did,local),did,local);
	dead_check := join(rollem,df,LEFT.did=(unsigned)RIGHT.did,deadtra(LEFT,RIGHT),LEFT OUTER,LOCAL);

	// Bad Data
	h1 := DEDUP(SORT(f(ind=''),did,prim_name,-dt_last_seen,local),did,prim_name,local);

	r :=
	RECORD
		f.prim_name;
		max_date := max(GROUP,h1.dt_last_seen);
	END;
		// Get every street name and the last time we saw it
	t := TABLE(h1,r,prim_name,few);
		// Take the list of old street names - we'll take thse as "bad"
	old_addr := distribute(t(ut.DaysApart(((STRING6)max_date)+'01',latest_date)>18*30),hash(prim_name));
		// Get the list of header records that have good street names
	j := JOIN(distribute(f(prim_name<>''),hash(prim_name)),old_addr,LEFT.prim_name=RIGHT.prim_name,LEFT ONLY, local);
	dj := DEDUP(SORT(DISTRIBUTE(j,HASH(did)),did,LOCAL),did,LOCAL);
		// Given list of DIDs that exist after removing bad data
		// just take those
	slimr wobaddatatra(slimr le, dj ri) :=
	TRANSFORM
		SELF.ind := IF(le.ind='' AND ri.did=0,'NOISE',le.ind);
		SELF := le;
	END;
	baddata_check := JOIN(dead_check, dj, LEFT.did=RIGHT.did,wobaddatatra(LEFT,RIGHT),LEFT OUTER,LOCAL);

	// Historical Merge-Candidate Identities
	slimr antra(slimr le) :=
	TRANSFORM
		SELF.ind := IF(le.ind='' AND 
						ut.DaysApart(latest_date, le.dt_last_seen+'01')>24*30 AND le.cnt=1, 'H_MERGE',le.ind);
		SELF := le;
	END;
	histMerge_check := PROJECT(baddata_check, antra(LEFT));

	// Current Merge-Candidate Identities
	slimr cmtra(slimr le) :=
	TRANSFORM
		SELF.ind := IF(le.ind='' AND le.cnt=1, 'C_MERGE', le.ind);
		SELF := le;
	END;
	currMerge_check := PROJECT(histMerge_check, cmtra(LEFT));

	// Inactive Identities
	slimr iatra(slimr le) :=
	TRANSFORM
		SELF.ind := IF(le.ind='' AND 
					(ut.DaysApart(latest_date, le.dt_last_seen+'01') > 24*30), 'INACTIVE', le.ind);
		SELF := le;
	END;
	inactive_check := PROJECT(currMerge_check, iatra(LEFT));

	// Known Ambiguous
	slimr ambtra(slimr le) :=
	TRANSFORM
		SELF.ind := IF(le.ind='' AND 
					(le.jflag2<>''), 'AMBIG', le.ind);
		SELF := le;
	END;
	amb_check := PROJECT(inactive_check, ambtra(LEFT));

	// No SSN
	slimr nstra(slimr le) :=
	TRANSFORM
		SELF.ind := IF(le.ind='' AND 
					(le.ssn=''), 'NO_SSN', le.ind);
		SELF := le;
	END;
	ssn_check := PROJECT(amb_check, nstra(LEFT)); 

	slimr core(slimr le):=
	TRANSFORM
		self.ind := IF(le.ind='','CORE',le.ind);
		self := le;
	END;
	
export	core_check := project(ssn_check, core(LEFT));
export  core_check_pst := core_check : persist('persist::adl_segmentation');

cross :=
RECORD
	core_check.ind;
	cnt := COUNT(GROUP);
END;

export tab := TABLE(core_check, cross, ind, FEW);
//output(SORT(tab,ind),named('AdlSegmentation_Table'));

END;