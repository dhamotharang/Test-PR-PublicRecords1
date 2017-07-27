


import BO_Address;
export CleanAddressEnclarity (const string line1,const string line2,
							const string server = BO_Address.BO_Server, 
							unsigned2 port = BO_Address.BO_Port)	:= FUNCTION
					
string xmldata := BO_Address.BOCleanAddressEnclarity(
				RegexReplace('(<)|(>)|\\0',line1,''),
				RegexReplace('(<)|(>)|\\0',line2,''),
				server,port);

// this needs to change
string10 pr := BO_Address.AddrUtils.prim_range(xmldata);
string2 pd := BO_Address.AddrUtils.predir(xmldata);
string28 pn := BO_Address.AddrUtils.prim_name(xmldata);
string4 ads := BO_Address.AddrUtils.addr_suffix(xmldata);
string2 psd := BO_Address.AddrUtils.postdir(xmldata);
string10 ud := BO_Address.AddrUtils.unit_desig(xmldata);
string8 sr := BO_Address.AddrUtils.sec_range(xmldata);
string25 pcn := BO_Address.AddrUtils.p_city_name(xmldata);
string25 vcn := BO_Address.AddrUtils.v_city_name(xmldata);
string2 ss := BO_Address.AddrUtils.st(xmldata);
string5 zp := BO_Address.AddrUtils.zip(xmldata);
string4 zp4 := BO_Address.AddrUtils.zip4(xmldata);
string4 ct := BO_Address.AddrUtils.cart(xmldata);
string1 css := BO_Address.AddrUtils.cr_sort_sz(xmldata);
string4 lt := BO_Address.AddrUtils.lot(xmldata);
string1 lto := BO_Address.AddrUtils.lot_order(xmldata);
string2 dp := BO_Address.AddrUtils.dpbc(xmldata);
string1 cd := BO_Address.AddrUtils.chk_digit(xmldata);
string2 rt := BO_Address.AddrUtils.record_type(xmldata);
string2 fs := BO_Address.AddrUtils.ace_fips_state(xmldata);
string3 fc := BO_Address.AddrUtils.county(xmldata);


string9 rrn := BO_Address.AddrUtils.rural_route_number(xmldata);
string9 pobn := BO_Address.AddrUtils.po_box_number(xmldata);
string50 sad := BO_Address.AddrUtils.secondary_address(xmldata);
string1 rdi := BO_Address.AddrUtils.rdi(xmldata);
//string10 npu := BO_Address.AddrUtils.non_postal_unit(xmldata);
string64 alr:= BO_Address.AddrUtils.address_line_remainder1(xmldata);
string64 ex1:= BO_Address.AddrUtils.extra1(xmldata);
string64 ex2:= BO_Address.AddrUtils.extra2(xmldata);
string64 ex3:= BO_Address.AddrUtils.extra3(xmldata);
string64 ex4:= BO_Address.AddrUtils.extra4(xmldata);
string64 ex5:= BO_Address.AddrUtils.extra5(xmldata);
string64 ex6:= BO_Address.AddrUtils.extra6(xmldata);
string64 ex7:= BO_Address.AddrUtils.extra7(xmldata);
string64 ex8:= BO_Address.AddrUtils.extra8(xmldata);
string64 ex9:= BO_Address.AddrUtils.extra9(xmldata);
string64 ex10:= BO_Address.AddrUtils.extra10(xmldata);
string64 esad:= BO_Address.AddrUtils.extra_secondary_address_data(xmldata);
string10 esun:= BO_Address.AddrUtils.extra_secondary_unit_number(xmldata);
string10 esnp:= BO_Address.AddrUtils.extra_secondary_non_postal(xmldata);
string10 poty:= BO_Address.AddrUtils.postal_type(xmldata);
string10 npu:= BO_Address.AddrUtils.non_postal_unit(xmldata);
string10 npun:= BO_Address.AddrUtils.non_postal_unit_number(xmldata);
string10 rbn:= BO_Address.AddrUtils.rural_box_number(xmldata);


string10 ga := BO_Address.AddrUtils.geo_lat(xmldata);
string11 go := BO_Address.AddrUtils.geo_long(xmldata);
string4 ma := BO_Address.AddrUtils.msa(xmldata);
string7 gb := BO_Address.AddrUtils.geo_blk(xmldata);
string1 gm := BO_Address.AddrUtils.geo_match(xmldata);



string4 es := BO_Address.AddrUtils.err_stat(xmldata);

return(pr+pd+pn+ads+psd+ud+sr+pcn+vcn+ss+zp+zp4+ct+css+lt+lto+
					dp+cd+rt+fs+fc+
					rrn + pobn + sad + rdi + alr+ ex1+ ex2+ ex3+ ex4+ ex5+ ex6+ ex7+ ex8+ ex9+
					ex10+ esad+ esun+ esnp+ poty+ npu+ npun+ rbn+ 
					ga+go+ma+gb+gm+es);





							
end;