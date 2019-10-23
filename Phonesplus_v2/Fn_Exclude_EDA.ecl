import Gong_Neustar;
//****************Function to exclud records that match Active EDA***************
export Fn_Exclude_EDA(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

// VC - Using newer file DF-23004. As per Charles file_gongmaster should not be used for anything
// gongf 	:=	distribute(gong_v2.file_gongmaster  (current_record_flag = 'Y' and phone10 <> ''), hash(phone10));
gongf	 	:=	distribute(Gong_Neustar.File_History(current_record_flag = 'Y' and phone10 <> ''), hash(phone10));


//------------Remove EDA records
remove_eda1    := join(distribute(phplus_in, hash(npa+phone7)),
									gongf,
									left.npa+left.phone7 = right.phone10,
									transform(recordof(phplus_in), self := left),
									left only,
									local);
									
remove_eda2    := join(distribute(remove_eda1(did >0), hash(did)),
									distribute(gongf(did > 0), hash(did)),
									left.did = right.did and
									left.phone7 = right.phone10[4..10],
									transform(recordof(phplus_in), self := left),
									left only,
									local);

return remove_eda2 + remove_eda1 (did = 0);

end;