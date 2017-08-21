// join these phone numbers to select matching business header phone records

layout_phone_source := record
unsigned6 bdid;
string10 phone;
string2 source;
end;

bh := Business_Header.File_Business_Header(phone <> 0);

bh_phones := project(bh,
                     transform(layout_phone_source, self.phone := intformat(left.phone, 10, 1), self := left));
				 
bh_phones_dedup := dedup(bh_phones, all);

// Match phone diff to business header phone sources
bh_phones_diff := join(bh_phones_dedup,
                       phone_diff_dedup,
				   left.phone = right.phone,
				   transform(layout_phone_source, self := left),
				   hash);

bh_phones_diff_dedup := dedup(bh_phones_diff, all);

// Filter out any BDIDs not in marketing filtered output
f3 := dataset('TMTEST::directorynet_bdid_did_prep', TM_Test.Layout_DirectoryNet_Base, flat);

bh_phones_diff_dedup_mktapp := join(bh_phones_diff_dedup,
                                    f3(bdid <> 0),
							 left.bdid = right.bdid,
							 transform(layout_phone_source, self := left),
							 hash);

output(bh_phones_diff_dedup_mktapp(source = 'GB'),all);
output(bh_phones_diff_dedup_mktapp(source = 'Y'),all);


bh_phones_diff_dedup1 := dedup(bh_phones_diff_dedup_mktapp, phone, source, all);

// Get stat to see which sources contain these phones
layout_phone_source_stat := record
bh_phones_diff_dedup1.source;
cnt := count(group);
end;

bh_phones_diff_stat := table(bh_phones_diff_dedup1, layout_phone_source_stat, source, few);

output(bh_phones_diff_stat, all);
