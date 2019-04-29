import didville, business_header_ss, business_header, DriversV2, NID, dx_header;


export ID_Function(DATASET(clerksofcourt.Layout_ID_Batch) full_layout) :=
FUNCTION

boolean include_xtra := false : STORED('IncludeExtraWork');

/* ******** Append an ADL *********** */
dedup_these := ~include_xtra;
fz := 'Z4G';
allscores := false;

didville.Layout_Did_OutBatch toDid(clerksofcourt.Layout_ID_Batch le) :=
TRANSFORM
	SELF := le;
END;
to_did_append := PROJECT(full_layout, toDid(LEFT));

didville.MAC_DidAppend(to_did_append,resu,dedup_these,fz,allscores)

index_did_lookups := dx_header.key_did_lookups();
resu getCnt(resu le, index_did_lookups ri) :=
TRANSFORM
	SELF.head_cnt := ri.head_cnt;
	SELF := le;
END;
j := JOIN(resu, index_did_lookups, keyed(LEFT.did=RIGHT.did), getCnt(LEFT,RIGHT), LEFT OUTER);

resu jroll(j le, j ri) :=
TRANSFORM
	choose_left := (ri.head_cnt=1 AND le.head_cnt<>1) OR le.score > ri.score;
	choose_right := (le.head_cnt=1 AND le.head_cnt<>1) OR ri.score > le.score;

	SELF.did := MAP(choose_left => le.did, 
				 choose_right => ri.did, 0);
	SELF.score := MAP(choose_left AND ri.head_cnt=1 => MIN(75,le.score+ri.score),
				   choose_left				   => MAX(50, le.score),
				   choose_right AND le.head_cnt=1 => MIN(75,le.score+ri.score),
				   choose_right			   => MAX(50, ri.score), le.score);	   
	SELF := le;
END;

jr := ROLLUP(j,true,jroll(LEFT,RIGHT));
adl_res := IF(include_xtra, jr, resu);

adl_d := adl_res(did<>0 AND score >= 50);

/* ******** Append a BDID *********** */
full_layout getorig(full_layout le, jr ri) :=
TRANSFORM
	SELF := le;
END;
adl_d_not := JOIN(full_layout, adl_res(did=0 OR score < 50), LEFT.seq=RIGHT.seq, getorig(LEFT,RIGHT));

Business_Header_SS.Layout_BDID_InBatch toBdid(adl_d_not le) :=
TRANSFORM
	SELF.company_name := le.name;
	SELF := le;
END;
to_bdid_append := PROJECT(adl_d_not, toBdid(LEFT));

Business_Header.doxie_MAC_Field_Declare()
business_header_ss.MAC_BDID_Append(to_bdid_append, resu2, 50, 1, true)

bdid_d := resu2(bdid<>0);
still_empty := resu2(bdid=0);


/* ************** Get everything back to common ************** */
Layout_Common_Answer :=
RECORD
	unsigned4 seq;
	string2	pid;
	string20	ucn;
	unsigned6 did;
	unsigned2 score;
	unsigned6 bdid;
	unsigned2 bdid_score;
	boolean well_behaved;
END;

Layout_Common_Answer adl2Common(adl_d le) :=
TRANSFORM
	SELF.seq := le.seq;
	SELF.did := le.did;
	SELF.score := le.score;
	SELF := [];
END;
p1 := PROJECT(adl_d, adl2Common(LEFT));

Layout_Common_Answer bdid2Common(bdid_d le) :=
TRANSFORM
	SELF.seq := le.seq;
	SELF.bdid := le.bdid;
	SELF.bdid_score := le.score;
	SELF := [];
END;
p2 := PROJECT(bdid_d, bdid2Common(LEFT));



Layout_Common_Answer empty2Common(still_empty le) :=
TRANSFORM
	SELF.seq := le.seq;
	SELF.bdid := le.bdid;
	SELF.bdid_score := IF(le.bdid=0,0,le.score); // always true
	SELF := [];
END;
p3 := PROJECT(still_empty, empty2Common(LEFT));


Layout_ID_Batch getBack(Layout_ID_Batch le, Layout_Common_Answer ri) :=
TRANSFORM
	SELF.seq := le.seq;
	SELF.ucn := le.ucn;
	SELF.pid := le.pid;
	SELF.well_behaved := (le.fname<>'' AND le.lname<>'') AND (le.dob<>'' OR le.z5<>'' OR le.ssn<>'');
	SELF := ri;
	SELF := le;
END;

alltogether := JOIN(full_layout, p1+p2+p3, LEFT.seq=RIGHT.seq, getBack(LEFT,RIGHT));


x_todo := GROUP(alltogether(did=0/* AND bdid=0*/), seq);
/* *************** Do my extra work here **************** */

key_dl := DriversV2.Key_DL_Number;
Layout_ID_Batch get_dl(Layout_ID_Batch le, key_dl ri) :=
TRANSFORM
	SELF.did := ri.did;
	SELF.score := IF(ri.did<>0,50,0);
	SELF := le;
