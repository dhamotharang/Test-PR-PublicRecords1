import doxie_build,RoxieKeybuild,header;

export Proc_Relatives_keys(string filedate) := function

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Relatives_v2,'~thor_data400::key::relatives_v2','~thor_data400::key::header::'+filedate+'::relatives_v2',rels_v2);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::relatives_v2','~thor_data400::key::header::'+filedate+'::relatives_v2',mv_rels_v2);

return sequential(rels_v2,mv_rels_v2);
end;