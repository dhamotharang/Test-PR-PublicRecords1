export fn_join_watchdog(dids, d_field, key) := functionmacro

		import dx_BestRecords, ut, _Control;

		return if(_Control.Environment.onThor, 
			join(distribute(dids, hash64(d_field)), distribute(pull(key), hash64(did)),
				(left.d_field = right.did),							
				transform(
					dx_BestRecords.layout_best,
					self.age := if ( right.dob = 0, 0, ut.age(right.dob) ),
					self := right
				), keep(1), limit(0), local),
			join(dids, key,
				keyed(left.d_field = right.did),							
				transform(
					dx_BestRecords.layout_best,
					self.age := if ( right.dob = 0, 0, ut.age(right.dob) ),
					self := right
				), keep(1), limit(0)));

	endmacro;