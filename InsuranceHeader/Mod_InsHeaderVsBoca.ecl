import idl_header;

export Mod_InsHeaderVsBoca(dataset(idl_header.Layout_Header_link) insHdr, 
													 dataset(idl_header.Layout_Header_boca) bocaHdr,
													 integer mismatch = 4) := module

export did_rec := record
	unsigned8 did;
	unsigned8 cnt;
end;

export did_rec_out := record
	unsigned8 did_boca;
	unsigned8 cnt_boca;
	unsigned8 did_ins;
	unsigned8 cnt_ins;
end;


// Insurance Header
ds1_did_cnt := RECORD
	UNSIGNED8 DID := insHdr.DID;
	UNSIGNED8 CNT := COUNT (GROUP);
END;
export ds_ins := TABLE (insHdr,ds1_did_cnt,DID);

// output(count(ds_salt),named('TotalSaltDid'));

// Boca Header
ds2_did_cnt := RECORD
	UNSIGNED8 DID := bocaHdr.DID;
	UNSIGNED8 CNT := COUNT (GROUP);
END;
export ds_boca := TABLE (bocaHdr,ds2_did_cnt,DID);
// output(count(ds_boca), named('TotalBocaDid'));

did_rec_out xform(ds_ins l, ds_boca r) := transform
	self.did_boca := r.did;
	self.did_ins := l.did;
	self.cnt_boca := r.cnt;
	self.cnt_ins := l.cnt;
end;

shared ds := join (ds_ins, ds_boca, left.did = right.did, xform(left, right), full outer);

export totalDid := count(ds);
export mismatchedDids := ds(cnt_boca!=cnt_ins and 
													 cnt_boca > 0 and 
													 cnt_ins > 0 and 
													 (cnt_boca-cnt_ins > mismatch or cnt_ins-cnt_boca > mismatch));
export matchedDids			:= ds(cnt_boca=cnt_ins);
export onlyInBocaDids 	:= ds(cnt_ins = 0);												 
export onlyInInsDids 		:= ds(cnt_boca = 0);												 
END;