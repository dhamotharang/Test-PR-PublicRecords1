IMPORT driversv2, mdr, drivers, ut;

EXPORT Boca_Shell_DL_Hist (GROUPED DATASET(Layout_Output) iid,
                           boolean isLN, unsigned1 dppa, boolean dppa_ok,
                           unsigned3 history_date) := FUNCTION

dlk			:= driversv2.key_dl;
kdln_nonFCRA	:= driversv2.key_dl_number;

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

dlrec get_dl_num(iid le, STRING14 dlnum, BOOLEAN dlmatch) := TRANSFORM
	SELF.dl_number := dlnum;
	SELF.dl_matched := dlmatch;
	SELF := le;
	SELF := [];
END;
dl_id := 

GROUP(
	SORT(
			GROUP(JOIN(iid,dlk,LEFT.did=RIGHT.s_did,
                 get_dl_num(LEFT,RIGHT.dl_number,false),KEEP(100)))+
			GROUP(PROJECT(iid(dl_number<>''),get_dl_num(LEFT,LEFT.dl_number,true))),seq),seq);

dlrec get_dl_recs_NonFCRA (dlrec le, kdln_NonFCRA ri) := TRANSFORM
	fname_match := g(Risk_Indicators.FnameScore(le.fname,ri.fname));
	addr_match := ga(Risk_Indicators.AddrScore(le.prim_range,le.prim_name,le.sec_range,
									ri.prim_range,ri.prim_name,ri.sec_range));
	lname_match := g(Risk_Indicators.LnameScore(le.lname,ri.lname));

	SELF.Issue_date := IF(ri.orig_issue_date<>0,ri.orig_issue_date,ri.lic_issue_date);
	SELF.Expire_date := ri.expiration_date;
	SELF.NADL := MAP(ri.dl_number=''																					=> 	0,
				  ~fname_match AND ~lname_match																			=>	1,
				  ~le.dl_matched AND fname_match AND ~lname_match AND addr_match		=> 	2,
				  ~le.dl_matched AND ~fname_match AND lname_match AND addr_match		=>	3,
				  ~le.dl_matched AND fname_match and lname_match AND addr_match			=>	4,
				  le.dl_matched AND ~fname_match AND ~lname_match AND addr_match		=>	5,
				  le.dl_matched AND fname_match AND ~lname_match AND ~addr_match		=>	6,
				  le.dl_matched AND ~fname_match AND lname_match AND ~addr_match		=>	7,
				  le.dl_matched AND fname_match AND lname_match AND ~addr_match			=>	8,
				  le.dl_matched AND fname_match AND ~lname_match AND addr_match			=>	9,
				  le.dl_matched AND ~fname_Match AND lname_match AND addr_match			=>	10,
				  le.dl_matched AND fname_match AND lname_match AND addr_match			=>	11, 0);
	SELF := le;
END;


dl_data := JOIN (dl_id,kdln_NonFCRA,
                 (TRIM(LEFT.dl_number)<>'' AND TRIM(StringLib.StringFilterOut(LEFT.dl_number,'0'))<>'') AND
                 keyed(LEFT.dl_number=RIGHT.s_dl) AND 
                 RIGHT.dt_first_seen < history_date AND
                 (isLN OR RIGHT.source_code NOT IN mdr.Source_is_lnOnly) AND
                 dppa_ok AND drivers.state_dppa_ok(RIGHT.orig_state,dppa),
                 get_dl_recs_nonFCRA (LEFT,RIGHT),
								 KEEP(100),LIMIT(200,SKIP));

dlrec roll_dls(dlrec le, dlrec ri) := TRANSFORM
	SELF.Issue_date := ut.Min2(le.Issue_date, ri.Issue_date);
	SELF.Expire_date := ut.Max2(le.Expire_date, ri.Expire_date);
	SELF.NADL := ut.max2(le.NADL,ri.NADL);	
	SELF := le;
END;
dl_rolled := ROLLUP(dl_data,true,roll_dls(LEFT,RIGHT));


RETURN dl_rolled;

END;