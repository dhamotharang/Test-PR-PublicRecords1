  IMPORT Text_Search;
	docref_Ln_Fares_id_rec := record(Text_search.Types.DocRef)
		Layout_Property_DM_Extract.ln_fares_id;
	end;

	//generate src, doc, ln_fares_id pairs
	docref_Ln_Fares_id_rec MakeKeyMap(Layout_Property_DM_Extract l) := TRANSFORM
			self.doc := l.sid;
			self.src := TRANSFER(l.source, unsigned2);
			self.ln_fares_id :=l.ln_fares_id;
	end;		
	
	EXPORT Key_DM_Map(DATASET(Layout_Property_DM_Extract) dmFile= DATASET([],Layout_Property_DM_Extract)) := INDEX(PROJECT(dmFile,MakeKeyMap(LEFT)),{src,doc},{ln_fares_id},'~thor_data400::key::ln_propertyv2::deeds::qa::doc.fares_id');
												