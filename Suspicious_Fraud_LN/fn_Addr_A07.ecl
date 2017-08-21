EXPORT fn_Addr_A07(dataset(layouts.slim_address) infile) := function

advo_addrkey_slim := record

infile.address_id;
unsigned3 dt_first_seen := Suspicious_Fraud_LN.fn_dt_first_seen(infile.dt_vendor_first_reported,infile.dt_first_seen);
unsigned3 dt_last_seen := Suspicious_Fraud_LN.fn_dt_last_seen(infile.dt_vendor_last_reported,infile.dt_last_seen);
integer	cnt := COUNT(GROUP);
	
	end;
	
addr_vacancy_with_dates := table(infile, advo_addrkey_slim, address_id,few);

return addr_vacancy_with_dates;

end;
