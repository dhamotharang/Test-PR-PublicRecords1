import roxiekeybuild;
roxiekeybuild.Mac_SK_Move('~thor_data400::key::file_name_ssn','Q',out1);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::file_name_addr','Q',out2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::file_name_addr_nn','Q',out3);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::file_name_address_st','Q',out4);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::file_name_zip','Q',out5);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::file_name_dob','Q',out6);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::file_name_dayob','Q',out7);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::file_name_phone','Q',out8);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::key_nazs4_age','Q',out9);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::key_nazs4_zip','Q',out10);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::key_nazs4_ssn4','Q',out11);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::hss_ns_did','Q',out12);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::hss_na_did','Q',out13);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::hss_np_did','Q',out14);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::hss_nd_did','Q',out15);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::hss_fz_did','Q',out16);
roxiekeybuild.Mac_SK_Move('~thor_Data400::key::did_ssn_glb','Q',out18);
roxiekeybuild.Mac_SK_Move('~thor_Data400::key::did_ssn_nonglb','Q',out19);
roxiekeybuild.Mac_SK_Move('~thor_Data400::key::did_ssn_nonutil','Q',out20);
roxiekeybuild.Mac_SK_Move('~thor_Data400::key::did_ssn_nonglb_nonutil','Q',out21);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::probationary_dids','Q',out23);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::header::ssn4_zip_yob_fi','Q',out24);

all_out := sequential(
											out1
											,out2
											,out3
											,out4
											,out5
											,out6
											,out7
											,out8
											,out9
											,out10
											,out11
											,out12
											,out13
											,out14
											,out15
											,out16
											,out18
											,out19
											,out20
											,out21
											,out23
											,out24
											);

export Proc_AcceptSK_toQA := all_out;