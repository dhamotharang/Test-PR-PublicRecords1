export StateColorToNCICColor(string pStateIn, string pColorIn)
 := map(pStateIn = 'FL' and pColorIn = 'AME'	=> 'AME',
		pStateIn = 'FL' and pColorIn = 'BGE'	=> 'BGE',
		pStateIn = 'FL' and pColorIn = 'BLK'	=> 'BLK',
		pStateIn = 'FL' and pColorIn = 'BLU'	=> 'BLU',
		pStateIn = 'FL' and pColorIn = 'BRO'	=> 'BRO',
		pStateIn = 'FL' and pColorIn = 'BRZ'	=> 'BRZ',
		pStateIn = 'FL' and pColorIn = 'CAM'	=> 'CAM',
		pStateIn = 'FL' and pColorIn = 'COM'	=> 'COM',
		pStateIn = 'FL' and pColorIn = 'CPR'	=> 'CPR',
		pStateIn = 'FL' and pColorIn = 'CRM'	=> 'CRM',
		pStateIn = 'FL' and pColorIn = 'DBL'	=> 'DBL',
		pStateIn = 'FL' and pColorIn = 'DGR'	=> 'DGR',
		pStateIn = 'FL' and pColorIn = 'GLD'	=> 'GLD',
		pStateIn = 'FL' and pColorIn = 'GRN'	=> 'GRN',
		pStateIn = 'FL' and pColorIn = 'GRY'	=> 'GRY',
		pStateIn = 'FL' and pColorIn = 'LAV'	=> 'LAV',
		pStateIn = 'FL' and pColorIn = 'LBL'	=> 'LBL',
		pStateIn = 'FL' and pColorIn = 'LGR'	=> 'LGR',
		pStateIn = 'FL' and pColorIn = 'MAR'	=> 'MAR',
		pStateIn = 'FL' and pColorIn = 'MUL'	=> 'MUL',
		pStateIn = 'FL' and pColorIn = 'MVE'	=> 'MVE',
		pStateIn = 'FL' and pColorIn = 'ONG'	=> 'ONG',
		pStateIn = 'FL' and pColorIn = 'PLE'	=> 'PLE',
		pStateIn = 'FL' and pColorIn = 'PNK'	=> 'PNK',
		pStateIn = 'FL' and pColorIn = 'RED'	=> 'RED',
		pStateIn = 'FL' and pColorIn = 'SIL'	=> 'SIL',
		pStateIn = 'FL' and pColorIn = 'TAN'	=> 'TAN',
		pStateIn = 'FL' and pColorIn = 'TEA'	=> 'TEA',
		pStateIn = 'FL' and pColorIn = 'TPE'	=> 'TPE',
		pStateIn = 'FL' and pColorIn = 'TRQ'	=> 'TRQ',
		pStateIn = 'FL' and pColorIn = 'UNK'	=> 'UNK',
		pStateIn = 'FL' and pColorIn = 'WHI'	=> 'WHI',
		pStateIn = 'FL' and pColorIn = 'YEL'	=> 'YEL',
		pStateIn = 'ID' and pColorIn = 'ALM'	=> 'SIL',
		pStateIn = 'ID' and pColorIn = 'AME'	=> 'AME',
		pStateIn = 'ID' and pColorIn = 'BGE'	=> 'BGE',
		pStateIn = 'ID' and pColorIn = 'BLK'	=> 'BLK',
		pStateIn = 'ID' and pColorIn = 'BLU'	=> 'BLU',
		pStateIn = 'ID' and pColorIn = 'BRN'	=> 'BRO',
		pStateIn = 'ID' and pColorIn = 'BRO'	=> 'BRO',
		pStateIn = 'ID' and pColorIn = 'BRZ'	=> 'BRZ',
		pStateIn = 'ID' and pColorIn = 'BUR'	=> 'MAR',
		pStateIn = 'ID' and pColorIn = 'CAM'	=> 'CAM',
		pStateIn = 'ID' and pColorIn = 'COL'	=> 'MUL',
		pStateIn = 'ID' and pColorIn = 'COM'	=> 'COM',
		pStateIn = 'ID' and pColorIn = 'CPR'	=> 'CPR',
		pStateIn = 'ID' and pColorIn = 'CRM'	=> 'CRM',
		pStateIn = 'ID' and pColorIn = 'DBL'	=> 'DBL',
		pStateIn = 'ID' and pColorIn = 'DGR'	=> 'DGR',
		pStateIn = 'ID' and pColorIn = 'GLD'	=> 'GLD',
		pStateIn = 'ID' and pColorIn = 'GRN'	=> 'GRN',
		pStateIn = 'ID' and pColorIn = 'GRY'	=> 'GRY',
		pStateIn = 'ID' and pColorIn = 'LAV'	=> 'LAV',
		pStateIn = 'ID' and pColorIn = 'LBL'	=> 'LBL',
		pStateIn = 'ID' and pColorIn = 'LGR'	=> 'LGR',
		pStateIn = 'ID' and pColorIn = 'MAR'	=> 'MAR',
		pStateIn = 'ID' and pColorIn = 'MUL'	=> 'MUL',
		pStateIn = 'ID' and pColorIn = 'MVE'	=> 'MVE',
		pStateIn = 'ID' and pColorIn = 'ONG'	=> 'ONG',
		pStateIn = 'ID' and pColorIn = 'ORG'	=> 'ONG',
		pStateIn = 'ID' and pColorIn = 'ORN'	=> 'ONG',
		pStateIn = 'ID' and pColorIn = 'PEW'	=> 'SIL',
		pStateIn = 'ID' and pColorIn = 'PLE'	=> 'PLE',
		pStateIn = 'ID' and pColorIn = 'PNK'	=> 'PNK',
		pStateIn = 'ID' and pColorIn = 'PTR'	=> 'SIL',
		pStateIn = 'ID' and pColorIn = 'PWT'	=> 'SIL',
		pStateIn = 'ID' and pColorIn = 'RED'	=> 'RED',
		pStateIn = 'ID' and pColorIn = 'SIL'	=> 'SIL',
		pStateIn = 'ID' and pColorIn = 'TAN'	=> 'TAN',
		pStateIn = 'ID' and pColorIn = 'TEA'	=> 'TEA',
		pStateIn = 'ID' and pColorIn = 'TPE'	=> 'TPE',
		pStateIn = 'ID' and pColorIn = 'TRQ'	=> 'TRQ',
		pStateIn = 'ID' and pColorIn = 'UNK'	=> 'UNK',
		pStateIn = 'ID' and pColorIn = 'WHI'	=> 'WHI',
		pStateIn = 'ID' and pColorIn = 'Y'		=> 'YEL',
		pStateIn = 'ID' and pColorIn = 'YEL'	=> 'YEL',
		pStateIn = 'ID' and pColorIn = 'YLW'	=> 'YEL',
		pStateIn = 'ME' and pColorIn = 'AL'		=> 'SIL',
		pStateIn = 'ME' and pColorIn = 'BE'		=> 'BGE',
		pStateIn = 'ME' and pColorIn = 'BG'		=> 'TEA',
		pStateIn = 'ME' and pColorIn = 'BK'		=> 'BLK',
		pStateIn = 'ME' and pColorIn = 'BL'		=> 'BLU',
		pStateIn = 'ME' and pColorIn = 'BR'		=> 'BRO',
		pStateIn = 'ME' and pColorIn = 'BU'		=> 'BLU',
		pStateIn = 'ME' and pColorIn = 'BW'		=> 'BRO',
		pStateIn = 'ME' and pColorIn = 'CH'		=> 'COM',
		pStateIn = 'ME' and pColorIn = 'CR'		=> 'CRM',
		pStateIn = 'ME' and pColorIn = 'GA'		=> 'GRY',
		pStateIn = 'ME' and pColorIn = 'GD'		=> 'GLD',
		pStateIn = 'ME' and pColorIn = 'GL'		=> 'GLD',
		pStateIn = 'ME' and pColorIn = 'GN'		=> 'GRN',
		pStateIn = 'ME' and pColorIn = 'GO'		=> 'GLD',
		pStateIn = 'ME' and pColorIn = 'GR'		=> 'GRN',
		pStateIn = 'ME' and pColorIn = 'GY'		=> 'GRY',
		pStateIn = 'ME' and pColorIn = 'LA'		=> 'LAV',
		pStateIn = 'ME' and pColorIn = 'LV'		=> 'LAV',
		pStateIn = 'ME' and pColorIn = 'MA'		=> 'MVE',
		pStateIn = 'ME' and pColorIn = 'O'		=> 'ONG',
		pStateIn = 'ME' and pColorIn = 'OG'		=> 'ONG',
		pStateIn = 'ME' and pColorIn = 'ON'		=> 'ONG',
		pStateIn = 'ME' and pColorIn = 'OR'		=> 'ONG',
		pStateIn = 'ME' and pColorIn = 'PE'		=> 'PLE',
		pStateIn = 'ME' and pColorIn = 'PI'		=> 'PNK',
		pStateIn = 'ME' and pColorIn = 'PK'		=> 'PNK',
		pStateIn = 'ME' and pColorIn = 'PL'		=> 'PLE',
		pStateIn = 'ME' and pColorIn = 'PP'		=> 'PLE',
		pStateIn = 'ME' and pColorIn = 'PR'		=> 'PLE',
		pStateIn = 'ME' and pColorIn = 'PT'		=> 'SIL',
		pStateIn = 'ME' and pColorIn = 'PU'		=> 'PLE',
		pStateIn = 'ME' and pColorIn = 'PW'		=> 'SIL',
		pStateIn = 'ME' and pColorIn = 'R'		=> 'RED',
		pStateIn = 'ME' and pColorIn = 'RD'		=> 'RED',
		pStateIn = 'ME' and pColorIn = 'RE'		=> 'RED',
		pStateIn = 'ME' and pColorIn = 'SI'		=> 'SIL',
		pStateIn = 'ME' and pColorIn = 'SL'		=> 'SIL',
		pStateIn = 'ME' and pColorIn = 'SV'		=> 'SIL',
		pStateIn = 'ME' and pColorIn = 'TA'		=> 'TPE',
		pStateIn = 'ME' and pColorIn = 'TE'		=> 'TEA',
		pStateIn = 'ME' and pColorIn = 'TL'		=> 'TEA',
		pStateIn = 'ME' and pColorIn = 'TN'		=> 'TAN',
		pStateIn = 'ME' and pColorIn = 'TP'		=> 'TPE',
		pStateIn = 'ME' and pColorIn = 'W'		=> 'WHI',
		pStateIn = 'ME' and pColorIn = 'WH'		=> 'WHI',
		pStateIn = 'ME' and pColorIn = 'WI'		=> 'WHI',
		pStateIn = 'ME' and pColorIn = 'WT'		=> 'WHI',
		pStateIn = 'ME' and pColorIn = 'Y'		=> 'YEL',
		pStateIn = 'ME' and pColorIn = 'YE'		=> 'YEL',
		pStateIn = 'ME' and pColorIn = 'YL'		=> 'YEL',
		pStateIn = 'ME' and pColorIn = 'YW'		=> 'YEL',
		pStateIn = 'MN' and pColorIn = 'A'		=> 'RED',
		pStateIn = 'MN' and pColorIn = 'B'		=> 'BLU',
		pStateIn = 'MN' and pColorIn = 'BGE'	=> 'BGE',
		pStateIn = 'MN' and pColorIn = 'C'		=> 'GRY',
		pStateIn = 'MN' and pColorIn = 'D'		=> 'BLK',
		pStateIn = 'MN' and pColorIn = 'E'		=> 'BRO',
		pStateIn = 'MN' and pColorIn = 'F'		=> 'WHI',
		pStateIn = 'MN' and pColorIn = 'G'		=> 'GRN',
		pStateIn = 'MN' and pColorIn = 'H'		=> 'TAN',
		pStateIn = 'MN' and pColorIn = 'I'		=> 'CRM',
		pStateIn = 'MN' and pColorIn = 'J'		=> 'PNK',
		pStateIn = 'MN' and pColorIn = 'K'		=> 'YEL',
		pStateIn = 'MN' and pColorIn = 'L'		=> 'MAR',
		pStateIn = 'MN' and pColorIn = 'M'		=> 'LAV',
		pStateIn = 'MN' and pColorIn = 'N'		=> 'GLD',
		pStateIn = 'MN' and pColorIn = 'O'		=> 'ONG',
		pStateIn = 'MN' and pColorIn = 'P'		=> 'SIL',
		pStateIn = 'MO' and pColorIn = 'BGE'	=> 'BGE',
		pStateIn = 'MO' and pColorIn = 'BLK'	=> 'BLK',
		pStateIn = 'MO' and pColorIn = 'BLU'	=> 'BLU',
		pStateIn = 'MO' and pColorIn = 'BRO'	=> 'BRO',
		pStateIn = 'MO' and pColorIn = 'BRZ'	=> 'BRZ',
		pStateIn = 'MO' and pColorIn = 'COM'	=> 'COM',
		pStateIn = 'MO' and pColorIn = 'CPR'	=> 'CPR',
		pStateIn = 'MO' and pColorIn = 'CRM'	=> 'CRM',
		pStateIn = 'MO' and pColorIn = 'DBL'	=> 'DBL',
		pStateIn = 'MO' and pColorIn = 'DGR'	=> 'DGR',
		pStateIn = 'MO' and pColorIn = 'GLD'	=> 'GLD',
		pStateIn = 'MO' and pColorIn = 'GRN'	=> 'GRN',
		pStateIn = 'MO' and pColorIn = 'GRY'	=> 'GRY',
		pStateIn = 'MO' and pColorIn = 'LAV'	=> 'LAV',
		pStateIn = 'MO' and pColorIn = 'LBL'	=> 'LBL',
		pStateIn = 'MO' and pColorIn = 'LGR'	=> 'LGR',
		pStateIn = 'MO' and pColorIn = 'MAR'	=> 'MAR',
		pStateIn = 'MO' and pColorIn = 'ORG'	=> 'ONG',
		pStateIn = 'MO' and pColorIn = 'PLE'	=> 'PLE',
		pStateIn = 'MO' and pColorIn = 'PNK'	=> 'PNK',
		pStateIn = 'MO' and pColorIn = 'RED'	=> 'RED',
		pStateIn = 'MO' and pColorIn = 'SIL'	=> 'SIL',
		pStateIn = 'MO' and pColorIn = 'TAN'	=> 'TAN',
		pStateIn = 'MO' and pColorIn = 'TRQ'	=> 'TRQ',
		pStateIn = 'MO' and pColorIn = 'UNK'	=> 'UNK',
		pStateIn = 'MO' and pColorIn = 'WHI'	=> 'WHI',
		pStateIn = 'MO' and pColorIn = 'YEL'	=> 'YEL',
		pStateIn = 'MS' and pColorIn = '1'		=> 'BLK',
		pStateIn = 'MS' and pColorIn = '2'		=> 'BLU',
		pStateIn = 'MS' and pColorIn = '3'		=> 'BRO',
		pStateIn = 'MS' and pColorIn = '4'		=> 'GLD',
		pStateIn = 'MS' and pColorIn = '5'		=> 'GRY',
		pStateIn = 'MS' and pColorIn = '6'		=> 'GRN',
		pStateIn = 'MS' and pColorIn = '7'		=> 'PNK',
		pStateIn = 'MS' and pColorIn = '8'		=> 'PLE',
		pStateIn = 'MS' and pColorIn = '*'		=> 'SIL',
		pStateIn = 'MS' and pColorIn = 'A'		=> 'BGE',
		pStateIn = 'MS' and pColorIn = 'B'		=> 'DBL',
		pStateIn = 'MS' and pColorIn = 'C'		=> 'LBL',
		pStateIn = 'MS' and pColorIn = 'D'		=> 'BRZ',
		pStateIn = 'MS' and pColorIn = 'E'		=> 'COM',
		pStateIn = 'MS' and pColorIn = 'F'		=> 'CPR',
		pStateIn = 'MS' and pColorIn = 'G'		=> 'CRM',
		pStateIn = 'MS' and pColorIn = 'H'		=> 'DGR',
		pStateIn = 'MS' and pColorIn = 'I'		=> 'LGR',
		pStateIn = 'MS' and pColorIn = 'J'		=> 'TRQ',
		pStateIn = 'MS' and pColorIn = 'L'		=> 'LAV',
		pStateIn = 'MS' and pColorIn = 'M'		=> 'MAR',
		pStateIn = 'MS' and pColorIn = 'O'		=> 'ONG',
		pStateIn = 'MS' and pColorIn = 'P'		=> 'PLE',
		pStateIn = 'MS' and pColorIn = 'R'		=> 'RED',
		pStateIn = 'MS' and pColorIn = 'S'		=> 'SIL',
		pStateIn = 'MS' and pColorIn = 'W'		=> 'WHI',
		pStateIn = 'MS' and pColorIn = 'Y'		=> 'YEL',
		pStateIn = 'NE' and pColorIn = 'ALM'	=> 'SIL',
		pStateIn = 'NE' and pColorIn = 'ALU'	=> 'SIL',
		pStateIn = 'NE' and pColorIn = 'BEG'	=> 'BGE',
		pStateIn = 'NE' and pColorIn = 'BEI'	=> 'BGE',
		pStateIn = 'NE' and pColorIn = 'BGE'	=> 'BGE',
		pStateIn = 'NE' and pColorIn = 'BIE'	=> 'BGE',
		pStateIn = 'NE' and pColorIn = 'BL'		=> 'BLK',
		pStateIn = 'NE' and pColorIn = 'BLA'	=> 'BLK',
		pStateIn = 'NE' and pColorIn = 'BLE'	=> 'BLU',
		pStateIn = 'NE' and pColorIn = 'BLK'	=> 'BLK',
		pStateIn = 'NE' and pColorIn = 'BLU'	=> 'BLU',
		pStateIn = 'NE' and pColorIn = 'BRG'	=> 'MAR',
		pStateIn = 'NE' and pColorIn = 'BRN'	=> 'BRO',
		pStateIn = 'NE' and pColorIn = 'BRO'	=> 'BRO',
		pStateIn = 'NE' and pColorIn = 'BRW'	=> 'BRO',
		pStateIn = 'NE' and pColorIn = 'BRZ'	=> 'BRZ',
		pStateIn = 'NE' and pColorIn = 'BUR'	=> 'MAR',
		pStateIn = 'NE' and pColorIn = 'COP'	=> 'CPR',
		pStateIn = 'NE' and pColorIn = 'CPR'	=> 'CPR',
		pStateIn = 'NE' and pColorIn = 'CRE'	=> 'CRM',
		pStateIn = 'NE' and pColorIn = 'CRM'	=> 'CRM',
		pStateIn = 'NE' and pColorIn = 'DBD'	=> 'DBL',
		pStateIn = 'NE' and pColorIn = 'DBL'	=> 'DBL',
		pStateIn = 'NE' and pColorIn = 'DGK'	=> 'DGR',
		pStateIn = 'NE' and pColorIn = 'DGR'	=> 'DGR',
		pStateIn = 'NE' and pColorIn = 'DRG'	=> 'DGR',
		pStateIn = 'NE' and pColorIn = 'DWH'	=> 'WHI',
		pStateIn = 'NE' and pColorIn = 'GLD'	=> 'GLD',
		pStateIn = 'NE' and pColorIn = 'GR'		=> 'GRN',
		pStateIn = 'NE' and pColorIn = 'GRA'	=> 'GRY',
		pStateIn = 'NE' and pColorIn = 'GRE'	=> 'GRN',
		pStateIn = 'NE' and pColorIn = 'GRM'	=> 'GRN',
		pStateIn = 'NE' and pColorIn = 'GRN'	=> 'GRN',
		pStateIn = 'NE' and pColorIn = 'GRY'	=> 'GRY',
		pStateIn = 'NE' and pColorIn = 'IVY'	=> 'CRM',
		pStateIn = 'NE' and pColorIn = 'IYE'	=> 'YEL',
		pStateIn = 'NE' and pColorIn = 'KGR'	=> 'GRN',
		pStateIn = 'NE' and pColorIn = 'LAV'	=> 'LAV',
		pStateIn = 'NE' and pColorIn = 'LBL'	=> 'LBL',
		pStateIn = 'NE' and pColorIn = 'LBR'	=> 'BRO',
		pStateIn = 'NE' and pColorIn = 'LGR'	=> 'LGR',
		pStateIn = 'NE' and pColorIn = 'MAR'	=> 'MAR',
		pStateIn = 'NE' and pColorIn = 'MAV'	=> 'MVE',
		pStateIn = 'NE' and pColorIn = 'MBR'	=> 'BRO',
		pStateIn = 'NE' and pColorIn = 'NAV'	=> 'BLU',
		pStateIn = 'NE' and pColorIn = 'NBL'	=> 'BLU',
		pStateIn = 'NE' and pColorIn = 'NVY'	=> 'BLU',
		pStateIn = 'NE' and pColorIn = 'NWH'	=> 'WHI',
		pStateIn = 'NE' and pColorIn = 'ONG'	=> 'ONG',
		pStateIn = 'NE' and pColorIn = 'ORG'	=> 'ONG',
		pStateIn = 'NE' and pColorIn = 'OWH'	=> 'CRM',
		pStateIn = 'NE' and pColorIn = 'PK'		=> 'PNK',
		pStateIn = 'NE' and pColorIn = 'PLE'	=> 'PLE',
		pStateIn = 'NE' and pColorIn = 'PLU'	=> 'PLE',
		pStateIn = 'NE' and pColorIn = 'PNK'	=> 'PNK',
		pStateIn = 'NE' and pColorIn = 'PUR'	=> 'PLE',
		pStateIn = 'NE' and pColorIn = 'RED'	=> 'RED',
		pStateIn = 'NE' and pColorIn = 'RGR'	=> 'GRN',
		pStateIn = 'NE' and pColorIn = 'ROS'	=> 'RED',
		pStateIn = 'NE' and pColorIn = 'RWH'	=> 'WHI',
		pStateIn = 'NE' and pColorIn = 'SAN'	=> 'TAN',
		pStateIn = 'NE' and pColorIn = 'SI'		=> 'SIL',
		pStateIn = 'NE' and pColorIn = 'SIL'	=> 'SIL',
		pStateIn = 'NE' and pColorIn = 'SIV'	=> 'SIL',
		pStateIn = 'NE' and pColorIn = 'SLV'	=> 'SIL',
		pStateIn = 'NE' and pColorIn = 'SND'	=> 'TAN',
		pStateIn = 'NE' and pColorIn = 'TAN'	=> 'TAN',
		pStateIn = 'NE' and pColorIn = 'TAU'	=> 'TPE',
		pStateIn = 'NE' and pColorIn = 'TEA'	=> 'TEA',
		pStateIn = 'NE' and pColorIn = 'TLE'	=> 'TEA',
		pStateIn = 'NE' and pColorIn = 'TPE'	=> 'TPE',
		pStateIn = 'NE' and pColorIn = 'TQR'	=> 'TRQ',
		pStateIn = 'NE' and pColorIn = 'TRQ'	=> 'TRQ',
		pStateIn = 'NE' and pColorIn = 'TUR'	=> 'TRQ',
		pStateIn = 'NE' and pColorIn = 'UK'		=> 'UNK',
		pStateIn = 'NE' and pColorIn = 'UNK'	=> 'UNK',
		pStateIn = 'NE' and pColorIn = 'UWH'	=> 'WHI',
		pStateIn = 'NE' and pColorIn = 'WHI'	=> 'WHI',
		pStateIn = 'NE' and pColorIn = 'WHT'	=> 'WHI',
		pStateIn = 'NE' and pColorIn = 'YEL'	=> 'YEL',
		pStateIn = 'NE' and pColorIn = 'YLW'	=> 'YEL',
		pStateIn = 'UT' and pColorIn = 'ALU'	=> 'SIL',
		pStateIn = 'UT' and pColorIn = 'AME'	=> 'AME',
		pStateIn = 'UT' and pColorIn = 'BEI'	=> 'BGE',
		pStateIn = 'UT' and pColorIn = 'BLK'	=> 'BLK',
		pStateIn = 'UT' and pColorIn = 'BLU'	=> 'BLU',
		pStateIn = 'UT' and pColorIn = 'BRO'	=> 'BRO',
		pStateIn = 'UT' and pColorIn = 'BRZ'	=> 'BRZ',
		pStateIn = 'UT' and pColorIn = 'BUR'	=> 'MAR',
		pStateIn = 'UT' and pColorIn = 'CAM'	=> 'CAM',
		pStateIn = 'UT' and pColorIn = 'CHR'	=> 'COM',
		pStateIn = 'UT' and pColorIn = 'COP'	=> 'CPR',
		pStateIn = 'UT' and pColorIn = 'CRM'	=> 'CRM',
		pStateIn = 'UT' and pColorIn = 'DBL'	=> 'DBL',
		pStateIn = 'UT' and pColorIn = 'DGR'	=> 'DGR',
		pStateIn = 'UT' and pColorIn = 'GOL'	=> 'GLD',
		pStateIn = 'UT' and pColorIn = 'GRA'	=> 'GRY',
		pStateIn = 'UT' and pColorIn = 'GRN'	=> 'GRN',
		pStateIn = 'UT' and pColorIn = 'LAV'	=> 'LAV',
		pStateIn = 'UT' and pColorIn = 'LBL'	=> 'LBL',
		pStateIn = 'UT' and pColorIn = 'LGR'	=> 'LGR',
		pStateIn = 'UT' and pColorIn = 'MAU'	=> 'MVE',
		pStateIn = 'UT' and pColorIn = 'MUL'	=> 'MUL',
		pStateIn = 'UT' and pColorIn = 'ORA'	=> 'ONG',
		pStateIn = 'UT' and pColorIn = 'PNK'	=> 'PNK',
		pStateIn = 'UT' and pColorIn = 'PUR'	=> 'PLE',
		pStateIn = 'UT' and pColorIn = 'RED'	=> 'RED',
		pStateIn = 'UT' and pColorIn = 'TAN'	=> 'TAN',
		pStateIn = 'UT' and pColorIn = 'TAU'	=> 'TPE',
		pStateIn = 'UT' and pColorIn = 'TEA'	=> 'TEA',
		pStateIn = 'UT' and pColorIn = 'TUR'	=> 'TRQ',
		pStateIn = 'UT' and pColorIn = 'WHI'	=> 'WHI',
		pStateIn = 'UT' and pColorIn = 'YEL'	=> 'YEL',
        'UNK'
	   );