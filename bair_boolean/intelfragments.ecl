IMPORT Text_Search, Codes, Header, MDR, bair;
// Should inherit IFragmentSource, but needs fix for 51580
EXPORT intelfragments(Types.StateList st_list=ALL, Boolean pDelta=true) := MODULE
	//SHARED Persist_Stem 		:= '~THOR_DATA400::PERSIST::FRAGS_';
	SHARED Persist_intel	:= bair_boolean.constants('').persistfile('intel');

  bair_data := Bair.files(pUseDelta:=pDelta).intel_Base.built;
	SHARED intel_Base := DISTRIBUTE(bair_data(eid <> ''),HASH64(eid));
	
	// intel Business
	Layout_intel_base xd(bair.layouts.dbo_intel_Base l) := TRANSFORM
		SELF := l;
	END;
	SHARED intel_File := PROJECT(intel_Base, xd(LEFT));
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