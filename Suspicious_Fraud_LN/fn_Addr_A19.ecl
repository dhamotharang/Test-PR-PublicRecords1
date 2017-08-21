
export fn_Addr_A19(infile, outf) := macro

//get the keys 

key_advo_addr := ADVO.Key_Addr1;

pobox_vacancy := key_advo_addr(zip <> '' and prim_name <> '' and address_vacancy_indicator='Y');

advo_addrkey_slim := record

//addr_vacancy.prim_range;
addr_vacancy.prim_name;
//addr_vacancy.sec_range
addr_vacancy.zip;
//Advo_addrkey_has_vacant.address_vacancy_indicator;
unsigned3 dt_first_seen := Suspicious_Fraud_LN.fn_dt_first_seen((unsigned3)addr_vacancy.date_vendor_first_reported[1..6],(unsigned3)addr_vacancy.date_first_seen[1..6]);
unsigned3 dt_last_seen := Suspicious_Fraud_LN.fn_dt_last_seen((unsigned3)addr_vacancy.date_vendor_last_reported[1..6],(unsigned3)addr_vacancy.date_last_seen[1..6]);
integer	cnt := COUNT(GROUP);
	
	end;
	
	pobox_vacancy_with_dates := table(pobox_vacancy, advo_addrkey_slim, prim_name, zip, few);
	
	infile tjoin_A19dates(infile le, pobox_vacancy_with_dates ri) := transform

self.dt_first_seen_pobox_vacant := ri.dt_first_seen;
self.dt_last_seen_pobox_vacant := ri.dt_last_seen;
self := le;

end;

with_pobox_vacancy_dates := join(infile(prim_name[1..6] = 'PO BOX'),  distribute(pobox_vacancy_with_dates,hash(prim_name,zip)),
left.prim_name = right.prim_name and left.zip = right.zip, tjoin_A19dates(left, right), left outer, local);

 outf := with_pobox_vacancy_dates;

endmacro;
	
	



