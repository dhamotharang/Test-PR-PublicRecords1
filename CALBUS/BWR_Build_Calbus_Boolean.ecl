import text_search,calbus;

export BWR_Build_Calbus_Boolean(string filedate) := function
	info := Text_Search.FileName_Info_Instance('~THOR_DATA400', 'calbus', filedate);
	
	Text_calbus_Record := record(Text_Search.Layout_Document)
		string13 account_number;
	end;

	ret := calbus.Convert_calbus_Func : persist('~thor_data400::persist::calbus::boolean');

	string_rec := record
		Text_calbus_Record.DocRef;
		Text_calbus_Record.account_number;
		unsigned8 __filepos{virtual (fileposition)};
	end;

	proj_map := project(ret,transform(string_rec,self.src := left.DocRef.src;
								 self.doc := left.DocRef.doc;
								 self := left));

	dist_map := distribute(proj_map,hash(doc));
	sort_map := sort(dist_map,src,doc,local);
	tmsid_map := dedup(sort_map,src,doc,local);

	inlkeyname := '~thor_data400::key::calbus::'+filedate+'::doc.accnumber';
	inskeyname := '~thor_data400::key::calbus::qa::doc.accnumber';

	build_key := buildindex(tmsid_map,{src,doc,account_number,__filepos},inlkeyname, OVERWRITE);

	retval := sequential(
									build_key,
									Text_Search.Build_From_DocSeg_Records(ret,info),
									Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname),
									fileservices.deletelogicalfile('~thor_data400::persist::calbus::boolean')
									);


return retval;


end;