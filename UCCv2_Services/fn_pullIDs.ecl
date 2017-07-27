import ut,doxie,suppress;

inrec := recordof(uccv2_services.layout_ucc_party_raw);

export fn_pullIDs(dataset(inrec) parties, string32 appType) := 
FUNCTION

outrec := UCCv2_services.layout_tmsid;

//add a seq num
rec := record(inrec)
	unsigned4 seq;
end;

ut.MAC_Sequence_Records_NewRec(parties, rec, seq, pseq)

//strip out the restricted parties
Suppress.MAC_pullIDs_tmsid(pseq, pseq3,false,true,appType,'UCC')

//see which ones we dropped
dropped := join(pseq, pseq3, 
				left.seq = right.seq, 
				transform(rec, self := left), 
				left only);
				
//if dropped, removing matching ids
clean   := join(pseq, dropped, 
				left.tmsid = right.tmsid,
				transform(outrec, self := left),
				left only);
				
return dedup (sort (clean, TMSID), TMSID);
	
END;