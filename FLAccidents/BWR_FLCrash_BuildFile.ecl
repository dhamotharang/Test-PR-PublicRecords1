import ut, did_add, business_header_ss;
#workunit ('name', 'build flcrash files');

//build flcrash0
ut.mac_sf_buildprocess(flaccidents.infile_flcrash0, 'base::flcrash0', build_flc0, 2);


//build flcrash1
ut.mac_sf_buildprocess(flaccidents.infile_flcrash1, 'base::flcrash1', build_flc1, 2);


//build flcrash2v did
flc2v_did_in := flaccidents.infile_flcrash2v(cname = '');

flc2v_did_rec := record
	unsigned6 did := 0,
	unsigned1 did_score := 0,
	flaccidents.layout_flcrash2v,
	string8 dob_better := '',
end;

flc2v_did_rec flc2v_get_newdob(flc2v_did_in l) := transform
	self.dob_better := l.vehicle_owner_dob[5..8] + l.vehicle_owner_dob[1..4];
	self := l;
end;

flc2v_did_ready := project(flc2v_did_in,flc2v_get_newdob(left));

matchset1 := ['D','A'];

did_add.mac_match_flex(flc2v_did_ready, matchset1,
                       foo, dob_better, fname, mname, lname, suffix,
				   prim_range, prim_name, sec_range, zip, st, foo,
				   did, flc2v_did_rec,
                       true, did_score, 75,
				   flc2v_did_file);

flc2v_out_rec := record
	string12 did,
	unsigned1 did_score,
	string12 bdid,
	unsigned1 bdid_score,
	flaccidents.layout_flcrash2v,
end;

flc2v_out_rec flc2v_get_didout(flc2v_did_file l) := transform
	self.did := intformat(l.did, 12, 1);
	self.bdid := '';
	self.bdid_score := 0;
	self := l;
end;

flc2v_did_out := project(flc2v_did_file, flc2v_get_didout(left));

//build flcrash2v bdid
flc2v_bdid_in := flaccidents.infile_flcrash2v(cname <> '');

flc2v_bdid_rec := record
	unsigned6 bdid := 0,
     unsigned1 bdid_score := 0,
	flaccidents.layout_flcrash2v,
end;

flc2v_bdid_rec flc2v_bdid_init(flc2v_bdid_in l) := transform
	self := l;
end;

flc2v_bdid_ready := project(flc2v_bdid_in,flc2v_bdid_init(left));

b_matchset1 := ['A'];

business_header_ss.MAC_Add_BDID_Flex(flc2v_bdid_ready,b_matchset1,
                                     cname,
				                 prim_range, prim_name, zip,
						       sec_range, st,
						       foo, foo,
				                 bdid,
						       flc2v_bdid_rec,
						       true, bdid_score,
						       flc2v_bdid_file);

flc2v_out_rec flc2v_bdid_getout(flc2v_bdid_file l) := transform
	self.did := '';
	self.did_score := 0;
	self.bdid := intformat(l.bdid, 12, 1);
	self := l;
end;

flc2v_bdid_out := project(flc2v_bdid_file, flc2v_bdid_getout(left));

flc2v_out := flc2v_did_out + flc2v_bdid_out;

ut.mac_sf_buildprocess(flc2v_out, 'base::flcrash2v', build_flc2v, 2);

//build flcrash3v
ut.mac_sf_buildprocess(flaccidents.infile_flcrash3v, 'base::flcrash3v', build_flc3v, 2);


//build flcrash4
flc4_raw := flaccidents.infile_flcrash4;

flc4_did_rec := record
	unsigned6 did := 0,
	unsigned1 did_score := 0,
	flc4_raw,
	string8 dob_better,
end;

flc4_did_rec flc4_getdid(flc4_raw l) := transform
	self.dob_better := l.driver_dob[5..8] + l.driver_dob[1..4];
	self := l;
end;

flc4_ready := project(flc4_raw,flc4_getdid(left));

matchset2 := ['D','A','P'];

did_add.mac_match_flex(flc4_ready, matchset2,
                       foo, dob_better, fname, mname, lname, suffix,
				   prim_range, prim_name, sec_range, zip, st, driver_phone_nbr,
				   did, flc4_did_rec,
                       true, did_score, 75,
				   flc4_didfile);

flc4_out_rec := record
	string12 did,
	unsigned1 did_score,
	flc4_raw,
end;

flc4_out_rec flc4_getout(flc4_didfile l) := transform
	self.did := intformat(l.did, 12, 1);
	self := l;
end;

flc4_out := project(flc4_didfile, flc4_getout(left));

ut.mac_sf_buildprocess(flc4_out, 'base::flcrash4', build_flc4, 2);


//build flcrash5
flc5_raw := flaccidents.infile_flcrash5;

