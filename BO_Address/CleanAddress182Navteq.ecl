export CleanAddress182Navteq (const string line1,const string line2,
							const string server = BO_Server, 
							unsigned2 port = BO_Port)	:= FUNCTION
					
string xmldata := BOCleanAddressNavteq(
				RegexReplace('(<)|(>)',line1,''),
				RegexReplace('(<)|(>)',line2,''),
				server,port);


string10 pr := AddrUtils.prim_range(xmldata);
string2 pd := AddrUtils.predir(xmldata);
string28 pn := AddrUtils.prim_name(xmldata);
string4 ads := AddrUtils.addr_suffix(xmldata);
string2 psd := AddrUtils.postdir(xmldata);
string10 ud := AddrUtils.unit_desig(xmldata);
string8 sr := AddrUtils.sec_range(xmldata);
string25 pcn := AddrUtils.p_city_name(xmldata);
string25 vcn := AddrUtils.v_city_name(xmldata);
string2 ss := AddrUtils.st(xmldata);
string5 zp := AddrUtils.zip(xmldata);
string4 zp4 := AddrUtils.zip4(xmldata);
string4 ct := AddrUtils.cart(xmldata);
string1 css := AddrUtils.cr_sort_sz(xmldata);
string4 lt := AddrUtils.lot(xmldata);
string1 lto := AddrUtils.lot_order(xmldata);
string2 dp := AddrUtils.dpbc(xmldata);
string1 cd := AddrUtils.chk_digit(xmldata);
string2 rt := AddrUtils.record_type(xmldata);
string2 fs := AddrUtils.ace_fips_state(xmldata);
string3 fc := AddrUtils.county(xmldata);
string10 ga := AddrUtils.geo_lat(xmldata);
string11 go := AddrUtils.geo_long(xmldata);
string4 ma := AddrUtils.msa(xmldata);
string7 gb := AddrUtils.geo_blk(xmldata);
string1 gm := AddrUtils.geo_match(xmldata);
string4 es := AddrUtils.err_stat(xmldata);

return(pr+pd+pn+ads+psd+ud+sr+pcn+vcn+ss+zp+zp4+ct+css+lt+lto+
					dp+cd+rt+fs+fc+ga+go+ma+gb+gm+es);



							
end;