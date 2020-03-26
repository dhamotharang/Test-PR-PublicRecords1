// the purpose is to have an index of (all available) last names by phonetic key.
// lname is unique;
// phonetic key to lname relation is 1:m (one phonetization MAY correspond to many words)
// index contain some counters, which can be used later.
IMPORT header, doxie, ut, Autokey, dx_Header;

layout_slim := RECORD (header.layout_phonetic_lname) // all initial counters are set to 1
  unsigned6 did;  
END;

// debug only: this is to skip building persist:
//lnames_src := DATASET (ut.foreign_prod + 'thor_dell400_2::prepped_for_keys', header.layout_prep_for_keys, FLAT);
lnames_src := header.Prepped_For_Keys;

layout_slim Shrink (header.layout_prep_for_keys L) := TRANSFORM
  SELF := L;
END;
ds_slim := PROJECT (lnames_src (did != 0, lname != ''), Shrink (Left));

// WARNING: this code relies on source (for ex., "prepped_for_keys") being distributed by did.
//          If it is not, skip this initial rollup and proceed from distributing below

// Use preemptive pseudo-local sort/rollup to reduce the overall number of records
ds_sort := SORT (ds_slim, lname, did, LOCAL);

layout_slim SetCounts (layout_slim L, layout_slim R) := TRANSFORM
  SELF.lname := R.lname;
  boolean same_did := (L.did = R.did);
  SELF.name_count := L.name_count + R.name_count;
  SELF.did_count := L.did_count + IF (same_did, 0, R.did_count);
  SELF.did := R.did;
  SELF.dph_lname := '';
END;
ds_slim_reduced := ROLLUP (ds_sort, Left.lname = Right.lname, SetCounts (Left, Right), LOCAL);


// WARNING: IF using other than prepped_for_keys source, start building process from here.
// count names frequency and number of distinguished dids belonging to each name
ds_distr := DISTRIBUTE (ds_slim_reduced, hash32 (lname));
ds_grp   := GROUP (SORT (ds_distr, lname, did, LOCAL), lname);
ds_names := ROLLUP (ds_grp, TRUE, SetCounts (Left, Right));

//assign phonetic key; actually, it could be taken from 'Prepped_For_Keys', but due to (possible) additional 
//preprocessing like cleaning, etc., and considering very small overhead, it's done here instead.
layout_slim AssignPhoneticKey (layout_slim L) := TRANSFORM
  SELF.dph_lname := metaphonelib.DMetaPhone1 (L.lname);
  SELF := L;
END;
ds_phonetics := PROJECT (ds_names, AssignPhoneticKey (Left));

//this is "pure" phonetic key, weed out those with pkey value empty, if any
ds_ph := ds_phonetics (dph_lname != '');

// phonetic key frequency
layout_count_phkey := RECORD
  dph_lname := ds_ph.dph_lname;
  cnt := COUNT (GROUP);
END;
phkey_count := TABLE (ds_ph, layout_count_phkey, dph_lname);

layout_output := header.layout_phonetic_lname;
ds_res := JOIN (ds_ph, phkey_count,
                Left.dph_lname = Right.dph_lname,
                transform (layout_output, SELF.pkey_count := Right.cnt; SELF := Left),
                ATMOST (1));  // [m:1]

export data_key_phonetic_lname := PROJECT (ds_res, dx_Header.layouts.i_phonetic_lname);
//export key_phonetic_lname := INDEX (ds_res, {dph_lname}, {ds_res},
//  ut.Data_Location.Person_header+'thor_data400::key::header::' + doxie.Version_SuperKey + '::phonetic_lname');
