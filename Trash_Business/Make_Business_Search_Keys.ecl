IMPORT Business_Header, Text, ut, risk_indicators;

bh := Business_Header.File_Business_Header_FP;

#workunit ('name', 'Build Business_Search_Keys');

layout_slim_bh := RECORD
	bh.company_name;
	bh.state;
	bh.bdid;
	bh.__filepos;
END;

layout_slim_bh MungeName(bh l) := TRANSFORM
	SELF := l;
END;

bh_slim := PROJECT(bh, MungeName(LEFT));

bh_dist := DISTRIBUTE(bh_slim, HASH(bdid));
bh_sort := SORT(bh_dist, bdid, company_name, state, LOCAL);
bh_ded1 := DEDUP(bh_sort, bdid, company_name, state, LOCAL);

// Nix blank states if the same bdid/name has a state.
TYPEOF(bh_ded1) ReplaceBlank(bh_ded1 l, bh_ded1 r) := TRANSFORM
	SELF := r;
END;

bh_ded := ROLLUP(bh_ded1, LEFT.bdid = RIGHT.bdid AND
							LEFT.company_name = RIGHT.company_name AND
							LEFT.state = '',
						  ReplaceBlank(LEFT, RIGHT), LOCAL);

PATTERN namechar := text.Alpha | text.Digit;
PATTERN not_namechar := PATTERN('[^A-Za-z0-9]');
PATTERN wrd := namechar+;
PATTERN co_name := wrd (LAST | not_namechar);

// Must match Layout_Header_Word_Index
words_layout := RECORD
	STRING40  word := MATCHTEXT(wrd);
	STRING2   state := bh_ded.state;
	UNSIGNED1 seq := MATCHPOSITION(wrd);
	UNSIGNED8 filepos := bh_ded.__filepos;
	UNSIGNED6 bdid := bh_ded.bdid;
END;

words := PARSE(	bh_ded, company_name, 
			co_name, words_layout,
			SCAN);

// Order the words found in the same record
words_distrib := DISTRIBUTE(words, HASH(filepos));
words_group := GROUP(SORT(words_distrib, filepos, seq, LOCAL), filepos, LOCAL);
words_dedup := DEDUP(words_group, filepos, word, seq);

words_layout Sequence(words_layout l, words_layout r) := TRANSFORM
	SELF.seq := IF(l.seq = 0, 1, l.seq + 1);
	SELF := r;
END;

words_seq := ITERATE(words_dedup, Sequence(LEFT, RIGHT));

// Create all contained sequences of words within the same bh record
layout_sub_seq := RECORD
	STRING120 word;
	STRING2   state;
	UNSIGNED1 seq;
	UNSIGNED1 right_seq;
	UNSIGNED8 filepos;
	UNSIGNED6 bdid;
END;

layout_sub_seq CreateSubSeq(words_seq l, words_seq r) := TRANSFORM
	SELF.right_seq := r.seq;
	SELF.word := r.word;
	SELF := l;
END;

subseqs := JOIN(words_seq, words_seq,
	LEFT.filepos = RIGHT.filepos AND
	RIGHT.seq >= LEFT.seq,
	CreateSubSeq(LEFT, RIGHT), LEFT OUTER, LOCAL);

// Rollup the sequences.
subseqs_sort := SORT(subseqs, filepos, seq, right_seq, LOCAL);

layout_sub_seq AppendNext(subseqs_sort l, subseqs_sort r) := TRANSFORM
	SELF.word := TRIM(l.word) + r.word;
	SELF := l;
END;

subseqs_rolled := ROLLUP(subseqs_sort, 
	LEFT.filepos = RIGHT.filepos AND
	LEFT.seq = RIGHT.seq, AppendNext(LEFT, RIGHT), LOCAL);

// Dedup identical sequences per bdid
words_ded := DEDUP(subseqs_rolled, bdid, seq, word, ALL);

// Get rid of the right_seq field which we don't need.
Business_Header_SS.Layout_Header_Word_Index Strip(words_ded l) := TRANSFORM
	SELF.bh_filepos := l.filepos;
	SELF := l;
END;

words_final := PROJECT(words_ded, Strip(LEFT));

// Output the file to TEMP, we won't need it once the index is
// built on it.
//switching to base for now to match standard
ut.MAC_SF_BuildProcess(words_final, 'BASE::bh_co_name_words', o_wi, 2)

// Now build the index
ut.MAC_SK_BuildProcess(business_header_ss.Key_Prep_BH_Header_Words, 'key::business_header.CoNameWords',
											 'key::business_header.CoNameWords', i_wi)

// Build an index on the business header file using
// the bdid as the primary field.
layout_slim_bh2 := RECORD
	bh.bdid;
	bh.city;
	bh.zip;
	bh.fein;
	bh.phone;
END;

layout_slim_bh2 SlimBH(bh l) := TRANSFORM
	SELF := l;
END;

bh_slim2 := PROJECT(bh, SlimBH(LEFT));
bh_slim_ded2 := DEDUP(bh_slim2, bdid, city, zip, fein, phone, ALL);

// Output the file to TEMP, we won't need it once the index is
// built on it.

ut.MAC_SF_BuildProcess(bh_slim_ded2, 'BASE::bh_bdid.city.zip.fein.phone', o_sbh, 2)

// Now build the index
ut.MAC_SK_BuildProcess(business_header_ss.Key_Prep_BH_BDID_City_Zip_Fein_Phone, 'key::business_header_bdid.city.zip.fein.phone',
											 'key::business_header_bdid.city.zip.fein.phone', i_sbh)

all_stuff := SEQUENTIAL(
	PARALLEL(o_wi, o_sbh), 
	ut.SF_MaintBuilding('BASE::bh_co_name_words'),
	ut.SF_MaintBuilding('BASE::bh_bdid.city.zip.fein.phone'),
	PARALLEL(i_wi, i_sbh),
	ut.SF_MaintBuilt('BASE::bh_co_name_words'),
	ut.SF_MaintBuilt('BASE::bh_bdid.city.zip.fein.phone')
	);

parallel(all_stuff,risk_indicators.proc_build_hri_all);