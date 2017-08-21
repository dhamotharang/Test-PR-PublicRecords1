EXPORT fn_Addr_A18(infile, outf) := macro

//get the keys 

key_advo_addr := ADVO.Key_Addr1;

addr_CMRA:= key_advo_addr(zip <> '' and prim_name <> '' and drop_indicator = 'C');

advo_addrkey_slim := record

addr_CMRA.prim_range;
addr_CMRA.predir;
addr_CMRA.prim_name;
addr_CMRA.addr_suffix;
addr_CMRA.postdir;
addr_CMRA.sec_range;
addr_CMRA.zip;
unsigned3 dt_first_seen := Suspicious_Fraud_LN.fn_dt_first_seen((unsigned3)addr_CMRA.date_vendor_first_reported[1..6],(unsigned3)addr_CMRA.date_first_seen[1..6]);
unsigned3 dt_last_seen := Suspicious_Fraud_LN.fn_dt_last_seen((unsigned3)addr_CMRA.date_vendor_last_reported[1..6],(unsigned3)addr_CMRA.date_last_seen[1..6]);
integer	cnt := COUNT(GROUP);
	
	end;
	
addr_CMRA_with_dates := table(addr_CMRA, advo_addrkey_slim, prim_range,predir,prim_name,addr_suffix,postdir,sec_range, zip, few);
	
infile tjoin_A18dates(infile le, addr_CMRA_with_dates ri) := transform

self.dt_first_seen_addr_CMRA := ri.dt_first_seen;
self.dt_last_seen_addr_CMRA := ri.dt_last_seen;
self := le;

end;

with_addr_CMRA_dates := join(infile, addr_CMRA_with_dates,
		keyed(left.prim_range=right.prim_range) and
		keyed(left.prim_name=right.prim_name) and
		keyed(left.suffix=right.addr_suffix) and
		keyed(left.predir=right.predir) and
		keyed(left.postdir=right.postdir) and
		keyed(left.sec_range=right.sec_range) and
		keyed(left.zip =right.zip),
		tjoin_A18dates(left, right), keep(1), limit (0), LEFT OUTER);

 outf := with_addr_CMRA_dates;

endmacro;
	
	
