EXPORT Constants := MODULE
   
   EXPORT sMode(unsigned1 mode) := trim(case(mode, 
                1 => 'full',
                2 => 'core',
                3 => 'derogatory',
				''));

   EXPORT sFile(unsigned1 record_type) := trim(case(record_type, 
                1 => 'consumers',
                2 => 'address',
                3 => 'akas',
				4 => 'relatives',
                5 => 'bankruptcy',
                6 => 'weapons',
				7 => 'criminals',
                8 => 'civil',
                9 => 'emails',
				10 => 'aircraft',
                11 => 'airmen',
                12 => 'hunting',
				13 => 'liens',
                14 => 'ucc',
                15 => 'paw',
				16 => 'phones',
                17 => 'pl',
                18 => 'so',
				19 => 'voters',
				20 => 'deeds',
				21 => 'tax',
				22 => 'students',
                23 => 'foreclosure',
				''));

END;