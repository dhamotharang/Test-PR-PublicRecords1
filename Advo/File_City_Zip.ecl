ZipCitySummary :=record
	string5    zip;
	string28   city;
	string2    state;
	string28   county_name;
	DECIMAL5_2 POBoxPercent:=0;
end;

//Normalize file so that each different city version has its own record
ZipCitySummary t_norm_city (Advo.Key_Addr1 le, integer c) := transform
	self.city := choose(c, le.v_city_name, le.p_city_name, le.city_name);
  self.state := le.state_code;
	self := le;
end;

ZipRecords := dedup(sort(distribute(normalize(Advo.Key_Addr1(zip<>''), 3, t_norm_city (left, counter)), hash(zip)), zip, city, state, county_name, local),zip, city, state, county_name, local);

//Table with the total number of records and total number of PO boxes per zip
pobox_tbl := table(Advo.Key_Addr1(zip<>''), {zip, 
																	 total_recs := count(group), 
																	 total_pobox := count(group, record_type_code='P'), 
																	 pct := ((real) count(group, record_type_code='P')  / (real)count(group)) * 100.00},
																	 zip, 
																	 few) ;
																	 
append_pobox_pct := join(ZipRecords, pobox_tbl,
												 left.zip = right.zip,
												 transform(ZipCitySummary,
																	 self.POBoxPercent := right.pct,
																	 self := left)): persist('~thor_data400::persist::advo::zipcity') ;
													
export File_City_Zip := append_pobox_pct;