import promotesupers,autokey,RoxieKeyBuild;

promotesupers.Mac_SK_Move_v2('~thor_data400::key::sexoffender_spk'+doxie_build.buildstate,'Q',out1a,,false)
promotesupers.Mac_SK_Move_v2('~thor_data400::key::sexoffender_enh'+doxie_build.buildstate,'Q',out1b,,false)
promotesupers.Mac_SK_Move_v2('~thor_data400::key::sexoffender_offenses_'+doxie_build.buildstate,'Q',out2,,false)
promotesupers.Mac_SK_Move_v2('~thor_data400::key::sexoffender_did'+doxie_build.buildstate,'Q',out3,,false)
promotesupers.Mac_SK_Move_v2('~thor_data400::key::sexoffender_fdid_'+doxie_build.buildstate,'Q',out4,,false)
promotesupers.Mac_SK_Move_v2('~thor_data400::key::sexoffender_zip_type_'+doxie_build.buildstate,'Q',out5,,false)

promotesupers.Mac_SK_Move_v2('~thor_data400::key::sexoffender::fcra::didpublic','Q',out6,,false)
promotesupers.Mac_SK_Move_v2('~thor_data400::key::sexoffender::fcra::enhpublic','Q',out7,,false)
promotesupers.Mac_SK_Move_v2('~thor_data400::key::sexoffender::fcra::offenses_public','Q',out8,,false)
promotesupers.Mac_SK_Move_v2('~thor_data400::key::sexoffender::fcra::spkpublic','Q',out9,,false)

autokey.MAC_AcceptSK_to_QA('~thor_data400::key::so_'+buildstate,autokeymove1,false);
autokey.MAC_AcceptSK_to_QA('~thor_data400::key::so_enh'+buildstate,autokeymove2,false);

export Proc_AcceptSK_so_toQA := parallel(out1a, out1b, out2, out3, out4, out5, out6, out7, out8, out9, autokeymove1, autokeymove2);