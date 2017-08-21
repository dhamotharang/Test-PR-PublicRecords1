import Suspicious_Fraud_LN, risk_indicators;

EXPORT fn_phone_P03_P04(infile, outf) := macro
		
layout_inquiry_phone := record
	
	infile.phone10;	
	infile.good_fraudsearch_inquiry;
	infile.log_date;
	infile.dt_first_seen_searchcountyear;
  infile.dt_first_seen_searchcountmonth;
	infile.dt_last_seen_searchcountyear;
  infile.dt_last_seen_searchcountmonth;
	unsigned6 fraudSearchInquiryPerphoneYear;
	unsigned6 fraudSearchInquiryPerphoneMonth;
	end;
	
	
	layout_inquiry_phone tformat(infile le) := transform
	
	unsigned3 historydate := 999999;

	agebucket := risk_indicators.iid_constants.age_bucket(le.log_date, historydate);
	self.dt_first_seen_searchcountyear := (unsigned3)le.log_date[1..6];
  self.dt_first_seen_searchcountmonth :=  (unsigned3)le.log_date[1..6];
	self.fraudSearchInquiryPerphoneYear := if(le.good_fraudsearch_inquiry and ageBucket between 1 and 12, 1, 0);
	self.fraudSearchInquiryPerphoneMonth := if(le.good_fraudsearch_inquiry and ageBucket = 1, 1, 0);
	self := le;
	end;
	
inquiry_phone := project(infile(good_fraudsearch_inquiry = true), tformat(left)):persist('~thor_data400::persist::inquiry_phone_fraudsearch');

//inquiry_phone := dataset('~thor_data400::persist::inquiry_phone_fraudsearch', layout_inquiry_phone, flat);

grouped_inquiry_phone := group(sort(distribute(inquiry_phone, hash(phone10)), phone10,log_date, local), phone10, local);

layout_inquiry_phone iterationP03year( layout_inquiry_phone le, layout_inquiry_phone ri ) := TRANSFORM	
  self.fraudSearchInquiryPerphoneYear := le.fraudSearchInquiryPerphoneYear  + 1;
	self := ri;		
	
end;

inquiry_phone_fraudsearchperyear := group(iterate(grouped_inquiry_phone(fraudSearchInquiryPerphoneYear > 0), iterationP03year(left,right)));

layout_inquiry_phone iterationP04month( layout_inquiry_phone le, layout_inquiry_phone ri ) := TRANSFORM	
	self.fraudSearchInquiryPerphonemonth := le.fraudSearchInquiryPerphonemonth  + 1;	
	self := ri;							
end;

inquiry_phone_fraudsearchpermonth := group(iterate(grouped_inquiry_phone(fraudSearchInquiryPerphonemonth > 0), iterationP04month(left,right)));

inquiry_phone_fraudsearchperyear_dt_first_seen := inquiry_phone_fraudsearchperyear(fraudSearchInquiryPerphoneyear = 30);

inquiry_phone_fraudsearchpermonth_dt_first_seen := inquiry_phone_fraudsearchpermonth(fraudSearchInquiryPerphoneMonth = 5);

//append risk code P03 and P04

layout_inquiry_phone 	tjoinP03_P04_dates(inquiry_phone_fraudsearchperyear_dt_first_seen le, 	inquiry_phone_fraudsearchpermonth_dt_first_seen ri) := transform

self.phone10 := if(le.phone10 = '', ri.phone10, le.phone10);
self.dt_first_seen_searchcountyear := le.dt_first_seen_searchcountyear;
self.dt_first_seen_searchcountmonth := ri.dt_first_seen_searchcountmonth;
self.fraudsearchinquiryperphoneyear := le.fraudsearchinquiryperphoneyear;
self.fraudsearchinquiryperphonemonth := ri.fraudsearchinquiryperphonemonth;
self := le;
self := ri;
end;
	
d_phone_P03_04_comb := join(distribute(inquiry_phone_fraudsearchperyear_dt_first_seen,hash(phone10)),
distribute(inquiry_phone_fraudsearchpermonth_dt_first_seen,hash(phone10)), left.phone10 = right.phone10,tjoinP03_P04_dates(left,right),
full outer, local);
//append dt_last_seen
inquiry_phone_dt_last_seen := dedup(sort(distribute(inquiry_phone, hash(phone10)), phone10, -log_date, local), phone10, local);

Suspicious_Fraud_LN.layouts.slim_phone tjoin_dt_last_seen(d_phone_P03_04_comb le, inquiry_phone_dt_last_seen ri) := transform

self.dt_last_seen_searchcountyear := (unsigned3)ri.log_date[1..6];
self.dt_last_seen_searchcountmonth := (unsigned3)ri.log_date[1..6];
self := le;
self := [];
end;

d_phone_P03_04 := join(distribute(d_phone_P03_04_comb, hash(phone10)), inquiry_phone_dt_last_seen,left.phone10 = right.phone10, 
tjoin_dt_last_seen(left, right),left outer, local);
  
outf := d_phone_P03_04;

endmacro;