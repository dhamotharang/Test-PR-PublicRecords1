import did_add, header_slimsort, address, ut, didville;

in_file := header.File_State_Death;

mast_did_rec := record
	unsigned6 did       := 0,
	unsigned1 did_score := 0,
	header.layout_state_death,
	//string5   zip5,
end;

mast_did_rec mast_getdid(in_file l) := transform
	//self.zip5 := l.zip; //self.zip5 := if(trim(l.zip_lastres) != '', l.zip_lastres, l.zip_lastpayment);
	self      := l;
end; 

mast_ready := project(in_file, mast_getdid(left));

matchset := ['D','S','Z'];

did_add.mac_match_flex(mast_ready, matchset, 
                       ssn, dob, fname, mname, lname, name_suffix,
				               foo, foo, foo, zip, foo, foo,
				               did, mast_did_rec,
                       true, did_score, 75,
				               mast_out);

out_f := mast_out;
				   				   
mast_out_rec := record
	string12  did,
	unsigned1 did_score,
	header.layout_state_death,
end;

mast_out_rec mast_getout(out_f l) := transform
	self.did := intformat(l.did, 12, 1);
	self     := l;
end;

did_dead_mast := project(out_f, mast_getout(left));

ut.mac_sf_buildprocess(did_dead_mast, '~thor_data400::base::did_statedeath_master', build_did_d_mast, 2);

export proc_statedeathmaster_buildfile := build_did_d_mast;