import ut;

rec := doxie.layout_inBatchMaster;
raw1 := dataset([],rec) : stored('batch_in',few);
raw0 := raw1 : global;

rec tra(rec l) := transform
	self.max_results := if((unsigned8)l.max_results > 0, l.max_results, '50');
	self := l;
end;

raw := project(raw0, tra(left));

ut.MAC_Sequence_Records(raw, seq, raw_seq)

export file_inBatchMaster(boolean forceSeq = false) := 
	if(not forceSeq and exists(raw(seq > 0)), raw, raw_seq);