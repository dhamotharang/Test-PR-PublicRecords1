//****  SETTINGS

useProd := TRUE;//or FALSE for Cert
samp_size := 1000000;
the_zip_radius := 30;
num_nodes := 50;
merge_blksiz := 2;

//****  END SETTINGS

import bizlinkfull,SALT28;
details := ', records='+(string)samp_size+', radius='+(string)the_zip_radius+', num_nodes='+(string)num_nodes+', merge_blksiz='+(string)merge_blksiz;;

cert_vip := 'http://certbiproxievip.sc.seisint.com:9876';
prod_vip := 'http://biproxievip.sc.seisint.com:9876';

soap_host := 
#if(useProd)
	prod_vip;#workunit('name','PROD'+details);
#else
	cert_vip;#workunit('name','CERT'+details);  
#end

outrec := recordof(bizlinkfull.MEOW_Biz(dataset([], bizlinkfull.Process_Biz_Layouts.InputLayout),DATASET([],bizlinkfull.Process_Biz_Layouts.Zip_Weights_Layout)).Data_);
// outrec := iesp.TopBusinessSearch.t_TopBusinessSearchResponse;

bip_ip_layout := record
	string120	Company_Name;
	string11  Company_Phone;
	string15  company_FEIN;
	string20 prim_range;
	string20 prim_name;
	string20 sec_range;
	string20 p_City_name;
	string2  St;
	string5  Zip;
	string5  Zip_radius;
	// SET OF string zip_cases;
	string30 fname;
	string30 mname;
	string30 lname;
	unsigned4  UniqueID;
end;

bigood := BIPV2_Testing.files.inq;

inq := 
project(
	bigood,
	transform(
		BIPV2_Testing.layouts.xlink,
		self.rid := counter;
		self.src := 'INQ';
		self.bdid_input := left.appended_bdid,
		self.bdid := 0,
		self.bdid_score := 0,
		BIPV2.IDmacros.mac_SetIDsZero()		

		self.company_name := left.cname;
		self.company_prim_range := left.prim_range;
		self.company_prim_name := left.prim_name;
		self.company_zip := left.zip5;
		self.company_sec_range := left.sec_range;
		self.company_city :=  left.v_city_name;
		self.company_state := left.st;
		self.company_phone := '';
		self.company_fein := left.ein;

		self.email_address := '';									
		self.fname := '';	
		self.mname := '';	
		self.lname := '';			
		
	)
);



// requests_dist := dataset([{'SEISINT','FL'}],{string companyname, string state});
requests_dist_raw := choosen(distribute(INQ, hash(rid) % num_nodes), samp_size);
requests_dist :=
project(
	requests_dist_raw,
	transform(
		bip_ip_layout, 
		self := left;
		self.prim_range := left.company_prim_range;
		self.prim_name := left.company_prim_name;
		self.sec_range := left.company_sec_range;
		self.p_City_name := left.company_city;
		self.St := left.company_state;
		self.Zip := left.company_zip;
		self.zip_radius := (string)the_zip_radius;
		self.UniqueID := counter;
		self := []
	)
);	

// SALT28.MAC_Soapcall(requests_dist, outrec, soap_host, 'topbusiness_services.businesssearch', result, 1);
SALT28.MAC_Soapcall(requests_dist, outrec, soap_host, 'BizLinkFull.Biz_Header_Service_2', result0, merge_blksiz, TRUE);
result := result0(uniqueid > 0);
output(requests_dist, named('requests_dist'));
output(result, named('result'));


hits := 	dedup(result(proxid > 0), uniqueid, all);
errors := dedup(result((integer4)errorcode > 0, uniqueid not in set(hits, uniqueid)), uniqueid, all);
lafn := 	dedup(result((integer4)keysfailed > 0, uniqueid not in set(hits, uniqueid), uniqueid not in set(errors, uniqueid)), uniqueid, all);
misses := dedup(result(proxid = 0, uniqueid not in set(hits, uniqueid), uniqueid not in set(errors, uniqueid), uniqueid not in set(lafn, uniqueid)), uniqueid, all);
others := dedup(result(proxid = 0, uniqueid not in set(hits, uniqueid), uniqueid not in set(errors, uniqueid), uniqueid not in set(lafn, uniqueid), uniqueid not in set(misses, uniqueid)), uniqueid, all);

output(hits, named('hits'));
output(errors, named('errors'));
output(lafn, named('lafn'));
output(misses, named('misses'));
output(others, named('others'));

output(count(hits), named('count_hits'));
output(count(errors), named('count_errors'));
output(count(lafn), named('count_lafn'));
output(count(misses), named('count_misses'));
output(count(others), named('count_others'));

