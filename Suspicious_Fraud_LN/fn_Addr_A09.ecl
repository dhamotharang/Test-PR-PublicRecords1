EXPORT fn_Addr_A09(infile, outf) := macro

//get the keys 

key_advo_addr := ADVO.Key_Addr1;

addr_educational_institution := key_advo_addr(zip <> '' and prim_name <> '' and seasonal_delivery_indicator='E');

advo_addr_slim := record

addr_educational_institution.prim_range;
addr_educational_institution.predir;
addr_educational_institution.prim_name;
addr_educational_institution.addr_suffix;
addr_educational_institution.postdir;
addr_educational_institution.sec_range;
addr_educational_institution.zip;
//Advo_addrkey_has_vacant.address_vacancy_indicator;
unsigned3 dt_first_seen := Suspicious_Fraud_LN.fn_dt_first_seen((unsigned3)addr_educational_institution.date_vendor_first_reported[1..6],(unsigned3)addr_educational_institution.date_first_seen[1..6]);
unsigned3 dt_last_seen := Suspicious_Fraud_LN.fn_dt_last_seen((unsigned3)addr_educational_institution.date_vendor_last_reported[1..6],(unsigned3)addr_educational_institution.date_last_seen[1..6]);
integer	cnt := COUNT(GROUP);
	
	end;
	
addr_educational_with_dates := table(addr_educational_institution, advo_addr_slim, prim_range,predir,prim_name,addr_suffix,postdir,sec_range, zip, few);
	
infile tjoin_A09dates(infile le, addr_educational_with_dates ri) := transform

self.dt_first_seen_educational_institution := ri.dt_first_seen;
self.dt_last_seen_educational_institution := ri.dt_last_seen;
self := le;

end;

with_addr_educational_dates := join(infile, addr_educational_with_dates, 
		keyed(left.prim_range=right.prim_range) and
		keyed(left.prim_name=right.prim_name) and
		keyed(left.suffix=right.addr_suffix) and
		keyed(left.predir=right.predir) and
		keyed(left.postdir=right.postdir) and
		keyed(left.sec_range=right.sec_range) and
		keyed(left.zip =right.zip),
    tjoin_A09dates(left, right), left outer, local);

outf := with_addr_educational_dates;

endmacro;
	