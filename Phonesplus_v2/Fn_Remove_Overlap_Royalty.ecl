//Function to eliminate records where DID classification is DEAD, NOISE or H_MERGE

import header;
export Fn_Remove_Overlap_Royalty(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in,
																 dataset(recordof(Layout_In_Phonesplus.layout_in_common)) royalty_in) := function


exclusive_did_phone := join(distribute(royalty_in(did > 0), hash(did)),
											 distribute(phplus_in(did > 0), hash(did)),
											 left.did = right.did and
											 left.npa+left.phone7 = right.npa+right.phone7,
											 transform(recordof(royalty_in), self := left),
											 left only,
											 local);


exclusive_name_phone := join(distribute(royalty_in(did = 0) + exclusive_did_phone, hash(npa+phone7)),
											 distribute(phplus_in, hash(npa+phone7)),
											 left.lname = right.lname and
											 left.fname = right.fname and
											 left.npa+left.phone7 = right.npa+right.phone7,
											 transform(recordof(royalty_in), self := left),
											 left only,
											 local);
											 

exclusive_rec_key := join(distribute(exclusive_name_phone, hash(CellPhoneIDKey)),
											 distribute(phplus_in, hash(CellPhoneIDKey)),
											 left.CellPhoneIDKey = right.CellPhoneIDKey,
											 transform(recordof(royalty_in), self := left),
											 left only,
											 local);
											 
											 
exclusive_did_phone7 := join(distribute(exclusive_rec_key, hash(phone7_did_key)),
											 distribute(phplus_in, hash(phone7_did_key)),
											 left.phone7_did_key = right.phone7_did_key,
											 transform(recordof(royalty_in), self := left),
											 left only,
											 local);



return exclusive_did_phone7 + phplus_in;
end;
