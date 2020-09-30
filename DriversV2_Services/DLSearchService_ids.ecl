IMPORT doxie, STD;

max_deepDIDs := 100;

EXPORT DATASET(layouts.search_ids) DLSearchService_ids(
  BOOLEAN enable_wild = FALSE
) := FUNCTION


// =========================================================
// Get seqs associated with various inputs...
// =========================================================

// NOTE: This may or may not be temporary. We used to just set workHard=false
// here but that was effectively disabling phonetic matching within the autokey
// code. We may want to fix that similar to how we fixed nicknames in bug 22532.
doxie.MAC_Header_Field_Declare();
workHard := phonetics;

// autokeys
envVarDefault := 'ON';
envVarName := 'DLUberSearch';
LuseUberFetch := thorlib.getenv(envVarName,envVarDefault) <> 'OFF';//TRUE unless this env Var is SET to 'OFF'
by_auto := autokey_ids(workHard,,NOT input.incDeepDive,useUberFetch := allow_uber_keys_value OR LuseUberFetch);

// deep dids
deep_dids := LIMIT( doxie.Get_Dids(TRUE,TRUE), max_deepDIDs, SKIP);
by_deep := IF(input.incDeepDive, DLRaw.get_seq_from_dids(deep_dids));

// lookup by DID
dids := IF( input.did<>0, DATASET([{input.did}], doxie.layout_references) );
by_did := DLRaw.get_seq_from_dids(dids);

// lookup by DL_Number
nums := IF( input.dl_num<>'', DATASET([{input.dl_num}], layouts.num) );
by_num := DLRaw.get_seq_from_num(nums);

// lookup by wild DL_Number
hasWild := enable_wild AND LENGTH(STD.STR.Filter(input.dl_num,'*?'))>0;
wildMod := MODULE(PROJECT(input,wildcard.params)) END;
by_wild := IF(hasWild,wildcard.get_seq_from_num(wildMod),DATASET([],layouts.seq));

// lookup by seq
by_seq := IF( input.dl_seq<>0, DATASET([{input.dl_seq}], layouts.seq) );

// search by indicatives
by_ind := DLRaw.get_seq_from_ind(input.DLState, input.agelow, input.agehigh, input.race, input.gender);


// ========================================
// assemble them into a single dataset...
// ========================================

// ...adding the deep dive flag
addFlag(DATASET(layouts.seq) ds, BOOLEAN flag) := PROJECT(
  ds,
  TRANSFORM(layouts.search_ids, SELF.isDeepDive := flag, SELF := LEFT)
);
seqs_all := MAP(
  input.randomize => addFlag(by_ind, FALSE),
  input.dl_seq<>0 => addFlag(by_seq, FALSE),
  hasWild => addFlag(by_wild, FALSE),
  input.dl_num<>'' => addFlag(by_num, FALSE),
  input.did<>0 => addFlag(by_did, FALSE),
  by_auto + addFlag(by_deep, TRUE)
);

// ...and shifting deep-dive-only to the end
seqs_d := DEDUP(SORT(seqs_all, dl_seq, IF(isDeepDive, 1, 0)), dl_seq);

RETURN seqs_d;

END;
