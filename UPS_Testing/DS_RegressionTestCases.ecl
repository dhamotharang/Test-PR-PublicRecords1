IMPORT UPS_Services;
TestCaseLayout := UPS_Testing.layout_TestCase;
Constant := UPS_Services.Constants;

export DS_RegressionTestCases := DATASET( [ 
	// phone searches
	/*  1 */ { '', '', '', '', '', '', '', '', '5616272000', Constant.TAG_ENTITY_UNK },
	/*  2 */ { '', '', '', '', '', '', '', '', '5616271800', Constant.TAG_ENTITY_UNK },
	/*  3 */ { '', '', '', '', '', '', '', '', '5617471802', Constant.TAG_ENTITY_UNK },

	// current resident searches
	/*  4 */ { '', '', '', '', '261 GOLFVIEW DR', 'TEQUESTA', 'FL', '33489', '', Constant.TAG_ENTITY_UNK },
	/*  5 */ { '', '', '', '', '1101 SE KITCHING COVE LN', 'PORT ST LUCIE', 'FL', '34952', '', Constant.TAG_ENTITY_UNK },
	/*  6 */ { '', '', '', '', '4661 MORGAN RUN ROAD', 'WEST DECATUR', 'PA', '16878', '', Constant.TAG_ENTITY_UNK },

	// business searches
	/*  7 */ { '', '', '', 'ST JOAN OF ARC CATHOLIC CHURCH', '', 'BOCA RATON', 'FL', '', '', Constant.TAG_ENTITY_UNK },

	// a current address and a historical address
	/*  8 */ { 'JEFF', '', 'WOODS', '', '945 DAVID TRACE', 'SUWANEE', 'GA', '30024', '', Constant.TAG_ENTITY_IND },
	/*  9 */ { 'JEFF', '', 'WOODS', '', '905 NW 10TH ST', 'BOYNTON BEACH', 'FL', '33426', '', Constant.TAG_ENTITY_IND },

	// city/state and zip searches
	/* 10 */ { 'JEFF', '', 'WOODS', '', '945 DAVID TRACE', '', '', '30024', '', Constant.TAG_ENTITY_IND },
	/* 11 */ { 'JEFF', '', 'WOODS', '', '905 NW 10TH ST', 'BOYNTON BEACH', 'FL', '', '', Constant.TAG_ENTITY_IND },

	// transposed address searches
	/* 12 */ { 'JEFF', '', 'WOODS', '', '905 DAVID TRACE', 'SUWANEE', 'GA', '30024', '', Constant.TAG_ENTITY_IND },
	/* 13 */ { 'JEFF', '', 'WOODS', '', '945 NW 10TH ST', 'BOYNTON BEACH', 'FL', '33426', '', Constant.TAG_ENTITY_IND },

	// last name + city/state
	/* 14 */ { '', '', 'WOODS', '', '945 DAVID TRACE', 'SUWANEE', 'GA', '30024', '', Constant.TAG_ENTITY_IND },

	// last name + zip
	/* 15 */ { '', '', 'WOODS', '', '945 NW 10TH ST', '', '', '33426', '', Constant.TAG_ENTITY_IND },

	// search with missing term
	/* 16 */ { 'JEFF', '', 'WOODS', '', '150 MULBERRY GROVE RD', 'ROYAL PALM BEACH', 'FL', '33411', '', Constant.TAG_ENTITY_IND },
	/* 17 */ { 'JEFF', '', 'WOODS', '', '150 MULBERRY GROVE RD', 'ROYAL PALM', 'FL', '33411', '', Constant.TAG_ENTITY_IND },
	/* 18 */ { 'JEFF', '', 'WOODS', '', '150 MULBERRY RD', 'ROYAL PALM BEACH', 'FL', '33411', '', Constant.TAG_ENTITY_IND },

	// addresses with numeric street names
	/* 19 */ { '', '', '', '', '209 3RD AVE N', 'LAKE WORTH', 'FL', '33460', '', Constant.TAG_ENTITY_UNK },
	/* 20 */ { '', '', '', '', '2146 E 23RD ST', 'OAKLAND', 'CA', '', '', Constant.TAG_ENTITY_UNK },
	/* 21 */ { '', '', '', '', '1636 7TH ST', 'OAKLAND', 'CA', '', '', Constant.TAG_ENTITY_UNK }
											], TestCaseLayout );
