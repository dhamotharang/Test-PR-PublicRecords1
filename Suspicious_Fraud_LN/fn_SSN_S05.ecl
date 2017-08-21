EXPORT fn_SSN_S05(infile, outf) := macro

death_f := distribute(infile, hash(ssn));

// sort by src ascending so that DE records are selected over EN and TN records
// sort by fname descending to select a record with a full name as opposed to a possible record with just an initial
death_master_deduped := dedup( sort(death_f, ssn, src, -fname, -dod8, -dob8, local), ssn, local);

Suspicious_Fraud_LN.layouts.temp_SSN getDead(death_master_deduped le) :=
TRANSFORM
	//death_only := le.ssn='';
	SELF.ssn := le.ssn;
	SELF.dt_first_deceased := IF(le.ssn<>'', (unsigned3)le.dod8[1..6],0);
	SELF.dt_last_deceased := IF(le.ssn<>'', (unsigned3)le.dod8[1..6],0);
//	SELF.isDeceased := ri.ssn<>'';
	self.did := (unsigned6)le.did;
	SELF := le;
	self := [];
END;

with_dead := project(death_master_deduped,getDead(LEFT));
							
outf := with_dead(dt_first_deceased > 0);

endmacro;