ds:=dataset('~thor_data400::base::avm_v2',avm_v2.layouts.layout_base_with_history,thor);
export File_AVM_Base := dedup(sort(distribute(ds,hash(zip, st, prim_range, predir, prim_name, postdir, sec_range)),
																	 zip, st, prim_range, predir, prim_name, postdir, sec_range, -recording_date, -assessed_value_year, unformatted_apn, ln_fares_id_ta, ln_fares_id_pi,local),
															zip, st, prim_range, predir, prim_name, postdir, sec_range);