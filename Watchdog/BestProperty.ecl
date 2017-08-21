/*Find the Best Property looking only at Deeds records
Group by DID and take the most recent last date seen.*/
import property,ln_propertyv2;

f:=ln_propertyv2.ln_propertyv2_as_source(,true).watchdog_prop_didv2(vendor_id[2]='D' and did!=0) + ln_propertyv2.Assessors_as_Deeds;

rfields := record
unsigned6    did;
unsigned3    dt_last_seen;
qstring14    vendor_id;
end;

rfields slim(f le) := transform
self.vendor_id := 'RD' + le.vendor_id[1..12];
self := le;
end;

slim_h := distribute(project(f,slim(left)),hash(did));
prpsrtd := sort(slim_h, did, -dt_last_seen, -vendor_id, local);
prpddpd := dedup(prpsrtd, did, local);

export BestProperty := prpddpd : persist('persist::Watchdog_BestProperty');