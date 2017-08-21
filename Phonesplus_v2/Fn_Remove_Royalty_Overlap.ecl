//Funtion to remove records in the royalty file that are also in the phoneplus base file
export Fn_Remove_Royalty_Overlap(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

pplus_base := phonesplus_v2.File_Phonesplus_Base;

different_did_phone := join(distribute(phplus_in(did > 0), hash(did)),
                            distribute(pplus_base(did > 0), hash(did)),
														left.did = right.did and
														left.npa+left.phone7 = right.npa+ right.phone7,
														left only,
														local);

different_did_phone_all := different_did_phone  + phplus_in(did = 0);

														
different_name_addr_phone := join(distribute(different_did_phone_all, hash(npa+phone7)),
                            distribute(pplus_base, hash(npa+phone7)),
														left.npa+left.phone7 = right.npa+ right.phone7 and
														left.fname = right.fname and
														left.lname = right.lname and
														left.prim_range = right.prim_range and
														left.prim_name = right.prim_name and
														left.sec_range = right.sec_range and
														left.zip5 = right.zip5,
														left only,
														local);
return different_name_addr_phone;
end;