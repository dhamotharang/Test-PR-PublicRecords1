export leSic2Desc(STRING2 sic) := 
CASE(sic, '10' => 'METAL MINING',
		'12'	=> 'COAL MINING',
		'13' => 'OIL AND GAS EXTRACTION OR NONMETALLIC MINERALS, EXCEPT FUELS',
		'27' => 'PRINTING AND PUBLISHING',
		'28'	=> 'CHEMICALS AND ALLIED PRODUCTS',
		'29'	=> 'PETROLEUM AND COAL PRODUCTS',
		'30'	=> 'RUBBER AND MISCELLANEOUS PLASTICS PRODUCTS',
		'33'	=> 'PRIMARY METAL INDUSTRIES',
		'34'	=> 'FABRICATED METAL PRODUCTS',
		'35'	=> 'INDUSTRIAL MACHINERY AND DQUIPMENT',
		'42'	=> 'MOTOR FREIGHT TRANSPORTATION AND WAREHOUSING',
		'46'	=> 'PIPLINES, EXCEPT NATURAL GAS',
		'48'	=> 'COMMUNICATIONS',
		'49'	=> 'ELECTRIC, GAS, AND SANITARY SERVICES',
		'60'	=> 'DEPOSITORY INSTITUTIONS',
		'61'	=> 'NONDEPOSITORY CREDIT INSTITUTIONS',
		'91'	=> 'EXECUTIVE LEGISLATIVE, AND GENERAL',
		'92'	=> 'JUSTIC, PUBLIC ORDER, AND SAFETY',
		'93'	=> 'FINANCE, TAXATION, AND MONETARY POLICY',
		'96'	=> 'ADMINISTRATION OF ECONOMIC PROGRAMS',
		'97'	=> 'NATIONAL SECURITY AND INTERNATIONAL AFFAIRS','');