import text_search;
inData_bus := FBNV2.File_FBN_Business_Base;

layout_tmsid_rmsid := record
typeof(indata_bus.tmsid)  tmsid;
typeof(indata_bus.rmsid)  rmsid;
typeof(text_search.Types.docid) doc;
unsigned8 __filepos {virtual (fileposition)} := 0;
end;

ds :=dataset([],layout_tmsid_rmsid);

export Key_Boolean_Fbnkey_map := index(ds,{doc,tmsid,rmsid,__filepos},
	'~thor_data400::key::fbn::qa::docref.docref');