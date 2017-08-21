// Module that will build the fragment inversion
IMPORT bair, Text_Search, Codes, MDR;
IMPORT LIB_THORLIB;

EXPORT fragment_builder(Types.SourceList sources=ALL, 
												Types.StateList st_list=ALL,
												 Boolean pDelta=true) := MODULE
	SHARED Bair_Source := [MDR.sourceTools.src_Bair_Analytics];
	
	// temp
	//SHARED Persist_Stem 		:= '~bair::PERSIST::FRAGS_';
	SHARED Persist_Posting(pDelta)	:= functionmacro return bair_boolean.constants('').persistfile(if(pDelta,'Raw_Posting_delta','Raw_Posting_full')); endMacro;
	
	
	///////////////////// FRAGS /////////////////////////////////////////
	
 	// cfs frags
   	SHARED cfsfrags := cfsfragments(st_list,pDelta);
   	EXPORT cfsfrags_postings := cfsfrags.rawPostings;
   	EXPORT cfs_recs := cfsfrags.answerRecs;

	
	// events frags
	SHARED eventsfrags := eventsfragments(st_list,pDelta);
	EXPORT eventsfrags_postings := eventsfrags.rawPostings;
	EXPORT events_recs := eventsfrags.answerRecs;
	
 	// crash frags
   	SHARED crashfrags := crashfragments(st_list,pDelta);
   	EXPORT crashfrags_postings := crashfrags.rawPostings;
   	EXPORT crash_recs := crashfrags.answerRecs;
   	
   	// intel frags
   	SHARED intelfrags := intelfragments(st_list,pDelta);
   	EXPORT intelfrags_postings := intelfrags.rawPostings;
   	EXPORT intel_recs := intelfrags.answerRecs;
   	
   	// lpr frags
   	SHARED lprfrags := lprfragments(st_list,pDelta);
   	EXPORT lprfrags_postings := lprfrags.rawPostings;
   	EXPORT lpr_recs := lprfrags.answerRecs;
   	
   	// offenders frags
   	SHARED offendersfrags := offendersfragments(st_list,pDelta);
   	EXPORT offendersfrags_postings := offendersfrags.rawPostings;
   	EXPORT offenders_recs := offendersfrags.answerRecs;
   	
   	// shotspotter frags
   	SHARED shotspotterfrags := shotspotterfragments(st_list,pDelta);
   	EXPORT shotspotterfrags_postings := shotspotterfrags.rawPostings;
   	EXPORT shotspotter_recs := shotspotterfrags.answerRecs;
   	

	
	///////////////////// FRAGS /////////////////////////////////////////
	
	// Cleanup Persist datasets used for checkpoints
	EXPORT Cleanup_Persist  := PARALLEL(
						 cfsfrags.DeletePersist,
						 eventsfrags.DeletePersist,
						 crashfrags.DeletePersist,
						intelfrags.DeletePersist,
						lprfrags.DeletePersist,
						offendersfrags.DeletePersist,
						shotspotterfrags.DeletePersist,
						FileServices.DeleteLogicalFile(Persist_Posting(pDelta)));
		
	// Unified segment data
	s0 := cfsfrags.SegmentDefinitions & eventsfrags.SegmentDefinitions & crashfrags.SegmentDefinitions & intelfrags.SegmentDefinitions  & lprfrags.SegmentDefinitions & offendersfrags.SegmentDefinitions & shotspotterfrags.SegmentDefinitions /*& prop_frags.SegmentDefinitions 
			& corp_frags.SegmentDefinitions & fbn_frags.SegmentDefinitions
			& SeqCompDef*/;
	EXPORT SegmentDefinitions := s0;
	EXPORT SegmentMetaData := Text_Search.Mod_SegDef(SegmentDefinitions).SegmentDef;
	
	dx := IF(Types.SourceItem.cfs IN sources, cfs_recs)
				& IF (Types.SourceItem.events IN sources, events_recs)
				& IF (Types.SourceItem.crash IN sources, crash_recs)
				& IF (Types.SourceItem.intel IN sources, intel_recs)
				& IF (Types.SourceItem.lpr IN sources, lpr_recs)
				& IF (Types.SourceItem.offenders IN sources, offenders_recs)
				& IF (Types.SourceItem.shotspotter IN sources, shotspotter_recs)

		 /*&  IF(Types.SourceItem.Property IN sources, prop_ans_recs)
		 &  IF(Types.SourceItem.SOS IN sources, Corp_ans_recs)
		 &  IF(Types.SourceItem.FBN IN sources, FBN_ans_recs)*/;
	EXPORT AnswerRecords := dx;
	

	
	// Combine postings
	p0 := IF(Types.SourceItem.cfs IN sources, cfsfrags_postings)
			  &	IF(Types.SourceItem.events IN sources, eventsfrags_postings)
 			  &	IF(Types.SourceItem.crash IN sources, crashfrags_postings)
   			&	IF(Types.SourceItem.intel IN sources, intelfrags_postings)
   			&	IF(Types.SourceItem.lpr IN sources, lprfrags_postings)
   			&	IF(Types.SourceItem.offenders IN sources, offendersfrags_postings)
   			&	IF(Types.SourceItem.shotspotter IN sources, shotspotterfrags_postings)

		  // & IF(Types.SourceItem.Property IN sources, prop_raw_postings)
		  // & IF(Types.SourceItem.SOS IN sources, Corp_raw_postings)
		  // & IF(Types.SourceItem.FBN IN sources, FBN_raw_postings)*/
			;
	EXPORT Postings := p0 : PERSIST(Persist_Posting(pDelta)); 
	
END;
