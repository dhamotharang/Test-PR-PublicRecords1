import header, ut,doxie_build, fcra;

export did_ssn_date_fcra(dataset(recordof(header.Layout_Header)) in_hdr) :=
function

//hf := distribute(doxie_build.file_header_building(~fcra.Restricted_Header_Src(src, vendor_id[1])),hash(did))(did <> 0);
hf := distribute(in_hdr(~fcra.Restricted_Header_Src(src, vendor_id[1])),hash(did))(did <> 0);


//eliminate any empty SSN recs
hf_pruned := hf(ssn <> '');

slim_rec := RECORD 
	hf.did;
	hf.ssn;
	unsigned3 best_date := 0;
END;

slim_rec slim_it(hf_pruned l) := TRANSFORM
  SELF.best_date := ut.max2(L.dt_first_seen, L.dt_last_seen);
	SELF := l;
END;

// slim it down
hf_slim := PROJECT(hf_pruned, slim_it(LEFT));
// group by did/ssn
hf_grp := GROUP(SORT(hf_slim, did, ssn,local), did, ssn,local);

slim_rec best_dt(slim_rec L, slim_rec R) := TRANSFORM
	SELF.best_date := ut.max2(L.best_date, R.best_date);
	SELF := L;
END;

// rollup to get the best (most recent) date for any did/ssn pair
hf_best_dt := ROLLUP(hf_grp, best_dt(LEFT,RIGHT),true);

hf_lite := hf_best_dt(ut.DaysApart(((STRING6)best_date)+'01',ut.GetDate) > 18 * 30);

hf_lite takeLeft(hf_lite l) := TRANSFORM
   SELF := l;
END;

// eliminate any records from the key that are in the death files
hf_nodeath1 := join(hf_lite, distribute(header.File_Did_Death_Master((unsigned) did > 0),hash((unsigned6)did)), LEFT.did = (unsigned6) RIGHT.did, 
                    takeLeft(LEFT), LEFT ONLY,local);
 
/*hf_nodeath2 := join(hf_nodeath1, distribute(header.File_Did_StateDeath_Master((unsigned) did > 0),hash((unsigned6)did)), LEFT.did = (unsigned6)RIGHT.did, 
                    takeLeft(LEFT), LEFT ONLY,local);*/

//export DID_SSN_Date_FCRA := hf_nodeath2 : PERSIST('persist::did_ssn_date_fcra');

return hf_nodeath1;

end;