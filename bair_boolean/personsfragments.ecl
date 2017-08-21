IMPORT Text_Search, Codes, Header, MDR, bair;
// Should inherit IFragmentSource, but needs fix for 51580
EXPORT personsfragments(Types.StateList st_list=ALL, Boolean pDelta=true) := MODULE
	//SHARED Persist_Stem 		:= '~THOR_DATA400::PERSIST::FRAGS_';
	SHARED Persist_persons	:= bair_boolean.constants('').persistfile('persons');

  bair_data := Bair.files(pUseDelta:=pDelta).persons_Base.built;
	//bair_data := choosen(Bair.files(pUseDelta:=pDelta).persons_Base.built,10000);
	SHARED persons_Base := DISTRIBUTE(bair_data(eid <> ''),HASH64(eid));
	
	// persons Business
	Layout_persons_base xd(bair.layouts.dbo_event_persons_final_Base l) := TRANSFORM
		SELF := l;
	END;
	SHARED persons_File := PROJECT(persons_Base, xd(LEFT));
	SHARED persons_mod := persons_baseBooleanSearch(persons_File);
  //
	Layout_AnswerListData xans(Layout_persons_base l) := TRANSFORM
		SELF.source_doc_type := 'persons';
		SELF.record_id := l.eid;
		SELF.gh12 := l.gh12;
		SELF.dt_last_seen := (STRING) l.dt_vendor_last_reported;
		SELF.address := l.address;
		//SELF.name := l;
		SELF := l;
	END;
	SHARED persons_ans_recs := PROJECT(persons_file, xans(LEFT));
	
	
	// Combine persons sources
	EXPORT DeletePersist := FileServices.DeleteLogicalFile(Persist_persons);
	EXPORT DATASET(Text_Search.Layout_Segment_ComposeDef) SegmentDefinitions
							:= persons_mod.SegmentDefinitions;
	EXPORT DATASET(Text_Search.Layout_Posting) rawPostings
							:= persons_mod.Postings_Doc;
	EXPORT DATASET(bair_boolean.Layout_AnswerListData) answerRecs
							:= persons_ans_recs;
END;