END;
dl_match := JOIN(x_todo, key_dl, LEFT.DLNum<>'' AND 
											keyed(LEFT.DLNum[3..]=RIGHT.s_dl) AND 
											LEFT.DLNum[1..2]=RIGHT.orig_state, get_dl(LEFT,RIGHT), 
				ATMOST(keyed(LEFT.DLNum[3..]=RIGHT.s_dl),50),
				LEFT OUTER);

index_ssn := dx_header.key_ssn();
Layout_ID_Batch getSsnDid(Layout_ID_Batch le, index_ssn ri) :=
TRANSFORM
	SELF.did := IF(ri.did<>0,ri.did,le.did);
	SELF.score := IF(ri.did<>0,50,le.did);
	SELF := le;
END;


ssn_match := JOIN(dl_match, index_ssn,
								LEFT.did=0 AND
								(INTEGER)LEFT.ssn<>0 AND
								keyed(RIGHT.s1=LEFT.ssn[1]) AND
								keyed(RIGHT.s2=LEFT.ssn[2]) AND
								keyed(RIGHT.s3=LEFT.ssn[3]) AND
								keyed(RIGHT.s4=LEFT.ssn[4]) AND
								keyed(RIGHT.s5=LEFT.ssn[5]) AND
								keyed(RIGHT.s6=LEFT.ssn[6]) AND
								keyed(RIGHT.s7=LEFT.ssn[7]) AND
								keyed(RIGHT.s8=LEFT.ssn[8]) AND
								keyed(RIGHT.s9=LEFT.ssn[9]) AND
								NID.Firstname_Match(LEFT.fname,RIGHT.pfname)>0, 
								getSsnDid(LEFT,RIGHT), 
								ATMOST(keyed(RIGHT.s1=LEFT.ssn[1]) AND
									keyed(RIGHT.s2=LEFT.ssn[2]) AND
									keyed(RIGHT.s3=LEFT.ssn[3]) AND
									keyed(RIGHT.s4=LEFT.ssn[4]) AND
									keyed(RIGHT.s5=LEFT.ssn[5]) AND
									keyed(RIGHT.s6=LEFT.ssn[6]) AND
									keyed(RIGHT.s7=LEFT.ssn[7]) AND
									keyed(RIGHT.s8=LEFT.ssn[8]) AND
									keyed(RIGHT.s9=LEFT.ssn[9]),
								100), LEFT OUTER);

Layout_ID_Batch rmBads(Layout_ID_Batch le, index_did_lookups ri) :=
TRANSFORM
	SELF.head_cnt := ri.head_cnt;
	SELF := le;
END;
ssn_rm := JOIN(ssn_match, index_did_lookups, LEFT.did=RIGHT.did, rmBads(LEFT, RIGHT), LEFT OUTER);

Layout_ID_Batch rollBads(Layout_ID_Batch le, Layout_ID_Batch ri) :=
TRANSFORM
	SELF.did := IF(ri.head_cnt<2 OR le.did=ri.did, le.did, 0);
	SELF.score := IF(SELF.did<>0, 50, 0);
	SELF := le;
END;
ssn_roll := ROLLUP(SORT(ssn_rm,-head_cnt,did), true, rollBads(LEFT,RIGHT));

xx_todo := ssn_roll(did=0);

index_county :=  dx_header.key_countyName();
Layout_ID_Batch getCountyDid(Layout_ID_Batch le, index_county ri) :=
TRANSFORM
	SELF.did := ri.did;
	SELF.score := IF(ri.did<>0,50,0);
	SELF := le;
END;
county_match := JOIN(xx_todo, index_county,
					keyed(LEFT.lname=RIGHT.lname) AND
					keyed(LEFT.county_name=RIGHT.county_name) AND
					keyed(LEFT.st=RIGHT.st) AND
					keyed(LEFT.fname[1]=RIGHT.fname[1]) AND
					NID.Firstname_Match(LEFT.fname,RIGHT.fname) > 1 AND
					NID.Firstname_Match(LEFT.mname,RIGHT.mname) > 0, getCountyDid(LEFT,RIGHT),
					ATMOST(	LEFT.lname=RIGHT.lname AND
							LEFT.st=RIGHT.st AND
							LEFT.county_name=RIGHT.county_name AND
							LEFT.fname[1]=RIGHT.fname[1],
							1000), LEFT OUTER);
county_rm := JOIN(county_match, index_did_lookups, LEFT.did=RIGHT.did, rmBads(LEFT, RIGHT), LEFT OUTER);
county_roll := ROLLUP(SORT(county_rm,-head_cnt,did), true, rollBads(LEFT,RIGHT));


Layout_ID_Batch clear_bdids(Layout_ID_Batch le) :=
TRANSFORM
	gotta_did := le.did<>0;
	SELF.bdid := IF(gotta_did,0,le.bdid);
	SELF.bdid_score := IF(gotta_did,0,le.bdid_score);
	SELF := le;
END;
hard_work := IF(include_xtra, PROJECT(ssn_roll(did<>0)+county_roll, clear_bdids(LEFT)), x_todo);

RETURN alltogether(~(did=0/* AND bdid=0 */))+hard_work;

END;
