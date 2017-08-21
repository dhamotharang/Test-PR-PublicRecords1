import ut;

export fn_append_puid(int0)
	:=
functionmacro

recordof(int0) t_append_puid(recordof(int0) le) := transform
 self.persistent_record_id := HASH64(ut.CleanSpacesAndUpper(le.vendor_source_flag) +','
																		+ ut.CleanSpacesAndUpper(le.ln_fares_id) + ' '
																		+ ut.CleanSpacesAndUpper(le.source_code) +','
																		+ ut.CleanSpacesAndUpper(le.which_orig) +','
																		+ ut.CleanSpacesAndUpper(le.conjunctive_name_seq) +','
																		+ ut.CleanSpacesAndUpper(le.title) +','
																		+ ut.CleanSpacesAndUpper(le.fname) +','
																		+ ut.CleanSpacesAndUpper(le.mname) +','
																		+ ut.CleanSpacesAndUpper(le.lname) +','
																		+ ut.CleanSpacesAndUpper(le.name_suffix) +','
																		+ ut.CleanSpacesAndUpper(le.cname) +','
																		+ ut.CleanSpacesAndUpper(le.nameasis) +','
																		+ ut.CleanSpacesAndUpper(le.prim_range) +','
																		+ ut.CleanSpacesAndUpper(le.predir) +','
																		+ ut.CleanSpacesAndUpper(le.prim_name) +','
																		+	ut.CleanSpacesAndUpper(le.suffix) +','
																		+ ut.CleanSpacesAndUpper(le.postdir) +','
																		+ ut.CleanSpacesAndUpper(le.unit_desig) +','
																		+ ut.CleanSpacesAndUpper(le.sec_range) +','
																		+	ut.CleanSpacesAndUpper(le.p_city_name) +','
																		+ ut.CleanSpacesAndUpper(le.v_city_name) +','
																		+ ut.CleanSpacesAndUpper(le.st) +','
																		+ ut.CleanSpacesAndUpper(le.zip) +','
																		+ ut.CleanSpacesAndUpper(le.zip4) +','
																		+	ut.CleanSpacesAndUpper(le.cart) +','
																		+ ut.CleanSpacesAndUpper(le.cr_sort_sz) +','
																		+ ut.CleanSpacesAndUpper(le.lot) +','
																		+ ut.CleanSpacesAndUpper(le.lot_order) +','
																		+ ut.CleanSpacesAndUpper(le.dbpc) +','
																		+ ut.CleanSpacesAndUpper(le.chk_digit) +','
																		+ ut.CleanSpacesAndUpper(le.rec_type) +','
																		+ ut.CleanSpacesAndUpper(le.county) +','
																		+ ut.CleanSpacesAndUpper(le.geo_lat) +','
																		+ ut.CleanSpacesAndUpper(le.geo_long) +','
																		+ ut.CleanSpacesAndUpper(le.msa) +','
																		+ ut.CleanSpacesAndUpper(le.geo_blk) +','
																		+ ut.CleanSpacesAndUpper(le.geo_match) +','
																			// + ut.CleanSpacesAndUpper(le.err_stat)
																		+ ut.CleanSpacesAndUpper(le.phone_number) +','
																		+ le.did +','
																		+ le.bdid +','
																		+ ut.CleanSpacesAndUpper(le.app_SSN) +','
																		+ ut.CleanSpacesAndUpper(le.app_tax_id));
									
 self := le;
 
end;

p_append_puid := project(int0,t_append_puid(left));

return p_append_puid;

endmacro;
