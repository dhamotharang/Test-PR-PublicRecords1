import Text_Search,Liensv2;

export BWR_Build_Liensv2_OPT(string filedate) := function

info := Text_Search.FileName_Info_Instance('~THOR_DATA400', 'LIENSV2', filedate);

Text_Liens_Record := record(Text_Search.Layout_Document)
	string50 tmsid;
	//string50 rmsid;
end;

Text_Liens_Flat := record(Text_Search.Layout_DocSeg)
	string50 tmsid;
	//string50 rmsid;
end;

ret := Liensv2.Convert_Liensv2_Func_OPT : persist('~thor_data400::persist::liensv2::boolean');

string_rec := record
		Text_Liens_Record.DocRef;
		Text_Liens_Record.tmsid;
		unsigned8 __filepos{virtual (fileposition)};
end;

proj_map := project(ret,transform(string_rec,self.src := left.DocRef.src;
								 self.doc := left.DocRef.doc;
								 self := left));

dist_map := distribute(proj_map,hash(doc));
sort_map := sort(dist_map,src,doc,local);
tmsid_map := dedup(sort_map,src,doc,local);

inlkeyname := '~thor_data400::key::liensv2::'+filedate+'::docref.tmsid';
inskeyname := '~thor_data400::key::liensv2::qa::docref.tmsid';

build_key := buildindex(tmsid_map,{src,doc,tmsid,__filepos},inlkeyname, OVERWRITE);

retval := sequential(
									build_key,
									Text_Search.Build_From_DocSeg_Records(ret,info),
									Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname),
									fileservices.deletelogicalfile('~thor_data400::persist::liensv2::boolean')
									
									);

return retval;

end;