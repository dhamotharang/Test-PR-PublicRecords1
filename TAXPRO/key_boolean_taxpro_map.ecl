
import taxpro,text_search,data_services;




layout_tmsid := record
typeof(Taxpro.File_Base.tmsid)  tmsid;
typeof(text_search.Types.DocID) doc;
unsigned8 __filepos {virtual (fileposition)} := 0;
end;




ds :=dataset([],layout_tmsid);




export key_boolean_taxpro_map := index(ds,{doc,tmsid,__filepos},
	data_services.data_location.prefix() + 'thor_data400::key::taxpro::qa::docref.docref');