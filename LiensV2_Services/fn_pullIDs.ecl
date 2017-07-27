import ut,doxie,suppress;

inrec := liensv2_services.layout_lien_party_raw;

export fn_pullIDs(grouped dataset(inrec) parties, string32 appType) := 
FUNCTION

outrec := liensv2_services.layout_rmsid;

//add a seq num
rec := record
	inrec;
	unsigned4 seq;
end;

ugparties := ungroup(parties);
ut.MAC_Sequence_Records_NewRec(ugparties, rec, seq, pseq)


//strip out the restricted parties
Suppress.MAC_pullIDs_tmsid(group(sorted(pseq, acctno), acctno), pseq3,false,true,appType,'LIENS')

//see which ones we dropped
dropped := join(pseq, pseq3, 
				left.seq = right.seq, 
				transform(rec, self := left), 
				left only);
				
//if dropped, removing matching ids
clean   := join(pseq, dropped, 
				left.tmsid = right.tmsid and 
				left.rmsid = right.rmsid,
				transform(outrec, self := left),
				left only);
				
return clean;
	
END;