flc5_did_rec := record
	unsigned6 did := 0,
	unsigned1 did_score := 0,
	flc5_raw,
end;

flc5_did_rec flc5_getdid(flc5_raw l) := transform
	self := l;
end;

flc5_ready := project(flc5_raw,flc5_getdid(left));

matchset3 := ['A'];

did_add.mac_match_flex(flc5_ready, matchset3,
                       foo, foo, fname, mname, lname, suffix,
				   prim_range, prim_name, sec_range, zip, st, foo,
				   did, flc5_did_rec,
                       true, did_score, 75,
				   flc5_didfile);

flc5_out_rec := record
	string12 did,
	unsigned1 did_score,
	flc5_raw,
end;

flc5_out_rec flc5_getout(flc5_didfile l) := transform
	self.did := intformat(l.did, 12, 1);
	self := l;
end;

flc5_out := project(flc5_didfile, flc5_getout(left));

ut.mac_sf_buildprocess(flc5_out, 'base::flcrash5', build_flc5, 2);


//build flcrash6
flc6_raw := flaccidents.infile_flcrash6;

flc6_did_rec := record
	unsigned6 did := 0,
	unsigned1 did_score := 0,
	flc6_raw,
	string8 dob_better,
end;

flc6_did_rec flc6_getdid(flc6_raw l) := transform
	self.dob_better := l.ded_dob[5..8] + l.ded_dob[1..4];
	self := l;
end;

flc6_ready := project(flc6_raw,flc6_getdid(left));

did_add.mac_match_flex(flc6_ready, matchset1,
                       foo, dob_better, fname, mname, lname, suffix,
				   prim_range, prim_name, sec_range, zip, st, foo,
				   did, flc6_did_rec,
                       true, did_score, 75,
				   flc6_didfile);

flc6_out_rec := record
	string12 did,
	unsigned1 did_score,
	flc6_raw,
end;

flc6_out_rec flc6_getout(flc6_didfile l) := transform
	self.did := intformat(l.did, 12, 1);
	self := l;
end;

flc6_out := project(flc6_didfile, flc6_getout(left));

ut.mac_sf_buildprocess(flc6_out, 'base::flcrash6', build_flc6, 2);


//build flcrash7 did
flc7_did_in := flaccidents.infile_flcrash7(cname = '');

flc7_did_rec := record
	unsigned6 did := 0,
	unsigned1 did_score := 0,
	flaccidents.layout_flcrash7,
end;

flc7_did_rec flc7_did_init(flc7_did_in l) := transform
	self := l;
end;

flc7_did_ready := project(flc7_did_in,flc7_did_init(left));

did_add.mac_match_flex(flc7_did_ready, matchset3,
                       foo, foo, fname, mname, lname, suffix,
				   prim_range, prim_name, sec_range, zip, st, foo,
				   did, flc7_did_rec,
                       true, did_score, 75,
				   flc7_did_file);

flc7_out_rec := record
	string12 did,
	unsigned1 did_score,
	string12 bdid,
	unsigned1 bdid_score,
	flaccidents.layout_flcrash7,
end;

flc7_out_rec flc7_get_didout(flc7_did_file l) := transform
	self.did := intformat(l.did, 12, 1);
	self.bdid := '';
	self.bdid_score := 0;
	self := l;
end;

flc7_did_out := project(flc7_did_file, flc7_get_didout(left));

//build flcrash7 bdid
flc7_bdid_in := flaccidents.infile_flcrash7(cname <> '');

flc7_bdid_rec := record
	unsigned6 bdid := 0,
	unsigned1 bdid_score := 0,
	flaccidents.layout_flcrash7,
end;

flc7_bdid_rec flc7_bdid_init(flc7_bdid_in l) := transform
	self := l;
end;

flc7_bdid_ready := project(flc7_bdid_in,flc7_bdid_init(left));

business_header_ss.MAC_Add_BDID_Flex(flc7_bdid_ready,b_matchset1,
                                     cname,
				                 prim_range, prim_name, zip,
						       sec_range, st,
						       foo, foo,
				                 bdid,
						       flc7_bdid_rec,
						       true, bdid_score,
						       flc7_bdid_file);

flc7_out_rec flc7_bdid_getout(flc7_bdid_file l) := transform
	self.did := '';
	self.did_score := 0;
	self.bdid := intformat(l.bdid, 12, 1);
	self := l;
end;

flc7_bdid_out := project(flc7_bdid_file, flc7_bdid_getout(left));

flc7_out := flc7_did_out + flc7_bdid_out;

ut.mac_sf_buildprocess(flc7_out, 'base::flcrash7', build_flc7, 2);

export bwr_flcrash_buildfile := sequential(build_flc0,build_flc1,build_flc2v,build_flc3v,build_flc4,build_flc5,build_flc6,build_flc7);
