import VotersV2;
import text_search;
import lib_stringlib;

export BWR_Build_Voters_Boolean(string filedate) := function
// May need to change high level
info := text_search.FileName_Info_Instance('~THOR_DATA400', 'VOTERSV2', filedate);

						
inData := distribute(VotersV2.File_Voters_Building,vtid);

ds := vOTERSv2.Convert_Voter_Func(inData) : PERSIST('~thor_data400::persist::votersv2::boolean');

string_rec := record
		unsigned2 src := ds.DocRef.src;
		unsigned6 doc := ds.DocRef.doc;
	//	unsigned2 src2 := ds.DocRef.src;
	//	unsigned6 doc2 := ds.DocRef.doc;		
		unsigned8 __filepos {virtual (fileposition)} := 0;
end;

proj_map := project(ds,transform(string_rec,
								 self.src := left.DocRef.src;
								 self.doc := left.DocRef.doc;
					//			 self.src2 := left.DocRef.src;
					//			 self.doc2 := left.DocRef.doc;
							
								 self := left));

dist_map := distribute(proj_map,hash(doc));
sort_map := sort(dist_map,src,doc,local);
tmsid_map := dedup(sort_map,src,doc,local);

inlkeyname := '~thor_data400::key::votersv2::'+filedate+'::doc.vtid';
inskeyname := '~thor_data400::key::votersv2::qa::doc.vtid';

build_key := buildindex(tmsid_map,{src,doc,__filepos},inlkeyname, OVERWRITE);


retval := sequential(
									build_key,
									Text_Search.Build_From_DocSeg_Records(ds(lib_stringlib.StringLib.StringFilterOut(content,';') <> ''),info),
									Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname),
									fileservices.deletelogicalfile('~thor_data400::persist::votersv2::boolean')
									);

return retval;

end;