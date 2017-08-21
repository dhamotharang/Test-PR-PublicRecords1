
File_phonefeed_base := dataset('~thor_data400::base::infutorcid',InfutorCID.Layout_InfutorCID_Base,thor);
File_phonefeed_base_father := dataset('~thor_data400::base::infutorcid_father',InfutorCID.Layout_InfutorCID_Base,thor);

File_phonefeed_base_dst := distribute(File_phonefeed_base((unsigned)phone<>0) ,HASH32(phone));
File_phonefeed_base_father_dst := distribute(File_phonefeed_base_father((unsigned)phone<>0),HASH32(phone));

InfutorCID.Layout_InfutorCID_Base join_phonefeed_tr(File_phonefeed_base le,File_phonefeed_base_father re) := transform

self := le;
end;

update_phonefeedback := join(File_phonefeed_base_dst,File_phonefeed_base_father_dst,LEFT.phone=RIGHT.phone,join_phonefeed_tr(LEFT,RIGHT),LEFT ONLY,local);

output(choosen(update_phonefeedback,100),named('infutor_qa_samples'));

