/*Pick best SSN
Group by SSN, then count the occurrences.
Pick the most frequent only if it is 2x as frequent as the next.
If not, don't pick any -- we don't have a 'best' SSN*/

import header, mdr;

string20 var1 := '' : stored('watchtype');

f := if(var1 not in ['nonutility','nonglb_nonutility'],file_header_filtered,file_header_filtered(pflag3=''));

header.MAC_Best_SSN(f, did, en)

did_ssn_rec := record
 f.did;
 f.ssn;
end;

good_ssns := table(f(~mdr.Source_is_DPPA(src)),did_ssn_rec);

en noDPPA(en L, good_ssns R) := transform 
 self := l;
end;

get_best := join(en,good_ssns,left.did=right.did and left.ssn=right.ssn,
					noDPPA(left,right),local);

export BestSSN := dedup(sort(get_best,did,local),did,local) : persist('persist::Watchdog_BestSSN');