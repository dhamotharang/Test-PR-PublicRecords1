	Import Data_Services, Text_Search,LN_PropertyV2;
	docref_Ln_Fares_id_rec := record(Text_search.Types.DocRef)
		LN_PropertyV2.Layout_Property_A_Extract.ln_fares_id;
	end;

	//generate src, doc, ln_fares_id pairs
	docref_Ln_Fares_id_rec MakeKeyMap(LN_PropertyV2.Layout_Property_A_Extract l) := TRANSFORM
			self.doc := l.sid;
			self.src := TRANSFER(l.source, unsigned2);
			self.ln_fares_id :=l.ln_fares_id;
	end;											
	EXPORT Key_Assessment_Map(DATASET(LN_PropertyV2.Layout_Property_A_Extract) 
		AFile= DATASET([],LN_PropertyV2.Layout_Property_A_Extract)) 
		:= INDEX(PROJECT(AFile,MakeKeyMap(LEFT)),{src,doc},{ln_fares_id}
			,Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::property_fast::assessment::qa::doc.fares_id');
												