output(requests_dist(uniqueid in set(lafn, uniqueid)), named('inputs_lafn'));
output(requests_dist(uniqueid in set(errors, uniqueid)), named('inputs_errors'));
output(requests_dist(uniqueid in set(others, uniqueid)), named('inputs_others'));

output((integer4)(100 * count(hits)/count(requests_dist)), named('pct_hits'));
output((integer4)(100 * count(errors)/count(requests_dist)), named('pct_errors'));
output((integer4)(100 * count(lafn)/count(requests_dist)), named('pct_lafn'));
output((integer4)(100 * count(misses)/count(requests_dist)), named('pct_misses'));
output((integer4)(100 * count(others)/count(requests_dist)), named('pct_others'));

output(ave(hits, transaction_time), named('ave_ms_hits'));

srt_resp := SORT(PROJECT(hits, {hits.transaction_time}), transaction_time);

c := count(srt_resp);

co25 := (UNSIGNED) (0.25 * c);
co50 := (UNSIGNED) (0.50 * c);
co90 := (UNSIGNED) (0.90 * c);
co96 := (UNSIGNED) (0.96 * c);
co98 := (UNSIGNED) (0.98 * c);

output(srt_resp[co25].transaction_time, named('pct25_ms_hits'));
output(srt_resp[co50].transaction_time, named('pct50_ms_hits'));
output(srt_resp[co90].transaction_time, named('pct90_ms_hits'));
output(srt_resp[co96].transaction_time, named('pct96_ms_hits'));
output(srt_resp[co98].transaction_time, named('pct98_ms_hits'));
output(srt_resp[c].transaction_time, named('slowest_ms_hits'));



keysdedup := dedup(result(keysused > 0 or keysfailed > 0), uniqueid, keysfailed, keysused, all);
keysrolled := 
rollup(
	keysdedup,
	left.uniqueid = right.uniqueid,
	transform(
		recordof(keysdedup),
		self.keysused := left.keysused | right.keysused;
		self.keysfailed := left.keysfailed | right.keysfailed;
		self := left
	)
);

keysrec := record
	keysrolled.keysfailed;
	keysrolled.keysused;
	string failed := bizlinkfull.Process_Biz_Layouts.keysusedtotext(keysrolled.keysfailed);
	string used 	:= bizlinkfull.Process_Biz_Layouts.keysusedtotext(keysrolled.keysused);
	boolean hit := keysrolled.proxid > 0;
	cnt := count(group);
end;

keystable := sort(table(keysrolled, keysrec, keysfailed, keysused), -cnt);
output(choosen(keysdedup, 500), named('keysdedup'));
output(choosen(keysrolled, 500), named('keysrolled'));
output(choosen(keystable, 500), named('keystable'));

		
/*
resp := soapcall(requests_dist, 
								soap_host,
								'topbusiness_services.businesssearch',
								{ requests_dist },
								dataset(OutRec),
								PARALLEL(1)
								// onFail(ft(LEFT)),HEADING('<RightAddressSearchRequest><row>','</row></RightAddressSearchRequest>'),LOG) : persist('cemtemp::UPS_Testing.fn_TestSuite::' + s);
								// onFail(ft(LEFT))
								//,HEADING('<RightAddressSearchRequest><row>','</row></RightAddressSearchRequest><DemoMode>1</DemoMode>')
								// ,LOG
								);
								
output(resp);
*/

