IMPORT Text_Search, Codes, Header, MDR, bair;
// Should inherit IFragmentSource, but needs fix for 51580
EXPORT offendersfragments(Types.StateList st_list=ALL, Boolean pDelta=true) := MODULE
	//SHARED Persist_Stem 		:= '~THOR_DATA400::PERSIST::FRAGS_';
	SHARED Persist_offenders	:= bair_boolean.constants('').persistfile('offenders');

  bair_data := Bair.files(pUseDelta:=pDelta).offenders_Base.built;
	SHARED offenders_Base := DISTRIBUTE(bair_data(eid <> ''),HASH64(eid));
	
	// offenders Business
	Layout_offenders_base xd(bair.layouts.dbo_offenders_Base l) := TRANSFORM
		SELF := l;
	END;
	SHARED offenders_File := PROJECT(offenders_Base, xd(LEFT));
	SHARED offenders_mod := offenders_baseBooleanSearch(offenders_File);
  //
	Layout_AnswerListData xans(Layout_offenders_base l) := TRANSFORM
		SELF.source_doc_type := 'offenders';
		SELF.record_id := l.eid;
		SELF.gh12 := l.gh12;
		SELF.dt_last_seen := (STRING) l.dt_vendor_last_reported;
		SELF.address := l.address;
		//SELF.name := l;
		SELF := l;
	END;
	SHARED offenders_ans_recs := PROJECT(offenders_file, xans(LEFT));
	
	
	// Combine offenders sources
	EXPORT DeletePersist := FileServices.DeleteLogicalFile(Persist_offenders);
	EXPORT DATASET(Text_Search.Layout_Segment_ComposeDef) SegmentDefinitions
							:= offenders_mod.SegmentDefinitions;
	EXPORT DATASET(Text_Search.Layout_Posting) rawPostings
							:= offenders_mod.Postings_Doc;
	EXPORT DATASET(bair_boolean.Layout_AnswerListData) answerRecs
							:= offenders_ans_recs;
END;