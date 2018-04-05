IMPORT Text_Search, Codes, Header, MDR, bair;
// Should inherit IFragmentSource, but needs fix for 51580
EXPORT intelfragments(Types.StateList st_list=ALL, Boolean pDelta=true) := MODULE
	//SHARED Persist_Stem 		:= '~THOR_DATA400::PERSIST::FRAGS_';
	SHARED Persist_intel	:= bair_boolean.constants('').persistfile('intel');

  bair_data := Bair.files(pUseDelta:=pDelta).intel_Base.built;
  // bair_data := Bair.files(pUseDelta:=pDelta).intel_Base.built(eid not in set(bair_boolean.temp,ExternalKey));
	// bair_data := enth(Bair.files(,true,false).intel_Base.built,10000)(eid not in set(bair_boolean.temp,ExternalKey));
	SHARED intel_Base := DISTRIBUTE(bair_data(eid <> ''),HASH64(eid));
	
	// intel Business
	SHARED intel_File := PROJECT(intel_Base, 
																TRANSFORM(Layout_intel_base,	
																SELF.height 					:= (Integer)left.height,
																SELF.weight 					:= (Integer)left.weight,
																SELF.gh12							:= left.gh12,
																self.gh4 							:= left.gh12[1..4],
																self.gh5 							:= left.gh12[1..5],
																self.gh6 							:= left.gh12[1..6],
																SELF.class_code				:= Bair.MapClassCodeNum(5, left.incident_type),
																SELF.wc_address_name	:= left.address_name,
																SELF.wc_location_type	:= left.location_type,
																self.agency						:= left.data_provider_name,
																SELF := left));
																							 
	SHARED intel_mod := intel_baseBooleanSearch(intel_File);
  //
	Layout_AnswerListData xans(Layout_intel_base l , INTEGER C) := TRANSFORM
		SELF.source_doc_type := 'intel';
		SELF.record_id := l.eid;
		SELF.gh12 := l.gh12;
		SELF.dt_last_seen := (STRING) l.dt_vendor_last_reported;
		SELF.address := CHOOSE(C, L.entity_address, L.incident_address);
		//SELF.name := l;
		SELF := l;
	END;
	//SHARED intel_ans_recs := PROJECT(intel_file, xans(LEFT));
	SHARED intel_ans_recs := normalize(intel_File, 2, xans(LEFT, counter));
	
	
	// Combine intel sources
	EXPORT DeletePersist := FileServices.DeleteLogicalFile(Persist_intel);
	EXPORT DATASET(Text_Search.Layout_Segment_ComposeDef) SegmentDefinitions
							:= intel_mod.SegmentDefinitions;
	EXPORT DATASET(Text_Search.Layout_Posting) rawPostings
							:= intel_mod.Postings_Doc;
	EXPORT DATASET(bair_boolean.Layout_AnswerListData) answerRecs
							:= intel_ans_recs;
END;