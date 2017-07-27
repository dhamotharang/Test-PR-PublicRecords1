import bankruptcyv3_services,suppress,ut;

inrec := bankruptcyv3_services.Layout_key_bankruptcyv3_search_full_bip_plus_case_numbers;

export fn_pullIDs(dataset(inrec) parties, boolean pull_indiv = false, string32 AppType) := 
FUNCTION

outrec := bankruptcyv3_services.layouts.layout_tmsid_ext;

//add a seq num
rec := record(inrec)
	unsigned4 seq;
end;

ut.MAC_Sequence_Records_NewRec(parties, rec, seq, pseq)

//strip out the restricted parties
Suppress.MAC_pullIDs_tmsid(pseq, pseq3,true, false, AppType,'BK')

//see which ones we dropped
dropped := join(pseq, pseq3, 
				left.seq = right.seq, 
				transform(rec, self := left), 
				left only);
				
//if dropped, removing matching ids
clean_tmsid := join(pseq, dropped, 
				left.tmsid = right.tmsid,
				transform(inrec, self := left, self := []),
				left only);
clean_indiv := join(pseq, dropped, 
				left.seq = right.seq,
				transform(inrec, self := left, self := []),
				left only);

// output(pseq, named('pseq'), EXTEND);
// output(pseq3, named('pseq3'), EXTEND);
// output(dropped, named('dropped'), EXTEND);
// output(clean, named('clean'), EXTEND);
				
return IF(pull_indiv,clean_indiv,clean_tmsid);
	
END;