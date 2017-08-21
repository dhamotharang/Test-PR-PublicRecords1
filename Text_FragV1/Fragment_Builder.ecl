// Module that will build the fragment inversion
IMPORT LN_PropertyV2, LN_PropertyV2_Services, Text_Search, Codes, Header, MDR, Corp2, FBNV2;
IMPORT LIB_THORLIB;

EXPORT Fragment_Builder(Types.SourceList sources=ALL, 
												Types.StateList st_list=ALL) := MODULE
	SHARED Prop_Assrs := [MDR.sourceTools.src_LnPropV2_Fares_Asrs, 
												 MDR.sourceTools.src_LnPropV2_Lexis_Asrs];
	SHARED Prop_DM		:= [MDR.sourceTools.src_LnPropV2_Fares_Deeds, 
												 MDR.sourceTools.src_LnPropV2_Lexis_Deeds_Mtgs];
	SHARED FBN				:= MDR.sourceTools.set_Fbnv2;
	SHARED Corp				:= MDR.sourceTools.set_CorpV2;
	
	// temp
	SHARED Persist_Stem 		:= '~THOR_DATA400::PERSIST::FRAGS_';
	SHARED Persist_Posting	:= Persist_Stem + 'Raw_Posting';
	
	// Special segment definitions
	SHARED STRING SeqSegmentName := 'FragV1SequenceKey';
	SHARED Text_Search.Types.ShortSegName SeqName:= Text_Search.MakeShortSeg(seqSegmentName);
	SHARED SeqCompDef := ROW({SeqName, SeqSegmentName, Text_Search.Types.SegmentType.SequenceKey,
																[SeqName]}, Text_Search.Layout_Segment_ComposeDef);
																
	// Cleanup Posting after dstribution
	Layout := Text_Search.Layout_Posting;
	SHARED Layout patchPart(Layout l) := TRANSFORM
		SELF.part := ThorLib.Node();
		SELF := l;
	END;
	
	// Header file
	SHARED hdr_frags := ExpandedHeaderFragments(st_list);
	e0 := hdr_frags.rawPostings;
	e1 := DISTRIBUTE(e0, HASH64(docRef.src, docRef.doc));
	e2 := SORT(e1, docRef.src, docRef.doc, rid, kwp, LOCAL);
	EXPORT hdr_raw_postings := PROJECT(e2, patchPart(LEFT));
	EXPORT hdr_ans_recs := hdr_frags.answerRecs;

	// Property.  Assessor plus Deeds and Mortgages
	SHARED prop_frags := PropertyFragments(st_list);
	e0 := prop_frags.rawPostings;
	e1 := DISTRIBUTE(e0, HASH64(docRef.src, docRef.doc));
	e2 := SORT(e1, docRef.src, docRef.doc, rid, kwp, LOCAL);
	EXPORT Prop_raw_postings := PROJECT(e2, patchPart(LEFT));
	EXPORT Prop_ans_recs := prop_frags.answerRecs;
	
	// Corp filings, base and contact
	SHARED corp_frags := CorpFragments(st_list);
	e0 := corp_frags.rawPostings;
	e1 := DISTRIBUTE(e0, HASH64(docRef.src, docRef.doc));
	e2 := SORT(e1, docRef.src, docRef.doc, rid, kwp, LOCAL);
	EXPORT Corp_raw_postings := PROJECT(e2, patchPart(LEFT));
	EXPORT Corp_ans_recs := corp_frags.answerRecs;
	
	// FBN Business and Contact
	SHARED fbn_frags := FBNFragments(st_list);
	e0 := fbn_frags.rawPostings;
	e1 := DISTRIBUTE(e0, HASH64(docRef.src, docRef.doc));
	e2 := SORT(e1, docRef.src, docRef.doc, rid, kwp, LOCAL);
	EXPORT FBN_raw_postings := PROJECT(e2, patchPart(LEFT));
	EXPORT FBN_ans_recs := fbn_frags.answerRecs;
		
	// Cleanup Persist datasets used for checkpoints
	EXPORT Cleanup_Persist  := PARALLEL(
						hdr_frags.DeletePersist,
						prop_frags.DeletePersist,
						corp_frags.DeletePersist,
						fbn_frags.DeletePersist,
						FileServices.DeleteLogicalFile(Persist_Posting));
		
	// Unified segment data
	s0 := hdr_frags.SegmentDefinitions & prop_frags.SegmentDefinitions 
			& corp_frags.SegmentDefinitions & fbn_frags.SegmentDefinitions
			& SeqCompDef;
	EXPORT SegmentDefinitions := Text_Search.Mod_SegDef(s0);
	EXPORT SegmentMetaData := SegmentDefinitions.SegmentDef;
	SHARED SeqSegNumber := segmentMetaData(SegName=SeqSegmentName)[1].segList[1];
	
	dx := IF(Types.SourceItem.Header IN sources, hdr_ans_recs)
		 &  IF(Types.SourceItem.Property IN sources, prop_ans_recs)
		 &  IF(Types.SourceItem.SOS IN sources, Corp_ans_recs)
		 &  IF(Types.SourceItem.FBN IN sources, FBN_ans_recs);
	EXPORT AllAnswerRecords := dx;
	
	// Generate Sequence Kays
	SeqWork := RECORD
		Text_Search.Layout_Posting.docRef;
		STRING90  sortKey;
		UNSIGNED6 sequenceNumber;
		UNSIGNED2 sequenceNode;
		Text_Search.Types.RID_Type rid;
	END;
	SeqWork cvtSeq(Layout_AnswerListData l) := TRANSFORM
		INTEGER8 wdate := (INTEGER8)l.dt_last_seen;
		UNSIGNED8 datePart:= 210000 - IF(wdate>210000, wdate/100, wdate);
		STRiNG10  namePart:= MAP(l.name.lname <> ''			=> l.name.lname,
														 l.name.full_name  <> ''=> l.name.full_name,
														 l.company_name<> ''		=> l.company_name,
														 'ZZZZZZZZZZZZZZZZZZZZ');
		UNSIGNED6	id			:= MAP(l.did <> 0							=> l.did,
														 l.bdid <> 0						=> l.bdid,
														 0xFFFFFFFFFFFF);
		SELF.sortKey := INTFORMAT(datePart,6,1) + namePart  
									+ IF(l.address.st <> ' ', l.address.st, 'ZZ') 
									+ IF(l.address.prim_name<>' ', l.address.prim_name[1..10], 'ZZZ')
									+ l.address.csz[1..30] + l.address.line1[1..20] 
									+ INTFORMAT(id, 12, 1);
		SELF := l;
		SELF := [];
	END;
	d0 := PROJECT(AllAnswerRecords, cvtSeq(LEFT));
	d1 := SORT(d0, sortKey);
	SeqWork iter1(SeqWork l, SeqWork r) := TRANSFORM
		SELF.sequenceNumber := l.sequenceNumber + 1;
		SELF.sequenceNode   := ThorLib.Node();
		SELF := r;
	END;
	d2 := ITERATE(d1, iter1(LEFT,RIGHT), LOCAL);
	d3 := DISTRIBUTE(d2, HASH64(src, doc));
	d4 := SORT(d3, src, doc, sequenceNode, SequenceNumber, LOCAL);
	d5 := DEDUP(d4, src, doc, LEFT, LOCAL);
	Text_Search.Layout_Posting makeSeqKey(SeqWork l) := TRANSFORM
		SELF.docRef := l;
		SELF.nominal := Text_search.Constants.SequenceKeyNominal;
		SELF.typ := Text_Search.Types.wordType.SeqKey;
		SELF.part := ThorLib.Node();
		SELF.rid := l.rid;
		SELF := Text_Search.SequenceKey.Seq2Fields(l.sequenceNode, l.sequenceNumber);
		SELF := [];
	END;
	EXPORT seqKeyPostings := PROJECT(d5, makeSeqKey(LEFT));
	
	m0 := JOIN(AllAnswerRecords, seqKeyPostings,
						LEFT.src=RIGHT.docRef.src AND LEFT.doc=RIGHT.docRef.doc 
						AND LEFT.rid=RIGHT.rid,
						TRANSFORM(Layout_AnswerListData, SELF:=LEFT)); // Keep only 1
	EXPORT SelectedAnswerRecords := m0;
	
	// Combine raw postings, and patch them up to get Postings
	p0 := MERGE(
				IF(Types.SourceItem.Header IN sources, hdr_raw_postings),
		    IF(Types.SourceItem.Property IN sources, prop_raw_postings),
		    IF(Types.SourceItem.SOS IN sources, Corp_raw_postings),
		    IF(Types.SourceItem.FBN IN sources, FBN_raw_postings),
				SORTED(docRef.src, docRef.doc, rid, kwp), LOCAL);
	EXPORT RawPostings := p0 : PERSIST(Persist_Posting); 
	
	Layout_Posting := Text_Search.Layout_Posting;
	Work1 := RECORD
		Text_Search.Types.DocRef	 prevRef;
		Text_Search.Types.RID_Type prevRid;
		Text_Search.Types.KWP			 prevOutKWP;
		UNSIGNED4			 						 adj;
	END;
	initState := ROW({0,0,0,0,0}, Work1);
	adjMod(Layout_Posting l, Work1 r) := MODULE
		UNSIGNED4 distance := Text_Search.Constants.InterSubSegDistance;
		SHARED UNSIGNED4 adjustment := MAP(
						l.docRef<>r.prevRef => 0,
						l.rid <> r.prevRid	=> r.prevOutKWP + distance,
						r.adj);
		SHARED kwpOut := l.kwp + adjustment;
		EXPORT Layout_Posting adj := TRANSFORM
			SELF.kwp := kwpOut;
			SELF := l;
		END;
		EXPORT Work1 calc := TRANSFORM
			SELF.prevOutKWP	:= kwpOut;
			SELF.adj 				:= adjustment;
			SELF.prevRef		:= l.docRef;
			SELF.prevRid		:= l.rid;
		END;
	END;
	p3 := PROCESS(RawPostings, initState, adjMod(LEFT,RIGHT).adj, 
								adjMod(LEFT,RIGHT).calc, LOCAL);
	p4 := SegmentDefinitions.SetSegs(p3);
	EXPORT postings := p4 & seqKeyPostings;
	
END;