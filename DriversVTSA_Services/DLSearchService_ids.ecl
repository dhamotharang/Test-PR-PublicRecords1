import doxie;

max_deepDIDs := 100;

export dataset(layouts.search_ids) DLSearchService_ids(
	boolean isAssetRpt = false,
	boolean didOnly = false
) := function


// =========================================================
//  Get seqs associated with various inputs...
// =========================================================

// NOTE: This may or may not be temporary.  We used to just set workHard=false
// here but that was effectively disabling phonetic matching within the autokey
// code.  We may want to fix that similar to how we fixed nicknames in bug 22532.
doxie.MAC_Header_Field_Declare();
workHard := phonetics;

// autokeys
by_auto	:= autokey_ids(workHard);

// deep dids
// deep_dids	:= limit( doxie.Get_Dids(true, not isAssetRpt), max_deepDIDs, skip);
// by_deep 	:= if(input.incDeepDive, DLRaw.get_seq_from_dids(deep_dids));

// lookup by DID
dids := if( input.did<>0, dataset([{input.did}], doxie.layout_references) );
by_did := DLRaw.get_seq_from_dids(dids);

// lookup by DL_Number
nums := if( input.dl_num<>'', dataset([{input.dl_num}], layouts.num) );
by_num := DLRaw.get_seq_from_num(nums);

// lookup by seq
by_seq := if( input.dl_seq<>0, dataset([{input.dl_seq}], layouts.seq) );

// output(by_auto, 		named('by_auto'));		// DEBUG
// output(deep_dids, 	named('deep_dids'));	// DEBUG
// output(by_deep,		named('by_deep'));		// DEBUG
// output(by_did,			named('by_did'));			// DEBUG
// output(by_num, 		named('by_num'));			// DEBUG
// output(by_seq,			named('by_seq'));			// DEBUG


// ========================================
//  assemble them into a single dataset...
// ========================================

// ...adding the deep dive flag 
addFlag(dataset(layouts.seq) ds, boolean flag) := project(
	ds,
	transform(layouts.search_ids, self.isDeepDive := flag, self := left)
);
seqs_all := map(
	input.dl_seq<>0		=> addFlag(by_seq, false),
	input.dl_num<>''	=> addFlag(by_num, false),
	input.did<>0			=> addFlag(by_did, false),
	by_auto// + addFlag(by_deep, true)
);
seqs_didOnly := if(input.did<>0,addFlag(by_did, false));
seqs := if(didOnly, seqs_didOnly, seqs_all);


// ...and shifting deep-dive-only to the end
seqs_d := dedup(sort(seqs, dl_seq), dl_seq);

// output(seqs, 	named('seqs')); 	// DEBUG
// output(seqs_d, named('seqs_d')); // DEBUG

return seqs_d;

end;