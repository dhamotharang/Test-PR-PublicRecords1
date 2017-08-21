import RoxieKeyBuild,ut,doxie_files;
export Proc_Build_DL_Search_keys(string filedate) := 
function

pre := ut.SF_MaintBuilding('~thor_data400::base::DLSearch_' + doxie_build.buildstate);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie_files.key_dl,'~thor_data400::key::dl_'+doxie_build.buildstate,'~thor_data400::key::dl::'+filedate+'::'+doxie_build.buildstate, a);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_Local(doxie_files.key_dl_did,'~thor_data400::key::dl_did_'+doxie_build.buildstate, '~thor_data400::key::dl::'+filedate+'::did_'+doxie_build.buildstate,a2);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_Local(doxie_files.key_dl_did_FCRA,'~thor_data400::key::dl::fcra::dl_did', '~thor_data400::key::dl::fcra::' + filedate + '::dl_did', a3);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_Local(doxie_files.key_dl_number_FCRA,'~thor_data400::key::dl::fcra::dl_number', '~thor_data400::key::dl::fcra::' + filedate + '::dl_number', a4);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(doxie_build.key_prep_dl_number,'~thor_data400::key::dl::'+filedate+'::number_'+doxie_build.buildstate,'~thor_data400::key::dl_number_'+doxie_build.buildstate,b,3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie_files.key_dl_indicatives, '~thor_data400::key::dl_indicatives'+doxie_build.buildstate,'~thor_data400::key::dl::'+filedate+'::indicatives'+doxie_build.buildstate, c);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie_files.Key_BocaShell_DL, '~thor_data400::key::bocaShell_DL_DID','~thor_data400::key::dl::'+filedate+'::bocashell_did', c2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie_files.Key_BocaShell_DL_FCRA, '~thor_data400::key::dl::fcra::bocaShell.DID','~thor_data400::key::dl::fcra::'+filedate+'::bocashell.did', c3);

RoxieKeyBuild.Mac_SK_Diff(doxie_files.key_dl,'~thor_data400::key::dl_'+doxie_build.buildstate,'~thor_data400::key::dl::'+filedate+'::'+doxie_build.buildstate, d);
RoxieKeyBuild.MAC_SK_Diff(doxie_files.key_dl_did,'~thor_data400::key::dl_did_'+doxie_build.buildstate, '~thor_data400::key::dl::'+filedate+'::did_'+doxie_build.buildstate,d2);
RoxieKeyBuild.MAC_SK_Diff(doxie_files.key_dl_did_FCRA,'~thor_data400::key::dl::fcra::dl_did', '~thor_data400::key::dl::fcra::' + filedate + '::dl_did', d3);
RoxieKeyBuild.Mac_SK_Diff(doxie_files.key_dl_indicatives, '~thor_data400::key::dl_indicatives'+doxie_build.buildstate,'~thor_data400::key::dl::'+filedate+'::indicatives'+doxie_build.buildstate, e);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dl_'+doxie_build.buildstate,'~thor_data400::key::dl::'+filedate+'::'+doxie_build.buildstate, f);
RoxieKeyBuild.MAC_SK_Move_to_Built_v2('~thor_data400::key::dl_did_'+doxie_build.buildstate, '~thor_data400::key::dl::'+filedate+'::did_'+doxie_build.buildstate,f2);
RoxieKeyBuild.MAC_SK_Move_to_Built_v2('~thor_data400::key::dl::fcra::dl_did', '~thor_data400::key::dl::fcra::' + filedate + '::dl_did', f3);
RoxieKeyBuild.MAC_SK_Move_to_Built_v2('~thor_data400::key::dl::fcra::dl_number', '~thor_data400::key::dl::fcra::' + filedate + '::dl_number', f4);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::dl::'+filedate+'::number_'+doxie_build.buildstate,'~thor_data400::key::dl_number_'+doxie_build.buildstate,g,3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dl_indicatives'+doxie_build.buildstate,'~thor_data400::key::dl::'+filedate+'::indicatives'+doxie_build.buildstate, h);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bocaShell_DL_DID','~thor_data400::key::dl::'+filedate+'::bocashell_did',h2);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dl::fcra::BocaShell.DID','~thor_data400::key::dl::fcra::' + filedate + '::bocashell.did', h3);


post := ut.SF_MaintBuilt('~thor_data400::base::DLSearch_' + doxie_build.buildstate);
		
return if (fileservices.getsuperfilesubname('~thor_data400::base::DLSearch_'+doxie_build.buildstate,1) = fileservices.getsuperfilesubname('~thor_data400::base::DLSearch_' +  doxie_build.buildstate + '_BUILT',1),
		output('BASE = BUILT, Nothing done.'),
		sequential(pre,parallel(a,a2,a3,a4,b,c,c2,c3),
					parallel(d,d2,d3,e),
					parallel(f,f2,f3,f4,g,h,h2,h3),post));
		
end;