#workunit('name','Death Master Boolean');
//#workunit('priority','high');

import Text_Search,Death_Master;

export bwr_build_DM(string filedate) := function

info := Text_Search.FileName_Info_Instance('~THOR_DATA400::BASE', death_master.Constants('').srcType, filedate);

ret := Death_master.Convert_DM_Func : persist('~thor_data400::persist::death_master::boolean');

string_rec := record
	text_search.layout_document.docref;
	string16 state_death_id;
	unsigned8 __filepos{virtual (fileposition)};
end;

my_tab := project(ret,transform(string_rec,
					self.doc := left.docref.doc;
					self.src := left.docref.src;
					self := left
					));

dist_map := distribute(my_tab,hash(doc));
sort_map := sort(dist_map,src,doc,local);
sdid_map := dedup(sort_map,src,doc,local);

inlkeyname := '~thor_data400::key::death_master::'+filedate+'::docref.state_death_id';
inskeyname := '~thor_data400::key::death_master::qa::docref.state_death_id';

build_key := buildindex(sdid_map,{src,doc,state_death_id,__filepos},inlkeyname, OVERWRITE);


retval := sequential(
					build_key,
					Text_Search.Build_From_DocSeg_Records(ret,info),
					Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname)
					);

return retval;

end;