import doxie;

keyfile := Business_Header.Key_Business_Contacts_DID;
outrec := Business_Header.layout_filepos;

outrec tra(keyfile r) := transform 
	self := r;
end;

export Fetch_BC_Key_DID(dataset(doxie.layout_references) did_ds) := 
	join(did_ds, keyfile, left.did > 0 and left.did = right.did, tra(right));

