import iesp,ups_services;

export fn_TestSuite(dataset(iesp.rightaddress.t_RightAddressSearchRequest) requests, string service_version, string modifier = '', string2 which_cluster = '') :=
function

s := service_version + modifier;

SearchRequest := iesp.rightaddress.t_RightAddressSearchRequest;
SearchResponse := iesp.rightaddress.t_RightAddressSearchResponseEx;
Constant := UPS_Services.Constants;

// ds := 
// UPS_Testing.DS_RegressionTestCases;
// UPS_Testing.DS_AutonomyQueries1000;
// choosen(UPS_Testing.DS_AutonomyQueries1000, 1000);
// UPS_Testing.ds_SlowQueriesNoFname2.formatted;
// requests :=UPS_Testing.fn_BuildTestCases(ds);
// requests := enth(UPS_Testing.mod_UPS_Queries_20091009.queries(true),1000);//28749 total in here

OutRec := RECORD
	// unsigned8 time_ms{xpath('_call_latency')} := 0;  // picks up timing
	unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	INTEGER code := 0;
	STRING250 message := '';

	// SearchRequest request;
	// SearchResponse response;
	iesp.rightaddress.t_RightAddressSearchResponse;
END;

OutRec ft(requests inn) := TRANSFORM
	SELF.code := 11;//IF(FAILCODE = 0, -1, FAILCODE);
	SELF.message := FAILMESSAGE;
	self := [];
END;

// Enable (uncomment) exactly one of the following:
// soap_host := 'http://10.173.195.2:9876';	// Roxie2
soap_host := 
case(
	which_cluster,
	'32' => 'http://roxiedevvip32.sc.seisint.com:9876', //dev 32
	'p2' => 'http://10.173.3.42:9876',// prod #2
	'190' => 'http://roxiedevvip.sc.seisint.com:9876', // Dev64 old
	'http://10.239.192.54:9876' // Dev64 new (no vip working now)
);
// soap_host := 'http://10.239.190.101:9876'; // Dev64 ???
// soap_host := 'http://roxiedevvip32.sc.seisint.com:9876';  //dev 32
// soap_host := 'http://10.173.190.54:9876';  // single host in Dev64

//i want 17 users, so i am going to put these records onto 17 nodes
// requests_dist := distribute(requests, random() % 15);
// requests_dist := distribute(requests, random() % 25);
// requests_dist := distribute(requests, random() % 50);
requests_dist := distribute(requests, 1);

resp := soapcall(requests_dist, 
								soap_host,
								'UPS_Services.RightAddressService' + service_version,
								{ requests },
								dataset(OutRec),
								PARALLEL(1),
								onFail(ft(LEFT)),HEADING('<RightAddressSearchRequest><row>','</row></RightAddressSearchRequest>'),LOG) : persist('cemtemp::UPS_Testing.fn_TestSuite::' + s);

output(choosen(requests, 10), named('requests' + s));
output(choosen(resp, 10), named('resp' + s));


srt_resp := SORT(PROJECT(resp, {resp.time_ms}), time_ms);

c := count(srt_resp);
a := ave(srt_resp, time_ms);
a2 := ave(resp(recordcount > 0), time_ms);
n := min(srt_resp, time_ms);
x := max(srt_resp, time_ms);



co25 := (UNSIGNED) (0.25 * c);
co50 := (UNSIGNED) (0.50 * c);
co90 := (UNSIGNED) (0.90 * c);
co96 := (UNSIGNED) (0.96 * c);
co98 := (UNSIGNED) (0.98 * c);

notHits := count(resp(recordcount = 0));
notHitsOver90 := count(resp(not exists(records(score >= 90))));

// output(resp,,'cemtemp::resp' + s, overwrite);
//output(ave(resp, time_ms), named('avg_ms'));
output(count(resp(code > 0)), named('NumFailures' + s));
output(resp(code > 0), named('Failures' + s));
output(sum(resp, recordcount), named('TotalResponses' + s));
output(notHits, named('NotHits' + s));
output(c, named('NumQueries' + s));
output((c-notHits)/c, named('HitRate' + s));
output((c-notHitsOver90)/c, named('Score90HitRate' + s));
output(a, named('AverageResponseMS' + s));
output(a2, named('AverageResponseMS_Hits' + s));
output(dataset([{a}], {unsigned4 avg}), named('dsAverageResponseMS' + service_version), extend);
output(dataset([{a2}], {unsigned4 avg}), named('dsAverageResponseMS_Hits' + service_version), extend);
// output(n, named('MinResponseMS' + s));
output(x, named('MaxResponseMS' + s));

// output(srt_resp[co25].time_ms, named('pct25ResponseMS' + s));
output(srt_resp[co50].time_ms, named('pct50ResponseMS' + s));
// output(srt_resp[co90].time_ms, named('pct90ResponseMS' + s));
// output(srt_resp[co96].time_ms, named('pct96ResponseMS' + s));
output(srt_resp[co98].time_ms, named('pct98ResponseMS' + s));
output(count(resp(time_ms <= 2000))/count(requests), named('pctUnderTwoSecs' + s));

return resp(recordcount > 0);
end;