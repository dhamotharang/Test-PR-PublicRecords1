IMPORT InsuranceHeader_RemoteLinking.Constants AS constants;
IMPORT InsuranceHeader_RemoteLinking.Layouts AS layouts;

samp_size := 1000;
num_nodes := 1;
str_samp_size := trim((string)samp_size);
roxieIP := constants.HEADER_SERVICE_ROXIE_IP;
ver := 'dev194'; #workunit('name',ver + ', ' + str_samp_size + ' recs, ');//this is the 194
serviceName := constants.HEADER_SERVICE_NAME;

qaFn := '~remote_linking::test_set::1';
qaDs := dedup(sort(dataset(qaFn,Layouts.ServiceInputLayout, thor), results_lexid),results_lexid);

qaDs_enth := enth(sort(qaDs, hash(Inquiry_Lexid)), samp_size) : persist('~remote_linking::persist::testing::qaDs_enth_' + str_samp_size, expire(10));

indata := distribute(qaDs_enth, random()%num_nodes);


output_layout := Layouts.ServiceOutputLayout;
        
str_xpath := '_call_latency_ms';
      
errx := record(output_layout), maxlength(2097152)
            string errorcode := '';
			integer transaction_time{xpath(str_xpath)};
end;

errx err_out(indata L) := transform
            SELF.errorcode := FAILCODE + FAILMESSAGE;
            self := L;
            self := [];
end;
/*
parallel(2) is the default for a SOAPCALL
tmeout set to 1 hour to match VIP/Radware timeout*/
final := soapcall(indata, roxieIP , servicename, {indata},
                    dataset(errx), onfail(err_out(LEFT)), parallel(1), merge(1)
										):independent;//: persist('~remote_linking::persist::test1_2_2ndrun::final_' + str_samp_size + ver, expire(10));


OUTPUT(qaDs_enth, named('qaDs_enth'));
OUTPUT(indata, named('indata'));
OUTPUT(final, named('final'));
OUTPUT(final(errorcode <> ''), named('final_errors'));
error_type(string EC) := if(std.str.find(std.str.touppercase(EC), 'MEMORY')>0, 'memory', 'other');
OUTPUT(table(final(errorcode <> ''), {error_type(errorcode), cnt := count(group)}, error_type(errorcode)), named('table_errors'));

OUTPUT(max(final, transaction_time), named('max_call_latency_ms'));
OUTPUT(ave(final, transaction_time), named('ave_call_latency_ms'));

sorted_time := sort(final,transaction_time);
InsuranceHeader_RemoteLinking.Add_Medians(sorted_time,errorcode,transaction_time,median);
InsuranceHeader_RemoteLinking.AppendNtile.ValueRange(sorted_time,transaction_time,100,outfile,percentile);
OUTPUT(median[1].median, named('median_latency_ms'));
OUTPUT(percentile, named('percentiles'));
OUTPUT(COUNT(FINAL(match=TRUE))/COUNT(FINAL), named('Hit_Rate'));
OUTPUT(ave(final, conf), named('Avg_Score'));