/*

output(result,,'~thor_data400::xlink.result'+version,overwrite);
output(count(result), named('count_results'));
output(choosen(result, 10), all, named('sample_results'));

output(count(result(errorcode <> '')), named('count_errors'));
output(choosen(result(errorcode <> ''), 100), all, named('sample_errors'));

output(100*count(result(st <> '' and exists(results(proxid > 0)) and not exists(results(stweight > 0))and not exists(results(st <> ''))))/count(input), named('pct_st_input_but_no_st_result'));
output(result(st <> '' and exists(results(proxid > 0)) and not exists(results(stweight > 0))and not exists(results(st <> ''))), named('sample_st_input_but_no_st_result'));
output(project(result(st <> '' and exists(results(proxid > 0)) and not exists(results(stweight > 0))and not exists(results(st <> ''))), transform({string kutt},self.kutt := BLFCM.Process_Biz_Layouts.KeysUsedToText(left.results[1].keys_used) )), named('kutt_st_input_but_no_st_result'));

output(100*count(result(st <> '' and exists(results(proxid > 0)) and exists(results(stweight = 0, st <> ''))))/count(input), named('pct_st_input_but_mismatch_st_result'));
output(result(st <> '' and exists(results(proxid > 0)) and exists(results(stweight = 0, st <> ''))), named('sample_st_input_but_mismatch_st_result'));
output(project(result(st <> '' and exists(results(proxid > 0)) and exists(results(stweight = 0, st <> ''))), transform({string kutt},self.kutt := BLFCM.Process_Biz_Layouts.KeysUsedToText(left.results[1].keys_used) )), named('kutt_st_input_but_mismatch_st_result'));


output(100*count(result(exists(results)))/count(input), named('pct_hits'));
output(100*count(result(exists(results(score>=75))))/count(input), named('pct_hits_score_gte75'));
output(ave(result(exists(results)), results[1].score), named('ave_hit_top_score'));
output(ave(result(exists(results)), results[1].weight), named('ave_hit_top_weight'));
output(ave(result, transaction_time), named('ave__Call_latency_ms'));



outfile := result;
rec2 := record
	outfile.results.weight;
	outfile.results.score;
	outfile.results.reference;
	outfile.results.keys_used;
	outfile.results.keys_failed;
	string KeysUsedToText;
	string KeysFailedToText;
end;

p :=
project(
	outfile,
	transform(
		rec2,
		self.reference := left.uniqueid,
		self.keys_failed := left.results(keys_failed <> 0)[1].keys_failed,
		self := left.results[1],
		self.KeysUsedToText := BLFCM.Process_Biz_Layouts.KeysUsedToText(self.keys_used),
		self.KeysFailedToText := BLFCM.Process_Biz_Layouts.KeysUsedToText(self.keys_failed)
	)
);
// (~INQONLY or (reference > 15000 and reference <= 20000))


output(p, named('p'));

rec3 := record
	p.KeysUsedToText;
	cnt := count(group);
end;

t := table(p, rec3, KeysUsedToText, few);
output(sort(t, -cnt), named('Most_Common_KeysUsedToText'));

totalcount := count(input);

mac(k) := macro //requires sandbox of KeysUsedToText to just return list, untrimmed

#uniquename(kt);
#uniquename(p1);
#uniquename(pf);
#uniquename(tenp1);
#uniquename(p2);
#uniquename(tenp2);
%kt% := #text(k);
%p1% := p(stringlib.stringfind(KeysUsedToText, %kt%+',', 1) > 0);
%pf% := p(stringlib.stringfind(KeysFailedToText, %kt%+',', 1) > 0);
%tenp1% := choosen(%p1%, 10);

output('******  ' + %kt% + '  ******');

output(ave(%p1%, score), named('ave_score_includes_' + %kt%));
output(ave(%p1%, weight), named('ave_weight_includes_' + %kt%));
output(count(%p1%), named('count_includes_' + %kt%));
output(100*count(%p1%)/totalcount, named('pct_includes_' + %kt%));
output(%p1%, named('sample_includes_' + %kt%));

output(count(%pf%), named('count_failed_' + %kt%));

%p2% := p(KeysUsedToText = %kt%+',');
%tenp2% := choosen(%p2%, 10);

output(count(%p2%), named('count_is_only_' + %kt%));
output(100*count(%p2%)/totalcount, named('pct_is_only_' + %kt%));
output(ave(%p2%, score), named('ave_score_is_only_' + %kt%));
output(ave(%p2%, weight), named('ave_weight_is_only_' + %kt%));
output(%p2%, named('sample_is_only_' + %kt%));
output(input(uniqueid in set(%tenp2%, reference)), named('input_for_sample_is_only_' + %kt%));
output(result(uniqueid in set(%tenp2%, reference)), named('result_for_sample_is_only_' + %kt%));

endmacro;

mac(L_CNPNAME)
mac(L_CNPNAMESTRAIGHT)
mac(L_CNPNAMESTRAIGHTLNCA)

mac(L_CITY_ST_CNPNAME)
mac(L_CITY_ST_CNPNAMESTRAIGHT)

mac(L_ZIP_CNPNAME)
mac(L_ZIP_CNPNAMESTRAIGHT)

mac(L_CNPNAME_ST)
mac(L_CNPNAMESTRAIGHT_ST)
mac(L_CNPNAMESTRAIGHTLNCA_ST)

mac(L_ADDRESS1)
mac(L_ADDRESS2)
mac(L_ADDRESS3)

mac(L_CONTACT)
mac(L_EMAIL)
mac(L_FEIN)
mac(L_PHONE)
mac(L_SOURCE)
mac(L_SSN)
mac(L_URL
*/