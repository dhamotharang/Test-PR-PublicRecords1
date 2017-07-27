import ut,doxie_files;

pre := ut.SF_MaintBuilding('~thor_data400::base::DLSearch_' + doxie_build.buildstate);

ut.MAC_SK_BuildProcess_v2(doxie_files.key_dl,'~thor_data400::key::dl_'+doxie_build.buildstate, a)
ut.mac_sk_buildprocess(doxie_build.key_prep_dl_number,'~thor_data400::key::dl_number_'+doxie_build.buildstate,'~thor_data400::key::dl_number_'+doxie_build.buildstate,b,3)
ut.MAC_SK_BuildProcess_v2(doxie_files.key_dl_indicatives, '~thor_data400::key::dl_indicatives'+doxie_build.buildstate, c)

post := ut.SF_MaintBuilt('~thor_data400::base::DLSearch_' + doxie_build.buildstate);
		
export Proc_Build_DL_Search_Keys := if (fileservices.getsuperfilesubname('~thor_data400::base::DLSearch_'+doxie_build.buildstate,1) = fileservices.getsuperfilesubname('~thor_data400::base::DLSearch_' +  doxie_build.buildstate + '_BUILT',1),
		output('BASE = BUILT, Nothing done.'),
		sequential(pre,a,b,c,post));