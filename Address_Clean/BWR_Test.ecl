import Amex_Collusion;
ds := Amex_Collusion.Files.Customer;
ds;
OUTPUT(COUNT(ds), named('input_count'));

recordof(ds) treatAddr(ds l) := TRANSFORM
	address1 := MAP(l.cm_addr_line1 = '' AND l.cm_addr_line2 <> '' => l.cm_addr_line2,
									l.cm_addr_line1 <> '' AND l.cm_addr_line2 <> '' => l.cm_addr_line1 + ' ' + l.cm_addr_line2,
									l.cm_addr_line1);
	address2 := TRIM(l.cm_city)+', '+TRIM(l.cm_state)+' '+TRIM(l.cm_zip5); 
	
	SELF.cm_addr_line1  := address1;
	SELF.cm_addr_line2  := address2;
	SELF := l;
END;
pretreated := PROJECT(ds(cm_addr_line1 <> ''), treatAddr(LEFT));


reduced := DEDUP(SORT(pretreated, cm_addr_line1, cm_addr_line2), cm_addr_line1, cm_addr_line2);
OUTPUT(COUNT(reduced), named('reduced_count'));

cleanedHash  := Address_Clean.mac_clean(reduced, 2, cm_addr_line1, cm_addr_line2);

output(cleanedHash, named('cleanedHash'));
output(CHOOSEN(cleanedHash(~cleaner_hit and ~cache_hit), 1000), named('total_miss'));

rCacheCounts := record
	cache_cnt := COUNT(GROUP, cleanedHash.cache_hit);
	cleaner_cnt := COUNT(GROUP, cleanedHash.cleaner_hit);
	miss_cnt := COUNT(GROUP, ~cleanedHash.cleaner_hit and ~cleanedHash.cache_hit);
end;
hashCounts := TABLE(cleanedHash, rCacheCounts, few);
output(hashCounts, named('hash_counts'));