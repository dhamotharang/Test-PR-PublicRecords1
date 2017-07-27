// the purpose is to have an index of (all available) last names by phonetic key.
// lname is unique;
// phonetic key to lname relation is 1:m (one phonetization MAY correspond to many words)
// index contain some counters, which can be used later.
IMPORT header, doxie, ut;

layout_slim := RECORD (header.layout_phonetic_lname)
  unsigned6 did;
END;

lnames_src := header.Prepped_For_Keys;
// this is to skip building persist:
//lnames_src := DATASET ('~thor_dell400_2::prepped_for_keys', header.layout_prep_for_keys, FLAT);
//lnames_src := PROJECT (PULL (doxie.Key_Header_Name), Autokey.Layout_Name);

layout_slim Shrink (header.layout_prep_for_keys L) := TRANSFORM
  SELF.lname := trim (L.lname);
  SELF := L;
END;
ds_slim := PROJECT (lnames_src (did != 0), Shrink (Left)) (lname != '');

// count names frequency and number of distinguished dids belonging to each name
ds_distr := DISTRIBUTE (ds_slim, hash32 (lname));
ds_grp   := GROUP (SORT (ds_distr, lname, did, LOCAL), lname);

layout_slim SetCounts (layout_slim L, layout_slim R) := TRANSFORM
  SELF.lname := R.lname;
  boolean same_did := (L.did = R.did);
  SELF.name_count := L.name_count + 1;
  SELF.did_count := L.did_count + IF (same_did, 0, 1);

  // actually, this could be taken from 'Prepped_For_Keys', but because of (possible) additional preprocessing
  // like trimming, cleaning, etc., and considering very small overhead, it's done here instead.
  SELF.dph_lname := metaphonelib.DMetaPhone1 (L.lname);

  SELF.did := R.did;
END;
ds_names := ROLLUP (ds_grp, TRUE, SetCounts (Left, Right));

layout_output := header.layout_phonetic_lname;

//this is "pure" phonetic key, weed out those with pkey value empty, if any
ds_ph := ds_names (dph_lname != '');

// phonetic key frequency
layout_count_phkey := RECORD
  dph_lname := ds_ph.dph_lname;
  cnt := COUNT (GROUP);
END;
phkey_count := TABLE (ds_ph, layout_count_phkey, dph_lname);

ds_res := JOIN (ds_ph, phkey_count,
                Left.dph_lname = Right.dph_lname,
                transform (layout_output, SELF.pkey_count := Right.cnt; SELF := Left),
                ATMOST (1));  // [m:1]

export key_phonetic_lname := INDEX (ds_res, {dph_lname}, {ds_res},
  '~thor_data400::key::header::' + doxie.Version_SuperKey + '::phonetic_lname');
