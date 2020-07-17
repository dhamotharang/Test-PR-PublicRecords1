IMPORT Autokey_batch, Didville;

// Obtain a set of dids for each batch input record. Return only acctno and did. ( 1 acctno --> M dids )
EXPORT GetDIDs(DATASET(Autokey_batch.Layouts.rec_inBatchMaster) dBatchIn, BOOLEAN getBest = FALSE) :=
FUNCTION
  lBatchInDID := PhoneFinder_Services.Layouts.BatchInAppendDID;

  rADLSeq_Layout := RECORD(Autokey_batch.Layouts.rec_inBatchMaster)
    	UNSIGNED8   adl_seq := 0;
  END;

  //Adding a unique Seq number for ADL processing
  dBatch_ADLseq := PROJECT (dBatchIn,  TRANSFORM (rADLSeq_Layout, SELF.adl_seq := COUNTER, SELF := LEFT));

  // ADL process to get dids for pii search
  didville.Layout_Did_OutBatch tFormat2ADLInput(rADLSeq_Layout l) := TRANSFORM
    SELF.seq     := l.adl_seq;
    SELF.phone10 := l.homephone;
    SELF.fname   := l.name_first;
    SELF.mname   := l.name_middle;
    SELF.lname   := l.name_last;
    SELF.suffix  := l.name_suffix;
    SELF         := l;
    SELF         := [];
  END;

  dADLBatchIn := PROJECT(dBatch_ADLseq, tFormat2ADLInput(LEFT));

  // append did
  Didville.MAC_DidAppend(dADLBatchIn, dADLBatchOut, getBest, '');

  rCntDIDs_Layout :=
  RECORD(didville.Layout_Did_OutBatch)
    UNSIGNED1 did_count := 1;
  END;

  dFormat2CntDIDs := SORT(PROJECT(dADLBatchOut, rCntDIDs_Layout), seq, -score);

  rCntDIDs_Layout tCntDIDs(rCntDIDs_Layout le, rCntDIDs_Layout ri) :=
  TRANSFORM
    SELF.did_count := IF(le.score > ri.score, le.did_count, le.did_count + 1);
    SELF           := le;
  END;

  dCntDIDs := ROLLUP(dFormat2CntDIDs, seq, tCntDIDs(LEFT, RIGHT));

  lBatchInDID tFormat2In(rADLSeq_Layout le, rCntDIDs_Layout ri) :=
  TRANSFORM
    SELF.did       := ri.did;
    SELF.did_count := ri.did_count;
    SELF.orig_did  := 0;
    SELF           := le;
  END;

  dWithDIDs := JOIN(dBatch_ADLseq,
                    dCntDIDs,
                    LEFT.adl_seq = RIGHT.seq,
                    tFormat2In(LEFT, RIGHT),
                    LIMIT(0), KEEP(1));

  RETURN dWithDIDs;
END;