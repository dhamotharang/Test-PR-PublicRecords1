import mdr, drivers, ut, driversV2;

export Boca_Shell_DL_FCRA (GROUPED DATASET(Layout_Output) iid,
                           boolean isLN, unsigned1 dppa, boolean dppa_ok) := function

KDL	:= driversV2.Key_BocaShell_DL_FCRA;

dlrec := RECORD
	unsigned6 seq;
	UNSIGNED4 Issue_date;
	UNSIGNED4 Expire_date;
	UNSIGNED1 NADL;
	STRING14 dl_number;
	BOOLEAN dl_matched; // D=DID, ''
	iid.fname;
	iid.lname;
	iid.prim_name;
	iid.prim_range;
	iid.sec_range;
	iid.z5;	
END;

match_rec := record
	boolean	Match;
end;

layout_addr := record
	qstring28	prim_name;
	qstring10	prim_range;
	qstring8	sec_range;
	qstring5	zip;
end;

layout_name := record
	qstring20	fname;
	qstring20	lname;
end;

match_rec match_fname(layout_name L, string20 fname) := transform
	fname_match := g(Risk_Indicators.FnameScore(l.fname,fname));	
	self.match := fname_match;
end;

match_rec match_lname(layout_name L, string20 lname) := transform
	lname_match := g(Risk_Indicators.LnameScore(l.lname,lname));
	self.match := lname_match;
end;
	
match_rec match_addr(layout_addr L, string10 prim_Range, string28 prim_name, string8 sec_range) := transform
	addr_match := ga(Risk_Indicators.AddrScore(l.prim_range,l.prim_name,l.sec_range,
									prim_range,prim_name,sec_range));
	self.match := addr_match;
end;
	
dlrec get_dl_recs (iid le, KDL ri) := TRANSFORM
	dl_match := Le.dl_number = ri.dl_number;
	fname_match := count(project(Ri.names, match_fname(LEFT,le.fname))(match = true)) > 0;
	lname_match := count(project(Ri.names, match_lname(LEFT,le.lname))(match = true)) > 0;
	addr_match  := count(project(Ri.addresses, match_addr(LEFT,le.prim_Range, Le.prim_name, Le.sec_range))(match = true)) > 0;
	SELF.Issue_date := ri.issue_date;
	SELF.Expire_date := ri.expire_date;
	SELF.NADL := MAP(ri.dl_number=''											=> 	0,
				  ~fname_match AND ~lname_match								=>	1,
				  ~dl_match AND fname_match AND ~lname_match AND addr_match		=> 	2,
				  ~dl_match AND ~fname_match AND lname_match AND addr_match		=>	3,
				  ~dl_match AND fname_match and lname_match AND addr_match		=>	4,
				  dl_match AND ~fname_match AND ~lname_match AND addr_match		=>	5,
				  dl_match AND fname_match AND ~lname_match AND ~addr_match		=>	6,
				  dl_match AND ~fname_match AND lname_match AND ~addr_match		=>	7,
				  dl_match AND fname_match AND lname_match AND ~addr_match		=>	8,
				  dl_match AND fname_match AND ~lname_match AND addr_match		=>	9,
				  dl_match AND ~fname_Match AND lname_match AND addr_match		=>	10,
				  dl_match AND fname_match AND lname_match AND addr_match		=>	11, 0);
	self.dl_matched := dl_match;
	SELF := le;
END;
dl_data := group(sort(ungroup(JOIN(iid, KDL,
				keyed(left.did = right.did) and
				(isLN OR RIGHT.source_code NOT IN mdr.Source_is_lnOnly),
				get_dl_recs(LEFT,RIGHT))), seq), seq);

dlrec roll_dls(dlrec le, dlrec ri) :=
TRANSFORM
	SELF.Issue_date := ut.Min2(le.Issue_date, ri.Issue_date);
	SELF.Expire_date := ut.Max2(le.Expire_date, ri.Expire_date);
	SELF.NADL := ut.max2(le.NADL,ri.NADL);	
	SELF := le;
END;

dl_rolled := ROLLUP(dl_data,true,roll_dls(LEFT,RIGHT));

RETURN dl_rolled;

end;
