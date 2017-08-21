import AutoStandardI, did_add, Header_SlimSort, didville, ut, Business_Header_SS, Business_Header,
			 Patriot, Doxie;

export ID_Function(DATASET(FloridaDFS.Layout_ID_Batch) full_layout, boolean glb_ok=false, string32 appType) :=

FUNCTION

mac_watchequalri() := macro
	self.watchlist.source := ri.source;
	self.watchlist.orig_pty_name := ri.orig_pty_name;
	self.watchlist.orig_vessel_name := ri.orig_vessel_name;
	self.watchlist.addr_1 := ri.addr_1;
	self.watchlist.addr_2 := ri.addr_2;
	self.watchlist.addr_3 := ri.addr_3;
	self.watchlist.addr_4 := ri.addr_4;
	self.watchlist.addr_5 := ri.addr_5;
	self.watchlist.addr_6 := ri.addr_6;
	self.watchlist.addr_7 := ri.addr_7;
	self.watchlist.addr_8 := ri.addr_8;
	self.watchlist.addr_9 := ri.addr_9;
	self.watchlist.addr_10 := ri.addr_10;
	self.watchlist.remarks_1 := ri.remarks_1;
	self.watchlist.remarks_2 := ri.remarks_2;
	self.watchlist.remarks_3 := ri.remarks_3;
	self.watchlist.remarks_4 := ri.remarks_4;
	self.watchlist.remarks_5 := ri.remarks_5;
	self.watchlist.remarks_6 := ri.remarks_6;
	self.watchlist.remarks_7 := ri.remarks_7;
	self.watchlist.remarks_8 := ri.remarks_8;
	self.watchlist.remarks_9 := ri.remarks_9;
	self.watchlist.remarks_10 := ri.remarks_10;
	self.watchlist.remarks_11 := ri.remarks_11;
	self.watchlist.remarks_12 := ri.remarks_12;
	self.watchlist.remarks_13 := ri.remarks_13;
	self.watchlist.remarks_14 := ri.remarks_14;
	self.watchlist.remarks_15 := ri.remarks_15;
	self.watchlist.remarks_16 := ri.remarks_16;
	self.watchlist.remarks_17 := ri.remarks_17;
	self.watchlist.remarks_18 := ri.remarks_18;
	self.watchlist.remarks_19 := ri.remarks_19;
	self.watchlist.remarks_20 := ri.remarks_20;
	self.watchlist.remarks_21 := ri.remarks_21;
	self.watchlist.remarks_22 := ri.remarks_22;
	self.watchlist.remarks_23 := ri.remarks_23;
	self.watchlist.remarks_24 := ri.remarks_24;
	self.watchlist.remarks_25 := ri.remarks_25;
	self.watchlist.remarks_26 := ri.remarks_26;
	self.watchlist.remarks_27 := ri.remarks_27;
	self.watchlist.remarks_28 := ri.remarks_28;
	self.watchlist.remarks_29 := ri.remarks_29;
	self.watchlist.remarks_30 := ri.remarks_30;
endmacro;



fz := 'G4Z';
to_did_append := PROJECT(full_layout,TRANSFORM(didville.Layout_Did_OutBatch,SELF := LEFT));


didville.MAC_DidAppend(to_did_append,resu,TRUE,fz,FALSE)

industryClass := AutoStandardI.InterfaceTranslator.industry_class_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.industry_class_val.params));

didville.MAC_BestAppend(resu,
												'',
												'BEST_ALL',
												0,
												glb_ok,
												best_apt,
												false,
												Doxie.DataRestriction.fixed_DRM,
												,
												,
												,
												,
												appType,
												,
												industryClass)

FloridaDFS.Layout_ID_Batch addPerBack(FloridaDFS.Layout_ID_Batch le, best_apt ri) :=
TRANSFORM
	SELF.EntityType := IF(ri.did<>0,'P','');
	SELF := ri;
	SELF := le;
END;
j1 := JOIN(full_layout,best_apt,LEFT.seq=RIGHT.seq,addPerBack(LEFT,RIGHT),LOOKUP);

Business_Header_SS.Layout_BDID_InBatch toBdid(FloridaDFS.Layout_ID_Batch le) :=
TRANSFORM
	SELF.company_name := le.name;
	SELF := le;
