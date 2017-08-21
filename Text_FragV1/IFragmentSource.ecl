IMPORT Text_Search;
EXPORT IFragmentSource := INTERFACE
	EXPORT DeletePersist := FileServices.DeleteLogicalFile(Persist_Name);
	EXPORT DATASET(Text_Search.Layout_Segment_ComposeDef) SegmentDefinitions;
	EXPORT DATASET(Text_Search.Layout_Posting) rawPostings;
	EXPORT DATASET(Text_FragV1.Layout_AnswerListData) answerRecs;
END;