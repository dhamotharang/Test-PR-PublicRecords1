import ut,doxie,bankruptcyv3,suppress, bankruptcyv3_services;

inrec := {recordof(bankruptcyv3.key_bankruptcyv3_main_full()),boolean isDeepDive,                     
									 boolean SuppressT};

export fn_pullTrusteeIds(dataset(inrec) full_layout, string32 appType):= FUNCTION

outrec := bankruptcyv3_services.layouts.layout_tmsid_ext;

//add a seq num
rec := record(inrec)
	unsigned4 seq;
end;

ut.MAC_Sequence_Records_NewRec(full_layout, rec, seq, pseqP)

//strip out the restricted trusties
// pull for did, app_ssn, tmsid (based on the 2 booleans in this call to Mac_PullIDs_tmsid.
// true = use the 'app_ssn' pull 
// false = do NOT use the 'ssn' pull
Suppress.MAC_pullIDs_tmsid(pseqP, pseq3P,true,false,appType,'BK') 


// add in suppress boolean

setSuppressed := join(pseqP,pseq3P,
                      left.seq = right.seq,
											transform(inrec,
                      self.suppressT := if (right.seq = 0, true, false);
											self := left), LEFT OUTER);
                     
// output(setSuppressed, named('setSuppressedV3TRUST'));
			
return setSuppressed;
	
END;