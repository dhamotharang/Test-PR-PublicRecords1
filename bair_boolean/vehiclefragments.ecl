IMPORT Text_Search, Codes, Header, MDR, bair;
// Should inherit IFragmentSource, but needs fix for 51580
EXPORT vehiclefragments(Types.StateList st_list=ALL, Boolean pDelta=true) := MODULE
	//SHARED Persist_Stem 		:= '~THOR_DATA400::PERSIST::FRAGS_';
	SHARED Persist_vehicle	:= bair_boolean.constants('').persistfile('vehicle');

  bair_data := Bair.files(pUseDelta:=pDelta).vehicle_Base.built;
	SHARED vehicle_Base := DISTRIBUTE(bair_data(eid <> ''),HASH64(eid));
	
	// vehicle Business
	Layout_vehicle_base xd(bair.layouts.dbo_event_vehicle_final_Base l) := TRANSFORM
		SELF := l;
	END;
	SHARED vehicle_File := PROJECT(vehicle_Base, xd(LEFT));
	SHARED vehicle_mod := vehicle_baseBooleanSearch(vehicle_File);
  //
	Layout_AnswerListData xans(Layout_vehicle_base l) := TRANSFORM
		SELF.source_doc_type := 'vehicle';
		SELF.record_id := l.eid;
		SELF.gh12 := l.gh12;
		SELF.dt_last_seen := (STRING) l.dt_vendor_last_reported;
		SELF.address := l.address;
		//SELF.name := l;
		SELF := l;
	END;
	SHARED vehicle_ans_recs := PROJECT(vehicle_file, xans(LEFT));
	
	
	// Combine vehicle sources
	EXPORT DeletePersist := FileServices.DeleteLogicalFile(Persist_vehicle);
	EXPORT DATASET(Text_Search.Layout_Segment_ComposeDef) SegmentDefinitions
							:= vehicle_mod.SegmentDefinitions;
	EXPORT DATASET(Text_Search.Layout_Posting) rawPostings
							:= vehicle_mod.Postings_Doc;
	EXPORT DATASET(bair_boolean.Layout_AnswerListData) answerRecs
							:= vehicle_ans_recs;
END;