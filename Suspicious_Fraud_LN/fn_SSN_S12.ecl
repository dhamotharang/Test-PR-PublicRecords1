
import watchdog;

EXPORT fn_SSN_S12(infile, outf) := macro
#uniquename(infile_dist)
key_watchdog := watchdog.Key_watchdog_glb(valid_ssn != 'M' and LENGTH(TRIM(ssn))=9 and (unsigned)ssn > 0 and ut.full_ssn(ssn));

key_minors := doxie_files.key_minors_hash;

out_minors := join(key_watchdog, key_minors,
														LEFT.did != 0 AND
														KEYED(hash32((UNSIGNED6)LEFT.did)=RIGHT.hash32_did) AND
		                  			KEYED(LEFT.did = RIGHT.did) AND 
														ut.GetAgeI(right.dob) < 18,   //check age since a few will turn 18 between builds
														TRANSFORM(LEFT));
															 
out_minors_dedup := dedup(sort(distribute(out_minors,hash((string9)ssn,did)), (string9)ssn,did, local), (string9)ssn, did, local);

%infile_dist% := distribute(infile,hash(ssn,did));

%infile_dist% getMinors(%infile_dist% le, out_minors_dedup ri) :=
TRANSFORM
	SELF.ssn := (string9)ri.ssn;
	SELF.DID := ri.DID;
	SELF := le;
	SELF := [];

END;

infile_has_minors := join(%infile_dist%,out_minors_dedup,left.ssn = (string9)right.ssn and left.did = right.did, getMinors(LEFT,right), local);
	
temp_rec := RECORD
	infile_has_minors.ssn;
	dt_first_seen := min(group,infile_has_minors.dt_first_seen);
	dt_last_seen := max(group,infile_has_minors.dt_last_seen);
integer cnt := count(group);

END;	
	infile_has_minors_dates := table(infile_has_minors, temp_rec, ssn,local);
	
	outf := project(infile_has_minors_dates, transform(Suspicious_Fraud_LN.layouts.temp_SSN,
	SELF.dt_first_seen_minors :=  left.dt_first_seen, SELF.dt_last_seen_minors  :=  left.dt_last_seen, self := left, self := []));

endmacro;

