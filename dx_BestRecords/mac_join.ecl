export mac_join (ds, d_field, key, use_dist, do_append) := functionmacro

	local out_rec := record(recordof(ds))
		dx_BestRecords.layout_best _best;
	end;

	local ds_res := if (use_dist, 
		join (distribute (ds, hash64(d_field)), distribute(pull(key), hash64(did)),
			(left.d_field = right.did),
			#if (do_append)            
				transform (out_rec,
					self._best._valid := true, 
					self._best.age := if (right.dob = 0, 0, ut.age(right.dob)),
					self._best := right,
					self := left),
				left outer,            
			#else
				transform (dx_BestRecords.layout_best, 
					self._valid := true, 
					self.age := if (right.dob = 0, 0, ut.age(right.dob)), 
					self := right),
			#end
			keep(1), limit(0), local),
		join (ds, key,
			keyed(left.d_field = right.did),
			#if (do_append)            
				transform (out_rec,
					self._best._valid := true, 
					self._best.age := if (right.dob = 0, 0, ut.age(right.dob)),
					self._best := right,
					self := left),
				left outer,            
			#else
				transform (dx_BestRecords.layout_best, 
					self._valid := true, 
					self.age := if (right.dob = 0, 0, ut.age(right.dob)), 
					self := right),
			#end
			keep(1), limit(0), local)
	);

	return ds_res;

endmacro;