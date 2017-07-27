export doxie.Layout_Rollup.KeyRec_feedback_batch fn_flatten_rollup(DATASET(doxie.Layout_Rollup.KeyRec_feedback)  inRecs,
                                                                  STRING20 BatchAccount) := FUNCTION
layout_w_seq := record
  integer seq;
	string20 acctno;
	doxie.Layout_Rollup.KeyRec_feedback;
end;

RECORDTYPE := MODULE
 EXPORT  STRING4 NAME := 'NAME';
 EXPORT  STRING4 ADDR := 'ADDR';
 EXPORT  STRING3 SSN := 'SSN';
 EXPORT  STRING3 DOB := 'DOB';
 EXPORT  STRING3 DOD := 'DOD';
 EXPORT  STRING2 DL := 'DL';
END;
  layout_w_seq addCounter(inRecs L, INTEGER C) := TRANSFORM
	  self.seq := C;
		self.acctno := BatchAccount;
	  self := l;
	END;
  recs_w_seq := project(inRecs, addCounter(LEFT, COUNTER));

MAC_addHeader(inTYPE) := MACRO
   self.acctno := l.acctno;
   self.linkID := l.did;
	 self.recordType := inTYPE;
	 self.seq := l.seq;
	 self.penalt := l.penalt;
	 self.num_compares := l.num_compares;
	 self.includedByHHID := l.includedByHHID;
	 self.bestSrchedAddrTntScore := l.bestSrchedAddrTntScore;
	 self.bestSrchedAddrDate := l.bestSrchedAddrDate;
	 self.bestTntScore := l.bestTntScore; 
	 self.bestSrchedValidSSNScore := l.bestSrchedValidSSNScore;
	 self.addrs_suppressed := l.addrs_suppressed;
	 self.ssn_count := l.ssn_count;
ENDMACRO;

doxie.Layout_Rollup.KeyRec_feedback_batch name_child(recs_w_seq l, doxie.Layout_Rollup.NameRec r, INTEGER C) := transform
   MAC_addHeader(RECORDTYPE.NAME);
	 self.typeSeq := C;
	 self := r;
   self := [];
end;
doxie.Layout_Rollup.KeyRec_feedback_batch addr_child(recs_w_seq l, doxie.Layout_Rollup.AddrRec_feedback r, INTEGER C) := transform
	 MAC_addHeader(RECORDTYPE.ADDR);
	 self.typeSeq := C;
	 self.match_type := r.phoneRecs[1].match_type;
	 self.gong_score := r.phoneRecs[1].gong_score;
	 self.phone := r.phoneRecs[1].phone;
	 self.timezone := r.phoneRecs[1].timezone;
	 self.listed := r.phoneRecs[1].listed;
	 self.bdid := r.phoneRecs[1].bdid;
	 self.did := r.phoneRecs[1].did;
	 self.listing_type_res := r.phoneRecs[1].listing_type_res;
	 self.listing_type_bus := r.phoneRecs[1].listing_type_bus;
	 self.listing_type_gov := r.phoneRecs[1].listing_type_gov;
	 self.listing_type_cell := r.phoneRecs[1].listing_type_cell;
	 self.new_type := r.phoneRecs[1].new_type;
	 self.carrier := r.phoneRecs[1].carrier;
	 self.carrier_city := r.phoneRecs[1].carrier_city;
	 self.carrier_state := r.phoneRecs[1].carrier_state;
	 self.PhoneType := r.phoneRecs[1].PhoneType; 
	 self.phone_first_seen := r.phoneRecs[1].phone_first_seen; 
	 self.phone_last_seen := r.phoneRecs[1].phone_last_seen; 
	 self.listed_name := r.phoneRecs[1].listed_name; // MAXLENGTH defined inside
	 self.caption_text := r.phoneRecs[1].caption_text; // MAXLENGTH defined inside
	 self.hri := r.hri_address[1].hri;
	 self.desc := r.hri_address[1].desc;
   self.hri_phone := [];
	 self := r;
   self := [];
end;
doxie.Layout_Rollup.KeyRec_feedback_batch ssn_child(recs_w_seq l, doxie.Layout_Rollup.ssnRec r, INTEGER C) := transform
   MAC_addHeader(RECORDTYPE.SSN);
	 self.typeSeq := C;
	 self := r;
   self := [];
end;
doxie.Layout_Rollup.KeyRec_feedback_batch dob_child(recs_w_seq l, doxie.Layout_Rollup.dobRec r, INTEGER C) := transform
	 MAC_addHeader(RECORDTYPE.DOB);
	 self.typeSeq := C;
	 self.dob := r.dob;
	 self.age := r.age;
   self := [];
end;
doxie.Layout_Rollup.KeyRec_feedback_batch dod_child(recs_w_seq l, doxie.Layout_Rollup.dodRec r, INTEGER C) := transform
   MAC_addHeader(RECORDTYPE.DOD);
	 self.typeSeq := C;
	 self.dod := r.dod;
	 self.dead_age := r.dead_age;
	 self.deceased := r.deceased;
   self := [];
end;
doxie.Layout_Rollup.KeyRec_feedback_batch dl_child(recs_w_seq l) := transform
	 MAC_addHeader(RECORDTYPE.DL);
	 self.typeSeq := 1;
   self.dl_num := l.dlrecs[1].dl_num;  
	 self.dl_st := l.dlrecs[1].dl_st;
   self := [];
end;
//create name records
  name_recs := normalize(recs_w_seq, left.nameRecs, name_child(left, right, COUNTER));
//create address records
  addr_recs := normalize(recs_w_seq, left.addrRecs, addr_child(left, right, COUNTER));
//create ssn records
  ssn_recs := normalize(recs_w_seq, left.ssnRecs, ssn_child(left, right, COUNTER));
//create dob records
  dob_recs := normalize(recs_w_seq, left.dobRecs, dob_child(left, right, COUNTER));
//create dod records
  dod_recs := normalize(recs_w_seq, left.dodRecs, dod_child(left, right, COUNTER));
//create dl records and don't add empty dl record.
  dl_recs := project(recs_w_seq(trim(dlrecs[1].dl_num) <> ''), dl_child(left));
  recs := name_recs + addr_recs + ssn_recs + dob_recs + dod_recs + dl_recs;
	outrecs := sort(recs, seq, recordType, typeSeq);
  RETURN outrecs;
END;