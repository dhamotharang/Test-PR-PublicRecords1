IMPORT Text_Search, Codes, Header, MDR, bair;
// Should inherit IFragmentSource, but needs fix for 51580
EXPORT mofragments(Types.StateList st_list=ALL, Boolean pDelta=true) := MODULE
	//SHARED Persist_Stem 		:= '~THOR_DATA400::PERSIST::FRAGS_';
	SHARED Persist_mo	:= bair_boolean.constants('').persistfile('mo');

  bair_data := Bair.files(pUseDelta:=pDelta).mo_Base.built;
	//bair_data := choosen(Bair.files(pUseDelta:=pDelta).mo_Base.built,10000);
	SHARED mo_Base := DISTRIBUTE(bair_data(eid <> ''),HASH64(eid));
	
	// mo Business
	Layout_mo_base xd(bair.Layouts.dbo_event_mo_final_Base l) := TRANSFORM
	  SELF.Property_Value := (Real)l.Property_Value;
		SELF.companions     := (Integer)l.companions;
		SELF.Geocoded				:= IF(l.Geocoded ='1','True','False');
		SELF.Raids					:= IF(l.Raids ='1','True','False');
		SELF.Quarantined		:= IF(l.Quarantined ='1','True','False');
		SELF := l;
	END;
	SHARED mo_File := PROJECT(mo_Base, xd(LEFT));
	SHARED mo_mod := mo_baseBooleanSearch(mo_File);
  //
	Layout_AnswerListData xans(Layout_mo_base l) := TRANSFORM
		SELF.source_doc_type := 'mo';
		SELF.record_id := l.eid;
		SELF.gh12 := l.gh12;
		SELF.dt_last_seen := (STRING) l.dt_vendor_last_reported;
		SELF.address := l.address;
		//SELF.name := l;
		SELF := l;
	END;
	SHARED mo_ans_recs := PROJECT(mo_file, xans(LEFT));
	
	
	// Combine mo sources
	EXPORT DeletePersist := FileServices.DeleteLogicalFile(Persist_mo);
	EXPORT DATASET(Text_Search.Layout_Segment_ComposeDef) SegmentDefinitions
							:= mo_mod.SegmentDefinitions;
	EXPORT DATASET(Text_Search.Layout_Posting) rawPostings
							:= mo_mod.Postings_Doc;
	EXPORT DATASET(bair_boolean.Layout_AnswerListData) answerRecs
							:= mo_ans_recs;
END;