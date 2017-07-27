PATTERN salutation1 := ['Miss', 'MISS', 
						'Sir', 'SIR',
						'Lady'];

PATTERN salutation2 := ['Mr', 'MR', 
						'Ms', 'MS', 
						'Dr', 'DR', 
						'Mrs', 'MRS',
						'Sgt', 'SGT',
						'Maj', 'MAJ',
						'Capt', 'CAPT',
						'Hon', 'HON',
						'Col', 'COL',
						'Rev', 'REV',
						'Jdg', 'JDG',
						'Sen', 'SEN',
						'Prof', 'PROF'];

export PATTERN salutations := salutation1 | salutation2 opt('.');