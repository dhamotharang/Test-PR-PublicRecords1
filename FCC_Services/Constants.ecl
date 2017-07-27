EXPORT Constants := MODULE

  // actual limit is higher than that, but this will cut off just ~0.2%
  // max is ~2 million, and decreases within first thousand to less than 1000.
  export unsigned2 FCC_PER_BDID := 1000;

  // max is ~900,000 but falls to ~500 within first hundred
  export unsigned2 FCC_PER_DID := 1000;

  export unsigned2 FCC_PER_SEQ := 1; // not used, just on case

  // boolean search
	export STRING stem		:= '~thor_data400::base';
	export STRING srcType := 'fcc';
	export STRING qual		:= 'test';

END;