import doxie_build, ut;

ut.MAC_SK_Move('~thor_data400::key::dl_'+doxie_build.buildstate,'P',out1);
ut.MAC_SK_Move('~thor_data400::key::dl_number_'+doxie_build.buildstate,'P',out2);
ut.MAC_SK_Move_v2( '~thor_data400::key::dl_indicatives'+doxie_build.buildstate, 'P', out3); 

export Proc_AcceptSK_dl_toProd := parallel(out1, out2, out3);