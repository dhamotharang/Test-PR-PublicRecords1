export Mac_deduprecs(indataset,by_lookup,favor_lookup,outdataset) := MACRO
import ut;

// If excluding lookup field from the dedup then prefer records with the favored lookup bit set
// and after that prefer records with the higher lookup bit set

outdataset:=  if(by_lookup, 
							dedup(sort(indataset,record,local),record,local),
							ungroup(
							dedup(sort(
							group(sort(indataset, record,except lookups,local),record,except lookups,local),
							if(ut.bit_test(indataset.lookups,favor_lookup),0,1), -lookups),
							record,except lookups)));
ENDMACRO;
