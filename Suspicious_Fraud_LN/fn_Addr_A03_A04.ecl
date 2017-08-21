import risk_indicators,inquiry_acclogs;

EXPORT fn_Addr_A03_A04(dataset(layouts.slim_address)  infile) := function


layout_inquiry_addr := record
	infile.prim_range;
	infile.predir;
	infile.prim_name;
	infile.suffix;
	infile.postdir;
	infile.unit_desig;
	infile.sec_range;
	infile.city_name;
	infile.st;
	infile.zip;
	infile.address_id;
	infile.good_fraudsearch_inquiry;
	infile.log_date;
	infile.dt_first_seen_searchcountyear;
  infile.dt_first_seen_searchcountmonth;
	infile.dt_last_seen_searchcountyear;
  infile.dt_last_seen_searchcountmonth;
	unsigned6 fraudSearchInquiryPerAddrYear;
	unsigned6 fraudSearchInquiryPerAddrMonth;
	end;
	
layout_inquiry_addr tformat(infile le) := transform
	
			unsigned3 historydate := 999999;

	agebucket := risk_indicators.iid_constants.age_bucket(le.log_date, historydate);
	self.dt_first_seen_searchcountyear := (unsigned3)le.log_date[1..6];
  self.dt_first_seen_searchcountmonth :=  (unsigned3)le.log_date[1..6];
	self.fraudSearchInquiryPerAddrYear := if(le.good_fraudsearch_inquiry and ageBucket between 1 and 12, 1, 0);
	self.fraudSearchInquiryPerAddrMonth := if(le.good_fraudsearch_inquiry and ageBucket = 1, 1, 0);
	self := le;
end;

inquiry_addr := project(infile(good_fraudsearch_inquiry = true), tformat(left)):persist('~thor_data400::persist::inquiry_address_fraudsearch');

//inquiry_addr := dataset('~thor_data400::persist::inquiry_address_fraudsearch', layout_inquiry_addr, flat);

	grouped_inquiry_addr_year := group(sort(distribute(inquiry_addr(fraudSearchInquiryPerAddrYear > 0), address_id), address_id, log_date, local), address_id, local);

layout_inquiry_addr iterationA03year(layout_inquiry_addr le, layout_inquiry_addr ri ) := TRANSFORM	
	
  self.fraudSearchInquiryPerAddrYear := le.fraudSearchInquiryPerAddrYear  + 1;
	self := ri;							
end;

inquiry_Addr_fraudsearchperyear := group(iterate(grouped_inquiry_addr_year, iterationA03year(left,right)));

	grouped_inquiry_addr_month := group(sort(distribute(inquiry_addr(fraudSearchInquiryPerAddrMonth > 0), address_id), address_id, log_date, local),address_id, local);

layout_inquiry_addr iterationS04month( layout_inquiry_addr le, layout_inquiry_addr ri ) := TRANSFORM	
	
 self.fraudSearchInquiryPerAddrmonth := le.fraudSearchInquiryPerAddrmonth  + 1;	
 self := ri;							
end;

inquiry_Addr_fraudsearchpermonth := group(iterate(grouped_inquiry_addr_month, iterationS04month(left,right)));

inquiry_Addr_fraudsearchperyear_dt_first_seen := inquiry_Addr_fraudsearchperyear(fraudSearchInquiryPerAddryear = 30);

inquiry_Addr_fraudsearchpermonth_dt_first_seen := inquiry_Addr_fraudsearchpermonth(fraudSearchInquiryPerAddrMonth = 5);

//append risk code A03 and A04

layout_inquiry_addr 	tjoinA03_A04_dates(inquiry_Addr_fraudsearchperyear_dt_first_seen le, 	inquiry_Addr_fraudsearchpermonth_dt_first_seen ri) := transform

self.address_id := if(le.address_id = 0, ri.address_id, le.address_id);
self.dt_first_seen_searchcountyear := le.dt_first_seen_searchcountyear;
self.dt_first_seen_searchcountmonth := ri.dt_first_seen_searchcountmonth;
self.fraudSearchInquiryPerAddryear := le.fraudSearchInquiryPerAddryear;
self.fraudSearchInquiryPerAddrMonth := ri.fraudSearchInquiryPerAddrMonth;
self.prim_range := if(le.prim_range = '', ri.prim_range, le.prim_range);
self.predir     := if(le.predir = '', ri.predir, le.predir);
self.prim_name  := if(le.prim_name = '', ri.prim_name, le.prim_name);
self.suffix     := if(le.suffix = '', ri.suffix, le.suffix);
self.postdir    := if(le.postdir = '', ri.postdir, le.postdir);
self.unit_desig  := if(le.unit_desig = '', ri.unit_desig, le.unit_desig);
self.sec_range   := if(le.sec_range = '', ri.sec_range, le.sec_range);
self.city_name   := if(le.city_name = '', ri.city_name, le.city_name);
self.st          := if(le.st = '', ri.st, le.st);
self.zip         := if(le.zip = '', ri.zip, le.zip);
self := le;
self := ri;
end;

		
d_addr_inquiry_A03_04_comb := join(inquiry_Addr_fraudsearchperyear_dt_first_seen, inquiry_Addr_fraudsearchpermonth_dt_first_seen, left.address_id = right.address_id,tjoinA03_A04_dates(left,right),
full outer, local):persist('~thor_data400::persist::inquiry_addr_fraudsearch_table'); 
//d_addr_inquiry_A03_04_comb := dataset('~thor_data400::persist::inquiry_addr_fraudsearch_table', layout_inquiry_addr, flat);

//append dt_last_seen
inquiry_addr_dt_last_seen := dedup(sort(distribute(inquiry_addr, address_id), address_id, -log_date, local), address_id, local);

layouts.slim_address tjoin_dt_last_seen(d_addr_inquiry_A03_04_comb le, inquiry_addr_dt_last_seen ri) := transform

self.dt_last_seen_searchcountyear := (unsigned3)ri.log_date[1..6];
self.dt_last_seen_searchcountmonth := (unsigned3)ri.log_date[1..6];
self := le;
self := [];
end;

d_addr_P03_04 := join(d_addr_inquiry_A03_04_comb, inquiry_addr_dt_last_seen,left.address_id = right.address_id, 
tjoin_dt_last_seen(left, right),left outer, local);
  
return d_addr_P03_04;

end;