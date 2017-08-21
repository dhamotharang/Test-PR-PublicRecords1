import risk_indicators,ut;

export fn_SSN_S11(infile, outf) := macro

Suspicious_Fraud_LN.layouts.temp_SSN tSSNissuedate(infile le) := transform

sysdate := (integer)(ut.GetDate[1..6]);
issued_within_3years := (sysdate - (INTEGER)(le.official_first_seen[1..6])) < 300; // If it is not a randomized social and only issued within the last 36 months																		;//Or it was possibly randomized and the date is prior to June 25th, 2014							
self.dt_first_seen_official := if(issued_within_3years, (unsigned3)le.official_first_seen[1..6], 999999);
self.dt_last_seen_official := if(issued_within_3years and (unsigned3)le.official_last_seen[1..6] <= sysdate, (unsigned3)le.official_last_seen[1..6], 0);

self := le;
self := [];

end;

outf := project(infile, tSSNissuedate(left));

endmacro;

