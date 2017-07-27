import ut;
ut.MAC_SK_Move('~thor_data400::key::file_name_ssn','Q',out1);
ut.mac_sk_move('~thor_data400::key::file_name_addr','Q',out2);
ut.mac_sk_move('~thor_data400::key::file_name_addr_nn','Q',out3);
ut.mac_sk_move('~thor_data400::key::file_name_address_st','Q',out4);
ut.mac_sk_move('~thor_data400::key::file_name_zip','Q',out5);
ut.mac_sk_move('~thor_data400::key::file_name_dob','Q',out6);
ut.mac_sk_move('~thor_data400::key::file_name_dayob','Q',out7);
ut.mac_sk_move('~thor_data400::key::file_name_phone','Q',out8);
ut.mac_sk_move('~thor_data400::key::key_nazs4_age','Q',out9);
ut.mac_sk_move('~thor_data400::key::key_nazs4_zip','Q',out10);
ut.mac_sk_move('~thor_data400::key::key_nazs4_ssn4','Q',out11);
ut.mac_sk_move('~thor_data400::key::hss_ns_did','Q',out12);
ut.mac_sk_move('~thor_data400::key::hss_na_did','Q',out13);
ut.mac_sk_move('~thor_data400::key::hss_np_did','Q',out14);
ut.mac_sk_move('~thor_data400::key::hss_nd_did','Q',out15);
ut.mac_sk_move('~thor_data400::key::hss_fz_did','Q',out16);
ut.mac_sk_move('~thor_Data400::key::did_ssn_glb','Q',out18);
ut.mac_sk_move('~thor_Data400::key::did_ssn_nonglb','Q',out19);
ut.mac_sk_move('~thor_Data400::key::did_ssn_nonutil','Q',out20);
ut.mac_sk_move('~thor_Data400::key::did_ssn_nonglb_nonutil','Q',out21);
ut.mac_sk_move('~thor_data400::key::header_hashes','Q',out22);
ut.mac_sk_move('~thor_data400::key::probationary_dids','Q',out23);

all_out := sequential(out1,out2,out3,out4,out5,out6,out7,out8,
		 out9,out10,out11,out12,out13,out14,out15,out16,out18,
		 out19,out20,out21,out22,out23);

export Proc_AcceptSK_toQA := all_out;