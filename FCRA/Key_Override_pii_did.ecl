import fcra, ut;

kf := Pii_for_FCRA ((unsigned)did<>0);

// rollup to a single record for an individual, picking the newest record
r := recordof(kf);
r roll( r le, r ri ) := TRANSFORM
	self := if( (unsigned)le.date_created > (unsigned)ri.date_created, le, ri );
END;

kf_rolled := rollup( group(sort(kf,did),did), true, roll(left,right) );


export Key_Override_pii_did := 
index(kf_rolled,
			{unsigned6 s_did := (unsigned)did}, {kf_rolled}, '~thor_data400::key::override::pii::qa::did');