import data_services;

layout_corp_key := record
string30  corp_key;
unsigned6 doc;
unsigned8 __filepos {virtual (fileposition)} := 0;
end;

ds :=dataset([],layout_corp_key);

export Key_Boolean_Corpkey_Map := index(ds,
                                        {doc,corp_key,__filepos},
	                                      data_services.data_location.prefix() + 'thor_data400::key::corp2.docref.docref');