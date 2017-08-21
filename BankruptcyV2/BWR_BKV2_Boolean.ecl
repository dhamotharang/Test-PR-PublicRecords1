import text_search,bankruptcyv2;

export BWR_BKV2_Boolean(string filedate) := function
	info := Text_Search.FileName_Info_Instance('~THOR_DATA400', 'BANKRUPTCYV2', filedate);
	
	Text_BK_Record := record(Text_Search.Layout_Document)
		string50 tmsid;
	end;

	Text_BK_Flat := record(Text_Search.Layout_DocSeg)
		string50 tmsid;
	end;

	ret := bankruptcyv2.Convert_BK_Func : persist('~thor_data400::persist::bkv2::boolean');

	string_rec := record
		Text_bk_Record.DocRef;
		Text_bk_Record.tmsid;
		unsigned8 __filepos{virtual (fileposition)};
	end;

	proj_map := project(ret,transform(string_rec,self.src := left.DocRef.src;
								 self.doc := left.DocRef.doc;
								 self := left));

	dist_map := distribute(proj_map,hash(doc));
	sort_map := sort(dist_map,src,doc,local);
	tmsid_map := dedup(sort_map,src,doc,local);

	inlkeyname := '~thor_data400::key::bankruptcyv2::'+filedate+'::docref.tmsid';
	inskeyname := '~thor_data400::key::bankruptcyv2::qa::docref.tmsid';

	build_key := buildindex(tmsid_map,{src,doc,tmsid,__filepos},inlkeyname, OVERWRITE);

	retval := sequential(
									Text_Search.Build_From_DocSeg_Records(ret,info),
									build_key,
									Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname)/*,
									fileservices.deletelogicalfile('~thor_data400::persist::bkv2::boolean')*/
									
									);


return retval;


end;