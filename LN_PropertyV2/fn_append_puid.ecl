import ut;

export fn_append_puid(int0)
	:=
functionmacro

recordof(int0) t_append_puid(recordof(int0) le) := transform
 self.persistent_record_id := HASH64(ut.fnTrim2Upper(le.vendor_source_flag) +','
																		+ ut.fnTrim2Upper(le.ln_fares_id) + ' '
																		+ ut.fnTrim2Upper(le.source_code) +','
																		+ ut.fnTrim2Upper(le.which_orig) +','
																		+ ut.fnTrim2Upper(le.conjunctive_name_seq) +','
																		+ ut.fnTrim2Upper(le.title) +','
																		+ ut.fnTrim2Upper(le.fname) +','
																		+ ut.fnTrim2Upper(le.mname) +','
																		+ ut.fnTrim2Upper(le.lname) +','
																		+ ut.fnTrim2Upper(le.name_suffix) +','
																		+ ut.fnTrim2Upper(le.cname) +','
																		+ ut.fnTrim2Upper(le.nameasis) +','
																		+ ut.fnTrim2Upper(le.prim_range) +','
																		+ ut.fnTrim2Upper(le.predir) +','
																		+ ut.fnTrim2Upper(le.prim_name) +','
																		+	ut.fnTrim2Upper(le.suffix) +','
																		+ ut.fnTrim2Upper(le.postdir) +','
																		+ ut.fnTrim2Upper(le.unit_desig) +','
																		+ ut.fnTrim2Upper(le.sec_range) +','
																		+	ut.fnTrim2Upper(le.p_city_name) +','
																		+ ut.fnTrim2Upper(le.v_city_name) +','
																		+ ut.fnTrim2Upper(le.st) +','
																		+ ut.fnTrim2Upper(le.zip) +','
																		+ ut.fnTrim2Upper(le.zip4) +','
																		+	ut.fnTrim2Upper(le.cart) +','
																		+ ut.fnTrim2Upper(le.cr_sort_sz) +','
																		+ ut.fnTrim2Upper(le.lot) +','
																		+ ut.fnTrim2Upper(le.lot_order) +','
																		+ ut.fnTrim2Upper(le.dbpc) +','
																		+ ut.fnTrim2Upper(le.chk_digit) +','
																		+ ut.fnTrim2Upper(le.rec_type) +','
																		+ ut.fnTrim2Upper(le.county) +','
																		+ ut.fnTrim2Upper(le.geo_lat) +','
																		+ ut.fnTrim2Upper(le.geo_long) +','
																		+ ut.fnTrim2Upper(le.msa) +','
																		+ ut.fnTrim2Upper(le.geo_blk) +','
																		+ ut.fnTrim2Upper(le.geo_match) +','
																			// + ut.fnTrim2Upper(le.err_stat)
																		+ ut.fnTrim2Upper(le.phone_number) +','
																		+ le.did +','
																		+ le.bdid +','
																		+ ut.fnTrim2Upper(le.app_SSN) +','
																		+ ut.fnTrim2Upper(le.app_tax_id));
									
 self := le;
 
end;

p_append_puid := project(int0,t_append_puid(left));

return p_append_puid;

endmacro;
