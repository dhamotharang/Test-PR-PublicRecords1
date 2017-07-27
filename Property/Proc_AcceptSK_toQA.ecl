import ut;
ut.MAC_SK_Move('~thor_data400::key::property_assessor.fid','Q',one);
ut.MAC_SK_Move('~thor_data400::key::property_deed.fid','Q',two);
ut.MAC_SK_Move('~thor_data400::key::property_search.did','Q',three);
ut.MAC_SK_Move('~thor_data400::key::addr_search.fid','Q',four);
ut.mac_sk_move_v2('~thor_data400::key::property_bdid','Q',five,2);
ut.mac_sk_move_v2('~thor_data400::key::assessors_parcelnum','Q',six,2);
ut.mac_sk_move_v2('~thor_data400::key::deeds_parcelnum','Q',seven,2);

export Proc_AcceptSK_toQA := parallel(one,two,three,four,five,six,seven);