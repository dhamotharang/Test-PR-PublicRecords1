import doxie_build, ut;

ut.MAC_SK_Move('~thor_data400::key::dl_'+doxie_build.buildstate,'Q',out1);
ut.MAC_SK_Move('~thor_data400::key::dl_did_'+doxie_build.buildstate,'Q',out1a);
ut.MAC_SK_Move('~thor_data400::key::dl_number_'+doxie_build.buildstate,'Q',out2);
ut.MAC_SK_Move_v2('~thor_data400::key::dl_indicatives'+doxie_build.buildstate, 'Q', out3); 
ut.Mac_sk_Move_v2('~thor_data400::key::bocaShell_DL_DID','Q',out4);

ut.Mac_sk_Move_v2('~thor_data400::key::dl::fcra::dl_did','Q',out5);
ut.Mac_sk_Move_v2('~thor_data400::key::dl::fcra::dl_number','Q',out6);
ut.Mac_sk_Move_v2('~thor_data400::key::dl::fcra::BocaShell.DID','Q',out7);

export Proc_AcceptSK_dl_toQA := parallel(out1, out1a, out2, out3, out4, out5, out6, out7);