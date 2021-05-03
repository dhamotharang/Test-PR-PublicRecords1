// Module that will build the fragment inversion
IMPORT bair, Text_Search, Codes, MDR;
IMPORT LIB_THORLIB;

EXPORT fragment_builder(Training_sharma.Types.SourceList sources=ALL, 
												Types.StateList st_list=ALL,
												 Boolean pDelta=true) := MODULE
	SHARED dsharma_Source := 'D+';
	
	SHARED Persist_Posting(pDelta)	:= functionmacro return Training_sharma.constants('').persistfile(if(pDelta,'Raw_Posting_delta','Raw_Posting_full')); endMacro;
	
	///////////////////// FRAGS /////////////////////////////////////////	
 	SHARED personfrags :=Training_sharma.personfragments(st_list,pDelta);
   	EXPORT personfrags_postings := personfrags.rawPostings;
   	EXPORT person_recs := personfrags.answerRecs;	
	///////////////////// FRAGS /////////////////////////////////////////
	
	// Cleanup Persist datasets used for checkpoints
	EXPORT Cleanup_Persist  := PARALLEL(
						 personfrags.DeletePersist,
						 FileServices.DeleteLogicalFile(Persist_Posting(pDelta))
						 );
		
	// Unified segment data
	s0 := personfrags.SegmentDefinitions;
	EXPORT SegmentDefinitions := s0;
	EXPORT SegmentMetaData := Text_Search.Mod_SegDef(SegmentDefinitions).SegmentDef;
	
	dx := IF(Types.SourceItem.cfs IN sources, person_recs);
	EXPORT AnswerRecords := dx;
	
	// Combine postings
	p0 := IF(Training_sharma.Types.SourceItem.per IN sources, personfrags_postings);
	EXPORT Postings := p0 : PERSIST(Persist_Posting(pDelta)); 
	
END;
