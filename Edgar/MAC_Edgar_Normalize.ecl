EXPORT MAC_Edgar_Normalize
(
	infile,  // recordset in Layout_Edgar_Company format
	outfile  // name of output recorset in 
			 // Layout_Edgar_Company_Single_Address format
) := MACRO

// NOTE : The same rcid value will be present in both children.

#uniquename(NormEdgar)

Layout_Edgar_Company_Single_Address %NormEdgar%(
		infile l, UNSIGNED1 num) := TRANSFORM
	SELF.addr_type := CHOOSE(num, 'B', 'M');
	SELF.prim_range := CHOOSE(num, l.bus_prim_range, l.mail_prim_range);
	SELF.predir := CHOOSE(num, l.bus_predir, l.mail_predir);
	SELF.prim_name := CHOOSE(num, l.bus_prim_name, l.mail_prim_name);
	SELF.addr_suffix := CHOOSE(num, l.bus_addr_suffix, l.mail_addr_suffix);
	SELF.postdir := CHOOSE(num, l.bus_postdir, l.mail_postdir);
	SELF.unit_desig := CHOOSE(num, l.bus_unit_desig, l.mail_unit_desig);
	SELF.sec_range := CHOOSE(num, l.bus_sec_range, l.mail_sec_range);
	SELF.p_city_name := CHOOSE(num, l.bus_p_city_name, l.mail_p_city_name);
	SELF.v_city_name := CHOOSE(num, l.bus_v_city_name, l.mail_v_city_name);
	SELF.st := CHOOSE(num, l.bus_st, l.mail_st);
	SELF.zip5 := CHOOSE(num, l.bus_zip, l.mail_zip);
	SELF.zip4 := CHOOSE(num, l.bus_zip4, l.mail_zip4);
	SELF.cart := CHOOSE(num, l.bus_cart, l.mail_cart);
	SELF.cr_sort_sz := CHOOSE(num, l.bus_cr_sort_sz, l.mail_cr_sort_sz);
	SELF.lot := CHOOSE(num, l.bus_lot, l.mail_lot);
	SELF.lot_order := CHOOSE(num, l.bus_lot_order, l.mail_lot_order);
	SELF.dbpc := CHOOSE(num, l.bus_dbpc, l.mail_dbpc);
	SELF.chk_digit := CHOOSE(num, l.bus_chk_digit, l.mail_chk_digit);
	SELF.rec_type := CHOOSE(num, l.bus_rec_type, l.mail_rec_type);
	SELF.county := CHOOSE(num, l.bus_county, l.mail_county);
	SELF.geo_lat := CHOOSE(num, l.bus_geo_lat, l.mail_geo_lat);
	SELF.geo_long := CHOOSE(num, l.bus_geo_long, l.mail_geo_long);
	SELF.msa := CHOOSE(num, l.bus_msa, l.mail_msa);
	SELF.geo_blk := CHOOSE(num, l.bus_geo_blk, l.mail_geo_blk);
	SELF.geo_match := CHOOSE(num, l.bus_geo_match, l.mail_geo_match);
	SELF.err_stat := CHOOSE(num, l.bus_err_stat, l.mail_err_stat);
	SELF.phone10 := CHOOSE(num, l.bus_phone10, l.mail_phone10);
	SELF := l;
END;

outfile := NORMALIZE(infile, 2, %NormEdgar%(LEFT, COUNTER));
	
ENDMACRO;