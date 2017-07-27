import RoxieKeyBuild,Patriot;

export Proc_Patriot_Keys_to_built(string filedate) :=
function
RoxieKeyBuild.MAC_SK_Move_to_Built('~thor_data400::key::patriot::'+filedate+'::baddids','~thor_data400::key::baddids',mv1,2);
RoxieKeyBuild.MAC_SK_Move_to_built('~thor_data400::key::patriot::'+filedate+'::annotated_names','~thor_data400::key::annotated_names',mv2,2);
RoxieKeyBuild.MAC_SK_Move_to_Built_v2('~thor_data400::key::patriot::Baddies_with_name','~thor_data400::key::patriot::'+filedate+'::baddies_with_name',mv3);
RoxieKeyBuild.MAC_SK_Move_to_Built('~thor_Data400::key::patriot::'+filedate+'::File_Full','~thor_Data400::key::patriot_File_Full',mv4,2,true)
RoxieKeyBuild.MAC_SK_Move_to_Built_v2('~thor_data400::key::patriot_did_file','~thor_Data400::key::patriot::'+filedate+'::did_file',mv5)
RoxieKeyBuild.MAC_SK_Move_to_Built_v2('~thor_data400::key::patriot_bdid_file','~thor_Data400::key::patriot::'+filedate+'::bdid_file',mv6)
RoxieKeyBuild.MAC_SK_Move_to_Built_v2('~thor_data400::key::patriot_key','~thor_Data400::key::patriot::'+filedate+'::patriot_key',mv7,true)
RoxieKeyBuild.MAC_SK_Move_to_Built_v2('~thor_Data400::key::patriot_phoneticnames','~thor_Data400::key::patriot::'+filedate+'::phoneticnames',mv8, true);

return sequential(mv1,mv2,mv3,mv4,mv5,mv6,mv7,mv8);

end;