IMPORT AddrBest, Address_Rank, Advo,didville, AutoStandardI, BatchServices, Doxie, Header;
EXPORT Functions := MODULE
	
	EXPORT fn_getHdrAddrRecs(DATASET(Address_Rank.Layouts.Batch_in) ds_batch_in,
									 Address_Rank.IParams.BatchParams in_mod) := FUNCTION

		recs_with_did := Address_Rank.fn_appendDids(ds_batch_in, in_mod);		

		ds_batch_in_w_seq := 
		  PROJECT(ds_batch_in, 
			TRANSFORM(didville.Layout_Did_OutBatch,
				SELF.seq     := (UNSIGNED)LEFT.acctno, 
				SELF.fname   := LEFT.name_first,
				SELF.mname   := LEFT.name_middle,
				SELF.lname   := LEFT.name_last,
				SELF.suffix  := LEFT.name_suffix,
				SELF.phone10 := LEFT.phone,
				SELF := LEFT,
				SELF := []));

		// recs_with_did is grouped by seq.
		recs_with_did_final := IF(in_mod.getDids, recs_with_did, GROUP(ds_batch_in_w_seq, seq));

		dids_hh   := DEDUP(SORT(PROJECT(recs_with_did_final, doxie.layout_references_hh),did),did);
		roll_recs := Address_Rank.fn_getHdrRecByDid_wBestdates(GROUP(dids_hh), in_mod);

		Address_Rank.Layouts.Bestrec restoreAcctno(recs_with_did l, roll_recs r):= TRANSFORM
			SELF.acctno      := (STRING)l.seq;
			SELF.dob         := (STRING)r.dob;
			SELF.name_first  := r.fname;
			SELF.name_middle := r.mname;
			SELF.name_last   := r.lname;
			SELF.suffix      := r.suffix;
			SELF.p_city_name := r.city_name;
			SELF.z5          := r.zip;
			SELF.addr_dt_first_seen := (STRING)r.dt_first_seen;
			SELF.addr_dt_last_seen  := (STRING)r.dt_last_seen;
			SELF.srcs := r.src;
			SELF := r;
			SELF := [];
		END;
		hdr_recs := JOIN(recs_with_did_final, roll_recs,
							LEFT.did = RIGHT.did,
							restoreAcctno(LEFT, RIGHT),
							LIMIT(Address_Rank.Constants.JOIN_LIMIT, SKIP),
							LEFT OUTER);
		RETURN hdr_recs;
	END;
END;