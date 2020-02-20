import data_services, vault, _control;

kf := Pii_for_FCRA ((unsigned)did<>0);

// rollup to a single record for an individual, picking the newest record
r := recordof(kf);
r roll( r le, r ri ) := TRANSFORM
	self := if( (unsigned)le.date_created > (unsigned)ri.date_created, le, ri );
END;

kf_rolled := rollup( group(sort(kf,did),did), true, roll(left,right) );

#IF(_Control.Environment.onVault) 
export Key_FCRA_Override_pii_did := vault.FCRA.Key_FCRA_Override_pii_did;
#ELSE
export Key_FCRA_Override_pii_did := index(kf_rolled,
			                                    {unsigned6 s_did := (unsigned)did}, 
			                                    {kf_rolled}, 
			                                    data_services.data_location.prefix() + 'thor_data400::key::fcra::override::pii::qa::did');
#END;
