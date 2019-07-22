import data_services;

kf := Pii_for_FCRA (ssn<>'');

// rollup to a single record for an individual, picking the newest record
r := recordof(kf);
r roll( r le, r ri ) := TRANSFORM
	self := if( (unsigned)le.date_created > (unsigned)ri.date_created, le, ri );
END;

kf_rolled := rollup( group(sort(kf,ssn),ssn), true, roll(left,right) );


export Key_FCRA_Override_pii_ssn := index (kf_rolled, 
                                           {ssn}, 
                                           {kf_rolled	}, 
                                           data_services.data_location.prefix() + 'thor_data400::key::fcra::override::pii::qa::ssn');