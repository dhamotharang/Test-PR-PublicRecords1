export Out_qa_samples(string filedate) := function

File_phonefeed_base := index(PhonesFeedback.Key_PhonesFeedback_phone(),'~thor_data400::key::phonesfeedback::'+filedate+'::phone');
File_phonefeed_base_father := index(PhonesFeedback.Key_PhonesFeedback_phone(),'~thor_data400::key::phonesfeedback::father::phone');

File_phonefeed_base_dst := distribute(File_phonefeed_base,HASH32(phone_number));
File_phonefeed_base_father_dst := distribute(File_phonefeed_base_father,HASH32(phone_number));

phonesFeedback.Layouts_PhonesFeedback.Layout_PhonesFeedback_base join_phonefeed_tr(File_phonefeed_base le,File_phonefeed_base_father re) := transform

self := le;
end;

update_phonefeedback := join(File_phonefeed_base_dst,File_phonefeed_base_father_dst,LEFT.phone_number=RIGHT.phone_number,join_phonefeed_tr(LEFT,RIGHT),LEFT ONLY,local);

result := output(choosen(update_phonefeedback ( street_name <> '' and city <> ''),100),named('PhoneFeedBackQASamples'));

return result;
end;