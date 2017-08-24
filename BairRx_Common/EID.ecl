EXPORT EID := MODULE
	EXPORT Type := ENUM(UNSIGNED1, EVE=1, CFS=2, CRA=3, LPR=4, INT=5, SHO=6, OFF=7);	
	
	// EID may carry stamp information, e.g. EVE:1:39201002993.
  EXPORT Clean(STRING eid) := IF(eid[4] = ':',  eid[1..3]+IF(eid[6]=':', eid[7..], eid[8..]), eid);					
	EXPORT Stamp(STRING eid, unsigned stamp) := IF(stamp=0, eid, eid[1..3]+':'+stamp+':'+eid[4..]);
	EXPORT GetStamp(STRING eid) := IF(eid[4] <> ':', 0, IF(eid[6]=':', (unsigned) eid[5], (unsigned) eid[5..6]));
	
	EXPORT IsEvent(STRING eid) := eid[1..3] = 'EVE';
	EXPORT IsCFS(STRING eid) := eid[1..3] = 'CFS';
	EXPORT IsCrash(STRING eid) := eid[1..3] = 'CRA';
	EXPORT IsLPR(STRING eid) := eid[1..3] = 'LPR';
	EXPORT IsIntel(STRING eid) := eid[1..3] = 'INT';
	EXPORT IsShotSpotter(STRING eid) := eid[1..3] = 'SHO';
	EXPORT IsOffender(STRING eid) := eid[1..3] = 'OFF';
	
	EXPORT TypeFromString(STRING3 t) := MAP(
		t = 'EVE' => Type.EVE,
		t = 'CFS' => Type.CFS,
		t = 'CRA' => Type.CRA,
		t = 'LPR' => Type.LPR,
		t = 'INT' => Type.INT,
		t = 'SHO' => Type.SHO,
		t = 'OFF' => Type.OFF,
		0
		);
		
	EXPORT TypeToString(unsigned1 t) := MAP(
		t = Type.EVE 	=> 'EVE',
		t = Type.CFS	=> 'CFS',
		t = Type.CRA	=> 'CRA',
		t = Type.LPR	=> 'LPR',
		t = Type.INT	=> 'INT',
		t = Type.SHO	=> 'SHO',
		t = Type.OFF	=> 'OFF',
		''
		);	
	
	/*
		MODE as defined in dbo.mode
			Mode [id=1, display=Events]=Events
			Mode [id=2, display=CAD/CFS]=CAD/CFS
			Mode [id=10, display=LPR]=LPR
			Mode [id=16, display=Crashes]=Crashes
			Mode [id=20, display=Intel]=Intel
			Mode [id=31, display=ShotSpotter]=ShotSpotter
			Mode [id=40, display=Offenders]=Offenders
	*/
	EXPORT TypeFromMode(unsigned mode) := MAP(
		mode = 1 => Type.EVE,
		mode = 2 => Type.CFS,
		mode = 10 => Type.LPR,
		mode = 16 => Type.CRA,
		mode = 20 => Type.INT,
		mode = 31 => Type.SHO,
		mode = 40 => Type.OFF,
		0
		);
		
	EXPORT TypeToMode(unsigned etype) := MAP (
			etype = Type.EVE => 1,
			etype = Type.CFS => 2,
			etype = Type.LPR => 10,
			etype = Type.CRA => 16,
			etype = Type.INT => 20,
			etype = Type.SHO => 31,
			etype = Type.OFF => 40,
			0
		);
		
		EXPORT TypeStrFromMode(unsigned mode) := MAP(
			mode = 1 => 'EVE',
			mode = 2 => 'CFS',
			mode = 10 => 'LPR',
			mode = 16 => 'CRA',
			mode = 20 => 'INT',
			mode = 31 => 'SHO',
			mode = 40 => 'OFF',
			''	
		);
END;