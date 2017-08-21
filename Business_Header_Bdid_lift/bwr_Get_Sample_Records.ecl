kmatchsample := Business_Header_Bdid_lift.Keys(business_header.BH_Basic_Match_FEIN()).MatchSample;
//output(kmatchsample);

mydsgoodmatches := kmatchsample(conf >= 38);

output(count		(mydsgoodmatches					), named('GoodMatchSamplesCount'));
output(choosen	(mydsgoodmatches, 1000, 1	), named('GoodMatchSamples1000'),all);
