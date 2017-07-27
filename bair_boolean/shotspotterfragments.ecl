IMPORT Text_Search, Codes, Header, MDR, bair;
// Should inherit IFragmentSource, but needs fix for 51580
EXPORT shotspotterfragments(Types.StateList st_list=ALL, Boolean pDelta=true) := MODULE
	//SHARED Persist_Stem 		:= '~THOR_DATA400::PERSIST::FRAGS_';
	SHARED Persist_shotspotter	:= bair_boolean.constants('').persistfile('shotspotter');

  bair_data := Bair.files(pUseDelta:=pDelta).shotspotter_Base.built;
	SHARED shotspotter_Base := DISTRIBUTE(bair_data(eid <> ''),HASH64(eid));
	
	// shotspotter Business
	Layout_shotspotter_base xd(bair.layouts.gunop_dbo_shot_incident_Base l) := TRANSFORM
		SELF := l;
	END;
	SHARED shotspotter_File := PROJECT(shotspotter_Base, xd(LEFT));
	SHARED shotspotter_mod := shotspotter_baseBooleanSearch(shotspotter_File);
  //
	Layout_AnswerListData xans(Layout_shotspotter_base l) := TRANSFORM
		SELF.source_doc_type := 'shotspotter';
		SELF.record_id := l.eid;
		SELF.gh12 := l.gh12;
		SELF.dt_last_seen := (STRING) l.dt_vendor_last_reported;
		SELF.address := l.address;
		//SELF.name := l;
		SELF := l;
	END;
	SHARED shotspotter_ans_recs := PROJECT(shotspotter_file, xans(LEFT));
	
	
	// Combine shotspotter sources
	EXPORT DeletePersist := FileServices.DeleteLogicalFile(Persist_shotspotter);
	EXPORT DATASET(Text_Search.Layout_Segment_ComposeDef) SegmentDefinitions
							:= shotspotter_mod.SegmentDefinitions;
	EXPORT DATASET(Text_Search.Layout_Posting) rawPostings
							:= shotspotter_mod.Postings_Doc;
	EXPORT DATASET(bair_boolean.Layout_AnswerListData) answerRecs
							:= shotspotter_ans_recs;
END;