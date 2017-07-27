import doxie_build, ut;

ut.MAC_SK_Move('~thor_data400::key::dl_'+doxie_build.buildstate,'R',out1);
ut.MAC_SK_Move('~thor_data400::key::dl_number_'+doxie_build.buildstate,'R',out2);


export Proc_RollbackSK_dl := parallel(out1, out2);