import ut,header,watchdog; 

export fn_Populate_Matchrecs (
	dataset(layout_header) inf,
	dataset(watchdog.Layout_Best) bestfile0,
	string persist_suffix = '',
	boolean new_version = false,
	boolean skipPreferredFirst = false):= function
	
	inf0 := if(persist_suffix ='_slimsort',header.fn_replace_alias_street(inf).alias_slimsorts , 
					 header.fn_replace_alias_street(inf).alias_header );

	inf1:=fn_void_src_vendor_id(inf0);
	 
	layout_matchcandidates intof(inf1 le) := transform
	    string5   name_suffix_std := header.fn_std_name_suffix_for_linking(le.name_suffix);
	    self.fname := if(skipPreferredFirst, le.fname, datalib.PreferredFirstNew(le.fname, new_version));
		self.mname := if(skipPreferredFirst, le.mname, datalib.PreferredFirstNew(le.mname, new_version));
		self.name_suffix := if(name_suffix_std='',le.dodgy_tracking,name_suffix_std);
		SELF.head_cnt := 1;
		self := le;
	end;

	// strip overly used or bad SSNs from Match_Candidates (MC) 
	new := header.fn_StripNonSSNs(inf1).head;
	me_use1 := project(new,intof(left));

	// strip overly used or bad SSNs from watchdog best
	bestfile := header.fn_StripNonSSNs(inf1).best(bestfile0);

	dist_precount := distribute(me_use1,hash(did));

	// count recs in each did
	cnt_rec := RECORD
		dist_precount.did;
		cnt := COUNT(GROUP);
	END;
	cnt_tab := TABLE(dist_precount, cnt_rec, did, LOCAL);

	layout_matchcandidates tra(layout_matchcandidates le, cnt_tab ri) := TRANSFORM
		SELF.head_cnt := IF(ri.cnt>255,255,ri.cnt);
		SELF := le;
	END;

	// set rec counts in each did to 255 where greater than 255 and append counts to MC
	dist := JOIN(dist_precount, cnt_tab, LEFT.did=RIGHT.did, tra(LEFT,RIGHT), LOCAL);

	layout_matchcandidates prop_mname(layout_matchcandidates le,layout_matchcandidates ri) := transform
		self.mname := if ( (	ri.mname=''
							and ri.fname[1]<>le.mname[1]
							and ri.lname[1]<>le.mname[1])
						or (	length(trim(ri.mname)) = 1
							and ri.mname[1] = le.mname[1])
						,le.mname,ri.mname );
		self := ri;
	end;

	layout_matchcandidates prop_phone(layout_matchcandidates le,layout_matchcandidates ri) := transform
		self.phone := if (ri.phone = '',le.phone,ri.phone);
		self := ri;
	end;

	layout_matchcandidates prop_fname(layout_matchcandidates le,layout_matchcandidates ri) := transform
		self.fname := if ( ri.fname='' or (length(trim(ri.fname)) = 1 and ri.fname[1] = le.fname[1])
						,le.fname,ri.fname );
		self := ri;
	end;

	layout_matchcandidates prop_lname(layout_matchcandidates le,layout_matchcandidates ri) := transform
		self.lname := if ( ri.lname='' or (length(trim(ri.lname)) = 1 and ri.lname[1] = le.lname[1])
						,le.lname,ri.lname );
		self := ri;
	end;

	layout_matchcandidates remove_fraction(layout_matchcandidates le) := transform
		self.prim_range := le.prim_range[1.. length(trim(le.prim_range))-4];
		self := le;
	end;

	layout_matchcandidates remove_lname2nd(layout_matchcandidates le) := transform
		self.lname := mod_hyphenated_lname(le.lname).lname1st;
		self := le;
	end;

	layout_matchcandidates remove_lname1st(layout_matchcandidates le) := transform
		self.lname := mod_hyphenated_lname(le.lname).lname2nd;
		self := le;
	end;

	// propagate the better SSNs throughout ADLs with more than one rec in MC
	sd1 := header.fn_Populate_SSN(dist(head_cnt > 1),bestfile);
	// propagate the better DOBs throughout ADLs with more than one rec in MC
	sd2 := header.fn_populate_dob(sd1,bestfile);
	// group ADLs with more than one rec in MC
	sd3 := group(sort(sd2,did,local),did,local);
	// propagate the larger mname throughout ADLs with more than one rec in MC
	sd5 := iterate(sort(sd3,-mname),prop_mname(left,right));
	// propagate the larger phone throughout ADLs with more than one rec in MC
	sd6 := iterate(sort(sd5,-phone),prop_phone(left,right));
	// propagate the larger lname throughout ADLs with more than one rec in MC
	sd7 := iterate(sort(sd6,-lname),prop_lname(left,right));
	// propagate the larger fname throughout ADLs with more than one rec in MC then add singletons
	sd8 := iterate(sort(sd7,-fname),prop_fname(left,right)) + dist (head_cnt = 1);
	// gather recs with prim_range that looks like "... 1/2" and not "... A/B",etc... from full MC
	sd9	:= sd8	(prim_range[length(trim(prim_range))-1]='/'
				,prim_range[length(trim(prim_range))-3]=' '
				,length(stringlib.stringfilter(
						prim_range[length(trim(prim_range))],'0123456789'))>0
				,length(stringlib.stringfilter(
						prim_range[length(trim(prim_range))-2],'0123456789'))>0
				,length(trim(prim_range))>4);
	// create a copy of gathered recs with fraction part of prim_range striped
	sd10:= project(sd9,remove_fraction(left));
	// append copy of cleaned recs to full MC
	sd11:= sd8 + sd10;
	// gather recs with hyphenated lname from full MC
	sd12:=	sd11(mod_hyphenated_lname(lname).is_hyphenated);
	// create a copy of gathered recs with 2nd part of hyphenated lname striped
	sd13:= project(sd12,remove_lname2nd(left));
	// create a copy of gathered recs with 1st part of hyphenated lname striped
	sd14:= project(sd12,remove_lname1st(left));
	// append copied and cleaned recs to full MC
	sd15:= sd11 + sd13 + sd14;
	// outf1 := distribute(group(dedup(sd15,all)),hash(did));
	outf1 := dedup(distribute(group(sd15),hash(did)),all,local);

	slimrec := record
		outf1.did;
		outf1.lname;
	end;

	slim1 := table(outf1,slimrec,local);
	slim2 := dedup(sort(slim1,did,lname,local),did,lname,local);

	outf1 crosspop(outf1 L, slim2 R) := transform
		self.lname := R.lname;
		self := L;
	end;

	// create a copy of each full MC record with each of the unique lnames per did and avoid creating fname=lname
	outf2 := join(outf1,slim2,left.did=right.did,crosspop(left,right),local);
	outf3 := outf2(fname<>lname) + outf1(fname=lname);

	d := dedup(sort(outf3,record,local),local);
	d_pst := d;

	return if ( header.DoSkipPersist(persist_suffix),d,d_pst);
end;