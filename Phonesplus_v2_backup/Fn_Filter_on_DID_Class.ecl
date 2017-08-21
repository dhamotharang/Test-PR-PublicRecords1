//Function to eliminate records where DID classification is DEAD, NOISE or H_MERGE

import header;
export Fn_Filter_on_DID_Class(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

did_classifications := header.fn_adlsegmentation(header.file_headers).core_check;

recordof(phplus_in) t_did_class(phplus_in le, did_classifications  ri):= transform 
self.did_type := ri.ind;
self := le;
end;

header_class := join(distribute(phplus_in (did > 0), hash(did)), 
				     distribute(did_classifications, hash(did)),
					 left.did = right.did ,
					 t_did_class(left, right),
					 left outer,
					 local);



header_class_all := header_class(did_type not in['DEAD', 'NOISE', 'H_MERGE']) + phplus_in (did = 0);

return header_class_all;
end;