END;
to_bdid_append := PROJECT(j1(did=0), toBdid(LEFT));

// HACK: Mac_Filter_Matches inside of BDID_Append needs these values;
mile_radius_value := 0;
bh_zip_value := [];
business_header_ss.MAC_BDID_Append(to_bdid_append, resu2, 50, 1, true)
Business_Header_SS.MAC_BestAppend(resu2, '', 'BEST_ALL', best_res, true)

FloridaDFS.Layout_ID_Batch addCoBack(FloridaDFS.Layout_ID_Batch le, resu2 ri) :=
TRANSFORM
	SELF.bdid := ri.bdid;
	SELF.score := IF(ri.bdid<>0,ri.score,le.score);
	SELF.EntityType := IF(ri.bdid<>0,'C',le.EntityType);
	SELF.verify_best_phone := IF(ri.bdid<>0,ri.verify_best_phone,le.verify_best_phone);
  SELF.verify_best_ssn := IF(ri.bdid<>0,ri.verify_best_fein,le.verify_best_ssn);
  SELF.verify_best_address := IF(ri.bdid<>0,ri.verify_best_address,le.verify_best_address);
  SELF.verify_best_name := IF(ri.bdid<>0,ri.verify_best_CompanyName,le.verify_best_name);
  SELF.verify_best_dob := IF(ri.bdid<>0,255,le.verify_best_dob);
	SELF := le;
END;
j2 := JOIN(j1,best_res,LEFT.seq=RIGHT.seq,addCoBack(LEFT,RIGHT),LOOKUP,LEFT OUTER);

// Patriot Stuff
idd := GROUP(j2,seq);

// Given a DID, do this
FloridaDFS.Layout_ID_Batch ap(FloridaDFS.Layout_ID_Batch le,patriot.Key_Baddids_with_name ri) := transform
	self.number_with_same_name := ri.other_count;
	self.first_seen := ri.first_seen;
	self.relative_count := ri.rel_count;
	self.known := true;
	self.name_match := ri.did<>0;
	self.name_match_fname := ri.fname;
	self.name_match_mname := ri.mname;
	self.name_match_lname := ri.lname;
	self := le;
	end;
route_1a := join(idd(did<>0),patriot.Key_Baddids_with_name,left.did=right.did,ap(left,right),left outer);

myNameMatch(STRING20 lfname,STRING20 lmname,STRING20 llname,
						STRING20 rfname,STRING20 rmname,STRING20 rlname) :=
			ut.max2(0,100-10*datalib.namematch(lfname,lmname,llname,
																							rfname,rmname,rlname));

myCompanyMatch(STRING lname, STRING rname) :=
			ut.max2(0,100-10*ut.CompanySimilar(lname,rname));

FloridaDFS.Layout_ID_Batch getPatriotDid(FloridaDFS.Layout_ID_Batch le, patriot.key_did_patriot_file ri) :=
TRANSFORM
	// Tighten if the input name isn't the one that matches at all
	potNameMatch := myNameMatch(le.fname,le.mname,le.lname,
																							ri.fname,ri.mname,ri.lname);
	potBestNameMatch := myNameMatch(
																	le.name_match_fname,le.name_match_mname,le.name_match_lname,
																	ri.fname,ri.mname,ri.lname);
	isaGoodMatch := potNameMatch >= 70 OR (potBestNameMatch >= 90);

	// So, if the tighter test doesn't pass, pretend like there was no match
	//SELF.WatchList := ri;
	mac_watchequalri()
	self.name_match_score :=  IF(ri.did<>0/* AND isaGoodMatch*/,
														myNameMatch(le.fname,le.mname,le.lname,
																							ri.fname,ri.mname,ri.lname),0);
	self.best_name_match_score := IF(ri.did<>0/* AND isaGoodMatch*/,
																myNameMatch(
																	le.name_match_fname,le.name_match_mname,le.name_match_lname,
																	ri.fname,ri.mname,ri.lname),0);
	SELF.name_match := isaGoodMatch;
	/*
	self.number_with_same_name := 0;
	self.first_seen := 0;
	self.relative_count := 0;
	self.name_match_fname := '';
	self.name_match_mname := '';
	self.name_match_lname := '';
	*/
	SELF := le;
