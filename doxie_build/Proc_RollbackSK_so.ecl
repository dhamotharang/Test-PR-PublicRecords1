import ut;

ut.MAC_SK_Move('~thor_data400::key::sexoffender_spk'+doxie_build.buildstate,'R',out1)
ut.MAC_SK_Move('~thor_data400::key::sexoffender_offenses_'+doxie_build.buildstate,'R',out2)
ut.MAC_SK_Move('~thor_data400::key::sexoffender_did'+doxie_build.buildstate,'R',out3)

export Proc_RollbackSK_so := parallel(out1, out2, out3);