IMPORT Text_Search, Codes, Header, MDR, bair;
// Should inherit IFragmentSource, but needs fix for 51580
EXPORT lprfragments(Types.StateList st_list=ALL, Boolean pDelta=true) := MODULE
	//SHARED Persist_Stem 		:= '~THOR_DATA400::PERSIST::FRAGS_';
	SHARED Persist_lpr	:= bair_boolean.constants('').persistfile('lpr');

  bair_data := Bair.files(pUseDelta:=pDelta).lpr_Base.built;
	SHARED lpr_Base := DISTRIBUTE(bair_data(eid <> ''),HASH64(eid));
	
	// lpr Business
	Layout_lpr_base xd(bair.layouts.lpr_dbo_LicensePlateEvent_Base l) := TRANSFORM
		SELF := l;
	END;
	SHARED lpr_File := PROJECT(lpr_Base, xd(LEFT));
	SHARED lpr_mod := lpr_baseBooleanSearch(lpr_File);
  //
	Layout_AnswerListData xans(Layout_lpr_base l) := TRANSFORM
		SELF.source_doc_type := 'lpr';
		SELF.record_id := l.eid;
		SELF.gh12 := l.gh12;
		SELF.dt_last_seen := (STRING) l.dt_vendor_last_reported;
		//SELF.address := l.address;
		//SELF.name := l;
		SELF := l;
		SELF :=[];
	END;
	SHARED lpr_ans_recs := PROJECT(lpr_file, xans(LEFT));
	
	
	// Combine lpr sources
	EXPORT DeletePersist := FileServices.DeleteLogicalFile(Persist_lpr);
	EXPORT DATASET(Text_Search.Layout_Segment_ComposeDef) SegmentDefinitions
							:= lpr_mod.SegmentDefinitions;
	EXPORT DATASET(Text_Search.Layout_Posting) rawPostings
							:= lpr_mod.Postings_Doc;
	EXPORT DATASET(bair_boolean.Layout_AnswerListData) answerRecs
							:= lpr_ans_recs;
END;