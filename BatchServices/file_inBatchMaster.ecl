
// Virtually identical to doxie.file_inBatchMaster; but, we may need to make changes later
// to meet Batch R2 needs.
IMPORT Autokey_batch, Doxie, ut;
	
// rec := Doxie.layout_inBatchMaster;
rec := Autokey_batch.Layouts.rec_inBatchMaster;

raw1 := DATASET([], rec) : STORED('batch_in', FEW);
raw0 := raw1 : GLOBAL;

rec tra(rec l) := TRANSFORM
	SELF.max_results := if((UNSIGNED8)l.max_results > 0, l.max_results, '500');
	SELF := l;
end;

raw := PROJECT(raw0, tra(LEFT));

ut.MAC_Sequence_Records(raw, seq, raw_seq)

EXPORT file_inBatchMaster(BOOLEAN forceSeq = FALSE) := 
	IF(NOT forceSeq AND EXISTS(raw(seq > 0)), raw, raw_seq);