END;
route_1b := join(route_1a,patriot.key_did_patriot_file,KEYED(LEFT.did=RIGHT.did),getPatriotDid(LEFT,RIGHT),LEFT OUTER);

route_1_rolled := DEDUP(SORT(route_1b,-best_name_match_score,-name_match_score),true);

// Given no DID, try this
FloridaDFS.Layout_ID_Batch getPatriotBdid(FloridaDFS.Layout_ID_Batch le, patriot.key_bdid_patriot_file ri) :=
TRANSFORM
	SELF.known := le.bdid<>0;
	SELF.name_match := ri.bdid<>0;
	self.name_match_score := IF(ri.bdid<>0,myCompanyMatch(le.name,	ri.cname),0);
	self.best_name_match_score := self.name_match_score; // no DID, so it always the same
	//SELF.WatchList := ri;
	mac_watchequalri()
	SELF := le;
END;
	// First, try BDID match
route_2 := join(idd(did=0),patriot.key_bdid_patriot_file,
												LEFT.bdid<>0 AND
												KEYED(LEFT.bdid=RIGHT.bdid),getPatriotBdid(LEFT,RIGHT),LEFT OUTER,KEEP(1));

	// Then, try pure fuzzy
FloridaDFS.Layout_ID_Batch nm(FloridaDFS.Layout_ID_Batch le,patriot.key_badnames ri) := transform
	self.number_with_same_name := ri.cnt;
	self := le;
end;       
route_3a := join(route_2(~name_match),patriot.key_badnames,
									left.fname=right.fname and
									left.mname=right.mname and left.lname=right.lname,
									nm(left,right),left outer);
route_3_rolled := DEDUP(SORT(route_3a,-number_with_same_name),true);

key_patriot_file := TABLE(patriot.key_patriot_file, {pty_key, fname, mname, lname, cname});

FloridaDFS.Layout_ID_Batch check_bads(FloridaDFS.Layout_ID_Batch le, key_patriot_file ri) := transform
  SELF.pty_key := ri.pty_key;
	self.name_match := ri.pty_key<>'';
	self.name_match_score := IF(ri.pty_key<>'', myNameMatch(le.fname,le.mname,le.lname,
																													ri.fname,ri.mname,ri.lname), 0);
	self.best_name_match_score := self.name_match_score; // no DID, so it always the same
	SELF := le;
end;

route_3b := join(route_3_rolled,key_patriot_file,
					patriot.namecheck(left.fname,left.mname,left.lname,right.fname,right.mname,right.lname) < 3,
					check_bads(LEFT,RIGHT),left outer,all,KEEP(1));

FloridaDFS.Layout_ID_Batch check_bad_co(FloridaDFS.Layout_ID_Batch le, key_patriot_file ri) :=
TRANSFORM
  SELF.pty_key := ri.pty_key;
	SELF.number_with_same_name := 0;
	SELF.name_match := ri.pty_key<>'';
	SELF.name_match_score := IF(ri.pty_key<>'',myCompanyMatch(le.name,ri.cname),0);
	SELF.best_name_match_score := SELF.name_match_score; // no DID, so it always the same
	SELF := le;
END;

route_3c := join(route_3b(~name_match),key_patriot_file,
																								ut.CompanySimilar(LEFT.name,RIGHT.cname)<3,
																								check_bad_co(LEFT,RIGHT),left outer,all,KEEP(1));

// Add in watch list info where we found it
FloridaDFS.Layout_ID_Batch addWatchList(FloridaDFS.Layout_ID_Batch le, Patriot.key_patriot_file ri) :=
TRANSFORM
	//SELF.WatchList := ri;
	mac_watchequalri()
	SELF := le;
END;

routes_3b3c := JOIN(route_3b(name_match)+route_3c, Patriot.key_patriot_file, 
  LEFT.pty_key != '' AND KEYED(LEFT.pty_key=RIGHT.pty_key) AND
	(LEFT.name_match_score=myCompanyMatch(LEFT.name,RIGHT.cname) OR
		LEFT.name_match_score=myNameMatch(LEFT.fname,LEFT.mname,LEFT.lname,
																			RIGHT.fname,RIGHT.mname,RIGHT.lname)), addWatchList(LEFT, RIGHT), LEFT OUTER,KEEP(1));

allChecked := route_1_rolled+route_2(name_match)+routes_3b3c;

RETURN allChecked;

END;