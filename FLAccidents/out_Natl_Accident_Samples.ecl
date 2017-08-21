File_Base_Natl_Accident := dataset('~thor_data400::base::ntlcrash',FLAccidents.Layout_NtlAccidents_Alpharetta.clean,thor);
File_Base_Natl_Accident_father := dataset('~thor_data400::base::ntlcrash_father',FLAccidents.Layout_NtlAccidents_Alpharetta.clean,thor);

dist_base := distribute(File_Base_Natl_Accident,HASH32(ORDER_ID,ACCT_NBR));
dist_base_father := distribute(File_Base_Natl_Accident_father,HASH32(ORDER_ID,ACCT_NBR));

FLAccidents.Layout_NtlAccidents_Alpharetta.clean tr_Natl_Accident(dist_base l,dist_base_father r) := transform
self := l;
end;

//to get the updates

to_update := join(dist_base,dist_base_father,LEFT.ORDER_ID=RIGHT.ORDER_ID AND LEFT.ACCT_NBR=RIGHT.ACCT_NBR,tr_Natl_Accident(LEFT,RIGHT),LEFT ONLY,LOCAL);

sort_update := sort(to_update,ORDER_ID,ACCT_NBR);

dedup_update := dedup(sort_update,ORDER_ID,ACCT_NBR);

export out_Natl_Accident_Samples := output(topn(to_update,200,-ORDER_ID),named('Natl_Accident_QA_Samples'));
