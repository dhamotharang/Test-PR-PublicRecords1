EXPORT MapClassCodeNum(unsigned t, string v) := FUNCTION

	integer inv := (integer) v;
	string upperv := TRIM(stringlib.stringtouppercase(v),LEFT,RIGHT);
	
	// event codes = 1 .. 27
	stdeve := IF(inv>0 AND inv<=27, inv, 0);
	// cfs codes = 1001..1034
	stdcfs := IF(inv>=1001 AND inv<=1034, inv, 0);
	// crash codes: Fatality, Injury, Non-Injury
	stdcra :=	MAP(
		upperv[1..3] = 'NON' => 1600,
		upperv[1..3] = 'INJ' => 1601,
		upperv[1..3] = 'FAT' => 1602,
		0);
	
	// LPR codes: 600 (fabricated)
	stdlpr :=	600;
	
	// Intel: CONFIDENTIAL GANGS NARCOTICS SUSPICIOUS TERRORISM THREATS  
	stdint := MAP(
		upperv[1..4] = 'CONF' => 2000,
		upperv[1..4] = 'GANG' => 2001,
		upperv[1..4] = 'NARC' => 2003,
		upperv[1..4] = 'SUSP' => 2004,
		upperv[1..4] = 'TERR' => 2005,
		upperv[1..4] = 'THRE' => 2006,
		0);

	// Shotspotter: 01, 02, 19: single, multiple, possible						
	stdshot :=	MAP(
		inv = 1 => 30000,
		inv = 2 => 30001,
		inv = 19 => 30002,
		0);
	
	// Offender: GANG	OFF PROB PROLIF SEX WARR
	stdoff :=	MAP(
		upperv[1..3] = 'SEX'	=> 4000,
		upperv[1..4] = 'GANG' => 4001,
		upperv[1..3] = 'OFF'	=> 4002,
		upperv[1..4] = 'PROL'	=> 4003,
		upperv[1..4] = 'WARR'	=> 4004,
		upperv[1..4] = 'PROB'	=> 4005,
		0
		);
	
	RETURN MAP(
		t = 1 => stdeve,
		t = 2 => stdcfs,
		t = 3 => stdcra,
		t = 4 => stdlpr,
		t = 5 => stdint,
		t = 6 => stdshot,
		t = 7 => stdoff,
		0	
		);
END;
