import ut;
ut.MAC_SK_Move('~thor_data400::key::property_assessor.fid','P',one);
ut.MAC_SK_Move('~thor_data400::key::property_deed.fid','P',two);
ut.MAC_SK_Move('~thor_data400::key::property_search.did','P',three);
ut.MAC_SK_Move('~thor_data400::key::addr_search.fid','P',four);
ut.mac_sk_move_v2('~thor_data400::key::property_bdid','P',five,2);
ut.mac_sk_move_v2('~thor_data400::key::assessors_parcelnum','P',six,2);
ut.mac_sk_move_v2('~thor_data400::key::deeds_parcelnum','P',seven,2);

export Proc_AcceptSK_toProd := parallel(one,two,three,four,five,six,seven);