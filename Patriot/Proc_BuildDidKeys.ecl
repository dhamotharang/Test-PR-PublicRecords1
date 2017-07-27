import ut,RoxieKeyBuild,Patriot;

export Proc_BuildDidKeys(string filedate) :=
function

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Patriot.key_prep_baddids,'~thor_data400::key::patriot::'+filedate+'::baddids','~thor_data400::key::baddids',did1,2);
RoxieKeyBuild.MAC_SK_BuildProcess_Local(Patriot.key_prep_badnames,'~thor_data400::key::patriot::'+filedate+'::annotated_names','~thor_data400::key::annotated_names',did2,2);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_Local(Patriot.Key_Baddids_with_name,'~thor_data400::key::patriot::Baddies_with_name','~thor_data400::key::patriot::'+filedate+'::baddies_with_name',did3);

return sequential(did1, did2, did3);

end;