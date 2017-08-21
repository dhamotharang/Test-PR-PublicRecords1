Export Out_qa_samples := function

File_Addressfeed_base := dataset('~thor_data400::base::AddressFeedback',AddressFeedback.Layouts.Lay_AddressFeedback_base,thor);
File_Addressfeed_base_father := dataset('~thor_data400::base::addressfeedback_father',AddressFeedback.Layouts.Lay_AddressFeedback_base,thor);

File_Addressfeed_base_dst := distribute(File_Addressfeed_base(did>0),HASH32(did));
File_Addressfeed_base_father_dst := distribute(File_Addressfeed_base_father(did>0),HASH32(did));

AddressFeedback.Layouts.Lay_AddressFeedback_base join_Addressfeed_tr(File_Addressfeed_base le,File_Addressfeed_base_father re) := transform
Self := le;
End;

update_Addressfeedback := join(File_Addressfeed_base_dst,File_Addressfeed_base_father_dst,LEFT.did=RIGHT.did,join_Addressfeed_tr(LEFT,RIGHT),LEFT ONLY,local);

Result := output(choosen(update_Addressfeedback,100),named('AddressFeedBackQASamples'));
Return result;
End;