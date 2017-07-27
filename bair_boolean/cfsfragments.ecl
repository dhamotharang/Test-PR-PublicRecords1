IMPORT Text_Search, Codes, Header, MDR, bair;
// Should inherit IFragmentSource, but needs fix for 51580
EXPORT cfsfragments(Types.StateList st_list=ALL, Boolean pDelta=true) := MODULE
	//SHARED Persist_Stem 		:= '~THOR_DATA400::PERSIST::FRAGS_';
	SHARED Persist_cfs	:= bair_boolean.constants('').persistfile('cfs');

  bair_data := Bair.files(pUseDelta:=pDelta).cfs_Base.built;
	SHARED cfs_Base := DISTRIBUTE(bair_data(eid <> ''),HASH64(eid));
	
	// cfs Business
	Layout_cfs_base xd(bair.layouts.dbo_cfs_Base l) := TRANSFORM
		SELF := l;
	END;
	SHARED cfs_File := PROJECT(cfs_Base, xd(LEFT));
	SHARED cfs_mod := cfs_baseBooleanSearch(cfs_File);
  //
	Layout_AnswerListData xans(Layout_cfs_base l) := TRANSFORM
		SELF.source_doc_type := 'cfs';
		SELF.record_id := l.eid;
		SELF.gh12 := l.gh12;
		SELF.dt_last_seen := (STRING) l.dt_vendor_last_reported;
		SELF.address := l.address;
		//SELF.name := l;
		SELF := l;
	END;
	SHARED cfs_ans_recs := PROJECT(cfs_file, xans(LEFT));
	
	
	// Combine cfs sources
	EXPORT DeletePersist := FileServices.DeleteLogicalFile(Persist_cfs);
	EXPORT DATASET(Text_Search.Layout_Segment_ComposeDef) SegmentDefinitions
							:= cfs_mod.SegmentDefinitions;
	EXPORT DATASET(Text_Search.Layout_Posting) rawPostings
							:= cfs_mod.Postings_Doc;
	EXPORT DATASET(bair_boolean.Layout_AnswerListData) answerRecs
							:= cfs_ans_recs;
END;