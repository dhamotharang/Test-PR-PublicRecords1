import ut;
ut.MAC_SK_Move('~thor_data400::key::file_name_ssn','P',out1);
ut.mac_sk_move('~thor_data400::key::file_name_addr','P',out2);
ut.mac_sk_move('~thor_data400::key::file_name_addr_nn','P',out3);
ut.mac_sk_move('~thor_data400::key::file_name_address_st','P',out4);
ut.mac_sk_move('~thor_data400::key::file_name_zip','P',out5);
ut.mac_sk_move('~thor_data400::key::file_name_dob','P',out6);
ut.mac_sk_move('~thor_data400::key::file_name_dayob','P',out7);
ut.mac_sk_move('~thor_data400::key::file_name_phone','P',out8);
ut.mac_sk_move('~thor_data400::key::key_nazs4_age','P',out9);
ut.mac_sk_move('~thor_data400::key::key_nazs4_zip','P',out10);
ut.mac_sk_move('~thor_data400::key::key_nazs4_ssn4','P',out11);
ut.mac_sk_move('~thor_data400::key::hss_ns_did','P',out12);
ut.mac_sk_move('~thor_data400::key::hss_na_did','P',out13);
ut.mac_sk_move('~thor_data400::key::hss_np_did','P',out14);
ut.mac_sk_move('~thor_data400::key::hss_nd_did','P',out15);
ut.mac_sk_move('~thor_data400::key::hss_fz_did','P',out16);
ut.MAC_SK_Move('~thor_data400::key::did_ssn_glb','P',out18);
ut.MAC_SK_Move('~thor_data400::key::did_ssn_nonglb','P',out19);
ut.MAC_SK_Move('~thor_data400::key::did_ssn_nonutil','P',out20);
ut.MAC_SK_Move('~thor_data400::key::did_ssn_nonglb_nonutil','P',out21);
ut.mac_sk_move('~thor_data400::key::header_hashes','P',out22);
ut.mac_sk_move('~thor_data400::key::probationary_dids','P',out23);

all_out := sequential(out1,out2,out3,out4,out5,out6,out7,out8,
		 out9,out10,out11,out12,out13,out14,out15,out16,out22,out23);

export Proc_AcceptSK_toProd := all_out;