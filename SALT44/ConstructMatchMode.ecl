// bit-encodes BagOfWords matching mode; Used to build the mode value with MatchBagOfWords()
EXPORT UNSIGNED ConstructMatchMode(UNSIGNED1 edit_distance=0, UNSIGNED1 edit_max_distance=0, BOOLEAN phonetic=false,
		                 BOOLEAN initial=false, BOOLEAN abbr=false,UNSIGNED1 abbr_type=0, UNSIGNED1 abbr_spc_threshold=31,
										 BOOLEAN abbr_acronym=false, UNSIGNED1 hyphen=0, UNSIGNED1 hyphen_min_distance=1, UNSIGNED1 stem_min_length=0
		                 ) := FUNCTION
          m1 := IF(initial,1,0);
          m2 := IF(abbr,1<<1,0);
          m3 := (hyphen & 3) <<2;
          m4 := (edit_distance & 3) <<4;
          m5 := IF(phonetic,1<<6,0);
          m6 := (abbr_type & 3) << 8;
          m7 := IF((abbr_spc_threshold>0x1F),0x1F,(abbr_spc_threshold & 0x1F)) << 10;
          m8 := IF(abbr_acronym,1 << 15,0);
          m9 := IF((stem_min_length>0xF),0xF,(stem_min_length & 0xF)) <<16;
          m10 := IF((edit_max_distance>0xF),0xF,(edit_max_distance & 0xF)) <<20;
          m11 := IF((hyphen_min_distance>0xF),0xF,(hyphen_min_distance & 0xF)) <<24;
          RETURN m1+m2+m3+m4+m5+m6+m7+m8+m9+m10+m11;
END;
