export mac_BlankDIDWhenSSNInvalid(inf, outf) :=
MACRO

#uniquename(set_vs)
%set_vs% := ['G','O'];

#uniquename(h)
#uniquename(d)
%h% := header.File_Headers(valid_ssn in %set_vs%);
%d% := dedup(project(%h%, {%h%.did, %h%.ssn}), all);

outf := join(inf, %d%, (unsigned6)left.did = (unsigned6)right.did and left.ssn = right.ssn, 
								 transform({inf}, 
													 self.did := right.did, 	//this only lets you keep the DID if the SSN is valid for that person
													 self.did_score := if(right.did > 0, left.did_score, 0),
													 self := left),
								 left outer, hash);
								 
endmacro; 