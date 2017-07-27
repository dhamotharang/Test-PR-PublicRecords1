import ut,autokey;

ut.MAC_SK_Move('~thor_data400::key::sexoffender_spk'+doxie_build.buildstate,'P',out1)
ut.MAC_SK_Move('~thor_data400::key::sexoffender_offenses_'+doxie_build.buildstate,'P',out2)
ut.MAC_SK_Move('~thor_data400::key::sexoffender_did'+doxie_build.buildstate,'P',out3)
ut.MAC_SK_Move('~thor_data400::key::sexoffender_fdid_'+doxie_build.buildstate,'P',out4)
autokey.MAC_AcceptSK_to_Prod('~thor_data400::key::so_'+buildstate,autokeymove);

export Proc_AcceptSK_so_toProd := parallel(out1, out2, out3, out4, autokeymove);