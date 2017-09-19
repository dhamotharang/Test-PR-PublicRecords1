EXPORT MapClassCode(unsigned t, string v) := FUNCTION

	integer inv := (integer) v;
	string upperv := stringlib.stringtouppercase(v);
	
	// event codes = 1 .. 27
	stdeve := IF(inv>0, 'EVE'+(string)inv, '');
	// cfs codes = 12, 13, 16, 18, 25, 1001..1034
	stdcfs := if(inv>0,'CFS'+(string)inv, '');
	// crash codes: Fatality, Injury, Non-Injury
	stdcra :=	MAP(
		upperv[1..3] = 'FAT' => 'CRAFAT',
		upperv[1..3] = 'INJ' => 'CRAINJ',
		upperv[1..3] = 'NON' => 'CRANON',
		'');
	
	// LPR codes: 9999 (fabricated)
	stdlpr :=	IF(inv=9999, 'LPR', '');
	
	// Intel: CONFIDENTIAL GANGS NARCOTICS SUSPICIOUS TERRORISM THREATS  
	stdint := MAP(
		upperv[1..4] = 'CONF' => 'INTCONF',
		upperv[1..4] = 'GANG' => 'INTGANG',
		upperv[1..4] = 'NARC' => 'INTNARC',
		upperv[1..4] = 'SUSP' => 'INTSUSP',
		upperv[1..4] = 'TERR' => 'INTTERR',
		upperv[1..4] = 'THRE' => 'INTTHRE',
		'');

	// Shotspotter: 01, 02, 19: single, multiple, possible						
	stdshot :=	IF(inv=1, 'SHOSING', IF(inv=2, 'SHOMULT', IF (inv=19, 'SHOPOSS', '')));
	
	// Offender: GANG	OFF PROB PROLIF SEX WARR
	stdoff :=	MAP(
		upperv[1..4] = 'GANG' => 'OFFGANG',
		upperv[1..3] = 'OFF'	=> 'OFFOFF',
		upperv[1..4] = 'PROB'	=> 'OFFPROB',
		upperv[1..4] = 'PROL'	=> 'OFFPROL',
		upperv[1..3] = 'SEX'	=> 'OFFSEX',
		upperv[1..4] = 'WARR'	=> 'OFFWARR',
		''
		);
	
	RETURN MAP(
		t = 1 => stdeve,
		t = 2 => stdcfs,
		t = 3 => stdcra,
		t = 4 => stdlpr,
		t = 5 => stdint,
		t = 6 => stdshot,
		t = 7 => stdoff,
		''	
		);
END;
