IMPORT Text_Search, Codes, Header, MDR, bair;
// Should inherit IFragmentSource, but needs fix for 51580
EXPORT offendersfragments(Types.StateList st_list=ALL, Boolean pDelta=true) := MODULE
	//SHARED Persist_Stem 		:= '~THOR_DATA400::PERSIST::FRAGS_';
	SHARED Persist_offenders	:= bair_boolean.constants('').persistfile('offenders');

  bair_data := Bair.files(pUseDelta:=pDelta).offenders_Base.built;
  // bair_data := Bair.files(pUseDelta:=pDelta).offenders_Base.built(eid not in set(bair_boolean.temp,ExternalKey));
	// bair_data := enth(Bair.files(,true,false).offenders_Base.built,10000)(eid not in set(bair_boolean.temp,ExternalKey));
	SHARED offenders_Base := DISTRIBUTE(bair_data(eid <> ''),HASH64(eid));
	
	// offenders Business

	SHARED offenders_File := PROJECT(offenders_Base, 
																		TRANSFORM(Layout_offenders_base,
																		SELF.gh12							:= left.gh12,
																		SELF.gh4 							:= left.gh12[1..4],
																		SELF.gh5 							:= left.gh12[1..5],
																		SELF.gh6 							:= left.gh12[1..6],
																		SELF.wc_last_name			:= left.last_name,
																		SELF.wc_first_name		:= left.first_name,
																		SELF.wc_middle_name		:= left.middle_name,
																		SELF.wc_name_type			:= left.name_type,
																		SELF.wc_moniker				:= left.moniker,
																		SELF.wc_offenders_sid	:= left.offenders_sid,
																		SELF.class_code				:= Bair.MapClassCodeNum(7, left.classification),
																		self.agency						:= left.data_provider_name,
																		SELF := left));
	
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