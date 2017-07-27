export Layouts_DL_uber  := MODULE

EXPORT Layout_Base := RECORD
  unsigned6 fakeid;
  Layout_DL;
  string1 record_type;
  unsigned1 zero;
  string1 blank;
	qstring20 pfname;
  qstring20 dph_lname;
 END;
 
export Layout_Plus := record
  unsigned4 word_id := 0;
	unsigned4 cnt := 0;
	unsigned2 field;
	unsigned6 uid;
  string30  word;
  unsigned2 word_weight100 := 0;
end;

END; 