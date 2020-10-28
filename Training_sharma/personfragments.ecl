IMPORT Text_Search, Codes, Header, MDR, bair;
// Should inherit IFragmentSource, but needs fix for 51580
EXPORT personfragments(Types.StateList st_list=ALL, Boolean pDelta=true) := MODULE
	
	SHARED Persist_per	:= Training_sharma.constants('').persistfile('persons');

  	SHARED person_File := dataset('~thor_400:out::persons::testdata2',Training_sharma.layout_person_base,thor); 
	SHARED person_mod := Training_sharma.person_baseBooleanSearch(person_File);

	Training_sharma.Layout_AnswerListData xans(Training_sharma.layout_person_base l) := TRANSFORM
		SELF.source_doc_type := 'person';
		SELF.record_id := (STRING62)l.eid;
		SELF.dt_last_seen := (STRING) '';
		SELF := l;
	END;
	SHARED per_ans_recs := PROJECT(person_File, xans(LEFT));
	
	
	// Combine person sources
	EXPORT DeletePersist := FileServices.DeleteLogicalFile(Persist_per);
	EXPORT DATASET(Text_Search.Layout_Segment_ComposeDef) SegmentDefinitions
							:= person_mod.SegmentDefinitions;
	EXPORT DATASET(Text_Search.Layout_Posting) rawPostings
							:= person_mod.Postings_Doc;
	EXPORT DATASET(Training_sharma.Layout_AnswerListData) answerRecs
							:= per_ans_recs;
END;