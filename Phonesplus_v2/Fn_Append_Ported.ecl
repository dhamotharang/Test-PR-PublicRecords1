//****************Function to append flags/indicators when matching to Neustar********************
export Fn_Append_Ported(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

Ported_dedp1 := dedup(sort(distribute(File_Ported, hash(CellPhone)),CellPhone,local),CellPhone,local);

Ported_dedp2 :=  dedup(sort(distribute(Ported_dedp1, hash(CellPhone[4..])),CellPhone[4..],local),CellPhone[4..],local);

phplus_in_d1 := distribute(phplus_in, hash(npa+phone7));

//match phone 10  - a match indicates the phone was ported
recordof(phplus_in) t_append_ported1(phplus_in_d1 le,Ported_dedp1 ri)  := transform
	self.append_ported_match := if(ri.cellphone <> '', le.append_ported_match | 1b, le.append_ported_match | 0b);
	self := le;
end;

Append_Ported1 := join(phplus_in_d1,
					   Ported_dedp1,
					   left.npa+left.phone7 = right.cellphone,
					   t_append_ported1(left, right),
						 left outer,
					   local);
					   
//match phone 7  - a match indicates the phone has a small chance of being ported
phplus_in_d2 := distribute(Append_Ported1, hash(phone7));

recordof(phplus_in) t_append_ported2(phplus_in_d2 le, Ported_dedp2 ri)  := transform
	self.append_ported_match := if(ri.cellphone <> '', le.append_ported_match | 10b, le.append_ported_match | 0b);
	self := le;
end;
Append_Ported2 := join(phplus_in_d2,
					   Ported_dedp2,
					   left.phone7 = right.cellphone[4..],
					   t_append_ported2(left, right),
						 left outer,
					   local);


return Append_Ported2;
end;

