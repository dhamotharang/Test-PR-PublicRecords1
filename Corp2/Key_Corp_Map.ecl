 IMPORT Text_Search;
 docref_Corp_key_rec := record
		layout_Corp_Extract.Corp_Key;
		typeof(text_search.Types.docid) doc;
		unsigned8 __filepos {virtual (fileposition)} := 0;
	end;
	//generate doc, Corp_Key pairs
	docref_Corp_key_rec MakeKeyMap(layout_Corp_Extract l) := TRANSFORM
			self.doc := l.sid;
			self.Corp_Key := l.Corp_Key;
	end;											
	EXPORT Key_Corp_Map(String indexname, DATASET(layout_Corp_Extract) CorpFile= DATASET([],layout_Corp_Extract)) := INDEX(PROJECT(CorpFile,MakeKeyMap(LEFT)),{doc,Corp_key,__filepos},indexname);
												