import risk_indicators,Suspicious_Fraud_LN;

EXPORT fn_SSN_S06_S07(infile, outf) := macro
		
layout_inquiry_SSN := record
	
	infile.ssn;	
	infile.good_fraudsearch_inquiry;
	infile.log_date;
	infile.dt_first_seen_searchcountyear;
  infile.dt_first_seen_searchcountmonth;
	infile.dt_last_seen_searchcountyear;
  infile.dt_last_seen_searchcountmonth;
	unsigned6 fraudSearchInquiryPerSSNYear;
	unsigned6 fraudSearchInquiryPerSSNMonth;
	end;
	
	
	layout_inquiry_SSN tformat(infile le) := transform
	
	unsigned3 historydate := 999999;

	agebucket := risk_indicators.iid_constants.age_bucket(le.log_date, historydate);
	self.dt_first_seen_searchcountyear := (unsigned3)le.log_date[1..6];
  self.dt_first_seen_searchcountmonth :=  (unsigned3)le.log_date[1..6];
	self.fraudSearchInquiryPerSSNYear := if(le.good_fraudsearch_inquiry and ageBucket between 1 and 12, 1, 0);
	self.fraudSearchInquiryPerSSNMonth := if(le.good_fraudsearch_inquiry and ageBucket = 1, 1, 0);
	self := le;
	end;
	
inquiry_SSN := project(infile(good_fraudsearch_inquiry = true), tformat(left)):persist('~thor_data400::persist::inquiry_SSN_fraudsearch');
	
//inquiry_SSN := dataset('~thor_data400::persist::inquiry_SSN_fraudsearch', layout_inquiry_SSN, flat);

	grouped_inquiry_SSN := GROUP(sort(distribute(inquiry_SSN, hash(ssn)), ssn, log_date, local), ssn, local);

layout_inquiry_SSN iterationS06year( layout_inquiry_SSN le, layout_inquiry_SSN ri ) := TRANSFORM	
	
  self.fraudSearchInquiryPerSSNYear := le.fraudSearchInquiryPerSSNYear  + 1;	
	self := ri;							
end;

inquiry_SSN_fraudsearchperyear := group(iterate(grouped_inquiry_SSN(fraudSearchInquiryPerSSNYear > 0), iterationS06year(left,right)));

layout_inquiry_SSN iterationS07month( layout_inquiry_SSN le, layout_inquiry_SSN ri ) := TRANSFORM	
self.fraudSearchInquiryPerSSNmonth   := le.fraudSearchInquiryPerSSNmonth  + 1;		
self := ri;							
end;

inquiry_SSN_fraudsearchpermonth := group(iterate(grouped_inquiry_SSN(fraudSearchInquiryPerSSNmonth > 0), iterationS07month(left,right)));

inquiry_SSN_fraudsearchperyear_dt_first_seen := inquiry_SSN_fraudsearchperyear(fraudSearchInquiryPerSSNyear = 30);

inquiry_SSN_fraudsearchpermonth_dt_first_seen := inquiry_SSN_fraudsearchpermonth(fraudSearchInquiryPerSSNMonth = 5);

//append risk code S06 and S07

layout_inquiry_SSN 	tjoinS06_S07_dates(inquiry_SSN_fraudsearchperyear_dt_first_seen le, 	inquiry_SSN_fraudsearchpermonth_dt_first_seen ri) := transform

self.SSN := if(le.SSN = '', ri.SSN, le.SSN);
self.dt_first_seen_searchcountyear := le.dt_first_seen_searchcountyear;
self.dt_first_seen_searchcountmonth := ri.dt_first_seen_searchcountmonth;
self.fraudsearchinquiryperSSNyear := le.fraudsearchinquiryperSSNyear;
self.fraudsearchinquiryperSSNmonth := ri.fraudsearchinquiryperSSNmonth;
self := le;
self := ri;
end;

		
d_ssn_S06_07_comb := join(distribute(inquiry_SSN_fraudsearchperyear_dt_first_seen,hash(SSN)),
distribute(inquiry_SSN_fraudsearchpermonth_dt_first_seen, hash(SSN)), left.SSN = right.SSN,tjoinS06_S07_dates(left,right),
full outer, local):persist('~thor_data400::persist::inquiry_SSN_fraudsearch_table');
//d_ssn_S06_07 := dataset('~thor_data400::persist::inquiry_SSN_fraudsearch_table', layout_inquiry_SSN, flat);

//append dt_last_seen
inquiry_SSN_dt_last_seen := dedup(sort(distribute(inquiry_SSN, hash(SSN)), SSN, -log_date, local), SSN, local);

#uniquename(tjoin_dt_last_seen)

Suspicious_Fraud_LN.layouts.temp_ssn %tjoin_dt_last_seen%(d_ssn_S06_07_comb le, inquiry_SSN_dt_last_seen ri) := transform

self.dt_last_seen_searchcountyear := (unsigned3)ri.log_date[1..6];
self.dt_last_seen_searchcountmonth := (unsigned3)ri.log_date[1..6];
self := le;
self := [];
end;

d_ssn_S06_07 := join(d_ssn_S06_07_comb, inquiry_SSN_dt_last_seen,left.SSN = right.SSN, 
%tjoin_dt_last_seen%(left, right),left outer, local);

outf := d_ssn_S06_07;

  
endmacro;