import doxie_build, RoxieKeyBuild;

RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dl2::@version@::dl_'+doxie_build.buildstate,'Q',out1);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dl2::@version@::dl_did_'+doxie_build.buildstate,'Q',out1a);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dl2::@version@::dl_number_'+doxie_build.buildstate,'Q',out2);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dl2::@version@::dl_indicatives_'+doxie_build.buildstate, 'Q', out3); 
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dl2::@version@::bocaShell_DL_DID','Q',out4);

RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dl2::fcra::@version@::dl_did','Q',out5);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dl2::fcra::@version@::dl_number','Q',out6);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dl2::fcra::@version@::BocaShell.DID','Q',out7);

export Proc_AcceptSK_dl_toQA := parallel(out1, out1a, out2, out3, out4, out5, out6, out7);
