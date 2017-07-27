// bit-encodes BagOfWords matching mode; Used to build the mode value with MatchBagOfWords()
EXPORT UNSIGNED ConstructMatchMode(UNSIGNED1 edit_distance=0, UNSIGNED1 edit_max_distance=0, BOOLEAN phonetic=false,
		                 BOOLEAN initial=false, BOOLEAN abbr=false,UNSIGNED1 abbr_type=0, UNSIGNED1 hyphen=0, UNSIGNED1 hyphen_min_distance=1
		                 ) := BEGINC++
#body
#option pure
	unsigned mode = 0;
	mode += initial ? 1:0;
	mode += abbr ? 1<<1:0;
	mode += (abbr_type & 3) <<8;
	mode += (hyphen & 3) <<2;
	mode += (edit_distance & 3) <<4;
	mode += phonetic ? 1<<6:0;
	mode += (edit_max_distance & 0xFF) <<15;
	mode += (hyphen_min_distance & 0xFF) <<23;
	return mode;
ENDC++;