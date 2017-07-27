import text_search,oshair;

export BWR_Oshair_Build_Boolean(string filedate) := function
	info := Text_Search.FileName_Info_Instance('~THOR_DATA400', 'oshair', filedate);
	
	ret := oshair.Convert_Oshair_Func : persist('~thor_data400::persist::oshair::boolean');

	string_rec := record
		text_search.layout_document.DocRef;
		unsigned8 __filepos{virtual (fileposition)};
	end;

	proj_map := project(ret,transform(string_rec,self.src := left.DocRef.src;
								 self.doc := left.DocRef.doc;
								 self := left));

	dist_map := distribute(proj_map,hash(doc));
	sort_map := sort(dist_map,src,doc,local);
	tmsid_map := dedup(sort_map,src,doc,local);

	inlkeyname := '~thor_data400::key::oshair::'+filedate+'::doc.anumber';
	inskeyname := '~thor_data400::key::oshair::qa::doc.anumber';

	build_key := buildindex(tmsid_map,{src,doc,__filepos},inlkeyname, OVERWRITE);

	retval := sequential(
									build_key,
									Text_Search.Build_From_DocSeg_Records(ret,info),
									Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname),
									fileservices.deletelogicalfile('~thor_data400::persist::oshair::boolean')
									);


return retval;


end;