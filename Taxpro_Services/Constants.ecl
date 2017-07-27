EXPORT Constants := MODULE

  export unsigned1 TAXPRO_PER_BDID := 100; //~25
  export unsigned1 TAXPRO_PER_DID := 100; //~10

  // boolean search
	export STRING stem		:= '~thor_data400::base';
	export STRING srcType := 'taxpro';
	export STRING qual		:= 'test';
END;
