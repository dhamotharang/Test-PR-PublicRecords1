IMPORT Lib_THORLIB;
LocalEntry_Limit := 5000000;

EXPORT Nominalization_Module(BOOLEAN incremental, Filename_Info info, 
														DATASET(Layout_Posting) invFile) := MODULE

	SHARED Types2Assign := [Types.WordType.TextStr, Types.WordType.AttrText,
														Types.WordType.SSN];
												 
	SHARED DictTypes := [Types.WordType.TextStr, Types.WordType.AttrText,
											 Types.WordType.MetaData, Types.WordType.SSN, Types.WordType.MultiEquiv];
											 
  //the only persist file
	SHARED inv_d := invFile:PERSIST(Persist_Name(info, Types.PersistType.Posting,incremental), SINGLE);

	// The old dictionary or an empty dictionary
  old_dict := PROJECT(PULL(Indx_Dictionary3(info)), Layout_Dictionary);
  nul_dict := DATASET([], Layout_Dictionary);
  SHARED inp_dict := DISTRIBUTE(IF(incremental, old_dict, nul_dict),HASH32(word));

  //The first nominal value to assign
  SHARED Base_Nominal := IF(incremental, MAX(inp_dict, nominal) + 1, 4096);
  
  //Sorted local entries
	SHARED dict_Inv_LSorted := SORT(inv_d(typ IN DictTypes), word, typ, docRef, LOCAL);
  
  //track where the words come from off local dictionaries
	SHARED NodeRecord := RECORD
		INTEGER2 node;
	END;

	SHARED withDocNode := RECORD(Layout_Dictionary) 
	  Types.DocRef docRef; 
		INTEGER2 node;
		INTEGER2 nodeCount;
		BOOLEAN	 localWord;
    BOOLEAN  usedWord;
		DATASET(NodeRecord) list{MAXCOUNT(Limits.Max_Parts)};
	END;

	withDocNode cvt(Layout_Posting l) := TRANSFORM
		SELF.word := l.word;
		SELF.nominal := IF(l.typ IN Types2Assign, 0, l.nominal);
		SELF.suffix  := IF(l.typ IN Types2Assign, 0, l.suffix);
		SELF.freq := 1;
		SELF.docFreq := 1;
		SELF.docRef := l.docRef;
		SELF.node 	:= ThorLib.Node();
		SELF.nodeCount := 1;
		SELF.localWord := FALSE;
		SELF.typ := l.typ;
		SELF.list := DATASET([{SELF.node}], NodeRecord);
    SELF.usedWord := TRUE;
	END;
		
	d1s	:= PROJECT(dict_Inv_LSorted(word<>''), cvt(LEFT));	
	
	withDocNode roll1(withDocNode l, withDocNode r, 
								BOOLEAN rollDoc, BOOLEAN rollNode) := TRANSFORM
		SELF.freq := l.freq + r.freq;
		SELF.docFreq := l.docFreq + IF(rollDoc, r.docFreq, 0);
		SELF.nodeCount := l.nodeCount + IF(rollNode, r.nodeCount, 0); 
		SELF.list  := IF(rollNode, l.list & r.list, r.list);
		SELF := l;
	END;
	// this rollup establishes docFreq for each word
	d1r	:= ROLLUP(d1s, roll1(LEFT,RIGHT, FALSE, FALSE), 
								word, typ, docRef.src, docRef.doc, LOCAL);
	// this rollup produces one Dictionary entry per word on the node
	d1r2 := ROLLUP(d1r, roll1(LEFT,RIGHT, TRUE, FALSE), word, typ, LOCAL);

	// Now distribute and get 1 entry per word
	d2 	:= DISTRIBUTE(d1r2, HASH32(word));
	d2s	:= SORT(d2, word, typ, LOCAL);
	d2r	:= ROLLUP(d2s, roll1(LEFT,RIGHT, TRUE, TRUE), word, typ, LOCAL);
  
  // Merge old dictionary to pick up nominals
  withDocNode cvt_dict(Layout_Dictionary d) := TRANSFORM
    SELF := d;
    SELF := [];
  END;
  dict_asDocNode := SORT(PROJECT(inp_dict, cvt_dict(LEFT)), word, typ, LOCAL);
  withDocNode mrg_old(withDocNode base, withDocNode incr) := TRANSFORM
    SELF.nominal := IF(base.nominal=0, incr.nominal, base.nominal); //latch nominal
    SELF.suffix  := IF(base.suffix=0, incr.suffix, base.suffix);    //latch suffix
    SELF.freq := incr.freq + base.freq;
    SELF.docFreq := incr.docFreq + base.docFreq;
    SELF.usedWord := base.usedWord OR incr.usedWord;
    SELF.nodeCount := IF(base.nodeCount>0, base.nodeCount, incr.nodeCount); // latch
    SELF.list := IF(base.nodeCount>0, base.list, incr.list); // latch
    SELF := base;
  END;
  d2_mrg := MERGE(d2r, dict_asDocNode, SORTED(word, typ), LOCAL);
  d2m := ROLLUP(d2_mrg, mrg_old(LEFT, RIGHT), word, typ, LOCAL);
  EXPORT wordList := IF(incremental, d2m(usedWord), d2r);
  
	EXPORT needNominal := wordList(nominal=0 AND suffix=0);
	EXPORT preAssigned := wordList(nominal<>0 OR suffix <> 0);
	
	withDocNode nameEntries(withDocNode l, withDocNode r, 
													INTEGER nominalFloor) := TRANSFORM
		SELF.nominal := IF(l.nominal=0, nominalFloor+ThorLib.Node(), 
																		l.nominal+ThorLib.Nodes());
		SELF := r;
	END;
	d3 := ITERATE(needNominal, nameEntries(LEFT,RIGHT, Base_Nominal), LOCAL);
	EXPORT nominal_assigned := d3 & preAssigned ;
	
	// determine Local (local replicants) versus Global entries
	NodeLimit := RECORD
		INTEGER2		nodes;
		INTEGER5		words := 1;
		INTEGER5		cummulative := 0;
	END;
	t0:=DISTRIBUTED(PROJECT(nominal_assigned,TRANSFORM(NodeLimit,SELF.nodes:=LEFT.nodeCount)));
	
	NodeLimit rollNodeLimit(NodeLimit l, NodeLimit r) := TRANSFORM
		SELF.words := l.words + r.words;
		SELF := l;
	END;
	t1 := ROLLUP(SORT(t0, nodes, LOCAL), rollNodeLimit(LEFT, RIGHT), nodes, LOCAL);
	t2 := ROLLUP(SORT(t1, nodes), rollNodeLimit(LEFT, RIGHT), nodes);
	NodeLimit sumNode(NodeLimit l, NodeLimit r) := TRANSFORM
		SELF.cummulative := l.cummulative + r.words;
		SELF := r;
	END;
	t3 := ITERATE(SORT(t2, -nodes), sumNode(LEFT,RIGHT));
	
	withDocNode markLocals(WithDocNode l, NodeLimit r) := TRANSFORM
		SELF.localWord := IF(r.cummulative > LocalEntry_Limit, TRUE, FALSE);
		SELF := l;
	END;
	SHARED d5 := JOIN(nominal_assigned, t3, LEFT.nodeCount=RIGHT.nodes,
										markLocals(LEFT,RIGHT), LOOKUP);
	
	
	EXPORT GlobalEntries := d5(localWord=FALSE);;
	
	// replicate for local entries on each node
	SHARED withDocNode replicateEntries(withDocNode l, INTEGER c) := TRANSFORM
		SELF.node := l.list[c].node;
		SELF := l;
	END;
	d6 := NORMALIZE(d5(localWord), LEFT.nodeCount, replicateEntries(LEFT,COUNTER));
	EXPORT LocalEntries	:= DISTRIBUTE(d6, node);

	// Dictionary
	EXPORT GlobalDictionary := PROJECT(nominal_assigned, Layout_Dictionary);

	// Assign nominals to inversion
	Layout_Posting assignNominal(Layout_Posting l, Layout_Dictionary r) :=TRANSFORM
		SELF.nominal := IF(r.nominal<>0, r.nominal, l.nominal);
		SELF.suffix  := IF(r.suffix<>0,  r.suffix,  l.suffix);
		SELF := l;
	END;
	lk1 := JOIN(inv_d(typ IN DictTypes), PROJECT(GlobalEntries, Layout_Dictionary), 
							LEFT.word=RIGHT.word AND LEFT.typ=RIGHT.typ,
							assignNominal(LEFT,RIGHT), NOSORT(LEFT), LEFT OUTER, LOOKUP);
	lk2 := lk1(nominal=0 AND suffix=0);
	gent:= lk1(nominal<>0 OR suffix<>0);		
	lk2s:= SORT(lk2, word, typ, docRef, LOCAL);

	lent:= JOIN(lk2s, PROJECT(LocalEntries, Layout_Dictionary), 
							LEFT.word=RIGHT.word AND 
						  LEFT.typ=RIGHT.typ,
							assignNominal(LEFT,RIGHT), NOSORT(LEFT), LEFT OUTER, LOCAL);
			
	iw_0 := gent + lent + inv_d(typ NOT IN DictTypes);
		

	EXPORT Inversion := PROJECT(iw_0, Layout_Posting);
	
	// build the local dictionary 
	ldct_0 := NORMALIZE(GlobalEntries, LEFT.nodeCount, replicateEntries(LEFT,COUNTER));	
	ldct_1 := DISTRIBUTE(ldct_0,node) + LocalEntries;
	ldct_2 := PROJECT(SORT(ldct_1, word, typ, node, LOCAL), Layout_Dictionary);
  ldct_3 := SORT(ldct_2, word, typ, -freq, LOCAL);
  ldct_4 := DEDUP(ldct_3, word, typ, LOCAL);
	
	EXPORT LocalDictionary := ldct_4;
  
	// build the local dictionary with the substring entries
	Text_Search.Layout_Dictionary2 replicateSubstr(Text_Search.Layout_Dictionary2 dictRec, Integer cnt) := TRANSFORM
		SELF.word := dictRec.word[cnt..LENGTH(dictRec.word)];
		// SELF.fullword := dictRec.word;
		SELF.subString := cnt!=1;
		SELF := dictRec;
	END;
	
	ldct_5 := PROJECT(LocalDictionary,TRANSFORM(Text_Search.Layout_Dictionary2,SELF.substring := false,
																																						 SELF.fullword := LEFT.word,
																																						 SELF := LEFT));
	
	ldct_5txt := NORMALIZE(ldct_5(typ=Text_Search.Types.WordType.TextStr),LENGTH(TRIM(LEFT.word)),replicateSubstr(LEFT,COUNTER));

	ldct_6 := ldct_5txt & ldct_5(typ!=Text_Search.Types.WordType.TextStr);
	
	EXPORT LocalDictionary2 := ldct_6;
	
  // build the dictionary stats record
  dfreq_tab := RECORD
    REAL8 maxDocFreq := MAX(GROUP,GlobalDictionary.docFreq);
    REAL8 maxFreq := MAX(GROUP, GlobalDictionary.freq);
    UNSIGNED4 nominals := COUNT(GROUP);
  END;
  dfreq := DISTRIBUTE(TABLE(GlobalDictionary, dfreq_tab),1); // single record to node 1
  MetaData_Type := Types.WordType.MetaData;
  kw_cnt_nominal := Constants.KeywordCountNominal;
  doc_size_postings := invFile(typ=Metadata_Type AND nominal=kw_cnt_nominal AND seg=0);
  dsize_tab := RECORD
    REAL8 meanDocSize:=AVE(GROUP,doc_size_postings.kwp);
    UNSIGNED4 docCount:=COUNT(GROUP);
  END;
  dsize := DISTRIBUTE(TABLE(doc_size_postings, dsize_tab),1); // single record to node 1
	Layout_DictStats cmb(dfreq_tab dfreq, dsize_tab dsize) := TRANSFORM
    SELF.maxDocFreq := dfreq.maxDocFreq;
    SELF.maxFreq := dfreq.maxFreq;
    SELF.UniqueNominals := dfreq.nominals;
    SELF.meanDocSize := dsize.meanDocSize;
    SELF.docCount := dsize.docCount;
    SELF.version := 1;  // all versions can be one
  END;
	EXPORT DictStats := COMBINE(dfreq, dsize, cmb(LEFT,RIGHT), LOCAL);  //Only local supported
END;