import ut,doxie,header, mdr,prte2_death_master;

export ADL_Segmentation(dataset(header.Layout_Header) in_header, boolean isFCRA = FALSE )  := module
	slimr :=	RECORD
		in_header.did;
		in_header.dt_last_seen;
		in_header.dt_first_seen;
		in_header.ssn;
		in_header.jflag2;
		in_header.prim_name;
		unsigned cnt := 1;
		STRING10 ind := '';
	END;
	f := TABLE(in_header,slimr);

	f roller(f le,f ri) := 	TRANSFORM
		SELF.dt_last_seen := max(le.dt_last_seen,ri.dt_last_seen);
		SELF.dt_first_seen := ut.Min2(le.dt_first_seen,ri.dt_first_seen);
		SELF.ssn := IF(le.ssn<>'',le.ssn,ri.ssn);
		SELF.jflag2 := IF(le.jflag2<>'',le.jflag2,ri.jflag2);
		SELF.cnt := le.cnt + ri.cnt;
		SELF := le;
	END;
	rollem := ROLLUP(SORT(f, did),LEFT.DID=RIGHT.DID,roller(LEFT,RIGHT));
	
	latest_dt_rec := RECORD
		rollem.dt_last_seen;
		cnt := count(group);
	END;
	
	latest_date_table := table(sort(rollem,dt_last_seen),latest_dt_rec,dt_last_seen);
	
	latest_date := ((string6) max(latest_date_table(cnt>1000),dt_last_seen))+ '01';
	
	slimr deadtra(slimr le, prte2_death_master.Files.File_DeathMaster_Building ri) := TRANSFORM
		SELF.ind := IF(le.did=(unsigned6)ri.did,'DEAD','');
		SELF := le
	END;
	df := DEDUP(SORT(	IF (	isFCRA,
						prte2_death_master.Files.File_DeathMaster_Building((src in mdr.sourceTools.set_scoring_FCRA) and (src not in mdr.sourceTools.set_scoring_FCRA_retro_test)), 
						prte2_death_master.Files.File_DeathMaster_Building),
					did),
		       did);
	dead_check := join(rollem,df,LEFT.did=(unsigned)RIGHT.did,deadtra(LEFT,RIGHT),LEFT OUTER);

	h1 := DEDUP(SORT(f(ind=''),did,prim_name,-dt_last_seen),did,prim_name);

	r := RECORD
		f.prim_name;
		max_date := max(GROUP,h1.dt_last_seen);
	END;
	
	t := TABLE(h1,r,prim_name,few);

	old_addr := t(ut.DaysApart(((STRING6)max_date)+'01',latest_date)>18*30);

	j := JOIN(f(prim_name<>''),
			old_addr,
			LEFT.prim_name=RIGHT.prim_name,
			LEFT ONLY);
	dj := DEDUP(SORT(j,did),did);
	slimr wobaddatatra(slimr le, dj ri) := 	TRANSFORM
		SELF.ind := IF(le.ind='' AND ri.did=0,'NOISE',le.ind);
		SELF := le;
	END;
	baddata_check := JOIN(dead_check, dj, LEFT.did=RIGHT.did,wobaddatatra(LEFT,RIGHT),LEFT OUTER);

	slimr antra(slimr le) := TRANSFORM
		SELF.ind := IF(le.ind='' AND 
						ut.DaysApart(latest_date, le.dt_last_seen+'01')>24*30 AND le.cnt=1, 'H_MERGE',le.ind);
		SELF := le;
	END;
	histMerge_check := PROJECT(baddata_check, antra(LEFT));

	slimr cmtra(slimr le) := TRANSFORM
		SELF.ind := IF(le.ind='' AND le.cnt=1, 'C_MERGE', le.ind);
		SELF := le;
	END;
	currMerge_check := PROJECT(histMerge_check, cmtra(LEFT));
	
	slimr iatra(slimr le) := 	TRANSFORM
		SELF.ind := IF(le.ind='' AND 
					(ut.DaysApart(latest_date, le.dt_last_seen+'01') > 24*30), 'INACTIVE', le.ind);
		SELF := le;
	END;
	inactive_check := PROJECT(currMerge_check, iatra(LEFT));

	slimr ambtra(slimr le) := TRANSFORM
		SELF.ind := IF(le.ind='' AND 
					(le.jflag2<>''), 'AMBIG', le.ind);
		SELF := le;
	END;
	amb_check := PROJECT(inactive_check, ambtra(LEFT));

	slimr nstra(slimr le) := TRANSFORM
		SELF.ind := IF(le.ind='' AND 
					(le.ssn=''), 'NO_SSN', le.ind);
		SELF := le;
	END;
	
	ssn_check := PROJECT(amb_check, nstra(LEFT)); 

	slimr core(slimr le):= 	TRANSFORM
		self.ind := IF(le.ind='','CORE',le.ind);
		self := le;
	END;
	
	export	core_check := project(ssn_check, core(LEFT));
	

END;