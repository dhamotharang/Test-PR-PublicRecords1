import RoxieKeyBuild,ut,doxie_build;

export Proc_Build_DL_Search_keys(string filedate) := 
function

pre := ut.SF_MaintBuilding('~thor_data400::base::DL2::DLSearch_' + doxie_build.buildstate);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DriversV2.key_dl,'~thor_data400::key::dl2::@version@::dl_'+doxie_build.buildstate,'~thor_data400::key::dl2::'+filedate+'::dl_'+doxie_build.buildstate, a);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_Local(DriversV2.key_dl_did,'~thor_data400::key::dl2::@version@::dl_did_'+doxie_build.buildstate, '~thor_data400::key::dl2::'+filedate+'::did_'+doxie_build.buildstate,a2);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_Local(DriversV2.key_prep_dl_number,'~thor_data400::key::dl2::@version@::dl_number_'+doxie_build.buildstate,'~thor_data400::key::dl2::'+filedate+'::dl_number_'+doxie_build.buildstate, b);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DriversV2.key_dl_indicatives, '~thor_data400::key::dl2::@version@::dl_indicatives_'+doxie_build.buildstate,'~thor_data400::key::dl2::'+filedate+'::indicatives_'+doxie_build.buildstate, c);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DriversV2.Key_BocaShell_DL, '~thor_data400::key::dl2::@version@::bocaShell_DL_DID','~thor_data400::key::dl2::'+filedate+'::bocashell_did', c2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DriversV2.Key_BocaShell_DL_FCRA, '~thor_data400::key::dl2::fcra::@version@::bocaShell.DID','~thor_data400::key::dl2::fcra::'+filedate+'::bocashell.did', c3);



RoxieKeyBuild.Mac_SK_Diff(DriversV2.key_dl,'~thor_data400::key::dl2::dl_'+doxie_build.buildstate,'~thor_data400::key::dl2::'+filedate+'::dl_'+doxie_build.buildstate, d);
RoxieKeyBuild.MAC_SK_Diff(DriversV2.key_dl_did,'~thor_data400::key::dl2::dl_did_'+doxie_build.buildstate, '~thor_data400::key::dl2::'+filedate+'::did_'+doxie_build.buildstate,d2);
RoxieKeyBuild.Mac_SK_Diff(DriversV2.key_dl_indicatives, '~thor_data400::key::dl2::dl_indicatives_'+doxie_build.buildstate,'~thor_data400::key::dl2::'+filedate+'::indicatives_'+doxie_build.buildstate, e);


RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dl2::@version@::dl_'+doxie_build.buildstate,'~thor_data400::key::dl2::'+filedate+'::dl_'+doxie_build.buildstate, f);
RoxieKeyBuild.MAC_SK_Move_to_Built_v2('~thor_data400::key::dl2::@version@::dl_did_'+doxie_build.buildstate, '~thor_data400::key::dl2::'+filedate+'::did_'+doxie_build.buildstate,f2);
RoxieKeyBuild.MAC_SK_Move_to_Built_v2('~thor_data400::key::dl2::@version@::dl_number_'+doxie_build.buildstate,'~thor_data400::key::dl2::'+filedate+'::dl_number_'+doxie_build.buildstate, g);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dl2::@version@::dl_indicatives_'+doxie_build.buildstate,'~thor_data400::key::dl2::'+filedate+'::indicatives_'+doxie_build.buildstate, h);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dl2::@version@::bocaShell_DL_DID','~thor_data400::key::dl2::'+filedate+'::bocashell_did',h2);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dl2::fcra::@version@::BocaShell.DID','~thor_data400::key::dl2::fcra::' + filedate + '::bocashell.did', h3);



post := ut.SF_MaintBuilt('~thor_data400::base::DL2::DLSearch_' + doxie_build.buildstate);

return if (fileservices.getsuperfilesubname('~thor_data400::base::DL2::DLSearch_'+doxie_build.buildstate,1) = fileservices.getsuperfilesubname('~thor_data400::base::DL2::DLSearch_' +  doxie_build.buildstate + '_BUILT',1),
		output('BASE = BUILT, Nothing done.'),
		sequential(pre,parallel(a,a2,b,c,c2,c3),
					parallel(d,d2,e),
					parallel(f,f2,g,h,h2,h3),post,
					proc_build_wildcard_search(filedate)));		

end;
