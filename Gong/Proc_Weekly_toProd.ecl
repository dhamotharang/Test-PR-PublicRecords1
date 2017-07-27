import ut;
ut.MAC_SK_Move_v2('~thor_data400::key::header','P',out1,2,true);
ut.MAC_SK_Move_v2('~thor_data400::key::header_lookups','P',out2,2,true);
ut.MAC_SK_Move_v2('~thor_data400::key::header.phone','P',out3,2,true);
ut.mac_sk_move('~thor_data400::key::gong_did','P',out4);
ut.mac_sk_move('~thor_data400::key::gong_hhid','P',out5);
ut.mac_sk_move('~thor_data400::key::gong_address','P',out6);


export Proc_Weekly_toProd := parallel(out1,out2,out3,out4,out5,out6);
