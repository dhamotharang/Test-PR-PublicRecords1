IMPORT Text_Search, Codes, Header, MDR, bair;
// Should inherit IFragmentSource, but needs fix for 51580
EXPORT crashfragments(Types.StateList st_list=ALL, Boolean pDelta=true) := MODULE
	//SHARED Persist_Stem 		:= '~THOR_DATA400::PERSIST::FRAGS_';
	SHARED Persist_crash	:= bair_boolean.constants('').persistfile('crash');

  bair_data := Bair.files(pUseDelta:=pDelta).crash_Base.built;
	SHARED crash_Base := DISTRIBUTE(bair_data(eid <> ''),HASH64(eid));
	
	// crash Business
	Layout_crash_base xd(bair.layouts.dbo_crash_Base l) := TRANSFORM
		SELF := l;
	END;
	SHARED crash_File := PROJECT(crash_Base, xd(LEFT));
	SHARED crash_mod := crash_baseBooleanSearch(crash_File);
  //
	Layout_AnswerListData xans(Layout_crash_base l) := TRANSFORM
		SELF.source_doc_type := 'crash';
		SELF.record_id := l.eid;
		SELF.gh12 := l.gh12;
		SELF.dt_last_seen := (STRING) l.dt_vendor_last_reported;
		SELF.address := l.address;
		//SELF.name := l;
		SELF := l;
	END;
	SHARED crash_ans_recs := PROJECT(crash_file, xans(LEFT));
	
	
	// Combine crash sources
	EXPORT DeletePersist := FileServices.DeleteLogicalFile(Persist_crash);
	EXPORT DATASET(Text_Search.Layout_Segment_ComposeDef) SegmentDefinitions
							:= crash_mod.SegmentDefinitions;
	EXPORT DATASET(Text_Search.Layout_Posting) rawPostings
							:= crash_mod.Postings_Doc;
	EXPORT DATASET(bair_boolean.Layout_AnswerListData) answerRecs
							:= crash_ans_recs;
END;