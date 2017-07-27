import ut,header;

/*
append valid_ssn from header by join DID + SSN, unique valid_ssn per DID + SSN
*/
																			
export validSSN(dataset(recordof(header.layout_header)) in_hdr) := function

 rslim := record
  in_hdr.did;
	in_hdr.ssn;
	in_hdr.valid_ssn;
 end;
 
tvalidSSN := table(distribute(in_hdr(ssn <> '' and valid_ssn <> ''), hash(did)), rslim);

validSSN_dedup := dedup(sort(tvalidSSN, did, ssn, local), did, ssn, local) : persist('persist::Watchdog_validSSN');

return validSSN_dedup;

end;