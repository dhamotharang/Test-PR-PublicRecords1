	IMPORT Text_Search;
	docref_Ln_Fares_id_rec := record(Text_search.Types.DocRef)
		Layout_Property_A_Extract.ln_fares_id;
	end;

	//generate src, doc, ln_fares_id pairs
	docref_Ln_Fares_id_rec MakeKeyMap(Layout_Property_A_Extract l) := TRANSFORM
			self.doc := l.sid;
			self.src := TRANSFER(l.source, unsigned2);
			self.ln_fares_id :=l.ln_fares_id;
	end;											
	EXPORT Key_Assessment_Map(DATASET(Layout_Property_A_Extract) AFile= DATASET([],Layout_Property_A_Extract)) := INDEX(PROJECT(AFile,MakeKeyMap(LEFT)),{src,doc},{ln_fares_id},'~thor_data400::key::ln_propertyv2::assessment::qa::doc.fares_id');
												