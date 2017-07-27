import BIPV2,BIPV2_PostProcess,ut;

EXPORT fStatMissingProxIDLinks(
	dataset(BIPV2.CommonBase.layout) f,
	integer iteration = 0 //just used for output names
) := FUNCTION

string s := (string)iteration;
 
 shared rslim := RECORD
  unsigned6 proxid;
  string250 cnp_name;
  string30 cnp_number;
  string10 prim_range;
  string28 prim_name;
  string8 sec_range;
  string5 zip;
  string2 st;	
  string9 active_duns_number;
  string9 active_enterprise_number;
  string30 active_domestic_corp_key;
 END;

BIPV2_PostProcess.macPartition(f, ProxID, SeleFree, SeleProb)

export mac_roll(dls_name) := macro
	self.dls_name := if(left.dls_name > right.dls_name, left.dls_name, right.dls_name);
endmacro;

p := project(SeleFree, rslim);
d0 := dedup(p, all);
d := 
rollup(
	sort(d0, proxid), 
	transform(
		rslim,
		mac_roll(cnp_number),
		mac_roll(sec_range),
		mac_roll(active_duns_number),
		mac_roll(active_enterprise_number),
		mac_roll(active_domestic_corp_key)
		self := left
	),
	proxid
);
		

rc := record
	d.cnp_name;
	d.cnp_number;
	d.prim_range;
	d.prim_name;
	d.sec_range;
	d.zip;
	d.st;
	d.active_duns_number;
	d.active_enterprise_number;
	d.active_domestic_corp_key;	
	cnt_proxids := count(group);
end;

t := table(d, rc, cnp_name,cnp_number,prim_range,prim_name,sec_range,zip,st,active_duns_number,active_enterprise_number,active_domestic_corp_key);

//hyphotheticals for duns number and corp key

jd := 
join(d,d,left.proxid<right.proxid and left.cnp_name = right.cnp_name and left.cnp_number = right.cnp_number and left.prim_range = right.prim_range and left.prim_name = right.prim_name and left.sec_range = right.sec_range and left.zip = right.zip and left.st = right.st and 
~ut.NNEQ(left.active_duns_number,right.active_duns_number) and left.active_enterprise_number = right.active_enterprise_number and left.active_domestic_corp_key = right.active_domestic_corp_key,
transform({unsigned6 proxid1, unsigned6 proxid2, string active_duns_number1, string active_duns_number2}, 
self.proxid1 := left.proxid, self.proxid2 := right.proxid, self.active_duns_number1 := left.active_duns_number, self.active_duns_number2 := right.active_duns_number));

jc := 
join(d,d,left.proxid<right.proxid and left.cnp_name = right.cnp_name and left.cnp_number = right.cnp_number and left.prim_range = right.prim_range and left.prim_name = right.prim_name and left.sec_range = right.sec_range and left.zip = right.zip and left.st = right.st and 
left.active_duns_number = right.active_duns_number and left.active_enterprise_number = right.active_enterprise_number and 
~ut.NNEQ(left.active_domestic_corp_key, right.active_domestic_corp_key),
transform({unsigned6 proxid1, unsigned6 proxid2, string active_domestic_corp_key1, string active_domestic_corp_key2}, 
self.proxid1 := left.proxid, self.proxid2 := right.proxid, self.active_domestic_corp_key1 := left.active_domestic_corp_key, self.active_domestic_corp_key2 := right.active_domestic_corp_key));		


t2 := t(cnt_proxids > 1);
j := join(d, t2, left.cnp_name = right.cnp_name and left.cnp_number = right.cnp_number and left.prim_range = right.prim_range and left.prim_name = right.prim_name and left.sec_range = right.sec_range and left.zip = right.zip and left.st = right.st and left.active_duns_number = right.active_duns_number and left.active_enterprise_number = right.active_enterprise_number and left.active_domestic_corp_key = right.active_domestic_corp_key
			,transform({d, t2.cnt_proxids}, self := left, self := right)
			);
no_state := t2.st = '';
no_prim_name := t2.prim_name = '';

t2_no_state := t2(no_state);
t2_no_prim_name := t2(no_prim_name);
t2_rest := t2(not no_state and not no_prim_name);

proxid_count_table := table(t2, {t2.cnt_proxids, cnt_occurences := count(group), pct_occurences := (integer)(100*count(group)/count(t2))}, cnt_proxids);

return parallel(
	output(choosen(sort(t2, -cnt_proxids), 500), named('biggest_counts_iter_'+s)),
	output(choosen(sort(proxid_count_table, -cnt_occurences), 500), named('most_common_counts_iter_'+s)),
	output(choosen(j(cnt_proxids = 2), 2000), named('sammple_cnt_proxids_'+s)),
	output(sum(t2, cnt_proxids), named('total_links_missing_iter_'+s)),
	output(sum(t2_no_state, cnt_proxids), named('links_missing_no_state_iter_'+s)),
	output(enth(t2_no_state, 500), named('enth_links_missing_no_state_iter_'+s)),
	output(sum(t2_no_prim_name, cnt_proxids), named('links_missing_no_prim_name_iter_'+s)),
	output(enth(t2_no_prim_name, 100), named('enth_links_missing_no_prim_name_iter_'+s)),
	output(sum(t2_rest, cnt_proxids), named('links_missing_rest_iter_'+s)),
	output(enth(t2_rest, 100), named('enth_links_missing_rest_iter_'+s)),	

	output(count(jd), named('links_hypothetical_missing_duns_iter_'+s)),
	output(enth(jd, 100), named('enth_links_hypothetical_missing_duns_iter_'+s)),	

	output(count(jc), named('links_hypothetical_missing_corp_iter_'+s)),
	output(enth(jc, 100), named('enth_links_hypothetical_missing_corp_iter_'+s)),		
	
	output(count(t2), named('total_companies_split_iter_'+s))
);

end;