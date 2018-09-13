export fn_join_watchdog(dids, d_field, key) := functionmacro

		import dx_BestRecords, ut;

		return join(dids, key,
			keyed(left.d_field = right.did),							
			transform(
				dx_BestRecords.layout_best,
				self.age := if ( right.dob = 0, 0, ut.age(right.dob) ),
				self := right
			), keep(1), limit(0));

	endmacro;