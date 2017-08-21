//========================================================
// Attribute: BestSSNFunc
// Function to get the best SSN.
//========================================================
import header, mdr, Doxie;

export BestSSNFunc(
    dataset(Header.Layout_Header) myDs, //header should be pre-filetered by myDate, if applies.
    unsigned3 myDate = 0, 
    boolean dppa = false, boolean glb = false,
    boolean util = false //false: non-utility
) := FUNCTION

f := myDs(util OR pflag3='');

en := watchdog.fn_best_ssn(f).concat_them;

did_ssn_rec := record
 f.did;
 f.ssn;
end;
good_ssns := table(f(~mdr.Source_is_DPPA(src)),did_ssn_rec);

en noDPPA(en L, good_ssns R) := transform 
 self := l;
end;

en_distr := distribute(en, hash(did));
good_ssns_distr := distribute(good_ssns, hash(did));

get_best := join(en_distr,good_ssns_distr,left.did=right.did and left.ssn=right.ssn,
					noDPPA(left,right),local);

return dedup(sort(get_best,did,local),did,local);
END;
