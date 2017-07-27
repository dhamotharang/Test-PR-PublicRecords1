import RoxieKeyBuild, Sam;


export ProcBuildKeys(string filedate = '') := function

		rundate := filedate;
		
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(sam.key_linkID.key,'~thor_data400::key::same_linkids','~thor_data400::key::sam::'+rundate+'::linkids',bk_linkids);

RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::sam::'+rundate+'::linkids','~thor_data400::key::sam_linkids',mv_linkids,3);

RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::sam_linkids','Q',mv2qa_linkids);

return sequential(bk_linkids,mv_linkids,mv2qa_linkids);


end;
