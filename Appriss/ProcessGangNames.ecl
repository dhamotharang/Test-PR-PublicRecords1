
//   creates a set of records with last names containing any non-letter delimeters;
//   parses names into name parts;
//   filters invalid entries, joines the result with the input data set.

IMPORT Header;

//input dataset MUST BE distributed (hashed) by did
export layout_prep_gang_key ProcessGangNames 
  (const DATASET (layout_prep_gang_key) data_source) := FUNCTION
	
data_hashed := DISTRIBUTED (data_source, HASH (booking_sid));

// Get subset containing delimeters;
String delims := ' .#-\'(),;/[]&=:';
trimmedname := TRIM (data_hashed.gang, LEFT, RIGHT);
len_trim := LENGTH (trimmedname);
Boolean ContainsDelims := 
  len_trim > LENGTH (StringLib.StringFilterOut (trimmedname, delims));

data_delimeted := PROJECT (data_hashed (ContainsDelims), TRANSFORM (layout_prep_gang_key, SELF :=LEFT));
//output(data_delimeted);

//==============================================================
//=======  Parsing name into individual parts  ===========
//==============================================================
PATTERN pt_word   := PATTERN ('[A-Za-z0-9]')+;
PATTERN pt_delim   := (ANY NOT IN pt_word)+;
TOKEN word1 := pt_word;
TOKEN word2 := pt_word;
TOKEN word3 := pt_word;
TOKEN word4 := pt_word;
RULE name_parts := OPT (pt_delim) word1 OPT (pt_delim word2 OPT (pt_delim word3 OPT (pt_delim word4)));

// Parse name into parts (first 4 parts considered only)
layout_nameParts := RECORD
  data_delimeted;
  first_part  := MATCHTEXT (word1);
  second_part := MATCHTEXT (word2);
  third_part  := MATCHTEXT (word3);
  fourth_part := MATCHTEXT (word4);
END; 
data_parsed := PARSE (data_delimeted, gang, name_parts, layout_nameParts, MAX);
//output(data_parsed());
// Preliminary filtering by invalid name's part (purely empirical).
// Any record, containing those, is considered invalid
SET OF String NotAName := ['EX','ON','THE','AND','EL','DEL','ST','TH','ND','RD',
                           'NA','NO','NONE','OF', 'INC', 'ASS', 'AVE',
                           'EST', 'SPA', 'AUTO', 'EXPO', 'PROPERTIES','NON',
													 'INT']; //'CONSTRUCTION, etc.

data_parts := data_parsed (first_part NOT IN NotAName,
                           second_part NOT IN NotAName,
                           third_part NOT IN NotAName,
                           fourth_part NOT IN NotAName);

//=======================================================
// ====== Normalize all name parts into 'newName' =======
//=======================================================

layout_did_partname := RECORD
	data_parts;
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

data_norm := NORMALIZE (data_parts, 4, createRecords (LEFT, COUNTER));
//output(data_norm(booking_sid in ['10186109','10186110']));
//filter out 1- letter words
Boolean IsValidLength := (LENGTH (TRIM (data_norm.partName)) > 1); 

data_cleaned := data_norm (IsValidLength);

// Filter common (prefix) names using predefined patterns
SET OF String CommonName3 := ['AKA', 'DEL', 'VAN', 'ABU', 'BEN', 'ALI', 'WON', 'VON',
                              'DER', 'DES', 'DON'];
															
data_valid_names := data_cleaned (partName NOT IN CommonName3);
//output(data_valid_names);
// Delete duplicate 'newName's 
data_temp1    := SORT (DISTRIBUTED (data_valid_names, HASH (booking_sid)), booking_sid, gang, partName, LOCAL);

data_newnames := DEDUP (data_temp1, RECORD, LOCAL);

//gets all  names' parts
layout_prep_gang_key getFields (layout_prep_gang_key L, layout_did_partname R) := TRANSFORM
  SELF.gang := REGEXREPLACE('([0-9])(TH |ST |RD |ND )', R.partName, '$1 ');
	SELF := L;
END;

layout_prep_gang_key stripchars(data_hashed L) := transform 
 clean_gang1 := stringlib.stringfilterout(l.gang,' .#-\'(),;/[]&=:');
 clean_gang2 := REGEXREPLACE('([0-9])(TH |ST |RD |ND )', clean_gang1, '$1 ');
 self.gang := clean_gang2; 
 self      := L;
end;

data_filtered := PROJECT (data_hashed , stripchars(left));
data_joined := data_filtered
               + JOIN (data_hashed,data_newnames,
                                   (LEFT.booking_sid = RIGHT.booking_sid) AND (LEFT.gang = RIGHT.gang), 
                                   getFields (LEFT, RIGHT),
                                   LOCAL);

// delete duplicates
temp_0 := SORT (data_joined(gang NOT IN NotAName), booking_sid, gang, LOCAL);
data_dedup := DEDUP (temp_0, booking_sid, gang, LOCAL);

//output(data_joined);
RETURN data_dedup;
END;