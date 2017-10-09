import ut,AutoStandardI,bipv2,bipv2_build,tools;

EXPORT key_Status := 
MODULE

	h := PRTE2_BIPV2_BusHeader.File_DS_CLEAN;
	rec := {h.ultid, h.orgid, h.seleid,h.proxid, h.source, h.company_status_derived, h.dt_first_seen, h.dt_last_seen, h.dt_vendor_first_reported, h.dt_vendor_last_reported};
	p := project(
		h,
		transform(
			rec,
			self := left
		)
	);

	d := dedup(p, all) ;

	rec xroll(rec l, rec r) := transform
		ut.mac_roll_DFS(dt_first_seen)
		ut.mac_roll_DFS(dt_vendor_first_reported)
		ut.mac_roll_DLS(dt_last_seen)
		ut.mac_roll_DLS(dt_vendor_last_reported)		
		self := l
	end;

	r := 
	rollup(
		sort(d, ultid, orgid, seleid, proxid, source, company_status_derived),
		xroll(left, right),
		ultid, orgid, seleid, proxid, source, company_status_derived
	);

	// lksd.oc(d)
	// lksd.oc(r)
  kname := PRTE2_BIPV2_BusHeader.keynames().status.qa;
  
  EXPORT lkey(string pversion = 'qa',boolean puseotherenvironment  = false) := tools.macf_FilesIndex('r,',PRTE2_BIPV2_BusHeader.keynames(pversion,puseotherenvironment).status);
  
	i := lkey().qa; //use qa version
	// index(r,,kname);

	export key := i;

	//DEFINE THE INDEX ACCESS
	export kFetch_unrestricted(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt)
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out_unrestricted, Level)		
		//was briefly doing restrictions here, but moved it down into BIPV2.mac_AddStatus so i could utilize the dates for an activity decision first
		return out_unrestricted			;		
	END;

END;
