/*Find the Best Property looking only at Deeds records
Group by DID and take the most recent last date seen.*/
import property;

f:=property.Prop_DID + property.Assessors_as_Deeds;

rfields := record
unsigned6    did;
unsigned3    dt_last_seen;
qstring12    vendor_id;
end;

rfields slim(f le) := transform
self.vendor_id := le.vendor_id[1..12];
self := le;
end;

slim_h := distribute(project(f(vendor_id[1..2]='RD'and did!=0),slim(left)),hash(did));
prpsrtd := sort(slim_h, did, -dt_last_seen, -vendor_id, local);
prpddpd := dedup(prpsrtd, did, local);

export BestProperty := prpddpd : persist('persist::Watchdog_BestProperty');