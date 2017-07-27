import doxie_build,RoxieKeybuild;

export Proc_Relatives_keys(string filedate) := function

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Relatives,'~thor_data400::key::relatives','~thor_data400::key::header::'+filedate+'::relatives',rels);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::relatives','~thor_data400::key::header::'+filedate+'::relatives',mv_rels);

return sequential(rels,mv_rels);
end;