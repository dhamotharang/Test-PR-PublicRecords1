//****************Function to append flags/indicators when matching to Non-pub***************
export Fn_Append_NonPub(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

non_pub := File_Nonpublished;
non_pub_d1 	:=	sort(distribute(non_pub(did > 0), hash(did)), did, FileID, local);
non_pub_d2 	:=	sort(distribute(non_pub, hash(lname, prim_range, prim_name, sec_range, zip5)), lname, prim_range, prim_name, sec_range, zip5, FileID, local);
non_pub_d3	:=  sort(distribute(non_pub (phone <> '' and length(prim_range +  prim_name + sec_range + zip5) > 5 ), hash(phone, prim_range, prim_name, sec_range, zip5)),phone, prim_range, prim_name, sec_range, zip5, FileID, local);

//----Match to non-pub by did
phplus_in_d1:=  distribute(phplus_in, hash(did));
recordof(phplus_in) t_match_nonpub1(phplus_in_d1 le, non_pub_d1 ri) := transform
	self.append_nonpublished_match := if(ri.did > 0 and ri.FileID[..1] = 'G', 
									     le.append_nonpublished_match | 1b, 
										 if(ri.did > 0 and ri.FileID = 'TA',
										    le.append_nonpublished_match | 10000b,
											le.append_nonpublished_match |0b));
	self:= le;
end;

match_nonpub1 := join(phplus_in_d1, 
				      non_pub_d1,
					  left.did = right.did and
					  left.pdid = 0,
					  t_match_nonpub1(left, right),
					  left outer,
					  keep(1),
					  local);
					  
//----Match to non-pub by name and address				  
phplus_in_d2:=  distribute(match_nonpub1, hash(lname, prim_range, prim_name, sec_range, zip5));

recordof(phplus_in) t_match_nonpub2(phplus_in_d2 le, non_pub_d2 ri) := transform
	self.append_nonpublished_match := if(ri.lname <> '' and ri.FileID[..1] = 'G', 
									     le.append_nonpublished_match | 10b,
										  if(ri.lname <> '' and ri.FileID = 'TA',
										     le.append_nonpublished_match | 100000b,
										     le.append_nonpublished_match |0b));	
	self:= le;
end;

match_nonpub2 := join(phplus_in_d2, 
				      non_pub_d2,
					  left.lname = right.lname and
					  left.prim_range = right.prim_range and
					  left.prim_name = right.prim_name and
					  left.sec_range = right.sec_range and
					  left.zip5 = right.zip5,
					  t_match_nonpub2(left, right),
					  left outer,
					  keep(1),
					  local);
					  
//----Match to non-pub by 7 first phone digits and address
phplus_in_d3:=  distribute(match_nonpub2, hash(npa+phone7, prim_range, prim_name, sec_range, zip5));

recordof(phplus_in) t_match_nonpub3(phplus_in_d3 le, non_pub_d3 ri) := transform
	self.append_nonpublished_match := if(ri.phone <> '' and ri.FileID[..1] = 'G', 
										le.append_nonpublished_match | 100b, 
										if(ri.phone <> '' and ri.FileID = 'TA',
										   le.append_nonpublished_match | 1000000b,
										   le.append_nonpublished_match |0b));
	self:= le;
end;

match_nonpub3 := join(phplus_in_d3, 
				      non_pub_d3,
					  left.npa+left.phone7[..7] = right.phone[..7] and
					  left.prim_range = right.prim_range and
					  left.prim_name = right.prim_name and
					  left.sec_range = right.sec_range and
					  left.zip5 = right.zip5 and
					  left.lname = right.lname,
					  t_match_nonpub3(left, right),
					  left outer,
					  keep(1),
					  local);
					  
//----Match to non-pub by did and  7 first phone digits
phplus_in_d4:=  distribute(match_nonpub3, hash(did));

recordof(phplus_in) t_match_nonpub4(phplus_in_d4 le, non_pub_d1 ri) := transform
	self.append_nonpublished_match := if(ri.phone <> '' and ri.did > 0 and ri.FileID[..1] = 'G', 
										le.append_nonpublished_match | 1000b, 
										if(ri.phone <> '' and ri.did > 0 and ri.FileID = 'TA',
										   le.append_nonpublished_match | 10000000b,
										   le.append_nonpublished_match |0b));
	self:= le;
end;

match_nonpub4 := join(phplus_in_d4, 
				      non_pub_d1,
					  left.did = right.did and
					  left.npa+left.phone7[..7] = right.phone[..7],
					  t_match_nonpub4(left, right),
					  left outer,
					  keep(1),
					  local);
					  
return match_nonpub4;

end;