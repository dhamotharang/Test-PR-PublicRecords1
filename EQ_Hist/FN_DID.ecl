import header,did_add;

rec := layout.base;

export FN_DID(
	dataset(rec) header_in, 
	unsigned2 thresh = 75):=
FUNCTION

//***** Prep for DIDing
temprec := record
	rec;
	typeof(header_in.clean_dob) dob;
	typeof(header_in.zip) z5;
	typeof(header_in.clean_phone) phone10;
end;

temprec prepit(rec l) := transform
	self.dob := l.clean_dob;
	self.z5 := l.zip;
	self.phone10 := l.clean_phone;
	self := l;
end;

prep := project(header_in, prepit(left));

//***** DIDing
matchset := ['A','D','S','P','4','G','Z'];

did_add.MAC_Match_Fast(prep, matchset, outf, true, false)

//***** Put back in rec
rec tra(outf l) := transform
	self.did := if((unsigned2)l.did_score >= thresh, (unsigned6)l.did_string, 0);
	self := l;
end;

return project(outf, tra(left));

END;