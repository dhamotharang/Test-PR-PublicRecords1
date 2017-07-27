import ut,doxie,bankruptcyv3,suppress;

inrec := recordof(bankruptcyv3.key_bankruptcyV3_search_full_bip());

export fn_pullIDs(dataset(inrec) parties, boolean pull_indiv = false, string32 appType) := 
FUNCTION

//add a seq num
rec := record(inrec)
	unsigned4 seq;
end;

ut.MAC_Sequence_Records_NewRec(parties, rec, seq, pseq)

//strip out the restricted parties
Suppress.MAC_pullIDs_tmsid(pseq,pseq3,true,false,appType,'BK')

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
				

clean_indv := join(pseq, dropped,
         LEFT.seq = RIGHT.seq,
				 TRANSFORM(inrec, 				                               										
				             self := left,
										 self := []),
				 LEFT ONLY);
	
				
return IF(pull_indiv,clean_indv,clean_tmsid);
	
END;