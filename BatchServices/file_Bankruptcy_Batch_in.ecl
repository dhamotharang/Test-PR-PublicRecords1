// Virtually identical to BatchServices.file_inBatchMaster
IMPORT Autokey_batch, Doxie, ut;
	
rec := layout_BankruptcyV3_Batch_in;

raw1 := DATASET([], rec) : STORED('batch_in', FEW);
raw0 := raw1 : GLOBAL;

rec tra(rec L) := TRANSFORM
	SELF.max_results := if((UNSIGNED8)L.max_results > 0, L.max_results, '500');
	/* name suffix substitutions to improve matching */
	name_suff_upper  := StringLib.StringToUpperCase(L.name_suffix);
	SELF.name_suffix := MAP(name_suff_upper = 'JR'	=> 'J',
							name_suff_upper = 'SR'	=> 'S',
							name_suff_upper = 'I'	=> 'I',
							name_suff_upper = 'II'	=> '2',
							name_suff_upper	= 'III'	=> '3',
							name_suff_upper	= 'IV'	=> '4',
							name_suff_upper	= 'V'	=> '5',
							L.name_suffix);
	SELF := L;
end;

raw := PROJECT(raw0, tra(LEFT));

ut.MAC_Sequence_Records(raw, seq, raw_seq)

EXPORT file_Bankruptcy_Batch_in(BOOLEAN forceSeq = FALSE) := 
	IF(NOT forceSeq AND EXISTS(raw(seq > 0)), raw, raw_seq);