// ADDING PARTS OF COMPOUND/DIRTY LAST NAMES TO HEADER FILE.
//   creates a set of records with last names containing any non-letter delimeters;
//   parses names into name parts;
//   filters invalid entries, joines the result with the input data set.
// Uses distribution by did-lname

IMPORT Header;

//input dataset MUST BE distributed (hashed) by did
export layout_prep_for_keys ProcessCompoundNames
  (const DATASET (layout_prep_for_keys) dt_source) := FUNCTION

layout_source := RECORDOF (dt_source);
layout_slim := RECORD
  unsigned6 did;
	qstring20 lname;
END;

// source is probably already distributed by did, but this is a small overhead
//dt_hashed := DISTRIBUTE (dt_source, HASH (did));
dt_hashed := DISTRIBUTED (dt_source, HASH (did));

// Get subset (shrinked to slim layout) with lnames containing delimeters;
String delims := ' -\'(),;/[]&=';
trimmedname := TRIM (dt_hashed.lname, LEFT, RIGHT);
len_trim := LENGTH (trimmedname);
Boolean ContainsDelims := 
  len_trim > LENGTH (StringLib.StringFilterOut (trimmedname, delims));

dt_delimeted := PROJECT (dt_hashed (ContainsDelims), TRANSFORM (layout_slim, SELF :=LEFT));

// simple pre-filtering by first/last names
// SET OF STRING InvalidFNamesSet := ['TRUST', 'CUSTOM'];
// validNames := dt_hashed.fname NOT IN InvalidFNamesSet;

// delete duplicates
temp_0 := SORT (dt_delimeted, did, lname, LOCAL);
dt_dedup := DEDUP (temp_0, did, lname, LOCAL);

// delete entries with names, containing numbers
String numbers := '0123456789';
len := LENGTH (dt_dedup.lname);
Boolean ContainsNumbers := 
  len > LENGTH (StringLib.StringFilterOut (dt_dedup.lname, numbers));
dt_not_numbered := dt_dedup (NOT ContainsNumbers);


//==============================================================
//=======  Parsing last names into individual parts  ===========
//==============================================================
//patterns for parsing compound or "dirty" names
//PATTERN pt_word   := PATTERN ('[A-Za-z0-9]')+;  //numbers were filtered out before
PATTERN pt_word   := PATTERN ('[A-Za-z]')+;
PATTERN pt_delim   := (ANY NOT IN pt_word)+;
TOKEN word1 := pt_word;
TOKEN word2 := pt_word;
TOKEN word3 := pt_word;
TOKEN word4 := pt_word;
RULE name_parts := OPT (pt_delim) word1 OPT (pt_delim word2 OPT (pt_delim word3 OPT (pt_delim word4)));

// Parse last name into parts (first 4 parts considered only)
layout_nameParts := RECORD
  dt_not_numbered;
  first_part  := MATCHTEXT (word1);
  second_part := MATCHTEXT (word2);
  third_part  := MATCHTEXT (word3);
  fourth_part := MATCHTEXT (word4);
END; 
dt_parsed := PARSE (dt_not_numbered, lname, name_parts, layout_nameParts, MAX);

// Preliminary filtering by invalid name's part (purely empirical).
// Any record, containing those, is considered invalid
SET OF String NotAName := ['OF', 'INC', 'ASS', 'AVE', 'OLD', 'OUR',
                           'EST', 'SPA', 'AUTO', 'EXPO', 'PROPERTIES',
													 'SON', 'SONS', 'INT']; //'CONSTRUCTION, etc.

dt_parts := dt_parsed (first_part NOT IN NotAName,
                       second_part NOT IN NotAName,
                       third_part NOT IN NotAName,
                       fourth_part NOT IN NotAName);



//=======================================================
// ====== Normalize all name parts into 'newName' =======
//=======================================================
layout_did_partname := RECORD
	dt_parts;
	qstring20 partName;
END;

layout_did_partname createRecords (layout_nameParts L, Integer cnt) := TRANSFORM
	SELF.partName := CHOOSE (cnt, 
							             L.first_part,
                           IF (L.second_part <> '', L.second_part, SKIP),
                           IF (L.third_part <> '', L.third_part, SKIP),
                           IF (L.fourth_part <> '', L.fourth_part, SKIP));
  SELF := L;
END;
dt_norm := NORMALIZE (dt_parts, 4, createRecords (LEFT, COUNTER));


//===============================================
// ====== Clean newly created names =============
//===============================================
//filter out 1- and 2-letter words
Boolean IsValidLength := (LENGTH (TRIM (dt_norm.partName)) > 2); //??? trim not required?

// names should contain vowels
String letters := 'AEIOUY';
Boolean ContainsVowels := 
  LENGTH (dt_norm.partName) > LENGTH (StringLib.StringFilterOut (dt_norm.partName, letters));

Boolean IsValidName := ContainsVowels AND IsValidLength;
dt_cleaned := dt_norm (IsValidName);

// Filter common (prefix) names using predefined patterns
SET OF String CommonName3 := ['AKA', 'DEL', 'VAN', 'ABU', 'BEN', 'ALI', 'WON', 'VON',
                              'DER', 'DES', 'DON', 'LOS'];
															
// SET OF qstring20 invalids := ['MORTGAGE', 'ELECTRONIC', 'REGISTRAT',
//                               'TRUSTEE', 'WESTERN', 'MUTUAL', 'REVOCABLE'];
															
dt_valid_names := dt_cleaned (partName NOT IN CommonName3);

// Delete duplicate 'newName's within given 'lname' (lname like 'John John')
dt_temp1    := SORT (DISTRIBUTED (dt_valid_names, HASH (did)), did, lname, partName, LOCAL);
//dt_temp1    := SORT (dt_valid_names, did, lname, partName, LOCAL);
dt_newnames := DEDUP (dt_temp1, RECORD, LOCAL);

//gets all header fields for names' parts
layout_source getFields (layout_source L, layout_did_partname R) := TRANSFORM
  SELF.lname := R.partName;
	SELF := L;
END;

//dt_hashed and dt_newnames are distributed by did; sorted by did, lname
dt_joined := dt_hashed + JOIN (dt_hashed,
                               dt_newnames,
                               (LEFT.did = RIGHT.did) AND (LEFT.lName = RIGHT.lName), 
                               getFields (LEFT, RIGHT),
                               LOCAL);

RETURN dt_joined;
END;