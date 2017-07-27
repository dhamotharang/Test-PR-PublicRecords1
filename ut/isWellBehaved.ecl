did_nneq(unsigned6 did1, unsigned6 did2) := did1 IN [0,999999999999] OR did2 IN [0,999999999999] OR did1=did2;



export boolean isWellBehaved(integer8 dob_max_val, integer8 dob_min_val,
					    string9 ssn_max_val, string9 ssn_min_val,
					    unsigned6 dob_did_max_val, unsigned6 dob_did_min_val,
							unsigned6 ssn_did_max_val, unsigned6 ssn_did_min_val) :=
			
			((ssn_max_val='' or 
               ut.StringSimilar(ssn_min_val,ssn_max_val)<2 or 
			((unsigned)ssn_max_val % 10000 = (unsigned)ssn_min_val % 10000 and 
			(((unsigned)ssn_max_val div 10000) = 0 or ((unsigned)ssn_min_val div 10000) = 0)) or
			did_nneq(ssn_did_max_val,ssn_did_min_val)) and
			
			(dob_max_val-dob_min_val<300 or
			did_nneq(dob_did_max_val,dob_did_min_val)));