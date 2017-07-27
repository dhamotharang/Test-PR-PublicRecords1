import fcra, ut;

kf := Pii_for_FCRA ((unsigned)did<>0);

export Key_Override_pii_did := 
index(kf,
			{unsigned6 s_did := (unsigned)did}, {kf}, '~thor_data400::key::override::pii::qa::did');