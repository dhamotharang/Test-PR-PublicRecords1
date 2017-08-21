//Picks ssn2 record that might have a DID if ssn1 has no DID

ssn1 := first_data.Get_AddrID(which_ssn='1');
ssn2 := first_data.Get_AddrID(which_ssn='2');

first_data.layout_fatrec choose_the_better_record(first_data.layout_fatrec l, first_data.layout_fatrec r) := transform
 self.did       := if(l.did<>0,l.did,r.did);
 self.ssn       := if(l.did<>0,l.ssn,r.ssn);
 self.which_ssn := if(l.did<>0,l.which_ssn,r.which_ssn);
 self           := l;
end;

export Choose_SSN1_or_SSN2 := join(ssn1,ssn2,
                                   left.boca_id=right.boca_id,
					               choose_the_better_record(left,right),
					               left outer
					              );