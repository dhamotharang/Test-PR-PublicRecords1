ds := InsuranceHeader_Address.files().addr_link_sfds;
dist := distribute(ds,hash(did));

old := sort(dist,did,addr_ind,local);
olddedup := dedup(old,did,addr_ind,local);
oldcount := count(olddedup);

new := sort(dist,did,address_group_id,local);
newdedup := dedup(new,did,address_group_id,local);
newcount := count(newdedup);

output(oldcount,named('oldcount'));
output(newcount,named('newcount'));
output( (oldcount - newcount) / oldcount * 100, named('pct_decrease'));